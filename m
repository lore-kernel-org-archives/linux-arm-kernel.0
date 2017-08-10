From: mturquette@baylibre.com (Michael Turquette)
Date: Thu, 10 Aug 2017 11:46:15 -0700
Subject: [PATCH v8 3/5] clk: samsung: exynos5433: Add support for runtime
 PM
In-Reply-To: <1502274907-11931-4-git-send-email-m.szyprowski@samsung.com>
References: <1502274907-11931-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170809103514eucas1p1d09fbd4d6b9954b24fb6280c7d9eaa02@eucas1p1.samsung.com>
 <1502274907-11931-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <150239077548.5192.17536583927926528432@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Marek Szyprowski (2017-08-09 03:35:05)
> Add runtime pm support for all clock controller units (CMU), which belong
> to power domains and require special handling during on/off operations.
> Typically special values has to be written to MUX registers to change
> internal clocks parents to OSC clock before turning power off. During such
> operation all clocks, which enter CMU has to be enabled to let MUX to
> stabilize. Also for each CMU there is one special parent clock, which has
> to be enabled all the time when any access to CMU registers is being done.
> 
> This patch solves most of the mysterious external abort and freeze issues
> caused by a lack of proper parent CMU clock enabled or incorrect turn off
> procedure.

I would have preferred two patches here. First to platform_driver-ify
the samsung clk driver and the second to add the pm_runtime bits.

> +static int exynos5433_cmu_suspend(struct device *dev)
> +{
> +       struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
> +       int i;
> +
> +       samsung_clk_save(data->ctx.reg_base, data->clk_save,
> +                        data->nr_clk_save);
> +
> +       for (i = 0; i < data->nr_pclks; i++)
> +               clk_prepare_enable(data->pclks[i]);
> +
> +       /* for suspend some registers have to be set to certain values */
> +       samsung_clk_restore(data->ctx.reg_base, data->clk_suspend,
> +                           data->nr_clk_suspend);
> +
> +       for (i = 0; i < data->nr_pclks; i++)
> +               clk_disable_unprepare(data->pclks[i]);
> +
> +       clk_disable_unprepare(data->clk);
> +
> +       return 0;
> +}
> +
> +static int exynos5433_cmu_resume(struct device *dev)
> +{
> +       struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
> +       int i;
> +
> +       clk_prepare_enable(data->clk);
> +
> +       for (i = 0; i < data->nr_pclks; i++)
> +               clk_prepare_enable(data->pclks[i]);
> +
> +       samsung_clk_restore(data->ctx.reg_base, data->clk_save,
> +                           data->nr_clk_save);

Will the restored clk hardware always match the software bookkeeping in
the clk framework?

Is it necessary to do a tree walk and recalc rates after restoring these
registers?

> +
> +       for (i = 0; i < data->nr_pclks; i++)
> +               clk_disable_unprepare(data->pclks[i]);
> +
> +       return 0;
> +}
> +
> +static int __init exynos5433_cmu_probe(struct platform_device *pdev)
> +{
> +       const struct samsung_cmu_info *info;
> +       struct exynos5433_cmu_data *data;
> +       struct samsung_clk_provider *ctx;
> +       struct device *dev = &pdev->dev;
> +       struct resource *res;
> +       void __iomem *reg_base;
> +       int i;
> +
> +       info = of_device_get_match_data(dev);
> +
> +       data = devm_kzalloc(dev, sizeof(*data) +
> +                           sizeof(*data->ctx.clk_data.hws) * info->nr_clk_ids,
> +                           GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +       ctx = &data->ctx;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       reg_base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(reg_base)) {
> +               dev_err(dev, "failed to map registers\n");
> +               return PTR_ERR(reg_base);
> +       }
> +
> +       for (i = 0; i < info->nr_clk_ids; ++i)
> +               ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
> +
> +       ctx->clk_data.num = info->nr_clk_ids;
> +       ctx->reg_base = reg_base;
> +       ctx->dev = dev;
> +       spin_lock_init(&ctx->lock);
> +
> +       data->clk_save = samsung_clk_alloc_reg_dump(info->clk_regs,
> +                                                   info->nr_clk_regs);
> +       data->nr_clk_save = info->nr_clk_regs;
> +       data->clk_suspend = info->suspend_regs;
> +       data->nr_clk_suspend = info->nr_suspend_regs;
> +       data->nr_pclks = of_count_phandle_with_args(dev->of_node, "clocks",
> +                                                   "#clock-cells");
> +       if (data->nr_pclks > 0) {
> +               data->pclks = devm_kcalloc(dev, sizeof(struct clk *),
> +                                          data->nr_pclks, GFP_KERNEL);
> +
> +               for (i = 0; i < data->nr_pclks; i++) {
> +                       struct clk *clk = of_clk_get(dev->of_node, i);
> +
> +                       if (IS_ERR(clk))
> +                               return PTR_ERR(clk);
> +                       data->pclks[i] = clk;
> +               }
> +       }
> +
> +       if (info->clk_name)
> +               data->clk = clk_get(dev, info->clk_name);
> +       clk_prepare_enable(data->clk);

What's going on here with this weird clk_prepare_enable? It looks like
it is never balanced with a disable_unprepare?

> +
> +       platform_set_drvdata(pdev, data);
> +
> +       /*
> +        * Enable runtime PM here to allow the clock core using runtime PM
> +        * for the registered clocks. Additionally, we increase the runtime
> +        * PM usage count before registering the clocks, to prevent the
> +        * clock core from runtime suspending the device.
> +        */
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);

Hmm, I do wonder if this sort of initialization can be made generic for
all other clk drivers that will use this. Thanksfully it is very few
functions to call.

Regards,
Mike
