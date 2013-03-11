From: amit.kachhap@gmail.com (amit kachhap)
Date: Mon, 11 Mar 2013 09:13:24 +0530
Subject: [PATCH V3 1/4] cpufreq: exynos: Adding cpufreq driver for
 exynos5440
In-Reply-To: <5138B200.7060906@samsung.com>
References: <1362629627-10012-1-git-send-email-amit.daniel@samsung.com>
 <5138B200.7060906@samsung.com>
Message-ID: <CADGdYn7yqFYxz6OENhTfpkj2_1mUBdu-HM1U=AbDft=XPbTPfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

Thanks for the review. Will update with your suggestion in the next version,

Thanks,
Amit D

On Thu, Mar 7, 2013 at 8:58 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> On 03/07/2013 05:13 AM, Amit Daniel Kachhap wrote:
>> +/* Register definations */
>
> s/definations/definitions
ok
>
>> +#define XMU_DVFS_CTRL                0x0060
>> +#define XMU_PMU_P0_7         0x0064
>> +#define XMU_C0_3_PSTATE              0x0090
>> +#define XMU_P_LIMIT          0x00A0
>> +#define XMU_P_STATUS         0x00A4
>> +#define XMU_PMUEVTEN         0x00D0
>> +#define XMU_PMUIRQEN         0x00D4
>> +#define XMU_PMUIRQ           0x00D8
>
> Keeping all hex numbers lower case might be a good idea.
Ok
>
>> +
>> +/* PMU mask and shift definations */
>> +#define P_VALUE_MASK         0x7
>> +
>> +#define XMU_DVFS_CTRL_EN_SHIFT       0
>> +
>> +#define P0_7_CPUCLKDEV_SHIFT 21
>> +#define P0_7_CPUCLKDEV_MASK  0x7
>> +#define P0_7_ATBCLKDEV_SHIFT 18
>> +#define P0_7_ATBCLKDEV_MASK  0x7
>> +#define P0_7_CSCLKDEV_SHIFT  15
>> +#define P0_7_CSCLKDEV_MASK   0x7
>> +#define P0_7_CPUEMA_SHIFT    28
>> +#define P0_7_CPUEMA_MASK     0xf
>> +#define P0_7_L2EMA_SHIFT     24
>> +#define P0_7_L2EMA_MASK      0xf
> ...
>> +static int exynos_cpufreq_probe(struct platform_device *pdev)
>> +{
>> +     int ret = -EINVAL;
>> +     struct device_node *np;
>> +     struct resource res;
>> +
>> +     np =  of_find_compatible_node(NULL, NULL, "samsung,exynos5440-cpufreq");
>> +     if (!np)
>> +             return -ENODEV;
>> +
>> +     dvfs_info = devm_kzalloc(&pdev->dev, sizeof(*dvfs_info), GFP_KERNEL);
>> +     if (!dvfs_info) {
>> +             ret = -ENOMEM;
>> +             goto err_put_node;
>> +     }
>> +
>> +     dvfs_info->dev = &pdev->dev;
>> +     dvfs_info->dev->of_node = np;
>> +
>> +     ret = of_address_to_resource(np, 0, &res);
>> +     if (ret)
>> +             goto err_put_node;
>> +
>> +     dvfs_info->base = devm_ioremap(dvfs_info->dev, res.start,
>
> There is a devm_ioremap_resource() function that has been introduced
> recently. It could simplify this code a bit and is preferred over
> devm_ioremap().
yes right. I somehow missed this api.
>
>> +                                     resource_size(&res));
>> +     if (!dvfs_info->base) {
>> +             pr_err("No cpufreq memory map found\n");
>> +             ret = -ENODEV;
>> +             goto err_put_node;
>> +     }
>> +
>> +     dvfs_info->irq = irq_of_parse_and_map(np, 0);
>> +     if (dvfs_info->irq == 0) {
>> +             pr_err("No cpufreq irq found\n");
>
> Wouldn't dev_err() be more appropriate here ?
Ok
>
>> +             ret = -ENODEV;
>> +             goto err_put_node;
>> +     }
>> +
>> +     ret = of_init_opp_table(dvfs_info->dev);
>> +     if (ret) {
>> +             pr_err("failed to init OPP table: %d\n", ret);
>> +             goto err_put_node;
>> +     }
>> +
>> +     ret = opp_init_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
>> +     if (ret) {
>> +             pr_err("failed to init cpufreq table: %d\n", ret);
>> +             goto err_put_node;
>> +     }
>> +     dvfs_info->freq_count = opp_get_opp_count(dvfs_info->dev);
>> +     exynos_sort_descend_freq_table();
>> +
>> +     if (of_property_read_u32(np, "clock-latency", &dvfs_info->latency))
>> +             dvfs_info->latency = DEF_TRANS_LATENCY;
>> +
>> +     dvfs_info->cpu_clk = devm_clk_get(dvfs_info->dev, "armclk");
>> +     if (IS_ERR_OR_NULL(dvfs_info->cpu_clk)) {
>
> devm_clk_get() return value needs to be checked with IS_ERR(),
> not IS_ERR_OR_NULL().
ok
>
>> +             pr_err("Failed to get cpu clock\n");
>> +             ret = PTR_ERR(dvfs_info->cpu_clk);
>> +             goto err_free_table;
>> +     }
>> +
>> +     dvfs_info->cur_frequency = clk_get_rate(dvfs_info->cpu_clk);
>> +     if (!dvfs_info->cur_frequency) {
>> +             pr_err("Failed to get clock rate\n");
>> +             ret = -EINVAL;
>> +             goto err_free_table;
>> +     }
>> +     dvfs_info->cur_frequency /= 1000;
>> +
>> +     INIT_WORK(&dvfs_info->irq_work, exynos_cpufreq_work);
>> +     if (devm_request_irq(dvfs_info->dev, dvfs_info->irq, exynos_cpufreq_irq,
>> +                             IRQF_TRIGGER_NONE, CPUFREQ_NAME, dvfs_info)) {
>> +             pr_err("Failed to register IRQ\n");
>> +             ret = -ENODEV;
>> +             goto err_free_table;
>> +     }
>> +
>> +     ret = init_div_table();
>> +     if (ret) {
>> +             pr_err("Failed to initialise div table\n");
>> +             goto err_free_table;
>> +     }
>> +
>> +     exynos_enable_dvfs();
>> +     ret = cpufreq_register_driver(&exynos_driver);
>> +     if (ret) {
>> +             pr_err("%s: failed to register cpufreq driver\n", __func__);
>> +             goto err_free_table;
>> +     }
>> +
>> +     of_node_put(np);
>> +     dvfs_info->dvfs_enable = true;
>> +     pr_info("exynos5440 DVFS initialized.\n");
>
> dev_info() ?
>
>> +     return 0;
>> +
>> +err_free_table:
>> +     opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
>> +err_put_node:
>> +     of_node_put(np);
>> +     pr_err("%s: failed initialization\n", __func__);
>
> Is this really needed ? This failure will be logged by the driver core
> anyway.
>
>> +     return ret;
>> +
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
