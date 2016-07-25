From: mirza.krak@gmail.com (Mirza Krak)
Date: Mon, 25 Jul 2016 14:17:11 +0200
Subject: [RFC 6/6] bus: Add support for Tegra NOR controller
In-Reply-To: <20160725111443.GB21170@ulmo.ba.sec>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-7-git-send-email-mirza.krak@gmail.com>
 <20160725111443.GB21170@ulmo.ba.sec>
Message-ID: <CALw8SCU5s8BAg6B8dT=QokY-D-CcokmMEkYqz1GJWHkX-XWpRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-25 13:14 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> On Tue, Jul 19, 2016 at 03:36:37PM +0200, Mirza Krak wrote:
>> +config TEGRA_NOR
>> +     tristate "Nvidia Tegra NOR flash bus driver a.k.a GMI/SNOR"
>> +             depends on ARCH_TEGRA_2x_SOC || ARCH_TEGRA_3x_SOC
>
> I think an ARCH_TEGRA dependency is enough here.

ACK.

>
>> +             depends on OF
>
> You can drop this because Tegra has been OF-only for a long time now.

ACK.

>
>> +             help
>> +                     Driver for NOR flash bus found on Tegra30/20 SOC`s.
>
> Maybe make this "Driver for GMI controller found on NVIDIA Tegra SoCs."
> or similar in light of the name change.

ACK.

>> --- /dev/null
>> +++ b/drivers/bus/tegra-nor.c
>> @@ -0,0 +1,118 @@
>> +/*
>> + * Driver for Nvidia NOR Flash bus a.k.a SNOR/GMI.
>
> Nit: I encourage the use of "NVIDIA" as spelling for consistency.

ACK.


>> +static int __init nor_parse_dt(struct platform_device *pdev,
>> +                             void __iomem *base)
>> +{
>> +     struct device_node *of_node = pdev->dev.of_node;
>> +     u32 config, timing[TEGRA_NOR_TIMING_REG_COUNT];
>> +     int ret;
>> +
>> +     ret = of_property_read_u32_array(of_node, "nvidia,cs-timing",
>> +                                      timing, TEGRA_NOR_TIMING_REG_COUNT);
>> +     if (!ret) {
>> +             writel(timing[0], base + TEGRA_NOR_TIMING0);
>> +             writel(timing[1], base + TEGRA_NOR_TIMING1);
>> +     }
>> +
>> +     ret = of_property_read_u32(of_node, "nvidia,config", &config);
>> +     if (ret)
>> +             return ret;
>> +
>> +     config |= TEGRA_NOR_CONFIG_GO;
>> +     writel(config, base + TEGRA_NOR_CONFIG);
>
> My preference would be for the tegra_gmi_parse_dt() function not to do
> any register programming. Instead I think it would be better to store
> any of the parameters inside a struct tegra_gmi and do the programming
> from within tegra_gmi_probe() (or via an other function such as
> tegra_gmi_initialize(), called from tegra_gmi_probe()).
>
> The reason is that you'll most likely want to do this programming when
> you resume from suspend, and you could reuse tegra_gmi_initialize() to
> do that.

ACK.

>
>> +
>> +     if (of_get_child_count(of_node))
>> +             ret = of_platform_populate(of_node,
>> +                                of_default_bus_match_table,
>> +                                NULL, &pdev->dev);
>
> Why the extra check? of_platform_populate() is almost a no-op if there
> aren't any children anyway. What it will do is set the OF_POPULATED_BUS
> flag, but I think we want that irrespective of whether or not there are
> any children.
>
> Was there any problem with calling it unconditionally that made you opt
> for the extra check?

I have not tested calling it unconditionally. Used another driver as
reference and they had that condition (drivers/bus/imx-weim.c), that
driver does not mention why the condition is there. But will test
removing the condition and see what happens.

>
> Also, I think you can call of_platform_default_populate(), which is a
> little shorter than the above because you can omit the match table.

Will look in to this.

>
>> +
>> +     return ret;
>> +}
>> +
>> +static int __init nor_probe(struct platform_device *pdev)
>> +{
>> +     struct resource *res;
>> +     struct clk *clk;
>> +     void __iomem *base;
>> +     int ret;
>> +
>> +     /* get the resource */
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     /* get the clock */
>> +     clk = devm_clk_get(&pdev->dev, NULL);
>
> Let's use a consumer name here. The problem with a NULL consumer name is
> that it effectively restricts the DT binding. It means that whatever the
> clock is its name needs to be the first in a clock-names property. We'll
> likely get away with this because there's only one clock, but should we
> ever need to add another we'd need to add wording to the device tree
> bindings that the "gmi" entry needs to be first.
>
> I'm not sure if that's clear, so I'll try to explain in other words: If
> you pass a NULL consumer name to clk_get() it will simply use the first
> clock in the clocks property. If you want to later extend the DT binding
> by adding a clock in a backwards-compatible way, you'll need to add the
> restriction that the "gmi" clock (the one that was previously unnamed)
> must be the first in the clock-names and clocks properties.
>
> That's all a little confusing, so let's avoid this by giving it a proper
> consumer name to begin with.

Got it. Will add a proper consumer name.

>
>> +     if (IS_ERR(clk))
>> +             return PTR_ERR(clk);
>> +
>> +     ret = clk_prepare_enable(clk);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* parse the device node */
>> +     ret = nor_parse_dt(pdev, base);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "%s fail to create devices.\n",
>> +                     pdev->dev.of_node->full_name);
>> +             clk_disable_unprepare(clk);
>> +             return ret;
>> +     }
>
> The good thing if you don't do any programming in tegra_gmi_parse_dt(),
> is that you can easily move the clk_prepare_enable() call to here where
> things can't fail anymore, so you don't have to add cleanup code.

ACK.

>
>> +
>> +     dev_info(&pdev->dev, "Driver registered.\n");
>
> Please avoid this kind of output. Users expect that everything will work
> so you want to let them know when something goes wrong, and be quiet
> when all goes as expected.

Will remove that.

>> +static struct platform_driver nor_driver = {
>> +     .driver = {
>> +             .name           = "tegra-nor",
>> +             .of_match_table = nor_id_table,
>> +     },
>> +};
>> +module_platform_driver_probe(nor_driver, nor_probe);
>> +
>> +MODULE_AUTHOR("Mirza Krak <mirza.krak@gmail.com");
>> +MODULE_DESCRIPTION("NVIDIA Tegra NOR Bus Driver");
>> +MODULE_LICENSE("GPL");
>
> You're header comment says GPL version 2, which means that the
> MODULE_LICENSE needs to be "GPL v2". "GPL" means "version 2 or later".

Ok, I do not really mind it being GPL version 2 or later so will
change the header comment instead if that is ok.


Best regards,
Mirza
