From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 3 Feb 2016 11:29:29 +0800
Subject: [PATCH v8 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1454300012-32552-2-git-send-email-jitao.shi@mediatek.com>
References: <1454300012-32552-1-git-send-email-jitao.shi@mediatek.com>
 <1454300012-32552-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <CAGS+omAhExDg1H96nFY1EEKwTPVsnS6vNnxJCPYL4QwMt+hAcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

One more comment, inline...

On Mon, Feb 1, 2016 at 12:13 PM, Jitao Shi <jitao.shi@mediatek.com> wrote:
> This patch adds drm_bridge driver for parade DSI to eDP bridge chip.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>

[snip]

> +static int ps8640_probe(struct i2c_client *client,
> +                       const struct i2c_device_id *id)
> +{
> +       struct device *dev = &client->dev;
> +       struct ps8640 *ps_bridge;
> +       struct device_node *np = dev->of_node;
> +       struct device_node *port, *out_ep;
> +       struct device_node *panel_node = NULL;
> +       int i, ret;
> +
> +       ps_bridge = devm_kzalloc(dev, sizeof(*ps_bridge), GFP_KERNEL);
> +       ps_bridge->dsi = devm_kzalloc(dev, sizeof(struct mipi_dsi_device),
> +                                     GFP_KERNEL);
> +       if (!ps_bridge) {
> +               ret = -ENOMEM;
> +               goto exit;
> +       }
> +       /* port at 1 is ps8640 output port */
> +       port = of_graph_get_port_by_id(np, 1);
> +       if (port) {
> +               out_ep = of_get_child_by_name(port, "endpoint");
> +               of_node_put(port);
> +               if (out_ep) {
> +                       panel_node = of_graph_get_remote_port_parent(out_ep);
> +                       of_node_put(out_ep);
> +               }
> +       }
> +       if (panel_node) {
> +               ps_bridge->panel = of_drm_find_panel(panel_node);
> +               of_node_put(panel_node);
> +               if (!ps_bridge->panel) {
> +                       ret = -EPROBE_DEFER;
> +                       goto exit;
> +               }
> +       }
> +
> +       ps_bridge->pwr_3v3_supply = devm_regulator_get(dev, "vdd33");
> +       if (IS_ERR(ps_bridge->pwr_3v3_supply)) {
> +               ret = PTR_ERR(ps_bridge->pwr_3v3_supply);
> +               dev_err(dev, "cannot get vdd33 supply: %d\n", ret);
> +               goto exit;
> +       }
> +
> +       ps_bridge->pwr_1v2_supply = devm_regulator_get(dev, "vdd12");

Since we have two regulators, and they must always be enabled &
disabled together, we can just use the 'bulk regulator' APIs:

  devm_regulator_bulk_get()
  regulator_bulk_enable()
  regulator_bulk_disable()
