From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 01 Sep 2011 20:27:30 +0200
Subject: [PATCH 04/13] mfd: twl-core: Add initial DT support for
	twl4030/twl6030
In-Reply-To: <1314897689-17791-5-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
	<1314897689-17791-5-git-send-email-b-cousson@ti.com>
Message-ID: <4690440.pddZTpGgxd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 September 2011 19:21:20 Benoit Cousson wrote:
> +#ifdef CONFIG_OF
> +#define MODALIAS_SIZE 32
> +
> +static int add_of_children(struct i2c_client *client, unsigned long features)
> +{
> +       u32 reg;
> +       struct device *child, *dev = &client->dev;
> +       struct device_node *node, *parent = client->dev.of_node;
> +       int irq;
> +       char alias[MODALIAS_SIZE];
> +
> +       for_each_child_of_node(parent, node) {
> +               if (of_property_read_u32(node, "reg", &reg)) {
> +                       dev_err(dev, "%s(): invalid reg on %s\n", __func__,
> +                               node->full_name);
> +                       continue;
> +               }
> +

Have you tried just calling calling of_platform_bus_probe on the
parent? If all child devices are in the device tree, I think that 
should work, too. It probably requires some tweaking in the
child drivers though.

	Arnd
