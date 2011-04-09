From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 9 Apr 2011 15:09:17 +0200
Subject: [PATCH][KERNEL] Add support for CPLD regs and CF cards in kernel
	2.6.38
In-Reply-To: <201103231851.24660.marek.vasut@gmail.com>
References: <AANLkTi=DfPWu9V8RhgKEaAMdqNmW8KPn9RwWOYCGKvRk@mail.gmail.com>
	<201103231851.24660.marek.vasut@gmail.com>
Message-ID: <201104091509.17652.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 March 2011 18:51:24 Marek Vasut wrote:
> On Wednesday 23 March 2011 17:22:14 Alex Mihaylov wrote:
> > Hello, All!
> > 
> > %Subj% Waiting for you comments.
> > Anybody have PXA270 module? I set comment for PXA270 specific, but not
> > write code.
> > All my PXA270 modules damaged :-(
> 
> PXA270 colibri doesn't have CPLD at all iirc.
> 
> CCing LAK and Dan Mack.
> 
> > ===== cut =====
> 
> git format-patch please.
> 
> > --- linux-2.6.38/arch/arm/mach-pxa/colibri-pxa320.c	2011-03-15
> > 04:20:32.000000000 +0300
> > +++ linux-2.6.38-pxavga/arch/arm/mach-pxa/colibri-pxa320.c	2011-03-23
> > 15:37:54.000000000 +0300
> > @@ -22,6 +22,7 @@
> > 
> >  #include <asm/sizes.h>
> >  #include <asm/mach/arch.h>
> >  #include <asm/mach/irq.h>
> > 
> > +#include <asm/mach/map.h>
> > 
> >  #include <mach/pxa3xx-regs.h>
> >  #include <mach/mfp-pxa320.h>
> > 
> > @@ -75,25 +76,31 @@ static mfp_cfg_t colibri_pxa320_evalboar
> > 
> >  	GPIO33_I2C_SDA,
> >  	
> >  	/* PCMCIA */
> > 
> > -	MFP_CFG(GPIO59, AF7),	/* PRST ; AF7 to tristate */
> > -	MFP_CFG(GPIO61, AF7),	/* PCE1 ; AF7 to tristate */
> > -	MFP_CFG(GPIO60, AF7),	/* PCE2 ; AF7 to tristate */
> > -	MFP_CFG(GPIO62, AF7),	/* PCD ; AF7 to tristate */
> > -	MFP_CFG(GPIO56, AF7),	/* PSKTSEL ; AF7 to tristate */
> > -	GPIO27_GPIO,		/* RDnWR ; input/tristate */
> > -	GPIO50_GPIO,		/* PREG ; input/tristate */
> > +	MFP_CFG(GPIO59, AF7),	/* SoDIMM75 CIF_MCLK  MUX GPIO77	*/
> > +	MFP_CFG(GPIO61, AF7),	/* SoDIMM94 CIF_HSYNC MUX CPLD nPCE1	*/
> > +	MFP_CFG(GPIO60, AF7),	/* SoDIMM96 CIF_PCLK  MUX CPLD nPCE2	*/
> > +	MFP_CFG(GPIO62, AF7),	/* SoDIMM81 CIF_VSYNC MUX GPIO81	*/
> > +	MFP_CFG(GPIO56, AF7),	/* SoDIMM59 CIF_DD7   MUX GPIO14 ???	*/
> > +	MFP_CFG(GPIO27, AF7),	/* SoDIMM93 GPIO27    MUX CPLD RDnWR	*/
> > +	MFP_CFG(GPIO50, AF7),	/* SoDIMM98 GPIO50    MUX CPLD nPREG	*/
> > +	MFP_CFG(GPIO51, AF7),	/* SoDIMM101 GPIO51   MUX GPIO6_nPIOW	*/
> > +	MFP_CFG(GPIO52, AF7),	/* SoDIMM103 GPIO52   MUX GPIO5_nPIOR	*/
> > +	MFP_CFG(GPIO54, AF7),	/* SoDIMM97 GPIO54    MUX CPLD DF_CLE_nOE */
> > +	MFP_CFG(GPIO93, AF7),	/* SoDIMM99 GPIO93    MUX CPLD DF_ALE_nWE */
> > +	MFP_CFG(GPIO122, AF7),	/* SoDIMM100 GPIO122  MUX CPLD nPXCVREN	*/
> > +	MFP_CFG(GPIO125, AF7),	/* SoDIMM85  GPIO125  MUX GPIO57 nPPEN	*/
> 
> No need to change comments ... besides, does this patch pass
> scripts/checkpatch.pl ? if not, please fix issues it points out.
> 
> >  	GPIO2_RDY,
> > 
> > +	GPIO4_nCS3,             /* CPLD and ext. CSs */
> > 
> >  	GPIO5_NPIOR,
> >  	GPIO6_NPIOW,
> >  	GPIO7_NPIOS16,
> >  	GPIO8_NPWAIT,
> > 
> > -	GPIO29_GPIO,		/* PRDY (READY GPIO) */
> > -	GPIO57_GPIO,		/* PPEN (POWER GPIO) */
> > -	GPIO81_GPIO,		/* PCD (DETECT GPIO) */
> > -	GPIO77_GPIO,		/* PRST (RESET GPIO) */
> > -	GPIO53_GPIO,		/* PBVD1 */
> > -	GPIO79_GPIO,		/* PBVD2 */
> > -	GPIO54_GPIO,		/* POE */
> > +	GPIO29_GPIO | MFP_LPM_EDGE_FALL,	/* PRDY  (READY GPIO) */
> > +	GPIO57_GPIO,				/* nPPEN (POWER GPIO) */
> > +	GPIO81_GPIO | MFP_LPM_EDGE_BOTH,	/* PCD  (DETECT GPIO) */
> > +	GPIO77_GPIO,				/* PRST  (RESET GPIO) */
> > +	GPIO53_GPIO,				/* PBVD1 */
> > +	GPIO79_GPIO,				/* PBVD2 */
> > 
> >  };
> >  #else
> >  static mfp_cfg_t colibri_pxa320_evalboard_pin_config[] __initdata = {};
> > 
> > @@ -253,10 +260,26 @@ void __init colibri_pxa320_init(void)
> > 
> >  	colibri_evalboard_init();
> >  
> >  }
> > 
> > +static struct map_desc colibri_pxa320_io_desc[] __initdata = {
> > +        {       // CPLD regs //
> 
> Wrong comment style.
> 
> > +                .virtual        = CPLD_REGS_VIRT,
> > +                .pfn            = __phys_to_pfn(CPLD_REGS_PHYS),
> > +                .length         = CPLD_REGS_LEN,
> > +                .type           = MT_DEVICE
> > +        }
> > +};
> > +
> > +void __init colibri_pxa320_map_io(void)
> > +{
> > +        pxa3xx_map_io();
> > +        iotable_init(ARRAY_AND_SIZE(colibri_pxa320_io_desc));
> > +	pxa3xx_get_clk_frequency_khz(1);
> 
> Eh? Wrong indent + what is this supposed to do ? Isn't this call in a wrong
> place ?
> 
> > +}
> > +
> > 
> >  MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
> >  
> >  	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
> >  	.init_machine	= colibri_pxa320_init,
> > 
> > -	.map_io		= pxa3xx_map_io,
> > +	.map_io		= colibri_pxa320_map_io,
> > 
> >  	.init_irq	= pxa3xx_init_irq,
> >  	.timer		= &pxa_timer,
> >  
> >  MACHINE_END
> > 
> > --- linux-2.6.38/arch/arm/mach-pxa/include/mach/colibri.h	2011-03-15
> > 04:20:32.000000000 +0300
> > +++ linux-2.6.38-pxavga/arch/arm/mach-pxa/include/mach/colibri.h
> 
> 2011-03-23
> 
> > 13:22:03.000000000 +0300
> > @@ -65,5 +65,38 @@ static inline void colibri_pxa3xx_init_n
> > 
> >  /* GPIO definitions for Colibri PXA320 */
> >  #define GPIO28_COLIBRI_PXA320_SD_DETECT	28
> > 
> > +// CPLD registers for Colibri PXA320
> > +// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +// Phys start   Phys end      Virt start   Virt end   Described in
> > +// 0x40000000 - 0x42000000 -> 0xf2000000 - 0xf4000000
> > generic.c:pxa_map_io() +// 0x4a000000 - 0x4a200000 -> 0xf6000000 -
> > 0xf6200000 pxa3xx.c:pxa3xx_map.io() +// 0x17800000 - 0x17a00000 ->
> > 0xf6200000 - 0xf6400000
> 
> Fix comment please. C++ style is a no-no ... see checkpatch.
> 
> > colibri-pxa320.c:colibri_pxa320_map_io()
> > +
> > +#define CPLD_REGS_PHYS		0x17800000
> > +#define CPLD_REGS_VIRT		0xf6200000
> > +#define CPLD_REGS_LEN		0x00200000
> > +
> > +#define CPLD_CS_CTRL		(CPLD_REGS_VIRT)
> > +#define CPLD_EXT_nCS2_EC_DIS	(1<<15)
> > +#define CPLD_EXT_nCS1_EC_DIS	(1<<14)
> > +#define CPLD_EXT_nCS0_EC_DIS	(1<<13)
> > +#define CPLD_EXT_nCS2_DIS	(1<<10)
> > +#define CPLD_EXT_nCS1_DIS	(1<<9)
> > +#define CPLD_EXT_nCS0_DIS	(1<<8)
> > +#define CPLD_EXT_nCS2_EC_EN	(1<<7)
> > +#define CPLD_EXT_nCS1_EC_EN	(1<<6)
> > +#define CPLD_EXT_nCS0_EC_EN	(1<<5)
> > +#define CPLD_EXT_nCS2_EN	(1<<2)
> > +#define CPLD_EXT_nCS1_EN	(1<<1)
> > +#define CPLD_EXT_nCS0_EN	(1<<0)
> > +
> > +#define CPLD_MEM_CTRL           (CPLD_REGS_VIRT + 4)
> > +#define CPLD_MEM_nOE_DIS	(1<<10)
> > +#define CPLD_MEM_RDnWR_DIS	(1<<9)
> > +#define CPLD_MEM_CF_DIS		(1<<8)
> > +#define CPLD_MEM_nOE_EN		(1<<2)
> > +#define CPLD_MEM_RDnWR_EN	(1<<1)
> > +#define CPLD_MEM_CF_EN		(1<<0)
> > +
> > 
> >  #endif /* _COLIBRI_H_ */
> > 
> > --- linux-2.6.38/drivers/pcmcia/pxa2xx_colibri.c	2011-03-15
> > 04:20:32.000000000 +0300
> > +++ linux-2.6.38-pxavga/drivers/pcmcia/pxa2xx_colibri.c	2011-03-23
> > 15:55:42.000000000 +0300
> > @@ -16,6 +16,9 @@
> > 
> >  #include <linux/delay.h>
> >  #include <linux/gpio.h>
> > 
> > +#include <mach/colibri.h>
> > +#include <asm/io.h>
> > +
> > 
> >  #include <asm/mach-types.h>
> >  
> >  #include "soc_common.h"
> > 
> > @@ -145,18 +148,105 @@ static int
> > 
> >  colibri_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
> >  
> >  				const socket_state_t *state)
> >  
> >  {
> > 
> > -	gpio_set_value(colibri_pcmcia_gpio.ppen_gpio,
> > -			!(state->Vcc == 33 && state->Vpp < 50));
> > -	gpio_set_value(colibri_pcmcia_gpio.reset_gpio, state->flags &
> > SS_RESET); -	return 0;
> > +   unsigned long flags;
> > +    int ret;
> > +
> > +    // Configure socket
> 
> Comment DTTO
> 
> > +
> > +    local_irq_save(flags);
> > +    switch (skt->nr) {
> > +    case 0:
> > +        // configure Vcc and Vpp
> 
> DTTO
> 
> > +        if (state->Vcc == 0 && state->Vpp == 0)
> > +        {
> > +    	    gpio_set_value(colibri_pcmcia_gpio.ppen_gpio,1);
> > +            printk(KERN_INFO "PCMCIA socket0 power disabled\n");
> 
> dev_info() maybe ?
> 
> > +        }
> > +        else if (state->Vcc == 33 && state->Vpp < 50)
> > +        {
> > +            // PCMCIA socket0 power enabled
> 
> Comment.
> 
> > +            gpio_set_value(colibri_pcmcia_gpio.ppen_gpio,0);
> > +        }
> > +        else
> > +        {
> > +            printk(KERN_ERR "%s(): unsupported Vcc %u Vpp %u
> > combination\n", +               __FUNCTION__, state->Vcc, state->Vpp);
> 
> dev_err() would remove the need for explicit __FUNCTION__ here.
> 
> > +            return -1;
> > +        }
> > +
> > +        // reset PCMCIA if requested
> 
> DTTO
> 
> > +        if (state->flags & SS_RESET)
> > +        {
> > +            // Reset card in slot0
> 
> DTTO
> 
> > +            gpio_set_value(colibri_pcmcia_gpio.reset_gpio, 1);
> > +        }
> > +
> > +        //
> 
> WTF
> 
> > +        if (state->flags & SS_OUTPUT_ENA)
> > +        {
> > +            // PCCards0 output enabled
> 
> if (condition) { } ? please fix.
> 
> > +	    if (machine_is_colibri()) {
> > +		// Enable PSKTSEL signal
> > +		// Sorry, I don't have Colibri PXA270
> > +		// module to write this code :-(
> > +	    } else if (machine_is_colibri320()) {
> > +		// Enable CF bus in CPLD register
> 
> Comments ... fix.
> 
> > +		__raw_writew(
> > +		    CPLD_MEM_nOE_EN | CPLD_MEM_RDnWR_EN | CPLD_MEM_CF_EN,
> > +		    CPLD_MEM_CTRL );
> > +	    }
> > +        }
> > +
> > +        ret = 0;
> > +        break;
> > +    default:
> > +        ret = -1;
> > +    };
> > +
> > +    local_irq_restore(flags);
> > +    udelay(200);
> > +    return ret;
> > 
> >  }
> >  
> >  static void colibri_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
> >  {
> > 
> > +    switch( skt->nr ) {
> > +    case 0:
> > +        // PCCards socket0 init (bus off, power & reset)
> > +
> > +        // Disable bus
> 
> DTTO, below DTTO. Fix coding style using checkpatch.pl
> 
> > +	if (machine_is_colibri()) {
> > +	    // Disable PSKTSEL signal
> > +	    // Sorry, I don't have Colibri PXA270
> > +	    // module to write this code :-(
> > +	} else if (machine_is_colibri320()) {
> > +	    // Disable CF bus in CPLD register
> > +	    __raw_writew(
> > +		CPLD_MEM_nOE_DIS | CPLD_MEM_RDnWR_DIS | CPLD_MEM_CF_DIS,
> > +		CPLD_MEM_CTRL );
> > +	}
> > +        // Power ON socket
> > +        gpio_set_value(colibri_pcmcia_gpio.ppen_gpio, 0);
> > +        // Reset socket
> > +        gpio_set_value(colibri_pcmcia_gpio.reset_gpio, 1);
> > +        udelay(10);
> > +        gpio_set_value(colibri_pcmcia_gpio.reset_gpio, 0);
> > +        break;
> > +    default:
> > +        printk(KERN_INFO "Try init NOT present PCCards socket\n");
> 
> dev_info() ?
> 
> > +    };
> > 
> >  }
> >  
> >  static void colibri_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
> >  {
> > 
> > +    switch( skt->nr ) {
> > +    case 0:
> > +        /* PCCards socket0 suspend (power off) */
> > +        gpio_set_value(colibri_pcmcia_gpio.ppen_gpio, 1);
> > +        break;
> > +    default:
> > +        printk(KERN_INFO "Try suspend NOT present PCCards socket\n");
> > +    };
> > 
> >  }
> >  
> >  static struct pcmcia_low_level colibri_pcmcia_ops = {
> > 
> > ===== cut =====
> > 
> > P.S.
> > Marek, I don't add CC to arm-lunux list. This code Toradex Colibri
> > specific and needs in test before put them to mainline. For this mail
> > list special =)
> 
> Please do CC LAK, always ! You'll get feedback from other devs and it'll
> reduce the number of rounds until this code gets mainline.
> 
> Besides, this code looks suspiciously close to the one from certain BSP I
> got sources of. Can you confirm you're not violating anything here please?
> 
> Thanks, cheers!
> Looking forward to a new version!

I tried applying this by hand, but it doesn't work with my CF card. Any idea 
why? Did you have any success with this ?

Cheers
