From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 21 Jun 2017 11:52:56 +0100
Subject: [project-aspen-dev] [PATCH 3/5] phy: add inno-usb2-phy driver for
 hi3798cv200 SoC
In-Reply-To: <1498035645-22804-4-git-send-email-xuejiancheng@hisilicon.com>
References: <1498035645-22804-1-git-send-email-xuejiancheng@hisilicon.com>
 <1498035645-22804-4-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <53b0ac0f-91b8-1ad3-91a4-a776b028fc8f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/17 10:00, Jiancheng Xue wrote:
> From: Pengcheng Li <lpc.li@hisilicon.com>
> 
> Add inno-usb2-phy driver for hi3798cv200 SoC.
> 
> Signed-off-by: Pengcheng Li <lpc.li@hisilicon.com>
> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> ---
>   drivers/phy/Kconfig              |  10 ++
>   drivers/phy/Makefile             |   1 +
>   drivers/phy/phy-hisi-inno-usb2.c | 287 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 298 insertions(+)
>   create mode 100644 drivers/phy/phy-hisi-inno-usb2.c
> 
> ...
> diff --git a/drivers/phy/phy-hisi-inno-usb2.c b/drivers/phy/phy-hisi-inno-usb2.c
> new file mode 100644
> index 0000000..582c500
> --- /dev/null
> +++ b/drivers/phy/phy-hisi-inno-usb2.c
> @@ -0,0 +1,287 @@
 > ...> +static int hisi_inno_phy_of_get_ports(struct device *dev,
> +					struct  hisi_inno_phy_priv *priv)
> +{
> +	struct device_node *node = dev->of_node;
> +	struct device_node *child;
> +	int port = 0;
> +	int ret;
> +
> +	priv->port_num = of_get_child_count(node);
> +	if (priv->port_num > MAX_PORTS) {
> +		dev_err(dev, "too many ports : %d (max = %d)\n",
> +				priv->port_num, MAX_PORTS);
> +		return -EINVAL;
> +	}
> +
> +	priv->ports = devm_kcalloc(dev, priv->port_num,
> +				sizeof(struct hisi_inno_phy_port), GFP_KERNEL);
> +	if (!priv->ports)
> +		return -ENOMEM;
> +
> +	for_each_child_of_node(node, child) {
> +		struct hisi_inno_phy_port *phy_port = &priv->ports[port];
> +
> +		phy_port->utmi_clk = devm_get_clk_from_child(dev, child, NULL);
> +		if (IS_ERR(phy_port->utmi_clk)) {
> +			ret = PTR_ERR(phy_port->utmi_clk);
> +			goto fail;
> +		}
> +
> +		phy_port->port_rst = of_reset_control_get_exclusive(child, "port_rst"); > +		if (IS_ERR(phy_port->port_rst)) {
> +			ret = PTR_ERR(phy_port->port_rst);
> +			goto fail;
> +		}
> +
> +		phy_port->utmi_rst = of_reset_control_get_exclusive(child, "utmi_rst");
> +		if (IS_ERR(phy_port->utmi_rst)) {
> +			ret = PTR_ERR(phy_port->utmi_rst);
> +			reset_control_put(phy_port->port_rst);
> +			goto fail;
> +		}
> +		port++;
> +	}
> +
> +	return 0;
> +
> +fail:
> +	while (--port >= 0) {
> +		struct hisi_inno_phy_port *phy_port = &priv->ports[port];
> +
> +		reset_control_put(phy_port->utmi_rst);
> +		reset_control_put(phy_port->port_rst) > +		clk_put(phy_port->utmi_clk);

clk_put() should not be needed here.

> +	}

Do we also need clean up code like this in a remove callback?


Daniel.
