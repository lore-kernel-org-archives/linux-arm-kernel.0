From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 25 Sep 2017 22:24:41 +0930
Subject: [PATCH v2 5/5] clk: aspeed: Add reset controller
In-Reply-To: <20170921042641.7326-6-joel@jms.id.au>
References: <20170921042641.7326-1-joel@jms.id.au>
 <20170921042641.7326-6-joel@jms.id.au>
Message-ID: <1506344081.30138.32.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-21 at 13:56 +0930, Joel Stanley wrote:
> There are some resets that are not associated with gates. These are
> represented by a reset controller.
>?
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> ?drivers/clk/clk-aspeed.c?????????????????| 82 +++++++++++++++++++++++++++++++-
> ?include/dt-bindings/clock/aspeed-clock.h |??9 ++++
> ?2 files changed, 90 insertions(+), 1 deletion(-)
>?
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index dec9db4ec47b..db97c0f9f99e 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -17,6 +17,7 @@
> ?#include <linux/of_device.h>
> ?#include <linux/platform_device.h>
> ?#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> ?#include <linux/slab.h>
> ?#include <linux/spinlock.h>
> ?
> @@ -256,6 +257,68 @@ static const struct clk_ops aspeed_clk_gate_ops = {
> ?	.is_enabled = aspeed_clk_is_enabled,
> ?};
> ?
> +/**
> + * struct aspeed_reset - Aspeed reset controller
> + * @map: regmap to access the containing system controller
> + * @rcdev: reset controller device
> + */
> +struct aspeed_reset {
> +	struct regmap			*map;
> +	struct reset_controller_dev	rcdev;
> +};
> +
> +#define to_aspeed_reset(p) container_of((p), struct aspeed_reset, rcdev)
> +
> +static const u8 aspeed_resets[] = {
> +	25, /* x-dma */
> +	24, /* mctp */
> +	23, /* adc */
> +	22, /* jtag-master */
> +	18, /* mic */
> +	?9, /* pwm */
> +	?8, /* pci-vga */
> +	?2, /* i2c */
> +	?1, /* ahb */

Bit of a nit, but given you define macros for the indices, maybe use designated
initialisers and drop the comments.

> +};
> +
> +static int aspeed_reset_deassert(struct reset_controller_dev *rcdev,
> +				?unsigned long id)
> +{
> +	struct aspeed_reset *ar = to_aspeed_reset(rcdev);
> +	u32 rst = BIT(aspeed_resets[id]);
> +
> +	return regmap_update_bits(ar->map, ASPEED_RESET_CTRL, rst, 0);
> +}
> +
> +static int aspeed_reset_assert(struct reset_controller_dev *rcdev,
> +			???????unsigned long id)
> +{
> +	struct aspeed_reset *ar = to_aspeed_reset(rcdev);
> +	u32 rst = BIT(aspeed_resets[id]);
> +
> +	return regmap_update_bits(ar->map, ASPEED_RESET_CTRL, rst, rst);
> +}
> +
> +static int aspeed_reset_status(struct reset_controller_dev *rcdev,
> +			???????unsigned long id)
> +{
> +	struct aspeed_reset *ar = to_aspeed_reset(rcdev);
> +	u32 val, rst = BIT(aspeed_resets[id]);
> +	int ret;
> +
> +	ret = regmap_read(ar->map, ASPEED_RESET_CTRL, &val);
> +	if (ret)
> +		return ret;
> +
> +	return !!(val & rst);
> +}
> +
> +static const struct reset_control_ops aspeed_reset_ops = {
> +	.assert = aspeed_reset_assert,
> +	.deassert = aspeed_reset_deassert,
> +	.status = aspeed_reset_status,
> +};
> +
> ?static struct clk_hw *aspeed_clk_hw_register_gate(struct device *dev,
> ?		const char *name, const char *parent_name, unsigned long flags,
> ?		struct regmap *map, u8 clock_idx, u8 reset_idx,
> @@ -299,10 +362,11 @@ static int __init aspeed_clk_probe(struct platform_device *pdev)
> ?	const struct clk_div_table *mac_div_table;
> ?	const struct clk_div_table *div_table;
> ?	struct device *dev = &pdev->dev;
> +	struct aspeed_reset *ar;
> ?	struct regmap *map;
> ?	struct clk_hw *hw;
> ?	u32 val, rate;
> -	int i;
> +	int i, ret;
> ?
> ?	map = syscon_node_to_regmap(dev->of_node);
> ?	if (IS_ERR(map)) {
> @@ -310,6 +374,22 @@ static int __init aspeed_clk_probe(struct platform_device *pdev)
> ?		return PTR_ERR(map);
> ?	}
> ?
> +	ar = devm_kzalloc(dev, sizeof(*ar), GFP_KERNEL);
> +	if (!ar)
> +		return -ENOMEM;
> +
> +	ar->map = map;
> +	ar->rcdev.owner = THIS_MODULE;
> +	ar->rcdev.nr_resets = ARRAY_SIZE(aspeed_resets);
> +	ar->rcdev.ops = &aspeed_reset_ops;
> +	ar->rcdev.of_node = dev->of_node;
> +
> +	ret = devm_reset_controller_register(dev, &ar->rcdev);
> +	if (ret) {
> +		dev_err(dev, "could not register reset controller\n");
> +		return ret;
> +	}
> +
> ?	/* SoC generations share common layouts but have different divisors */
> ?	soc_data = of_device_get_match_data(&pdev->dev);
> ?	div_table = soc_data->div_table;
> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
> index afe06b77562d..a9d552b6bbd2 100644
> --- a/include/dt-bindings/clock/aspeed-clock.h
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -40,4 +40,13 @@
> ?#define ASPEED_CLK_GATE_SDCLKCLK	(22 + ASPEED_CLK_GATES)
> ?#define ASPEED_CLK_GATE_LHCCLK		(23 + ASPEED_CLK_GATES)
> ?
> +#define ASPEED_RESET_XDMA		0
> +#define ASPEED_RESET_MCTP		1
> +#define ASPEED_RESET_JTAG_MASTER	2
> +#define ASPEED_RESET_MIC		3
> +#define ASPEED_RESET_PWM		4
> +#define ASPEED_RESET_PCIVGA		5
> +#define ASPEED_RESET_I2C		6
> +#define ASPEED_RESET_AHB		7
> +
> ?#endif
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170925/645f6bb8/attachment.sig>
