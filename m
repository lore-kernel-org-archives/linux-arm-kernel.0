From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 15 May 2014 11:41:57 +0300
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <20140513212639.GA18001@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com> <536C924E.5000307@ti.com>
 <20140509153008.GC17814@atomide.com> <20140513212639.GA18001@atomide.com>
Message-ID: <53747DD5.2030406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/14 00:26, Tony Lindgren wrote:

> +	/* lcd MO */
> +	ddata->mo_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 1, "mode");
> +	if (PTR_ERR(ddata->mo_gpio) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	if (!IS_ERR(ddata->mo_gpio))
> +		if (gpiod_get_raw_value_cansleep(ddata->mo_gpio))
> +			ddata->flags |= SHARP_LS_QVGA;

Shouldn't there be an explicit flag in the DT data for this? If the
panel's MO pin is hardwired to, say, pull up, then the mode-gpios won't
have MO gpio, right? So something like:


mode-gpios = <0					/* high, lcd MO */
	      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
	      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */

vga-mode;	/* MO hardwired high */



Btw, the gpio.txt has each gpio inside <>:

chipsel-gpios = <&gpio1 12 0>,
		 <&gpio1 13 0>,
		 <0>, /* holes are permitted, means no GPIO 2 */
		 <&gpio2 2>;

Is that equivalent to having all gpios inside <>?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/f1095dc8/attachment.sig>
