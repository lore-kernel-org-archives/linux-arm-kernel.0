From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Sep 2011 10:30:48 -0700
Subject: [PATCH v3 5/6] OMAP: omap_device: Create a default
	omap_device_pm_latency
In-Reply-To: <1317143886-13285-6-git-send-email-b-cousson@ti.com>
References: <1317143886-13285-1-git-send-email-b-cousson@ti.com>
	<1317143886-13285-6-git-send-email-b-cousson@ti.com>
Message-ID: <20110927173048.GM6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [110927 09:45]:
> Most devices are using the same default omap_device_pm_latency structure
> during device built. In order to avoid the duplication of the same
> structure everywhere, add a default structure that will be used if
> the device does not have an explicit one.
> 
> Next patches will clean the duplicated structures.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/plat-omap/omap_device.c |   19 ++++++++++++++++++-
>  1 files changed, 18 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index f832f92..cd8d977 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -97,6 +97,14 @@
>  static int omap_device_register(struct platform_device *pdev);
>  static int omap_early_device_register(struct platform_device *pdev);
>  
> +static struct omap_device_pm_latency omap_default_latency[] = {
> +	{
> +		.deactivate_func = omap_device_idle_hwmods,
> +		.activate_func   = omap_device_enable_hwmods,
> +		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> +	}
> +};
> +
>  /* Private functions */

Isn't this racey between devices if the latency values get adjusted
automatically for each device?

Tony
