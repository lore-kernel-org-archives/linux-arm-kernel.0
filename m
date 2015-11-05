From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 05 Nov 2015 10:09:24 +0100
Subject: [RFC v2 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1446430166-7378-2-git-send-email-jitao.shi@mediatek.com>
References: <1446430166-7378-1-git-send-email-jitao.shi@mediatek.com>
 <1446430166-7378-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <1446714564.3894.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

some things I missed before.

Am Montag, den 02.11.2015, 10:09 +0800 schrieb Jitao Shi:
[...]
> +static int ps8640_regr(struct i2c_client *client, u16 i2c_addr,
> +		       u8 reg, u8 *value)
> +{
> +	int ret;
> +
> +	client->addr = i2c_addr;

I think i2c_new_dummy should be used to create additional clients for
the secondary addresses, instead of changing the address of the client
with every transfer.

> +	ret = i2c_master_send(client, &reg, 1);
> +	if (ret <= 0) {
> +		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = i2c_master_recv(client, value, 1);
> +	if (ret <= 0) {
> +		DRM_ERROR("Failed to recv i2c data, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
[...]
> +static int ps8640_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct ps8640 *ps_bridge;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *in_ep, *out_ep;
> +	struct device_node *panel_node = NULL;
> +	int ret;
> +	u32 temp_reg;
> +
> +	ps_bridge = devm_kzalloc(dev, sizeof(*ps_bridge), GFP_KERNEL);
> +	if (!ps_bridge)
> +		return -ENOMEM;
> +
> +	in_ep = of_graph_get_next_endpoint(np, NULL);
> +	if (in_ep) {
> +		out_ep = of_graph_get_next_endpoint(np, in_ep);
> +		of_node_put(in_ep);
> +		if (out_ep) {
> +			panel_node = of_graph_get_remote_port_parent(out_ep);
> +			of_node_put(out_ep);
> +		}
> +	}
> +	if (panel_node) {
> +		ps_bridge->panel = of_drm_find_panel(panel_node);
> +		of_node_put(panel_node);
> +		if (!ps_bridge->panel)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	ps_bridge->client = client;
> +
> +	ps_bridge->pwr_3v3_supply = devm_regulator_get(dev, "vdd33-supply");

Should be "vdd3", regulator_get will add the "-supply" suffix.

> +	if (IS_ERR(ps_bridge->pwr_3v3_supply)) {
> +		dev_err(dev, "cannot get ps_bridge->pwr_3v3_supply\n");
> +		return PTR_ERR(ps_bridge->pwr_3v3_supply);
> +	}
> +
> +	ps_bridge->pwr_1v2_supply = devm_regulator_get(dev, "vdd12-supply");

Same here, "vdd12".

> +	if (IS_ERR(ps_bridge->pwr_1v2_supply)) {
> +		dev_err(dev, "cannot get ps_bridge->pwr_1v2_supply\n");
> +		return PTR_ERR(ps_bridge->pwr_1v2_supply);
> +	}
> +
> +	ps_bridge->gpio_mode_sel_n = devm_gpiod_get(&client->dev, "mode-sel",
> +						    GPIOD_OUT_HIGH);
> +	if (IS_ERR(ps_bridge->gpio_mode_sel_n)) {
> +		ret = PTR_ERR(ps_bridge->gpio_mode_sel_n);
> +		DRM_ERROR("cannot get gpio_mode_sel_n %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = gpiod_direction_output(ps_bridge->gpio_mode_sel_n, 1);
> +	if (ret) {
> +		DRM_ERROR("cannot configure gpio_mode_sel_n\n");
> +		return ret;
> +	}
> +
> +	ps_bridge->gpio_slp_n = devm_gpiod_get(&client->dev, "sleep-gpios",
> +					       GPIOD_OUT_HIGH);

Should be "sleep", gpiod_get will add the "-gpios" suffix.

> +	if (IS_ERR(ps_bridge->gpio_slp_n)) {
> +		ret = PTR_ERR(ps_bridge->gpio_slp_n);
> +		DRM_ERROR("cannot get gpio_slp_n %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = gpiod_direction_output(ps_bridge->gpio_slp_n, 1);
> +	if (ret) {
> +		DRM_ERROR("cannot configure gpio_slp_n\n");
> +		return ret;
> +	}

This can be removed, the "devm_gpiod_get(..., GPIOD_OUT_HIGH);" already
does the same.

> +
> +	ps_bridge->gpio_rst_n = devm_gpiod_get(&client->dev, "reset",
> +					       GPIOD_OUT_HIGH);
> +	if (IS_ERR(ps_bridge->gpio_rst_n)) {
> +		ret = PTR_ERR(ps_bridge->gpio_rst_n);
> +		DRM_ERROR("cannot get gpio_rst_n %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = gpiod_direction_output(ps_bridge->gpio_rst_n, 1);
> +	if (ret) {
> +		DRM_ERROR("cannot configure gpio_rst_n\n");
> +		return ret;
> +	}

Same here, the gpiod_direction_output can be removed.

best regards
Philipp
