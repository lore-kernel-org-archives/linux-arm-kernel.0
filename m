From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu, 05 Oct 2017 18:17:09 +1030
Subject: [PATCH v4 5/5] clk: aspeed: Add reset controller
In-Reply-To: <20171003065540.11722-6-joel@jms.id.au>
References: <20171003065540.11722-1-joel@jms.id.au>
 <20171003065540.11722-6-joel@jms.id.au>
Message-ID: <1507189629.5452.69.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-03 at 17:25 +1030, Joel Stanley wrote:
> There are some resets that are not associated with gates. These are
> represented by a reset controller.
>?
> Signed-off-by: Joel Stanley <joel@jms.id.au>

With respect to the Aspeed hardware reset bits:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

>?
> ---
> v3:
> ? - Add named initalisers for the reset defines
> ? - Add define for ADC
> ---
> ?drivers/clk/clk-aspeed.c?????????????????| 82 +++++++++++++++++++++++++++++++-
> ?include/dt-bindings/clock/aspeed-clock.h | 10 ++++
> ?2 files changed, 91 insertions(+), 1 deletion(-)
>?
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index a424b056e767..de491dc7f955 100644
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
> @@ -292,6 +293,68 @@ static const struct clk_ops aspeed_clk_gate_ops = {
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
> +	[ASPEED_RESET_XDMA]	= 25,
> +	[ASPEED_RESET_MCTP]	= 24,
> +	[ASPEED_RESET_ADC]	= 23,
> +	[ASPEED_RESET_JTAG_MASTER] = 22,
> +	[ASPEED_RESET_MIC]	= 18,
> +	[ASPEED_RESET_PWM]	=??9,
> +	[ASPEED_RESET_PCIVGA]	=??8,
> +	[ASPEED_RESET_I2C]	=??2,
> +	[ASPEED_RESET_AHB]	=??1,
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
> @@ -333,10 +396,11 @@ static int aspeed_clk_probe(struct platform_device *pdev)
> ?{
> ?	const struct aspeed_clk_soc_data *soc_data;
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
> @@ -344,6 +408,22 @@ static int aspeed_clk_probe(struct platform_device *pdev)
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
> ?	soc_data = of_device_get_match_data(dev);
> ?	if (!soc_data) {
> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
> index 4a99421d77c8..8e19646d8025 100644
> --- a/include/dt-bindings/clock/aspeed-clock.h
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -39,4 +39,14 @@
> ?
> ?#define ASPEED_NUM_CLKS			35
> ?
> +#define ASPEED_RESET_XDMA		0
> +#define ASPEED_RESET_MCTP		1
> +#define ASPEED_RESET_ADC		2
> +#define ASPEED_RESET_JTAG_MASTER	3
> +#define ASPEED_RESET_MIC		4
> +#define ASPEED_RESET_PWM		5
> +#define ASPEED_RESET_PCIVGA		6
> +#define ASPEED_RESET_I2C		7
> +#define ASPEED_RESET_AHB		8
> +
> ?#endif
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171005/75109006/attachment-0001.sig>
