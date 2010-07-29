From: wookey@wookware.org (Wookey)
Date: Thu, 29 Jul 2010 11:10:55 +0100
Subject: [PATCH 10/13] [ARM] pxa/balloon3: PCMCIA Support
In-Reply-To: <1280373389-32475-10-git-send-email-marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
	<1280373389-32475-10-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100729101054.GB4981@dream.aleph1.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+++ Marek Vasut [2010-07-29 05:16 +0200]:
> This driver adds support for the on-board CF socket.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-pxa/balloon3.c              |   13 ++-
>  arch/arm/mach-pxa/include/mach/balloon3.h |   17 ---
>  drivers/pcmcia/Kconfig                    |    2 +-
>  drivers/pcmcia/Makefile                   |    1 +
>  drivers/pcmcia/pxa2xx_balloon3.c          |  199 +++++++++++++++++++++++++++++
>  5 files changed, 213 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/pcmcia/pxa2xx_balloon3.c
> 
> diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
> index 572525c..91ad56d 100644
> --- a/arch/arm/mach-pxa/balloon3.c
> +++ b/arch/arm/mach-pxa/balloon3.c
> @@ -88,6 +88,18 @@ static unsigned long balloon3_pin_config[] __initdata = {
>  	/* USB Host */
>  	GPIO88_USBH1_PWR,
>  	GPIO89_USBH1_PEN,
> +
> +	/* PC Card */
> +	GPIO48_nPOE,
> +	GPIO49_nPWE,
> +	GPIO50_nPIOR,
> +	GPIO51_nPIOW,
> +	GPIO85_nPCE_1,
> +	GPIO54_nPCE_2,
> +	GPIO79_PSKTSEL,
> +	GPIO55_nPREG,
> +	GPIO56_nPWAIT,
> +	GPIO57_nIOIS16,
>  };
>  
>  /******************************************************************************
> @@ -405,7 +417,6 @@ static void balloon3_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	unsigned long pending = __raw_readl(BALLOON3_INT_CONTROL_REG) &
>  					balloon3_irq_enabled;
> -
>  	do {
>  		/* clear useless edge notification */
>  		if (desc->chip->ack)
> diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h b/arch/arm/mach-pxa/include/mach/balloon3.h
> index 1a74106..14f4bd5 100644
> --- a/arch/arm/mach-pxa/include/mach/balloon3.h
> +++ b/arch/arm/mach-pxa/include/mach/balloon3.h
> @@ -26,10 +26,6 @@ enum balloon3_features {
>  #define BALLOON3_FPGA_VIRT	(0xf1000000)	/* as per balloon2 */
>  #define BALLOON3_FPGA_LENGTH	0x01000000
>  
> -/* FPGA/CPLD registers */
> -#define BALLOON3_PCMCIA0_REG		(BALLOON3_FPGA_VIRT + 0x00e00008)
> -/* fixme - same for now */
> -#define BALLOON3_PCMCIA1_REG		(BALLOON3_FPGA_VIRT + 0x00e00008)
>  #define BALLOON3_NANDIO_IO_REG		(BALLOON3_FPGA_VIRT + 0x00e00000)
>  /* fpga/cpld interrupt control register */
>  #define BALLOON3_INT_CONTROL_REG	(BALLOON3_FPGA_VIRT + 0x00e0000C)
> @@ -58,16 +54,6 @@ enum balloon3_features {
>  #define BALLOON3_INT_S0_IRQ		(1 << 0)  /* PCMCIA 0 IRQ */
>  #define BALLOON3_INT_S0_STSCHG		(1 << 1)  /* PCMCIA 0 status changed */
>  
> -/* CF Status Register */
> -#define BALLOON3_PCMCIA_nIRQ		(1 << 0)  /* IRQ / ready signal */
> -#define BALLOON3_PCMCIA_nSTSCHG_BVD1	(1 << 1)
> -					/* VDD sense / card status changed */
> -
> -/* CF control register (write) */
> -#define BALLOON3_PCMCIA_RESET		(1 << 0)   /* Card reset signal */
> -#define BALLOON3_PCMCIA_ENABLE		(1 << 1)
> -#define BALLOON3_PCMCIA_ADD_ENABLE	(1 << 2)
> -
> -#define BALLOON3_BP_CF_NRDY_IRQ	BALLOON3_IRQ(0)
> -#define BALLOON3_BP_NSTSCHG_IRQ	BALLOON3_IRQ(1)
> -


> diff --git a/drivers/pcmcia/pxa2xx_balloon3.c b/drivers/pcmcia/pxa2xx_balloon3.c
> new file mode 100644
> index 0000000..1f71f0d
> --- /dev/null
> +++ b/drivers/pcmcia/pxa2xx_balloon3.c
> @@ -0,0 +1,199 @@
> +/*
> + * FPGA / CPLD register offsets for CF socket
> + */
> +#define	BALLOON3_CF_STATUS_REG		(0x10e00008)
> +#define	BALLOON3_CF_CONTROL_REG		(0x10e00008)
> +#define BALLOON3_FPGA_VER		(0x10e0001c)
> +
> +/* CF Status Register bits (read-only) bits */
> +#define BALLOON3_CF_nIRQ		(1 << 0)
> +#define BALLOON3_CF_nSTSCHG_BVD1	(1 << 1)
> +
> +/* CF Control Set Register bits / CF Control Clear Register bits (write-only) */
> +#define BALLOON3_CF_RESET		(1 << 0)
> +#define BALLOON3_CF_ENABLE		(1 << 1)
> +#define BALLOON3_CF_ADD_ENABLE		(1 << 2)
> +
> +/* CF Interrupt sources */
> +#define BALLOON3_BP_CF_NRDY_IRQ		BALLOON3_IRQ(0)
> +#define BALLOON3_BP_NSTSCHG_IRQ		BALLOON3_IRQ(1)

erm. Why move the FPGA/CPLD register definitions out of balloon3.h
(along with the others) and put them in balloon3.c?
Is that really good kernel form?

And surely keeping the FPGA_VIRT offset makes it clearer where the
magic addresses come from?


And finally as this code is quite dependent on VHDL version numbers
and we know we have a number of incompatible versions around
should we add a version check to ensure that we have the same VHDL
version as the driver is expecting? I guess it should be of the 'at
least n' form, otherwise later VHDL updates would break the driver,
probbaly for no good reason.


Wookey
-- 
Principal hats:  Linaro, Emdebian, Wookware, Balloonboard, ARM
http://wookware.org/
