From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 10 Aug 2017 16:39:18 +0300
Subject: [PATCH 1/2] drm/bridge/sii8620: add external connector handle
In-Reply-To: <1502371530-32260-2-git-send-email-m.purski@samsung.com>
References: <1502371530-32260-1-git-send-email-m.purski@samsung.com>
 <CGME20170810132556eucas1p2413e372ac3494e73dd07cb941a1baa3f@eucas1p2.samsung.com>
 <1502371530-32260-2-git-send-email-m.purski@samsung.com>
Message-ID: <6478480.TjcUCueU5y@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maciej,

Thank you for the patch.

On Thursday 10 Aug 2017 15:25:29 Maciej Purski wrote:
> The driver should be switched on if an external connector is plugged and
> switched off if it is unplugged. Extcon is optional. If it is not found,
> the driver stays in "always-on" mode.
> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  .../bindings/display/bridge/sil-sii8620.txt        |  4 ++
>  drivers/gpu/drm/bridge/sil-sii8620.c               | 83 ++++++++++++++++++-
>  2 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
> b/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt index
> 9409d9c..1f230bf 100644
> --- a/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
> @@ -10,6 +10,9 @@ Required properties:
>  	- clocks, clock-names: specification and name of "xtal" clock
>  	- video interfaces: Device node can contain video interface port
>  			    node for HDMI encoder according to [1].
> +Optional properties:
> +	- extcon: phandle to external connector for MHL cable changes
> +		  detection

The sii8620 DT node should model its connection to the MHL connector using OF 
graph, connecting a port to the MHL connector DT node through endpoints. I 
believe the extcon property should then be added to the MHL connector DT node, 
not the bridge.

>  [1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> 
> @@ -24,6 +27,7 @@ Example:
>  		reset-gpio = <&gpv7 0 0>;
>  		clocks = <&pmu_system_controller 0>;
>  		clock-names = "xtal";
> +		extcon = <&muic>;
> 
>  		port {
>  			mhl_to_hdmi: endpoint {
> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c
> b/drivers/gpu/drm/bridge/sil-sii8620.c index 2d51a22..5002654 100644
> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
> @@ -17,6 +17,7 @@
> 
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/extcon.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> @@ -78,6 +79,10 @@ struct sii8620 {
>  	struct edid *edid;
>  	unsigned int gen2_write_burst:1;
>  	enum sii8620_mt_state mt_state;
> +	struct extcon_dev *extcon;
> +	struct notifier_block extcon_nb;
> +	struct work_struct extcon_wq;
> +	bool extcon_attached;
>  	struct list_head mt_queue;
>  	struct {
>  		int r_size;
> @@ -2102,6 +2107,72 @@ static void sii8620_cable_in(struct sii8620 *ctx)
>  	enable_irq(to_i2c_client(ctx->dev)->irq);
>  }
> 
> +static void sii8620_cable_out(struct sii8620 *ctx)
> +{
> +	disable_irq(to_i2c_client(ctx->dev)->irq);
> +	sii8620_hw_off(ctx);
> +}
> +
> +static void sii8620_extcon_work(struct work_struct *work)
> +{
> +	struct sii8620 *ctx =
> +		container_of(work, struct sii8620, extcon_wq);
> +
> +	if (ctx->extcon_attached)
> +		sii8620_cable_in(ctx);
> +	else
> +		sii8620_cable_out(ctx);
> +}
> +
> +static int sii8620_extcon_notifier(struct notifier_block *self,
> +			unsigned long event, void *ptr)
> +{
> +	struct sii8620 *ctx =
> +		container_of(self, struct sii8620, extcon_nb);
> +
> +	ctx->extcon_attached = event;
> +	schedule_work(&ctx->extcon_wq);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int sii8620_extcon_init(struct sii8620 *ctx)
> +{
> +	struct extcon_dev *edev;
> +	int ret;
> +
> +	INIT_WORK(&ctx->extcon_wq, sii8620_extcon_work);
> +
> +	if (!of_property_read_bool(ctx->dev->of_node, "extcon")) {
> +		dev_info(ctx->dev, "no extcon found, switching to 'always on' 
mode\n");
> +		ctx->extcon_attached = true;
> +		return 0;
> +	}
> +
> +	edev = extcon_get_edev_by_phandle(ctx->dev, 0);
> +	if (IS_ERR(edev)) {
> +		if (PTR_ERR(edev) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_err(ctx->dev, "Invalid or missing extcon\n");
> +		return PTR_ERR(edev);
> +	}
> +
> +	ctx->extcon_attached = extcon_get_cable_state_(edev, EXTCON_DISP_MHL);
> +	dev_info(ctx->dev, "extcon(MHL) = %d\n", ctx->extcon_attached);
> +
> +	ctx->extcon = edev;
> +	ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
> +	ret = devm_extcon_register_notifier(ctx->dev, edev,
> +					EXTCON_DISP_MHL, &ctx->extcon_nb);
> +
> +	if (ret) {
> +		dev_err(ctx->dev, "failed to register notifier for MHL\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static inline struct sii8620 *bridge_to_sii8620(struct drm_bridge *bridge)
>  {
>  	return container_of(bridge, struct sii8620, bridge);
> @@ -2201,13 +2272,20 @@ static int sii8620_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
> 
> +	ret = sii8620_extcon_init(ctx);
> +	if (ret < 0) {
> +		dev_err(ctx->dev, "failed to initialize EXTCON\n");
> +		return ret;
> +	}
> +
>  	i2c_set_clientdata(client, ctx);
> 
>  	ctx->bridge.funcs = &sii8620_bridge_funcs;
>  	ctx->bridge.of_node = dev->of_node;
>  	drm_bridge_add(&ctx->bridge);
> 
> -	sii8620_cable_in(ctx);
> +	if (ctx->extcon_attached)
> +		sii8620_cable_in(ctx);
> 
>  	return 0;
>  }
> @@ -2216,7 +2294,8 @@ static int sii8620_remove(struct i2c_client *client)
>  {
>  	struct sii8620 *ctx = i2c_get_clientdata(client);
> 
> -	disable_irq(to_i2c_client(ctx->dev)->irq);
> +	if (!ctx->extcon_attached)
> +		sii8620_cable_out(ctx);
>  	drm_bridge_remove(&ctx->bridge);
>  	sii8620_hw_off(ctx);

-- 
Regards,

Laurent Pinchart
