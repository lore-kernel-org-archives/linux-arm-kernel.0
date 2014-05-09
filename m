From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 9 May 2014 10:24:03 +0300
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <20140508233300.GI2198@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com>
Message-ID: <536C8293.4070506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/14 02:33, Tony Lindgren wrote:

> We can pass the GPIO configuration for ls037v7dw01 in a standard
> gpios property.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt
> @@ -0,0 +1,56 @@
> +SHARP LS037V7DW01 TFT-LCD panel
> +
> +Required properties:
> +- compatible: should be "sharp,ls037v7dw01"
> +
> +Optional properties:
> +- enable-gpios: a GPIO spec for the optional enable pin
> +  this pin is the INI pin as specified in the LS037V7DW01.pdf file.
> +- reset-gpios: a GPIO spec for the optional reset pin
> +  this pin is the RESB pin as specified in the LS037V7DW01.pdf file.
> +- mode-gpios: a GPIO 
> +  ordered MO, LR, and UD as specified in the LS037V7DW01.pdf file.
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

The video port data is required also. See for example
Documentation/devicetree/bindings/video/panel-dsi-cm.txt or
Documentation/devicetree/bindings/video/hdmi-connector.txt.

Also, all the bindings I've made are in
Documentation/devicetree/bindings/video/, and I'd rather keep the video
bindings OMAP uses in the same place.

> +This panel can have zero to five GPIOs to configure
> +to change configuration between QVGA and VGA mode
> +and the scan direction. As these pins can be also
> +configured with external pulls, all the GPIOs are
> +considered optional with holes in the array.
> +
> +Example when connected to a omap2+ based device:
> +
> +	lcd0: display {
> +		compatible = "sharp,ls037v7dw01";
> +		power-supply = <&lcd_3v3>;
> +		enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
> +		reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
> +		mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
> +			      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
> +			      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
> +
> +		panel-timing {
> +			clock-frequency = <19200000>;
> +			hback-porch = <28>;
> +			hactive = <480>;
> +			hfront-porch = <1>;
> +			hsync-len = <2>;
> +			vback-porch = <1>;
> +			vactive = <640>;
> +			vfront-porch = <1>;
> +			vsync-len = <1>;
> +			hsync-active = <0>;
> +			vsync-active = <0>;
> +			de-active = <1>;
> +			pixelclk-active = <1>;
> +		};

I don't think we should define panel-timing here. We know it's
sharp,ls037v7dw01, so the driver knows the video timings. Also, if we
would extend the driver to support both resolution modes, it needs to
support two different timings, so the above doesn't work in that case
either.

Although if the MO gpio is not controlled by the driver, we should tell
the driver whether that gpio is high or low.

> +static int sharp_ls_probe_of(struct platform_device *pdev)
> +{
> +	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct device_node *node = pdev->dev.of_node;
> +	struct omap_dss_device *in;
> +	struct display_timing timing;
> +	struct videomode vm;
> +	int r;
> +
> +	ddata->vcc = devm_regulator_get(&pdev->dev, "envdd");
> +	if (IS_ERR(ddata->vcc)) {
> +		dev_err(&pdev->dev, "failed to get regulator\n");
> +		return PTR_ERR(ddata->vcc);
> +	}
> +
> +	r = regulator_enable(ddata->vcc);
> +	if (r != 0) {
> +		dev_err(&pdev->dev, "failed to enable regulator\n");
> +		return r;
> +	}

The regulator should be enabled when the panel is enabled, not at probe
time.

> +static const struct of_device_id sharp_ls_of_match[] = {
> +	{ .compatible = "sharp,ls037v7dw01", },

At the moment our display drivers are OMAP specific, and for that reason
we should prefix the compatible strings with "omapdss,". For example,
drivers/video/fbdev/omap2/displays-new/panel-dsi-cm.c:

	{ .compatible = "omapdss,panel-dsi-cm", },

But we should still have the right compatible string in the .dts, so we
convert the compatible name in arch/arm/mach-omap2/display.c, with
'dss_compat_conv_list' array, to which this panel's name should be added.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/b9aeba1b/attachment.sig>
