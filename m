From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 25 Apr 2015 22:11:40 +0200
Subject: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to
 the WDT driver.
In-Reply-To: <1429902534-2348-2-git-send-email-eric@anholt.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net>
 <1429902534-2348-2-git-send-email-eric@anholt.net>
Message-ID: <12253069.Jm7LIDAreu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 April 2015 12:08:54 Eric Anholt wrote:
> +/*
> + * We can't really power off, but if we do the normal reset scheme, and
> + * indicate to bootcode.bin not to reboot, then most of the chip will be
> + * powered off.
> + */
> +static void bcm2835_power_off(void)
> +{
> +       struct device_node *np =
> +               of_find_compatible_node(NULL, NULL, "brcm,bcm2835-pm-wdt");
> +       struct platform_device *pdev = of_find_device_by_node(np);
> +       struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
> +       u32 val;
> +

Instead of doing the lookup again here, I'd suggest using a static variable
in the driver to store the device pointer for the device used on power_off.

Make sure that the device remove callback assigns it back to NULL though
and that the function checks for NULL pointer.

Aside from this, the patch looks great.

	Arnd
