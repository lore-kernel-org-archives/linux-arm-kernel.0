From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 25 Jan 2015 16:18:49 +0100
Subject: [PATCH 0/4] Drop legacy support for omap3517
In-Reply-To: <201501241300.00723@pali>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <20150113204219.GJ2419@atomide.com>
 <20150115142536.GC512@earth.universe> <201501241300.00723@pali>
Message-ID: <20150125151848.GF2719@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 24, 2015 at 01:00:00PM +0100, Pali Roh?r wrote:
> Another regression for DT setup (which does not occur for board code):
> 
> omap_hsmmc driver does not export slot_name sysfs entry because
> it not supported by DT yet. Entry slot_name is used by userspace
> application to determinate if mmc block device is internal eMMC
> memory or external uSD card. So support for this property also in
> DT is needed.
> 
> Here is simple patch which fix this problem:
> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 8571027..31ca609 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -665,6 +665,7 @@
>  };
>  
>  &mmc1 {
> +	slot-name = "external";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc1_pins>;
>  	vmmc-supply = <&vmmc1>;
> @@ -674,6 +675,7 @@
>  
>  /* most boards use vaux3, only some old versions use vmmc2 instead */
>  &mmc2 {
> +	slot-name = "internal";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc2_pins>;
>  	vmmc-supply = <&vaux3>;
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 7c71dcd..cd189eb 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2021,6 +2021,8 @@ static struct omap_hsmmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>  	if (of_find_property(np, "enable-sdio-wakeup", NULL))
>  		pdata->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>  
> +	of_property_read_string(np, "slot-name", &pdata->name);
> +
>  	return pdata;
>  }
>  #else

I suggest to use "label" as DT property name, which is also used for
labeling GPIOs, LEDs, partitions, ... in DT.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150125/e97be3c8/attachment.sig>
