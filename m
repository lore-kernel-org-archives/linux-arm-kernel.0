From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 May 2011 07:34:11 -0700
Subject: [PATCH] OMAP3: beagle: add support for beagleboard xM revision C
In-Reply-To: <1306503133-31996-1-git-send-email-koen@dominion.thruhere.net>
References: <1306503133-31996-1-git-send-email-koen@dominion.thruhere.net>
Message-ID: <20110530143411.GG11352@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Koen Kooi <koen@dominion.thruhere.net> [110527 06:28]:
>
> @@ -123,9 +126,13 @@ static void __init omap3_beagle_init_rev(void)
>  		printk(KERN_INFO "OMAP3 Beagle Rev: xM\n");
>  		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
>  		break;
> +	case 2:
> +		printk(KERN_INFO "OMAP3 Beagle Rev: xM\n");
> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XMC;
> +		break;
>  	default:
>  		printk(KERN_INFO "OMAP3 Beagle Rev: unknown %hd\n", beagle_rev);
> -		omap3_beagle_version = OMAP3BEAGLE_BOARD_UNKN;
> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XMC;
>  	}
>  }

Maybe just set up static struct omap3_beagle that contains the
various things to initialize. Then initialize it in omap3_beagle_init_rev
above.

Otherwise we'll end up adding more and more omap3_beagle_get_rev and
cpu_is_omap tests to this file and it will become hard to maintain.
  
> @@ -253,7 +260,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
>  {
>  	int r, usb_pwr_level;
>  
> -	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> +	if (cpu_is_omap3630()) {
>  		mmc[0].gpio_wp = -EINVAL;
>  	} else if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
>  		(omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C4)) {

This would become:

	mmc[0].gpio_wp = beagle.gpio_wp;

> @@ -275,11 +282,10 @@ static int beagle_twl_gpio_setup(struct device *dev,
>  	 * high / others active low)
>  	 * DVI reset GPIO is different between beagle revisions
>  	 */
> -	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> -		usb_pwr_level = GPIOF_OUT_INIT_HIGH;
> +	if (cpu_is_omap3630()) {
>  		beagle_dvi_device.reset_gpio = 129;
>  		/*
> -		 * gpio + 1 on Xm controls the TFP410's enable line (active low)
> +		 * gpio + 1 on xM controls the TFP410's enable line (active low)
>  		 * gpio + 2 control varies depending on the board rev as below:
>  		 * P7/P8 revisions(prototype): Camera EN
>  		 * A2+ revisions (production): LDO (DVI, serial, led blocks)

This would be just:

	usb_pwr_level = beagle.usb_pwr_level;

And so on.

Regards,

Tony
