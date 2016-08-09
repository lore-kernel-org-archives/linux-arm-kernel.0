From: mirza.krak@gmail.com (Mirza Krak)
Date: Tue, 9 Aug 2016 09:21:54 +0200
Subject: [PATCH 6/6] bus: Add support for Tegra Generic Memory Interface
In-Reply-To: <fae8dbaf-53e9-dcfe-f755-32f7b28f4c9f@nvidia.com>
References: <1470512452-8322-1-git-send-email-mirza.krak@gmail.com>
 <1470512452-8322-7-git-send-email-mirza.krak@gmail.com>
 <fae8dbaf-53e9-dcfe-f755-32f7b28f4c9f@nvidia.com>
Message-ID: <CALw8SCWjs2TnwFcTY=iXv_eskpKaKpvUmoXnTgtpoL8w9neD=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-08-08 15:47 GMT+02:00 Jon Hunter <jonathanh@nvidia.com>:
>
> On 06/08/16 20:40, Mirza Krak wrote:
>> From: Mirza Krak <mirza.krak@gmail.com>
>>
>> The Generic Memory Interface bus can be used to connect high-speed
>> devices such as NOR flash, FPGAs, DSPs...
>>
>> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
>> ---
>>  drivers/bus/Kconfig     |   7 ++
>>  drivers/bus/Makefile    |   1 +
>>  drivers/bus/tegra-gmi.c | 224 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 232 insertions(+)
>>  create mode 100644 drivers/bus/tegra-gmi.c
>>

<--snip-->

>> +
>> +static int tegra_gmi_parse_dt(struct device *dev, struct tegra_gmi_priv *priv)
>> +{
>> +     struct device_node *of_node = dev->of_node;
>> +     u32 property;
>> +
>> +     /* configuration */
>> +
>> +     if (of_property_read_bool(of_node, "nvidia,snor-data-width-32bit"))
>> +             priv->snor_config |= TEGRA_GMI_BUS_WIDTH_32BIT;
>> +
>> +     if (of_property_read_bool(of_node, "nvidia,snor-mux-mode"))
>> +             priv->snor_config |= TEGRA_GMI_MUX_MODE;
>> +
>> +     if (of_property_read_bool(of_node, "nvidia,snor-rdy-active-before-data"))
>
> Line is over 80 characters.

Yes, indeed it is.

I ran checkpatch on everything and did get warnings about it being over
80 characters. But scratched my head a bit of why it complained because
it was not over 80 characters in my editor.

But now I know why. My tab size was set to 4, and then it is not over 80 :).
>
>> +             priv->snor_config |= TEGRA_GMI_RDY_BEFORE_DATA;
>> +
>> +     if (of_property_read_bool(of_node, "nvidia,snor-rdy-inv"))
>> +             priv->snor_config |= TEGRA_GMI_RDY_ACTIVE_HIGH;
>> +
>> +     if (of_property_read_bool(of_node, "nvidia,snor-adv-inv"))
>> +             priv->snor_config |= TEGRA_GMI_ADV_ACTIVE_HIGH;
>> +
>> +     if (of_property_read_bool(of_node, "nvidia,snor-oe-inv"))
>> +             priv->snor_config |= TEGRA_GMI_OE_ACTIVE_HIGH;
>> +
>> +     if (of_property_read_bool(of_node, "nvidia,snor-cs-inv"))
>> +             priv->snor_config |= TEGRA_GMI_CS_ACTIVE_HIGH;
>> +
>> +     if (!of_property_read_u32(of_node, "nvidia,snor-cs-select", &property))
>> +             priv->snor_config |= TEGRA_GMI_CS_SELECT(property);
>> +
>> +     /* Timing, the default values that are provided are reset values */
>> +
>> +     if (!of_property_read_u32(of_node, "nvidia,snor-muxed-width", &property))
>
> Line is over 80 characters.

ACK.

>
>> +             priv->snor_timing0 |= TEGRA_GMI_MUXED_WIDTH(property);
>> +     else
>> +             priv->snor_timing0 |= TEGRA_GMI_MUXED_WIDTH(1);
>> +
>> +     if (!of_property_read_u32(of_node, "nvidia,snor-hold-width", &property))
>> +             priv->snor_timing0 |= TEGRA_GMI_HOLD_WIDTH(property);
>> +     else
>> +             priv->snor_timing0 |= TEGRA_GMI_HOLD_WIDTH(1);
>> +
>> +     if (!of_property_read_u32(of_node, "nvidia,snor-adv-width", &property))
>> +             priv->snor_timing0 |= TEGRA_GMI_ADV_WIDTH(property);
>> +     else
>> +             priv->snor_timing0 |= TEGRA_GMI_ADV_WIDTH(1);
>> +
>> +     if (!of_property_read_u32(of_node, "nvidia,snor-ce-width", &property))
>> +             priv->snor_timing0 |= TEGRA_GMI_CE_WIDTH(property);
>> +     else
>> +             priv->snor_timing0 |= TEGRA_GMI_CE_WIDTH(4);
>> +
>> +     if (!of_property_read_u32(of_node, "nvidia,snor-we-width", &property))
>> +             priv->snor_timing1 |= TEGRA_GMI_WE_WIDTH(property);
>> +     else
>> +             priv->snor_timing1 |= TEGRA_GMI_WE_WIDTH(1);
>> +
>> +     if (!of_property_read_u32(of_node, "nvidia,snor-oe-width", &property))
>> +             priv->snor_timing1 |= TEGRA_GMI_OE_WIDTH(property);
>> +     else
>> +             priv->snor_timing1 |= TEGRA_GMI_OE_WIDTH(1);
>> +
>> +     if (!of_property_read_u32(of_node, "nvidia,snor-wait-width", &property))
>> +             priv->snor_timing1 |= TEGRA_GMI_WAIT_WIDTH(property);
>> +     else
>> +             priv->snor_timing1 |= TEGRA_GMI_WAIT_WIDTH(3);
>> +
>> +     return of_platform_default_populate(of_node, NULL, dev);
>
> Seems odd to do this here. Why not as the last thing in probe once the
> GMI has been setup correctly?

It is done here mostly to avoid clean up in probe. I could move it out
of tegra_gmi_parse_dt and put it right after that call but still
before clk enable? Is that less odd?

>
>> +}
>> +
>> +static int tegra_gmi_probe(struct platform_device *pdev)
>> +{
>> +     struct resource *res;
>> +     struct clk *clk;
>> +     struct device *dev = &pdev->dev;
>> +     struct reset_control *rst;
>> +     struct tegra_gmi_priv *priv;
>> +     void __iomem *base;
>> +     int ret;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     base = devm_ioremap_resource(dev, res);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +     if (!priv)
>> +             return -ENOMEM;
>> +
>> +     priv->base = base;
>
> If you allocate the memory first, you can get rid of this extra base
> variable.

ACK.

>
>> +     clk = devm_clk_get(dev, "gmi");
>> +     if (IS_ERR(clk)) {
>> +             dev_err(dev, "can not get clock\n");
>> +             return PTR_ERR(clk);
>> +     }
>> +
>> +     priv->clk = clk;
>
> Why not set priv->clk directly from calling devm_clk_get? Then you don't
> this extra clk variable.

ACK.
>
>> +
>> +     rst = devm_reset_control_get(dev, "gmi");
>> +     if (IS_ERR(rst)) {
>> +             dev_err(dev, "can not get reset\n");
>> +             return PTR_ERR(rst);
>> +     }
>> +
>> +     ret = tegra_gmi_parse_dt(dev, priv);
>> +     if (ret) {
>> +             dev_err(dev, "fail to create devices.\n");
>> +             return ret;
>> +     }
>> +
>> +     ret = clk_prepare_enable(clk);
>> +     if (ret) {
>> +             dev_err(dev, "fail to enable clock.\n");
>> +             return ret;
>> +     }
>> +
>> +     reset_control_assert(rst);
>> +     udelay(2);
>> +     reset_control_deassert(rst);
>> +
>> +     tegra_gmi_init(dev, priv);
>> +
>> +     dev_set_drvdata(dev, priv);
>> +
>> +     return 0;
>> +}
>> +
>> +static int tegra_gmi_remove(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>
> Do you really need this dev variable?

Not really.

>
>> +     struct tegra_gmi_priv *priv = dev_get_drvdata(dev);
>> +     void __iomem *base = priv->base;
>
> Do you really need this base variable?

Not really,
>
>> +     u32 config;
>> +
>> +     of_platform_depopulate(dev);
>> +
>> +     config = readl(base + TEGRA_GMI_CONFIG);
>> +     config &= ~TEGRA_GMI_CONFIG_GO;
>> +     writel(config, base + TEGRA_GMI_CONFIG);
>> +
>> +     clk_disable_unprepare(priv->clk);
>
> What about asserting the reset?

ACK, will add that.

Best Regards
Mirza
