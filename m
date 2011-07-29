From: balbi@ti.com (Felipe Balbi)
Date: Fri, 29 Jul 2011 17:05:16 +0300
Subject: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
In-Reply-To: <20110729134932.GA2258@foobar>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-4-git-send-email-khilman@ti.com>
	<20110722085716.GI32058@legolas.emea.dhcp.ti.com>
	<20110728055346.GA11921@foobar> <4E315C9F.1030801@ti.com>
	<CAOMWX4fYGD4aRomoHZjvy_F9CRb_U9UV4OOa0BgrzZhx81iQtQ@mail.gmail.com>
	<20110729134932.GA2258@foobar>
Message-ID: <20110729140515.GV31013@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Fri, Jul 29, 2011 at 08:49:34AM -0500, Nishanth Menon wrote:
> From f03490456e24f72ca5272303c95a6f0b212494d5 Mon Sep 17 00:00:00 2001
> From: Nishanth Menon <nm@ti.com>
> Date: Wed, 27 Jul 2011 15:02:32 -0500
> Subject: [PATCH 1/2] OMAP: PM: omap_device: add omap_hwmod_name_get_odev
> 
> An API which translates a standard hwmod name to corresponding
> omap_device is useful for drivers when they need to look up the
> device associated with a hwmod name to map back into the device
> structure pointers. These ideally should be used by drivers in
> mach directory. Using a generic hwmod name like "gpu" instead of
> the actual device name which could change in the future, allows
> us to:
> a) Could in effect help replace apis such as omap2_get_mpuss_device,
> omap2_get_iva_device, omap2_get_l3_device, omap4_get_dsp_device,
> etc..
> b) Scale to more devices rather than be restricted to named functions
> c) Simplify driver's platform_data from passing additional fields
> all doing the same thing with different function pointer names
> just for accessing a different device name.
> 
> Change-Id: Ib42d22b4a929982c87a79866e3d7dc6e41073a6c
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/omap_device.h |    1 +
>  arch/arm/plat-omap/omap_device.c              |   32 +++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> index 70d31d0..7a3c046 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -102,6 +102,7 @@ int omap_device_register(struct omap_device *od);
>  int omap_early_device_register(struct omap_device *od);
>  
>  void __iomem *omap_device_get_rt_va(struct omap_device *od);
> +struct omap_device *omap_hwmod_name_get_odev(const char *oh_name);
>  
>  /* OMAP PM interface */
>  int omap_device_align_pm_lat(struct platform_device *pdev,
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 92b4496..21df532 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -780,6 +780,38 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od)
>  	return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
>  }
>  
> +/**
> + * omap_hwmod_name_get_odev() - convert a hwmod name to omap_device pointer
> + * @oh_name: name of the hwmod device
> + *
> + * returns back a struct omap_device * pointer associated with a hwmod
> + * device represented by a hwmod_name
> + */
> +struct omap_device *omap_hwmod_name_get_odev(const char *oh_name)
> +{
> +	struct omap_hwmod *oh;
> +
> +	if (!oh_name) {
> +		WARN(1, "%s: no hwmod name!\n", __func__);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (IS_ERR_OR_NULL(oh)) {
> +		WARN(1, "%s: no hwmod for %s\n", __func__,
> +			oh_name);
> +		return ERR_PTR(oh ? PTR_ERR(oh) : -ENODEV);
> +	}
> +	if (IS_ERR_OR_NULL(oh->od)) {
> +		WARN(1, "%s: no omap_device for %s\n", __func__,
> +			oh_name);
> +		return ERR_PTR(oh->od ? PTR_ERR(oh->od) : -ENODEV);
> +	}
> +
> +	return oh->od;
> +}
> +EXPORT_SYMBOL(omap_hwmod_name_get_odev);

maybe EXPORT_SYMBOL_GPL() ?? Not sure we want non-GPL code to access
this ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110729/627d1615/attachment-0001.sig>
