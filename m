From: architt@codeaurora.org (Archit Taneja)
Date: Tue, 15 Dec 2015 12:47:25 +0530
Subject: [PATCH v6 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1450150210-21951-2-git-send-email-jitao.shi@mediatek.com>
References: <1450150210-21951-1-git-send-email-jitao.shi@mediatek.com>
 <1450150210-21951-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <566FBE85.4060708@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/15/2015 09:00 AM, Jitao Shi wrote:
> This patch adds drm_bridge driver for parade DSI to eDP bridge chip.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
> Changes since v5
> -fix compile errors when CONFIG_GPIOLIB=n
> ---
>   drivers/gpu/drm/bridge/Kconfig         |   10 +
>   drivers/gpu/drm/bridge/Makefile        |    1 +
>   drivers/gpu/drm/bridge/parade-ps8640.c |  472 ++++++++++++++++++++++++++++++++
>   3 files changed, 483 insertions(+)
>   create mode 100644 drivers/gpu/drm/bridge/parade-ps8640.c
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 6dddd39..dcfdbc9 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -41,4 +41,14 @@ config DRM_PARADE_PS8622
>   	---help---
>   	  Parade eDP-LVDS bridge chip driver.
>
> +config DRM_PARADE_PS8640
> +	tristate "Parade PS8640 MIPI DSI to eDP Converter"
> +	depends on OF
> +	select DRM_KMS_HELPER
> +	select DRM_PANEL
> +	---help---
> +	  Choose this option if you have PS8640 for display
> +	  The PS8640 is a high-performance and low-power
> +	  MIPI DSI to eDP converter
> +
>   endmenu
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index d4e28be..272e3c01 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_DRM_DW_HDMI) += dw_hdmi.o
>   obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw_hdmi-ahb-audio.o
>   obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
>   obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
> +obj-$(CONFIG_DRM_PARADE_PS8640) += parade-ps8640.o
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> new file mode 100644
> index 0000000..bf0c3c37
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -0,0 +1,472 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_graph.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_panel.h>
> +
> +#include <drmP.h>
> +#include <drm_crtc_helper.h>
> +#include <drm_crtc.h>
> +#include <drm_mipi_dsi.h>

This doesn't seem to be used at the moment.

<snip>

> +
> +static int ps8640_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct ps8640 *ps_bridge;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *port, *out_ep;
> +	struct device_node *panel_node = NULL;
> +	int i, ret;
> +
> +	ps_bridge = devm_kzalloc(dev, sizeof(*ps_bridge), GFP_KERNEL);
> +	if (!ps_bridge)
> +		return -ENOMEM;
> +
> +	/* port at 1 is ps8640 output port */
> +	port = of_graph_get_port_by_id(np, 1);
> +	if (port) {
> +		out_ep = of_get_child_by_name(port, "endpoint");
> +		of_node_put(port);
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

The driver retrieves the panel from the output port via DT, but doesn't
retrieve the DSI host from the input port?

Wouldn't this driver need to call a "mipi_dsi_attach" at some point to
link with the DSI host (and pass parameters like number of lanes, color
format etc)?

I've been working on a patchset[1] which lets i2c drivers create mipi
dsi devices. I think this would be needed for the ps8640 driver too.

[1] https://lkml.org/lkml/2015/12/10/283

Archit

> +
> +	ps_bridge->page[0] = client;
> +	for (i = 1; i < 6; i++)
> +		ps_bridge->page[i] = i2c_new_dummy(client->adapter,
> +						   client->addr + i);
> +
> +	ps_bridge->pwr_3v3_supply = devm_regulator_get(dev, "vdd33");
> +	if (IS_ERR(ps_bridge->pwr_3v3_supply)) {
> +		ret = PTR_ERR(ps_bridge->pwr_3v3_supply);
> +		dev_err(dev, "cannot get vdd33 supply: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ps_bridge->pwr_1v2_supply = devm_regulator_get(dev, "vdd12");
> +	if (IS_ERR(ps_bridge->pwr_1v2_supply)) {
> +		ret = PTR_ERR(ps_bridge->pwr_1v2_supply);
> +		dev_err(dev, "cannot get vdd12 supply: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ps_bridge->gpio_mode_sel_n = devm_gpiod_get(&client->dev, "mode-sel",
> +						    GPIOD_OUT_HIGH);
> +	if (IS_ERR(ps_bridge->gpio_mode_sel_n)) {
> +		ret = PTR_ERR(ps_bridge->gpio_mode_sel_n);
> +		dev_err(dev, "cannot get gpio_mode_sel_n %d\n", ret);
> +		return ret;
> +	}
> +
> +	ps_bridge->gpio_slp_n = devm_gpiod_get(&client->dev, "sleep",
> +					       GPIOD_OUT_HIGH);
> +	if (IS_ERR(ps_bridge->gpio_slp_n)) {
> +		ret = PTR_ERR(ps_bridge->gpio_slp_n);
> +		dev_err(dev, "cannot get gpio_slp_n: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ps_bridge->gpio_rst_n = devm_gpiod_get(&client->dev, "reset",
> +					       GPIOD_OUT_HIGH);
> +	if (IS_ERR(ps_bridge->gpio_rst_n)) {
> +		ret = PTR_ERR(ps_bridge->gpio_rst_n);
> +		dev_err(dev, "cannot get gpio_rst_n: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ps_bridge->bridge.funcs = &ps8640_bridge_funcs;
> +	ps_bridge->bridge.of_node = dev->of_node;
> +	ret = drm_bridge_add(&ps_bridge->bridge);
> +	if (ret) {
> +		dev_err(dev, "Failed to add bridge: %d\n", ret);
> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(client, ps_bridge);
> +
> +	return 0;
> +}
> +
> +static int ps8640_remove(struct i2c_client *client)
> +{
> +	struct ps8640 *ps_bridge = i2c_get_clientdata(client);
> +
> +	drm_bridge_remove(&ps_bridge->bridge);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ps8640_i2c_table[] = {
> +	{"parade,ps8640", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, ps8640_i2c_table);
> +
> +static const struct of_device_id ps8640_match[] = {
> +	{ .compatible = "parade,ps8640" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ps8640_match);
> +
> +static struct i2c_driver ps8640_driver = {
> +	.id_table = ps8640_i2c_table,
> +	.probe = ps8640_probe,
> +	.remove = ps8640_remove,
> +	.driver = {
> +		.name = "parade,ps8640",
> +		.of_match_table = ps8640_match,
> +	},
> +};
> +module_i2c_driver(ps8640_driver);
> +
> +MODULE_AUTHOR("Jitao Shi <jitao.shi@mediatek.com>");
> +MODULE_AUTHOR("CK Hu <ck.hu@mediatek.com>");
> +MODULE_DESCRIPTION("PARADE ps8640 DSI-eDP converter driver");
> +MODULE_LICENSE("GPL v2");
>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, hosted by The Linux Foundation
