From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 16 Aug 2016 15:34:35 +0200
Subject: [PATCH 1/3] clk: meson: Add GXBB AO Clock and Reset controller
 driver
In-Reply-To: <20160813012910.GT361@codeaurora.org>
References: <1470734008-18849-1-git-send-email-narmstrong@baylibre.com>
 <1470734008-18849-2-git-send-email-narmstrong@baylibre.com>
 <20160813012910.GT361@codeaurora.org>
Message-ID: <16163435-1310-043d-804f-3bb1fd33cff4@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 08/13/2016 03:29 AM, Stephen Boyd wrote:
> On 08/09, Neil Armstrong wrote:
>> diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
>> new file mode 100644
>> index 0000000..56a9186
>> --- /dev/null
>> +++ b/drivers/clk/meson/gxbb-aoclk.c
>> @@ -0,0 +1,203 @@

[...]

>> + */
>> +#include <linux/clk.h>
> 
> Is this include used?

No !

> 
>> +#include <linux/clk-provider.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/module.h>
>> +#include <dt-bindings/clock/gxbb-aoclkc.h>
>> +#include <dt-bindings/reset/gxbb-aoclkc.h>
>> +
>> +static DEFINE_SPINLOCK(clk_lock);
> 
> gxbb_clk_lock?

Renamed into gxbb_aoclk_lock for sake of clarity

> 
>> +
>> +struct gxbb_aoclk_reset_controller {
>> +	struct reset_controller_dev reset;
>> +	unsigned int *data;
>> +	void __iomem *base;
>> +};
>> +

[...]

>> +
>> +static struct clk_hw_onecell_data gxbb_aoclk_onecell_data = {
> 
> can this be const?

It would be awesome, but it will be discarded by of_clk_add_hw_provider :

drivers/clk/meson/gxbb-aoclk.c:176:4: warning: passing argument 3 of 'of_clk_add_hw_provider' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    &gxbb_aoclk_onecell_data);

In file included from drivers/clk/meson/gxbb-aoclk.c:55:0:
./include/linux/clk-provider.h:788:5: note: expected 'void *' but argument is of type 'const struct clk_hw_onecell_data *'
 int of_clk_add_hw_provider(struct device_node *np,

> 
>> +	.hws = {
>> +		[CLKID_AO_REMOTE] = &remote_ao.hw,
>> +		[CLKID_AO_I2C_MASTER] = &i2c_master_ao.hw,
>> +		[CLKID_AO_I2C_SLAVE] = &i2c_slave_ao.hw,
>> +		[CLKID_AO_UART1] = &uart1_ao.hw,
>> +		[CLKID_AO_UART2] = &uart2_ao.hw,
>> +		[CLKID_AO_IR_BLASTER] = &ir_blaster_ao.hw,
>> +	},
>> +	.num = ARRAY_SIZE(gxbb_aoclk_gate),
>> +};
>> +
>> +static int gxbb_aoclkc_probe(struct platform_device *pdev)
>> +{
>> +	void __iomem *base;
>> +	int ret, clkid;
>> +	struct device *dev = &pdev->dev;
>> +	struct gxbb_aoclk_reset_controller *rstc;
>> +
>> +	rstc = devm_kzalloc(dev, sizeof(rstc), GFP_KERNEL);
>> +	if (!rstc)
>> +		return -ENOMEM;
>> +
>> +	/*  Generic clocks */
>> +	base = of_iomap(dev->of_node, 0);
> 
> use devm_ioremap_resource() please and platform APIs to get the
> ioresource.

Done.

> 
>> +	if (!base) {
>> +		pr_err("%s: Unable to map clk base\n", __func__);
> 
> We don't need error prints here with devm_ioremap_resource().
> 
>> +		return -ENXIO;
>> +	}
>> +
>> +	/* Reset Controller */
>> +	rstc->base = base;
>> +	rstc->data = gxbb_aoclk_reset;
>> +	rstc->reset.ops = &gxbb_aoclk_reset_ops;
>> +	rstc->reset.nr_resets = ARRAY_SIZE(gxbb_aoclk_reset);
>> +	rstc->reset.of_node = dev->of_node;
>> +	ret = devm_reset_controller_register(dev, &rstc->reset);
>> +
>> +	/*
>> +	 * Populate base address and register all clks
>> +	 */
>> +	for (clkid = 0; clkid < gxbb_aoclk_onecell_data.num; clkid++) {
>> +		gxbb_aoclk_gate[clkid]->reg = base;
>> +
>> +		ret = devm_clk_hw_register(dev,
>> +					gxbb_aoclk_onecell_data.hws[clkid]);
>> +		if (ret)
>> +			goto iounmap;
>> +	}
>> +
>> +	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
>> +			&gxbb_aoclk_onecell_data);
>> +
>> +iounmap:
>> +	iounmap(base);
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id gxbb_aoclkc_match_table[] = {
>> +	{ .compatible = "amlogic,gxbb-aoclkc" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, gxbb_aoclkc_match_table);
>> +
>> +static struct platform_driver gxbb_aoclkc_driver = {
>> +	.probe		= gxbb_aoclkc_probe,
> 
> No remove means leak of iomem mapping.
> 

It will be non-modular, so no need of remove. The MODULE_* macros and module.h include will be removed like other clk drivers (gxbb and oxnas for instance).

Thanks,
Neil
