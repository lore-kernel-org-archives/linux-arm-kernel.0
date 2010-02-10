From: maz@misterjones.org (Marc Zyngier)
Date: Wed, 10 Feb 2010 09:38:38 -0000 (GMT)
Subject: [PATCH] Eurotech Zeus : Making USB port 2 work
In-Reply-To: <20100210120555.1b648467@ironhide>
References: <20100210120555.1b648467@ironhide>
Message-ID: <37cba69b59077aff2450e9b89c9d0d20.squirrel@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, February 10, 2010 06:35, Amit Walambe wrote:

Hi Amit,

> The attached patch adds support for the second USB port of
> Arcom/Eurotech Zeus SBC. Currently only port 1 works. The patch sets the
> power enabling GPIO for port 2 and corrects the port initialisation
> flags.

Thanks for having a look at this. Comments below:

> Index: linux-2.6.33-rc6/arch/arm/mach-pxa/zeus.c
> ===================================================================
> --- linux-2.6.33-rc6.orig/arch/arm/mach-pxa/zeus.c	2010-02-10 11:37:47.456069467 +0530
> +++ linux-2.6.33-rc6/arch/arm/mach-pxa/zeus.c	2010-02-10 11:40:30.443073251 +0530
> @@ -482,7 +482,6 @@
>  {
>  	int err;
>
> -	/* Switch on port 2. */
>  	if ((err = gpio_request(ZEUS_USB2_PWREN_GPIO, "USB2_PWREN"))) {
>  		dev_err(dev, "Can't request USB2_PWREN\n");
>  		return err;
> @@ -494,6 +493,9 @@
>  		return err;
>  	}
>
> +	/* Switch on port 2. */
> +	gpio_set_value(ZEUS_USB2_PWREN_GPIO, 1);
> +

ZEUS_USB2_PWREN_GPIO is already set to one a few lines above (see call to
gpio_direction_output).

>  	/* Port 2 is shared between host and client interface. */
>  	UP2OCR = UP2OCR_HXOE | UP2OCR_HXS | UP2OCR_DMPDE | UP2OCR_DPPDE;
>
> @@ -503,13 +505,16 @@
>  static void zeus_ohci_exit(struct device *dev)
>  {
>  	/* Power-off port 2 */
> +	gpio_set_value(ZEUS_USB2_PWREN_GPIO, 0);
>  	gpio_direction_output(ZEUS_USB2_PWREN_GPIO, 0);

Same here.

>  	gpio_free(ZEUS_USB2_PWREN_GPIO);
>  }
>
>  static struct pxaohci_platform_data zeus_ohci_platform_data = {
>  	.port_mode	= PMM_NPS_MODE,
> -	.flags		= ENABLE_PORT_ALL | POWER_CONTROL_LOW | POWER_SENSE_LOW,
> +	/* Clear Power Control Polarity Low and set Power Sense
> +	 * Polarity Low. Supply power to USB ports. */
> +	.flags		= ENABLE_PORT_ALL | ~(POWER_CONTROL_LOW) | POWER_SENSE_LOW,

I suppose that is actually what makes it work, though the change is rather suspect.
You're basically setting *all* bits to 1, except for POWER_CONTROL_LOW, and I don't
think that's the expected behaviour. Could you try the following instead:

         .flags        = ENABLE_PORT_ALL | POWER_SENSE_LOW,

Additionally, you can try adding NO_OC_PROTECTION or OC_MODE_PERPORT if the above doesn't
work. This is a bit of a shot in the dark, as I'm currently far away from my Zeus board
and can't directly test it.

>  	.init		= zeus_ohci_init,
>  	.exit		= zeus_ohci_exit,
>  };
> @@ -837,7 +842,7 @@
>  	PCFR = PCFR_OPDE | PCFR_DC_EN | PCFR_FS | PCFR_FP;
>  }
>
> -MACHINE_START(ARCOM_ZEUS, "Arcom ZEUS")
> +MACHINE_START(ARCOM_ZEUS, "Arcom/Eurotech ZEUS")

Please sent this as a separate patch, including a Signed-off-by: line.

Thanks,

        M.
-- 
And if you don't know where you're going, any road will take you there...
