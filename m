From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 10 Mar 2015 10:16:53 +0100
Subject: [PATCH 2/3] drm/bridge: dw-hdmi: support optional supply
 regulators
In-Reply-To: <2297963.iMSNqyfSUx@phil>
References: <1429128.MSqYm0qZ9p@phil> <2297963.iMSNqyfSUx@phil>
Message-ID: <1425979013.3141.17.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

Am Dienstag, den 10.03.2015, 00:22 +0100 schrieb Heiko Stuebner:
> diff --git a/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt b/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
> index a905c14..bb74640 100644
> --- a/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
> +++ b/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
> @@ -22,6 +22,11 @@ Optional properties
>  - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
>  - clocks, clock-names: phandle to the HDMI CEC clock, name should be "cec"
>  
> +Supplies:

"Optional supplies:" ? It seems to be common to always state optional or
required for the properties.

> +rockchip,rk3288-dw-hdmi handles two optional power supplies:
> +- avdd1v0-supply: 1.0V power supply
> +- avdd1v8-supply: 1.8V power supply
> +
>  Example:
>  	hdmi: hdmi at 0120000 {
>  		compatible = "fsl,imx6q-hdmi";
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> index cd6a706..9f8999d 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> @@ -17,6 +17,7 @@
>  #include <linux/clk.h>
>  #include <linux/hdmi.h>
>  #include <linux/of_device.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <drm/drm_of.h>
>  #include <drm/drmP.h>
> @@ -114,6 +115,9 @@ struct dw_hdmi {
>  	struct hdmi_data_info hdmi_data;
>  	const struct dw_hdmi_plat_data *plat_data;
>  

Superfluous empty line.

> +	struct regulator_bulk_data *supplies;
> +	int nsupplies;
> +
>  	int vic;
>  
>  	u8 edid[HDMI_EDID_LEN];
> @@ -879,6 +883,12 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi)
>  	int i, ret;
>  	bool cscon = false;
>  
> +	if (hdmi->nsupplies > 0) {
> +		ret = regulator_bulk_enable(hdmi->nsupplies, hdmi->supplies);
> +		if (ret)
> +			return ret;
> +	}
> +

Are these really supplies to the PHY or is this just a convenient place
to enable them? Looking at the i.MX6 docs, I suppose yes.

>  	/*check csc whether needed activated in HDMI mode */
>  	cscon = (is_color_space_conversion(hdmi) &&
>  			!hdmi->hdmi_data.video_mode.mdvi);
> @@ -1105,6 +1115,9 @@ static void dw_hdmi_phy_disable(struct dw_hdmi *hdmi)
>  	dw_hdmi_phy_enable_tmds(hdmi, 0);
>  	dw_hdmi_phy_enable_power(hdmi, 0);
>  
> +	if (hdmi->nsupplies > 0)
> +		regulator_bulk_disable(hdmi->nsupplies, hdmi->supplies);
> +
>  	hdmi->phy_enabled = false;
>  }
>  
> @@ -1549,7 +1562,8 @@ static int dw_hdmi_register(struct drm_device *drm, struct dw_hdmi *hdmi)
>  int dw_hdmi_bind(struct device *dev, struct device *master,
>  		 void *data, struct drm_encoder *encoder,
>  		 struct resource *iores, int irq,
> -		 const struct dw_hdmi_plat_data *plat_data)
> +		 const struct dw_hdmi_plat_data *plat_data,
> +		 struct regulator_bulk_data *supplies, int nsupplies)

I'm not sure I like this function sprouting so many parameters. Is there
a good reason not to add this to struct dw_hdmi_plat_data?

>  {
>  	struct drm_device *drm = data;
>  	struct device_node *np = dev->of_node;
> @@ -1602,6 +1616,17 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
>  	if (IS_ERR(hdmi->regs))
>  		return PTR_ERR(hdmi->regs);
>  
> +	if (nsupplies > 0) {
> +		ret = devm_regulator_bulk_get(hdmi->dev, nsupplies, supplies);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +		if (ret)
> +			nsupplies = 0;
> +	}
> +
> +	hdmi->supplies = supplies;
> +	hdmi->nsupplies = nsupplies;
> +
>  	hdmi->isfr_clk = devm_clk_get(hdmi->dev, "isfr");
>  	if (IS_ERR(hdmi->isfr_clk)) {
>  		ret = PTR_ERR(hdmi->isfr_clk);
> diff --git a/drivers/gpu/drm/imx/dw_hdmi-imx.c b/drivers/gpu/drm/imx/dw_hdmi-imx.c
> index 121d30c..153e259 100644
> --- a/drivers/gpu/drm/imx/dw_hdmi-imx.c
> +++ b/drivers/gpu/drm/imx/dw_hdmi-imx.c
> @@ -214,7 +214,8 @@ static int dw_hdmi_imx_bind(struct device *dev, struct device *master,
>  	drm_encoder_init(drm, encoder, &dw_hdmi_imx_encoder_funcs,
>  			 DRM_MODE_ENCODER_TMDS);
>  
> -	return dw_hdmi_bind(dev, master, data, encoder, iores, irq, plat_data);
> +	return dw_hdmi_bind(dev, master, data, encoder, iores, irq, plat_data,
> +			    NULL, 0);
>  }
>  
>  static void dw_hdmi_imx_unbind(struct device *dev, struct device *master,
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index d236faa..c085e88 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -11,6 +11,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <drm/drm_of.h>
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -24,6 +25,8 @@
>  #define GRF_SOC_CON6                    0x025c
>  #define HDMI_SEL_VOP_LIT                (1 << 4)
>  
> +#define HDMI_NUM_REGULATORS             2
> +
>  struct rockchip_hdmi {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -248,6 +251,7 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
>  	struct platform_device *pdev = to_platform_device(dev);
>  	const struct dw_hdmi_plat_data *plat_data;
>  	const struct of_device_id *match;
> +	struct regulator_bulk_data *supplies;
>  	struct drm_device *drm = data;
>  	struct drm_encoder *encoder;
>  	struct rockchip_hdmi *hdmi;
> @@ -275,6 +279,14 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
>  	if (!iores)
>  		return -ENXIO;
>  
> +	supplies = devm_kcalloc(&pdev->dev, HDMI_NUM_REGULATORS,
> +				sizeof(*supplies), GFP_KERNEL);
> +	if (!supplies)
> +		return -ENOMEM;
> +
> +	supplies[0].supply = "avdd1v0";
> +	supplies[1].supply = "avdd1v8";
> +
>  	platform_set_drvdata(pdev, hdmi);
>  
>  	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
> @@ -297,7 +309,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
>  	drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
>  			 DRM_MODE_ENCODER_TMDS);
>  
> -	return dw_hdmi_bind(dev, master, data, encoder, iores, irq, plat_data);
> +	return dw_hdmi_bind(dev, master, data, encoder, iores, irq, plat_data,
> +			    supplies, HDMI_NUM_REGULATORS);
>  }
>  
>  static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 5a4f490..7b0fac5 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -57,5 +57,6 @@ void dw_hdmi_unbind(struct device *dev, struct device *master, void *data);
>  int dw_hdmi_bind(struct device *dev, struct device *master,
>  		 void *data, struct drm_encoder *encoder,
>  		 struct resource *iores, int irq,
> -		 const struct dw_hdmi_plat_data *plat_data);
> +		 const struct dw_hdmi_plat_data *plat_data,
> +		 struct regulator_bulk_data *supplies, int nsupplies);
>  #endif /* __IMX_HDMI_H__ */

regards
Philipp
