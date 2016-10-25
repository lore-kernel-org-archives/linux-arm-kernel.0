From: architt@codeaurora.org (Archit Taneja)
Date: Tue, 25 Oct 2016 13:39:27 +0530
Subject: [PATCH v2 1/8] drm/bridge: rgb-to-vga: Support an enable GPIO
In-Reply-To: <20161020034344.14154-2-wens@csie.org>
References: <20161020034344.14154-1-wens@csie.org>
 <20161020034344.14154-2-wens@csie.org>
Message-ID: <0b5fbe8e-e51b-c874-e1a3-0b88dc65e361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/20/2016 09:13 AM, Chen-Yu Tsai wrote:
> Some rgb-to-vga bridges have an enable GPIO, either directly tied to
> an enable pin on the bridge IC, or indirectly controlling a power
> switch.
>
> Add support for it.

Does the bridge on your platform have an active/passive DAC, or is it a
smarter encoder chip that is capable of doing more? If so, it might be
good to have a separate DT compatible string to it, like what's done
in the patch titled:

drm: bridge: vga-dac: Add adi,adv7123 compatible string

so that we can switch to a different driver later if needed.

Thanks,
Archit

>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../bindings/display/bridge/dumb-vga-dac.txt       |  2 ++
>  drivers/gpu/drm/bridge/dumb-vga-dac.c              | 28 ++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> index 003bc246a270..d3484822bf77 100644
> --- a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> @@ -16,6 +16,8 @@ graph bindings specified in Documentation/devicetree/bindings/graph.txt.
>  - Video port 0 for RGB input
>  - Video port 1 for VGA output
>
> +Optional properties:
> +- enable-gpios: GPIO pin to enable or disable the bridge
>
>  Example
>  -------
> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> index afec232185a7..b487e5e9b56d 100644
> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> @@ -10,6 +10,7 @@
>   * the License, or (at your option) any later version.
>   */
>
> +#include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/of_graph.h>
>
> @@ -23,6 +24,7 @@ struct dumb_vga {
>  	struct drm_connector	connector;
>
>  	struct i2c_adapter	*ddc;
> +	struct gpio_desc	*enable_gpio;
>  };
>
>  static inline struct dumb_vga *
> @@ -124,8 +126,26 @@ static int dumb_vga_attach(struct drm_bridge *bridge)
>  	return 0;
>  }
>
> +static void dumb_vga_enable(struct drm_bridge *bridge)
> +{
> +	struct dumb_vga *vga = drm_bridge_to_dumb_vga(bridge);
> +
> +	if (vga->enable_gpio)
> +		gpiod_set_value_cansleep(vga->enable_gpio, 1);
> +}
> +
> +static void dumb_vga_disable(struct drm_bridge *bridge)
> +{
> +	struct dumb_vga *vga = drm_bridge_to_dumb_vga(bridge);
> +
> +	if (vga->enable_gpio)
> +		gpiod_set_value_cansleep(vga->enable_gpio, 0);
> +}
> +
>  static const struct drm_bridge_funcs dumb_vga_bridge_funcs = {
>  	.attach		= dumb_vga_attach,
> +	.enable		= dumb_vga_enable,
> +	.disable	= dumb_vga_disable,
>  };
>
>  static struct i2c_adapter *dumb_vga_retrieve_ddc(struct device *dev)
> @@ -169,6 +189,14 @@ static int dumb_vga_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, vga);
>
> +	vga->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> +						   GPIOD_OUT_LOW);
> +	if (IS_ERR(vga->enable_gpio)) {
> +		ret = PTR_ERR(vga->enable_gpio);
> +		dev_err(&pdev->dev, "failed to request GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
>  	vga->ddc = dumb_vga_retrieve_ddc(&pdev->dev);
>  	if (IS_ERR(vga->ddc)) {
>  		if (PTR_ERR(vga->ddc) == -ENODEV) {
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
