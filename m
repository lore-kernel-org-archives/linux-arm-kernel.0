From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 26 Jan 2016 02:17:43 +0100
Subject: [PATCH v7 1/6] clk: hisilicon: add CRG driver for hi3519 soc
In-Reply-To: <1453690883-31220-2-git-send-email-xuejiancheng@huawei.com>
References: <1453690883-31220-1-git-send-email-xuejiancheng@huawei.com>
 <1453690883-31220-2-git-send-email-xuejiancheng@huawei.com>
Message-ID: <1453771063.17181.56.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ma, 2016-01-25 at 11:01 +0800, Jiancheng Xue wrote:
> --- a/drivers/clk/hisilicon/Kconfig
> +++ b/drivers/clk/hisilicon/Kconfig

> +config COMMON_CLK_HI3519
> +	bool "Hi3519 Clock Driver"
> +	depends on ARCH_HISI
> +	default y
> +	help
> +	  Build the clock driver for hi3519.

> --- a/drivers/clk/hisilicon/Makefile
> +++ b/drivers/clk/hisilicon/Makefile

> +obj-$(CONFIG_COMMON_CLK_HI3519)	+= clk-hi3519.o

If I parsed the above correctly clk-hi3519.o can only be built-in,
right?

> --- /dev/null
> +++ b/drivers/clk/hisilicon/clk-hi3519.c

> +#include <linux/module.h>

So is this include actually needed?

> +static int hi3519_clk_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct hisi_clock_data *clk_data;
> +
> +       clk_data = hisi_clk_init(np, HI3519_NR_CLKS);
> +       if (!clk_data)
> +               return -ENODEV;
> +
> +       hisi_clk_register_fixed_rate(hi3519_fixed_rate_clks,
> +                                   
> ARRAY_SIZE(hi3519_fixed_rate_clks),
> +                                    clk_data);
> +       hisi_clk_register_mux(hi3519_mux_clks,
> ARRAY_SIZE(hi3519_mux_clks),
> +                                       clk_data);
> +       hisi_clk_register_gate(hi3519_gate_clks,
> +                       ARRAY_SIZE(hi3519_gate_clks), clk_data);
> +
> +       return hisi_reset_init(np);
> +}

(evolution 3.16.5 makes replying to code quite a challenge.)

> +static const struct of_device_id hi3519_clk_match_table[] = {
> +	{ .compatible = "hisilicon,hi3519-crg" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, hi3519_clk_match_table);

Last time I checked MODULE_DEVICE_TABLE is preprocessed away for built
-in code.

> +static void __exit hi3519_clk_exit(void)
> +{
> +	platform_driver_unregister(&hi3519_clk_driver);
> +}
> +module_exit(hi3519_clk_exit);

Not needed for built-in only code.

> +MODULE_DESCRIPTION("HiSilicon Hi3519 Clock Driver");

Ditto.

> --- a/drivers/clk/hisilicon/clk.c
> +++ b/drivers/clk/hisilicon/clk.c

> +EXPORT_SYMBOL(hisi_clk_init);

What module uses this export?
 
> +EXPORT_SYMBOL(hisi_clk_register_fixed_rate);

Ditto.

> +EXPORT_SYMBOL(hisi_clk_register_fixed_factor);

Ditto.
 
> +EXPORT_SYMBOL(hisi_clk_register_mux);

Ditto.

> +EXPORT_SYMBOL(hisi_clk_register_divider);

Ditto.

> +EXPORT_SYMBOL(hisi_clk_register_gate);

Ditto.

> +EXPORT_SYMBOL(hisi_clk_register_gate_sep);

Ditto.

> --- /dev/null
> +++ b/drivers/clk/hisilicon/reset.c

> +int hisi_reset_init(struct device_node *np)
> +{
> +	[...]
> +}
> +EXPORT_SYMBOL(hisi_reset_init);

Ditto.

> --- /dev/null
> +++ b/drivers/clk/hisilicon/reset.h

> +#ifdef CONFIG_RESET_CONTROLLER
> +int hisi_reset_init(struct device_node *np);
> +#else
> +static inline int hisi_reset_init(struct device_node *np)
> +{
> +	return 0;
> +}
> +#endif

Thanks,


Paul Bolle
