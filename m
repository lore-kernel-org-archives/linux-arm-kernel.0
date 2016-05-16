From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 16 May 2016 16:24:15 +0300
Subject: [PATCH 13/20] drm/bridge: Add RGB to VGA bridge support
In-Reply-To: <1463402840-17062-14-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-14-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1773896.kpi58ilqqm@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thank you for the patch.

On Monday 16 May 2016 14:47:13 Maxime Ripard wrote:
> Some boards have an entirely passive RGB to VGA bridge, based on either
> DACs or resistor ladders.
> 
> Those might or might not have an i2c bus routed to the VGA connector in
> order to access the screen EDIDs.
> 
> Add a bridge that doesn't do anything but expose the modes available on the
> screen, either based on the EDIDs if available, or based on the XGA
> standards.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../bindings/display/bridge/dumb-vga.txt           |  40 +++++
>  drivers/gpu/drm/bridge/Kconfig                     |   6 +
>  drivers/gpu/drm/bridge/Makefile                    |   1 +
>  drivers/gpu/drm/bridge/dumb-vga.c                  | 186 ++++++++++++++++++
>  4 files changed, 233 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/bridge/dumb-vga.txt create mode
> 100644 drivers/gpu/drm/bridge/dumb-vga.c
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/dumb-vga.txt
> b/Documentation/devicetree/bindings/display/bridge/dumb-vga.txt new file
> mode 100644
> index 000000000000..757f04de97f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga.txt
> @@ -0,0 +1,40 @@
> +Passive RGB to VGA bridge
> +-------------------------
> +
> +This binding is aimed for entirely passive RGB to VGA bridges that do not
> +require any configuration.
> +
> +Required properties:
> +
> +- compatible: Should be "dumb-vga-bridge"
> +
> +Optional properties:
> +
> +- ddc-i2c-bus: phandle to the i2c bus used to communicate with the monitor
> +
> +Required nodes:
> +
> +This device has one video port. Its connection is modelled using the OF
> +graph bindings specified in Documentation/devicetree/bindings/graph.txt.
> This +connection is meant to be the RGB input bus.

Should the bridge have two ports, one input port connected to a display engine 
and one output port connected to a VGA connector ?

> +
> +
> +Example
> +-------
> +
> +bridge {
> +        compatible = "dumb-vga-bridge";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port at 0 {
> +                reg = <0>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                vga_input: endpoint at 0 {
> +                        reg = <0>;
> +                        remote-endpoint = <&tcon0_out_vga>;
> +               };
> +        };
> +};
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 8f7423f18da5..cf279956cbec 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -17,6 +17,12 @@ config DRM_ANALOGIX_ANX78XX
>  	  the HDMI output of an application processor to MyDP
>  	  or DisplayPort.
> 
> +config DRM_DUMB_VGA
> +	tristate "Dumb RGB to VGA Bridge support"
> +	select DRM_KMS_HELPER
> +	help
> +	  Support for passive RGB to VGA bridges
> +
>  config DRM_DW_HDMI
>  	tristate
>  	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/bridge/Makefile
> b/drivers/gpu/drm/bridge/Makefile index 96b13b30e6ab..63f21120e8f8 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,6 +1,7 @@
>  ccflags-y := -Iinclude/drm
> 
>  obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
> +obj-$(CONFIG_DRM_DUMB_VGA) += dumb-vga.o
>  obj-$(CONFIG_DRM_DW_HDMI) += dw-hdmi.o
>  obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw-hdmi-ahb-audio.o
>  obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
> diff --git a/drivers/gpu/drm/bridge/dumb-vga.c
> b/drivers/gpu/drm/bridge/dumb-vga.c new file mode 100644
> index 000000000000..2864fa535bf8
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/dumb-vga.c
> @@ -0,0 +1,186 @@
> +
> +#include <linux/module.h>
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
> +	if (!vga->ddc)
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

The DRM core adds modes up to 1024x768 in 
drm_helper_probe_single_connector_modes(). I wonder if it really makes sense 
to override that in drivers, compared to increasing the maximum resolution in 
the core. What we can reasonable expect from a VGA monitor doesn't really 
depend on which display engine it is connected to.

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
> +	return connector_status_connected;

Shouldn't that be connector_status_unknown if you have no information about 
the connection status ?

Would it make sense to add an optional GPIO-based connection detection to this 
driver ?

> +}
> +
> +static void
> +dumb_vga_connector_destroy(struct drm_connector *connector)
> +{
> +	drm_connector_cleanup(connector);
> +}
> +
> +static struct drm_connector_funcs dumb_vga_con_funcs = {
> +	.dpms			= drm_atomic_helper_connector_dpms,
> +	.detect			= dumb_vga_connector_detect,
> +	.fill_modes		= drm_helper_probe_single_connector_modes,
> +	.destroy		= dumb_vga_connector_destroy,
> +	.reset			= drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static int dumb_vga_attach(struct drm_bridge *bridge)
> +{
> +	struct dumb_vga *vga = drm_bridge_to_dumb_vga(bridge);
> +	int ret;
> +
> +	if (!bridge->encoder) {
> +		DRM_ERROR("Missing encoder\n");
> +		return -ENODEV;
> +	}
> +
> +	drm_connector_helper_add(&vga->connector,
> +				 &dumb_vga_con_helper_funcs);
> +	ret = drm_connector_init(bridge->dev, &vga->connector,
> +				 &dumb_vga_con_funcs, DRM_MODE_CONNECTOR_VGA);
> +	if (ret) {
> +		DRM_ERROR("Failed to initialize connector\n");
> +		return ret;
> +	}
> +
> +	drm_mode_connector_attach_encoder(&vga->connector,
> +					  bridge->encoder);
> +
> +	return 0;
> +}
> +
> +static void dumb_vga_nop(struct drm_bridge *bridge) {};
> +
> +static struct drm_bridge_funcs dumb_vga_bridge_funcs = {
> +	.attach		= dumb_vga_attach,
> +	.enable		= dumb_vga_nop,
> +	.disable	= dumb_vga_nop,
> +	.pre_enable	= dumb_vga_nop,
> +	.post_disable	= dumb_vga_nop,
> +};
> +
> +static int dumb_vga_probe(struct platform_device *pdev)
> +{
> +	struct dumb_vga *vga;
> +	struct device_node *ddc;
> +
> +	vga = devm_kzalloc(&pdev->dev, sizeof(*vga), GFP_KERNEL);
> +	if (!vga)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, vga);
> +
> +	ddc = of_parse_phandle(pdev->dev.of_node, "ddc-i2c-bus", 0);
> +	if (ddc) {
> +		vga->ddc = of_find_i2c_adapter_by_node(ddc);

You're leaking the reference to the I2C adapter.

Also, shouldn't you use of_get_i2c_adapter_by_node() ? Otherwise you won't 
take a reference to the adapter module.

> +		of_node_put(ddc);
> +
> +		if (!vga->ddc) {
> +			dev_err(&pdev->dev, "Couldn't retrieve i2c bus\n");
> +			return -EPROBE_DEFER;
> +		}
> +	} else {
> +		dev_info(&pdev->dev,
> +			 "No i2c bus specified... Disabling EDID readout\n");
> +	}
> +
> +	vga->bridge.funcs = &dumb_vga_bridge_funcs;
> +	vga->bridge.of_node = pdev->dev.of_node;
> +
> +	return drm_bridge_add(&vga->bridge);
> +}
> +
> +static int dumb_vga_remove(struct platform_device *pdev)
> +{
> +	struct dumb_vga *vga = platform_get_drvdata(pdev);
> +
> +	drm_bridge_remove(&vga->bridge);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dumb_vga_match[] = {
> +	{ .compatible = "dumb-vga-bridge" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dumb_vga_match);
> +
> +struct platform_driver dumb_vga_driver = {
> +	.probe	= dumb_vga_probe,
> +	.remove	= dumb_vga_remove,
> +	.driver		= {
> +		.name		= "dumb-vga-bridge",
> +		.of_match_table	= dumb_vga_match,
> +	},
> +};
> +module_platform_driver(dumb_vga_driver);
> +
> +MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
> +MODULE_DESCRIPTION("Dumb RGB to VGA bridge driver");
> +MODULE_LICENSE("GPL");

-- 
Regards,

Laurent Pinchart
