From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 20 Jan 2010 07:59:51 +0100
Subject: 2.6.23 irda
In-Reply-To: <1b1304131001190526p63f3a3adr837b3b88d513151a@mail.gmail.com>
References: <1b1304131001190526p63f3a3adr837b3b88d513151a@mail.gmail.com>
Message-ID: <20100120065951.GB26053@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> about irda on 2.6.23, it seems to me there is a bit of code missing ...
> i wander who and where is calling
> "akita_set_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_IR_ON);"

Okay, I'm not using akita, and 2.6.23 is very historic. Can you try on
recent kernel?

> cause i need AKITA_IOEXP_IR_ON
> 
> 
> 2010-01-19--01-28   [irda] doesitneedsomekindofmagic?
>                     arch/arm/mach-pxa/spitz.c
> /*
>  * Irda              on spitz != akita? if so you can have an idea
>  */
> static void spitz_irda_transceiver_mode(struct device *dev, int mode)
> {
>         if (mode & IR_OFF)
>                 set_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_IR_ON);
>         else
>                 reset_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_IR_ON);
> }
> 
> /* Spitz Scoop Device (No. 2) GPIOs */
> /* Suspend States in comments
>  * Spitz only, Akita uses corresponding AKITA_IOEXP_ */
> #define SPITZ_SCP2_IR_ON           SCOOP_GPCR_PA11  /* IrDA On, High */
> 
> /* These UART GPIO pins are connected to IrDA:
>  * GPIO46_STRXD
>  * GPIO47_STTXD
>  */
> 
> 
> 
> http://www.linuxhq.com/kernel/v2.6/27-git2/arch/arm/mach-pxa/spitz.c
> 
> 
> #ifdef CONFIG_MACH_AKITA
>  static void akita_irda_transceiver_mode(struct device *dev, int mode)
>  {
> -   if (mode & IR_OFF)
> -      akita_set_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_IR_ON);
> -   else
> -      akita_reset_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_IR_ON);
> +   gpio_set_value(AKITA_GPIO_IR_ON, mode & IR_OFF);
>     pxa2xx_transceiver_mode(dev, mode);
>  }
>  #endif
> 
> 
> 
> 
> 
> on my 2.6.23 three i run the following script
> 
> my() {
> echo "[*] $1"
> echo "echo [*] $1 >> my-irda.log"
> grep -r $1 $2 * >> my-irda.log
> }
> 
> #echo > my-irda.log
> my "irda_startup"
> my "SPITZ_GPIO_IR_ON"
> my "gpio_request(SPITZ_GPIO_IR_ON"
> my "irda_shutdown"
> my "irda_transceiver_mode"
> 
> 
> and i get
> 
> drivers/net/irda/sa1100_ir.c:static int sa1100_irda_startup(struct
> sa1100_irda *si)
> drivers/net/irda/sa1100_ir.c:           sa1100_irda_startup(si);
> drivers/net/irda/sa1100_ir.c:   err = sa1100_irda_startup(si);
> drivers/net/irda/pxaficp_ir.c:static void pxa_irda_startup(struct pxa_irda *si)
> drivers/net/irda/pxaficp_ir.c:  pxa_irda_startup(si);
> drivers/net/irda/pxaficp_ir.c:          pxa_irda_startup(si);
> drivers/net/irda/sa1100_ir.c:static int sa1100_irda_startup(struct
> sa1100_irda *si)
> drivers/net/irda/sa1100_ir.c:           sa1100_irda_startup(si);
> drivers/net/irda/sa1100_ir.c:   err = sa1100_irda_startup(si);
> drivers/net/irda/pxaficp_ir.c:static void pxa_irda_startup(struct pxa_irda *si)
> drivers/net/irda/pxaficp_ir.c:  pxa_irda_startup(si);
> drivers/net/irda/pxaficp_ir.c:          pxa_irda_startup(si);
> drivers/net/irda/sa1100_ir.c:static void sa1100_irda_shutdown(struct
> sa1100_irda *si)
> drivers/net/irda/sa1100_ir.c:           sa1100_irda_shutdown(si);
> drivers/net/irda/sa1100_ir.c:   sa1100_irda_shutdown(si);
> drivers/net/irda/sa1100_ir.c:   sa1100_irda_shutdown(si);
> drivers/net/irda/pxaficp_ir.c:static void pxa_irda_shutdown(struct pxa_irda *si)
> drivers/net/irda/pxaficp_ir.c:  pxa_irda_shutdown(si);
> drivers/net/irda/pxaficp_ir.c:  pxa_irda_shutdown(si);
> drivers/net/irda/pxaficp_ir.c:          pxa_irda_shutdown(si);
> net/irda/af_irda.c:     /* Prevent race conditions with irda_release()
> and irda_shutdown() */
> net/irda/af_irda.c: * Function irda_shutdown (sk, how)
> net/irda/af_irda.c:static int irda_shutdown(struct socket *sock, int how)
> net/irda/af_irda.c:     .shutdown =     irda_shutdown,
> net/irda/af_irda.c:     .shutdown =     irda_shutdown,
> net/irda/af_irda.c:     .shutdown =     irda_shutdown,
> net/irda/af_irda.c:     .shutdown =     irda_shutdown,
> arch/arm/mach-pxa/lubbock.c:static void
> lubbock_irda_transceiver_mode(struct device *dev, int mode)
> arch/arm/mach-pxa/lubbock.c:    .transceiver_mode =
> lubbock_irda_transceiver_mode,
> arch/arm/mach-pxa/spitz.c:static void
> spitz_irda_transceiver_mode(struct device *dev, int mode)
> arch/arm/mach-pxa/spitz.c:static void
> akita_irda_transceiver_mode(struct device *dev, int mode)
> arch/arm/mach-pxa/spitz.c:      .transceiver_mode = spitz_irda_transceiver_mode,
> arch/arm/mach-pxa/spitz.c:
> spitz_ficp_platform_data.transceiver_mode =
> akita_irda_transceiver_mode;
> arch/arm/mach-pxa/mainstone.c:static void
> mainstone_irda_transceiver_mode(struct device *dev, int mode)
> arch/arm/mach-pxa/mainstone.c:  .transceiver_mode =
> mainstone_irda_transceiver_mode,
> arch/arm/mach-pxa/tosa.c:static void tosa_irda_transceiver_mode(struct
> device *dev, int mode)
> arch/arm/mach-pxa/tosa.c:       .transceiver_mode = tosa_irda_transceiver_mode,
> arch/arm/mach-pxa/poodle.c:static void
> poodle_irda_transceiver_mode(struct device *dev, int mode)
> arch/arm/mach-pxa/poodle.c:     .transceiver_mode =
> poodle_irda_transceiver_mode,
> arch/arm/mach-pxa/htcuniversal/htcuniversal.c:static void
> htcuniversal_irda_transceiver_mode(struct device *dev, int mode)
> arch/arm/mach-pxa/htcuniversal/htcuniversal.c:  .transceiver_mode =
> htcuniversal_irda_transceiver_mode,
> arch/arm/mach-pxa/corgi.c:static void
> corgi_irda_transceiver_mode(struct device *dev, int mode)
> arch/arm/mach-pxa/corgi.c:      .transceiver_mode = corgi_irda_transceiver_mode,
> arch/arm/mach-pxa/spitz.c.original:static void
> spitz_irda_transceiver_mode(struct device *dev, int mode)
> arch/arm/mach-pxa/spitz.c.original:static void
> akita_irda_transceiver_mode(struct device *dev, int mode)
> arch/arm/mach-pxa/spitz.c.original:     .transceiver_mode =
> spitz_irda_transceiver_mode,
> arch/arm/mach-pxa/spitz.c.original:
> spitz_ficp_platform_data.transceiver_mode =
> akita_irda_transceiver_mode;
> 
> 
> 
> 
> 
> could you point me into the right way ?
> then i will write a kernel modul that will call
> static void akita_irda_transceiver_mode(struct device *dev, int mode)
> ot
> akita_set_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_IR_ON);
> 
> what "dev" needs ?
> 
> 
> (i am not so skilled about kernel module)
> regards

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
