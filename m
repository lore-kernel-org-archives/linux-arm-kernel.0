From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Sep 2011 15:58:26 -0700
Subject: [PATCH 10/11] arm/dts: OMAP4: Add a main ocp entry bound to
	l3-noc driver
In-Reply-To: <1316809399-19579-11-git-send-email-b-cousson@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
	<1316809399-19579-11-git-send-email-b-cousson@ti.com>
Message-ID: <20110923225825.GB6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [110923 12:50]:
> Used the main OCP node to add bindings with the l3_noc driver.
> Remove l3_noc static device creation if DT is populated.
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -16,6 +16,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
> @@ -77,6 +78,10 @@ static int __init omap4_l3_init(void)
>  	struct platform_device *pdev;
>  	char oh_name[L3_MODULES_MAX_LEN];
>  
> +	/* If dtb is there, the devices will be created dynamically */
> +	if (of_have_populated_dt())
> +		return -ENODEV;
> +
>  	/*
>  	 * To avoid code running on other OMAPs in
>  	 * multi-omap builds

How about just remove omap3_l3_init and omap4_l3_init completely
instead?

There should not be any need for the platform glue code if the
driver, it's OK for us to require that either DT is passed from
the bootloader or as appended DT as soon as the appended DT patches
are merged.

Regards,

Tony
