From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Apr 2018 12:56:32 -0500
Subject: [PATCH 1/3] drm/vc4: Remove the need for the GPU-subsystem DT
 node.
In-Reply-To: <20180409230040.1100-1-eric@anholt.net>
References: <20180409230040.1100-1-eric@anholt.net>
Message-ID: <20180413175632.oz62n363g6rxdp6z@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 04:00:38PM -0700, Eric Anholt wrote:
> The GPU subsystem node was a workaround to have a central device to
> bind V3D and display to.  Following the lead of 246774d17fc0
> ("drm/etnaviv: remove the need for a gpu-subsystem DT node"), remove
> the subsystem node usage and just create a platform device for the DRM
> device to attach to if any of the subsystem devices are present.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../bindings/display/brcm,bcm-vc4.txt         |  7 ----
>  drivers/gpu/drm/vc4/vc4_drv.c                 | 33 ++++++++++++++-----
>  drivers/gpu/drm/vc4/vc4_hvs.c                 |  1 +
>  drivers/gpu/drm/vc4/vc4_v3d.c                 |  1 +
>  4 files changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
> index 284e2b14cfbe..5fd4717101d6 100644
> --- a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
> @@ -4,9 +4,6 @@ The VC4 device present on the Raspberry Pi includes a display system
>  with HDMI output and the HVS (Hardware Video Scaler) for compositing
>  display planes.
>  
> -Required properties for VC4:
> -- compatible:	Should be "brcm,bcm2835-vc4" or "brcm,cygnus-vc4"
> -
>  Required properties for Pixel Valve:
>  - compatible:	Should be one of "brcm,bcm2835-pixelvalve0",
>  		  "brcm,bcm2835-pixelvalve1", or "brcm,bcm2835-pixelvalve2"
> @@ -153,10 +150,6 @@ v3d: v3d at 7ec00000 {
>  	interrupts = <1 10>;
>  };
>  
> -vc4: gpu {
> -	compatible = "brcm,bcm2835-vc4";
> -};
> -
>  panel: panel {
>  	compatible = "ontat,yx700wv03", "simple-panel";
>  
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index 7c95ed5c5cac..d282ab7de03a 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -364,22 +364,34 @@ static int vc4_platform_drm_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id vc4_of_match[] = {
> -	{ .compatible = "brcm,bcm2835-vc4", },
> -	{ .compatible = "brcm,cygnus-vc4", },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, vc4_of_match);
> -
>  static struct platform_driver vc4_platform_driver = {
>  	.probe		= vc4_platform_drm_probe,
>  	.remove		= vc4_platform_drm_remove,
>  	.driver		= {
>  		.name	= "vc4-drm",
> -		.of_match_table = vc4_of_match,
>  	},
>  };
>  
> +static bool
> +driver_of_table_has_a_match(const struct platform_driver *driver)
> +{
> +	int i;
> +

> +	for (i = 0; driver->driver.of_match_table[i].compatible; i++) {
> +		const char *compat = driver->driver.of_match_table[i].compatible;
> +		struct device_node *node;
> +
> +		while ((node = of_find_compatible_node(node, NULL, compat))) {
> +			if (of_device_is_available(node)) {
> +				of_node_put(node);
> +				return true;
> +			}
> +		}
> +	}

All this can be replaced with:

node = of_find_matching_node_and_match(NULL, driver->driver.of_match_table, NULL);
if (of_device_is_available(node)) {
	of_node_put(node);
	return true;
}

> +
> +	return false;
> +}
> +
