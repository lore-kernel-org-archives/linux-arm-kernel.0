From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 4 Jul 2018 10:41:51 +0200
Subject: [PATCH 1/3] soc: amlogic: Add Meson GX Clock Measure driver
In-Reply-To: <CAFBinCDBEbVSEzhM2WOhxNX1DZLiSrkeo7GWdxGzBpOUH3PKQw@mail.gmail.com>
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
 <1530624110-4687-2-git-send-email-narmstrong@baylibre.com>
 <CAFBinCDBEbVSEzhM2WOhxNX1DZLiSrkeo7GWdxGzBpOUH3PKQw@mail.gmail.com>
Message-ID: <7d83a0a4-5cde-7e4f-78a8-372ae8cb03d0@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On 03/07/2018 21:18, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Tue, Jul 3, 2018 at 3:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
>> clock paths frequencies.
>> The precision is in the order of the MHz.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/soc/amlogic/Kconfig                |   8 ++
>>  drivers/soc/amlogic/Makefile               |   1 +
>>  drivers/soc/amlogic/meson-gx-clk-measure.c | 224 +++++++++++++++++++++++++++++
>>  3 files changed, 233 insertions(+)
>>  create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c
>>
>> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
>> index b04f6e4..4a3217d 100644
>> --- a/drivers/soc/amlogic/Kconfig
>> +++ b/drivers/soc/amlogic/Kconfig
>> @@ -1,5 +1,13 @@
>>  menu "Amlogic SoC drivers"
>>
>> +config MESON_GX_CLK_MEASURE
>> +       bool "Amlogic Meson GX SoC Clock Measure driver"
>> +       depends on ARCH_MESON || COMPILE_TEST
>> +       default ARCH_MESON
>> +       help
>> +         Say yes to support of Measuring a set of internal SoC clocks
>> +         from the debugfs interface.
>> +
>>  config MESON_GX_SOCINFO
>>         bool "Amlogic Meson GX SoC Information driver"
>>         depends on ARCH_MESON || COMPILE_TEST
>> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
>> index 8fa3218..a0ad966 100644
>> --- a/drivers/soc/amlogic/Makefile
>> +++ b/drivers/soc/amlogic/Makefile
>> @@ -1,3 +1,4 @@
>> +obj-$(CONFIG_MESON_GX_CLK_MEASURE) += meson-gx-clk-measure.o
>>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
>> diff --git a/drivers/soc/amlogic/meson-gx-clk-measure.c b/drivers/soc/amlogic/meson-gx-clk-measure.c
>> new file mode 100644
>> index 0000000..434d9f3
>> --- /dev/null
>> +++ b/drivers/soc/amlogic/meson-gx-clk-measure.c

[...]

>> +       CLK_MSR_ID(57, "wave420l_c"),
>> +       CLK_MSR_ID(58, "wave420l_b"),
> AFAIK the Chips&Media WAVE420L video codec is only available on GXM (S912)
> I assume reading this on GXBB or GXL simply reads 0?

Yes

> 
>> +       CLK_MSR_ID(59, "hcodec"),
>> +       CLK_MSR_ID(60, "alt_32k"),
>> +       CLK_MSR_ID(61, "gpio_msr"),
>> +       CLK_MSR_ID(62, "hevc"),
>> +       CLK_MSR_ID(66, "vid_lock"),
>> +       CLK_MSR_ID(70, "pwm_f"),
>> +       CLK_MSR_ID(71, "pwm_e"),
>> +       CLK_MSR_ID(72, "pwm_d"),
>> +       CLK_MSR_ID(73, "pwm_C"),
> should this be pwm_c (instead of pwm_C)?
> 
>> +       CLK_MSR_ID(75, "aoclkx2_int"),
>> +       CLK_MSR_ID(76, "aoclk_int"),
>> +       CLK_MSR_ID(77, "rng_ring_osc_0"),
>> +       CLK_MSR_ID(78, "rng_ring_osc_1"),
>> +       CLK_MSR_ID(79, "rng_ring_osc_2"),
>> +       CLK_MSR_ID(80, "rng_ring_osc_3"),
>> +       CLK_MSR_ID(81, "vapb"),
>> +       CLK_MSR_ID(82, "ge2d"),
>> +};
> I did a quick check whether the clock IDs are really the same for all GX SoCs:
> apart from clocks missing on older SoCs (see for example the WAVE420L
> clocks above) there were only minor renames but no conflicts!

I did the same work ! I will add this detail to the commit log.
Thanks for checking ;-)

> 
>> +
>> +static int meson_gx_measure_id(struct meson_gx_msr *priv, unsigned int id)
>> +{
>> +       unsigned int val;
>> +       int ret;
>> +
>> +       regmap_write(priv->regmap, MSR_CLK_REG0, 0);
>> +
>> +       /* Set measurement gate to 50uS */
>> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_DIV,
>> +                          FIELD_PREP(MSR_CLK_DIV, DIV_50US));
>> +
>> +       /* Set ID */
>> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_SRC,
>> +                          FIELD_PREP(MSR_CLK_SRC, id));
>> +
>> +       /* Enable & Start */
>> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0,
>> +                          MSR_RUN | MSR_ENABLE,
>> +                          MSR_RUN | MSR_ENABLE);
>> +
>> +       ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
>> +                                      val, !(val & MSR_BUSY), 10, 1000);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Disable */
>> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
>> +
>> +       /* Get the value in MHz*64 */
>> +       regmap_read(priv->regmap, MSR_CLK_REG2, &val);
>> +
>> +       return (((val + 31) & MSR_VAL_MASK) / 64) * 1000000;
>> +}
>> +
>> +static int clk_msr_show(struct seq_file *s, void *data)
>> +{
>> +       struct meson_gx_msr_id *clk_msr_id = s->private;
>> +       int val;
>> +
>> +       val = meson_gx_measure_id(clk_msr_id->priv, clk_msr_id->id);
>> +       if (val < 0)
>> +               return val;
>> +
>> +       seq_printf(s, "%d\n", val);

With jerome, we managed to have a much higher precision by cycling over the divider
and checking when the counter overflows. And I will print the precision in the clock debugfs
entry.

>> +
>> +       return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(clk_msr);
> have you considered modelling this as clock driver instead?

Yes, but it can wait.
Actually this clk-msr can be feed to GEN_CLK and be outputted to a pad,
but all this is only for debug, so we can stick to debugfs for now.

Question, should I separate the clocks in a subdirectory and add a summary file like
for the clk debugfs ?


/sys/kernel/debug/meson-clk-msr
------------------|--- summary
------------------|--- clks
-----------------------|--- ring_osc_out_ee_0
...
-----------------------|--- ge2d

?

> 
>> +
>> +static const struct regmap_config clk_msr_regmap_config = {
>> +       .reg_bits = 32,
>> +       .val_bits = 32,
>> +       .reg_stride = 4,
>> +       .max_register = MSR_CLK_REG2,
>> +};
>> +
>> +static int meson_gx_msr_probe(struct platform_device *pdev)
>> +{
>> +       struct meson_gx_msr *priv;
>> +       struct resource *res;
>> +       struct dentry *root;
>> +       void __iomem *base;
>> +       int i;
>> +
>> +       priv = devm_kzalloc(&pdev->dev, sizeof(struct meson_gx_msr),
>> +                           GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(base)) {
>> +               dev_err(&pdev->dev, "io resource mapping failed\n");
>> +               return PTR_ERR(base);
>> +       }
>> +
>> +       priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
>> +                                             &clk_msr_regmap_config);
>> +       if (IS_ERR(priv->regmap))
>> +               return PTR_ERR(priv->regmap);
>> +
>> +       root = debugfs_create_dir("meson-clk-msr", NULL);
>> +
>> +       for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
>> +               if (!clk_msr[i].name)
>> +                       continue;
>> +
>> +               clk_msr[i].priv = priv;
>> +
>> +               debugfs_create_file(clk_msr[i].name, 0444, root,
>> +                                   &clk_msr[i], &clk_msr_fops);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id meson_gx_msr_match_table[] = {
>> +       { .compatible = "amlogic,meson-gx-clk-measure" },
> maybe pass the meson_gx_msr_id table here because it seems easy to add
> support for AXG and Meson8/Meson8b/Meson8m2 later on

Yes, I will rename the driver to be generic and pass the table as match data.

> 
> 
> Regards
> Martin
> 

Thanks for reviewing !

Neil
