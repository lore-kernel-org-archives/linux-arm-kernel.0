From: architt@codeaurora.org (Archit Taneja)
Date: Mon, 12 Sep 2016 14:01:01 +0530
Subject: [PATCH v3 1/4] drm/bridge: Add RGB to VGA bridge support
In-Reply-To: <20160908121751.16911-2-maxime.ripard@free-electrons.com>
References: <20160908121751.16911-1-maxime.ripard@free-electrons.com>
 <20160908121751.16911-2-maxime.ripard@free-electrons.com>
Message-ID: <57D667C5.2080800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/08/2016 05:47 PM, Maxime Ripard wrote:
> Some boards have an entirely passive RGB to VGA bridge, based on either
> DACs or resistor ladders.
>
> Those might or might not have an i2c bus routed to the VGA connector in
> order to access the screen EDIDs.
>
> Add a bridge that doesn't do anything but expose the modes available on the
> screen, either based on the EDIDs if available, or based on the XGA
> standards.

Some minor comments below, besides the ones by ChenYu.

>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   .../bindings/display/bridge/rgb-to-vga-bridge.txt  |  52 +++++
>   drivers/gpu/drm/bridge/Kconfig                     |   6 +
>   drivers/gpu/drm/bridge/Makefile                    |   1 +
>   drivers/gpu/drm/bridge/rgb-to-vga.c                | 232 +++++++++++++++++++++
>   4 files changed, 291 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
>   create mode 100644 drivers/gpu/drm/bridge/rgb-to-vga.c
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt b/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
> new file mode 100644
> index 000000000000..83a053fb51a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
> @@ -0,0 +1,52 @@
> +Passive RGB to VGA bridge
> +-------------------------
> +
> +This binding is aimed for entirely passive RGB to VGA bridges that do not
> +require any configuration.
> +
> +Required properties:
> +
> +- compatible: Must be "rgb-to-vga-bridge"
> +
> +Required nodes:
> +
> +This device has two video ports. Their connections are modeled using the OF
> +graph bindings specified in Documentation/devicetree/bindings/graph.txt.
> +
> +- Video port 0 for RGB input
> +- Video port 1 for VGA output
> +
> +
> +Example
> +-------
> +
> +bridge {
> +	compatible = "rgb-to-vga-bridge";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;

The above 2 properties required for the individual port nodes, right?

> +			reg = <0>;
> +
> +			vga_bridge_in: endpoint {
> +				remote-endpoint = <&tcon0_out_vga>;
> +			};
> +		};
> +
> +		port at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			vga_bridge_out: endpoint {
> +				remote-endpoint = <&vga_con_in>;
> +			};
> +		};
> +	};
> +};
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index b590e678052d..42b95adf5091 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -17,6 +17,12 @@ config DRM_ANALOGIX_ANX78XX
>   	  the HDMI output of an application processor to MyDP
>   	  or DisplayPort.
>
> +config DRM_RGB_TO_VGA
> +	tristate "Dumb RGB to VGA Bridge support"
> +	select DRM_KMS_HELPER

In the current state of the driver, we need to rely on OF support for
it to function properly. I guess we need to depend on CONFIG_OF here.

> +	help
> +	  Support for passive RGB to VGA bridges
> +
>   config DRM_DW_HDMI
>   	tristate
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index efdb07e878f5..3bb8cbe09fe9 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,6 +1,7 @@
>   ccflags-y := -Iinclude/drm
>
>   obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
> +obj-$(CONFIG_DRM_RGB_TO_VGA) += rgb-to-vga.o
>   obj-$(CONFIG_DRM_DW_HDMI) += dw-hdmi.o
>   obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw-hdmi-ahb-audio.o
>   obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
> diff --git a/drivers/gpu/drm/bridge/rgb-to-vga.c b/drivers/gpu/drm/bridge/rgb-to-vga.c
> new file mode 100644
> index 000000000000..84b1b10198a4
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/rgb-to-vga.c
> @@ -0,0 +1,232 @@
> +
> +#include <linux/module.h>
> +#include <linux/of_graph.h>
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_crtc_helper.h>
> +
> +struct dumb_vga {
> +	struct drm_bridge	bridge;
> +	struct drm_connector	connector;
> +
> +	struct i2c_adapter	*ddc;
> +};
> +
> +static inline struct dumb_vga *
> +drm_bridge_to_dumb_vga(struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct dumb_vga, bridge);
> +}
> +
> +static inline struct dumb_vga *
> +drm_connector_to_dumb_vga(struct drm_connector *connector)
> +{
> +	return container_of(connector, struct dumb_vga, connector);
> +}
> +
> +static int dumb_vga_get_modes(struct drm_connector *connector)
> +{
> +	struct dumb_vga *vga = drm_connector_to_dumb_vga(connector);
> +	struct edid *edid;
> +	int ret;
> +
> +	if (IS_ERR(vga->ddc))
> +		goto fallback;
> +
> +	edid = drm_get_edid(connector, vga->ddc);
> +	if (!edid) {
> +		DRM_INFO("EDID readout failed, falling back to standard modes\n");
> +		goto fallback;
> +	}
> +
> +	drm_mode_connector_update_edid_property(connector, edid);
> +	return drm_add_edid_modes(connector, edid);
> +
> +fallback:
> +	/*
> +	 * In case we cannot retrieve the EDIDs (broken or missing i2c
> +	 * bus), fallback on the XGA standards
> +	 */
> +	ret = drm_add_modes_noedid(connector, 1920, 1200);
> +
> +	/* And prefer a mode pretty much anyone can handle */
> +	drm_set_preferred_mode(connector, 1024, 768);
> +
> +	return ret;
> +}
> +
> +static struct drm_encoder *
> +dumb_vga_best_encoder(struct drm_connector *connector)
> +{
> +	struct dumb_vga *vga = drm_connector_to_dumb_vga(connector);
> +
> +	return vga->bridge.encoder;
> +}
> +
> +static struct drm_connector_helper_funcs dumb_vga_con_helper_funcs = {
> +	.get_modes	= dumb_vga_get_modes,
> +	.best_encoder	= dumb_vga_best_encoder,
> +};
> +
> +static enum drm_connector_status
> +dumb_vga_connector_detect(struct drm_connector *connector, bool force)
> +{
> +	struct dumb_vga *vga = drm_connector_to_dumb_vga(connector);
> +
> +	/*
> +	 * Even if we have an I2C bus, we can't assume that the cable
> +	 * is disconnected if drm_probe_ddc. Some cables don't wire

s/if/in ?

> +	 * the DDC pins, or the I2C bus might be disfunctional.

s/disfunctional/not functional

Looks good otherwise.

Archit

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
