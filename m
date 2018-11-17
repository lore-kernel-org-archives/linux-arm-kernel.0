From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 17 Nov 2018 21:41:04 +0100
Subject: [PATCH v2 2/3] soc: amlogic: Add Meson GX Clock Measure driver
In-Reply-To: <20181114131627.17766-3-narmstrong@baylibre.com>
References: <20181114131627.17766-1-narmstrong@baylibre.com>
 <20181114131627.17766-3-narmstrong@baylibre.com>
Message-ID: <CAFBinCCQA=k9c5W4OML1X0CfxAkmyJwtj6Wry9R563HScZUDEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Wed, Nov 14, 2018 at 2:18 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
I would remove "GX" from that sentence

> The precision is determined by stepping into the divider until the counter
> overflows.
> The debugfs slows a pretty summary and each clock can be measured
> individually aswell.
>
> The clock table covers all GX SoCs (GXBB, GXL & GXM) even if some clocks
> are only present on GXBB or GXM (i.e. wave420l) but the counter returns
> 0 when the clocks are invalid.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
looks good apart from a small comments (and a 32-bit SoC fix) below as
this driver is not GX specific

> ---
>  drivers/soc/amlogic/Kconfig                |   8 +
>  drivers/soc/amlogic/Makefile               |   1 +
>  drivers/soc/amlogic/meson-gx-clk-measure.c | 293 +++++++++++++++++++++
>  3 files changed, 302 insertions(+)
>  create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c
>
> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> index 2f282b472912..155868830773 100644
> --- a/drivers/soc/amlogic/Kconfig
> +++ b/drivers/soc/amlogic/Kconfig
> @@ -7,6 +7,14 @@ config MESON_CANVAS
>         help
>           Say yes to support the canvas IP for Amlogic SoCs.
>
> +config MESON_GX_CLK_MEASURE
> +       bool "Amlogic Meson GX SoC Clock Measure driver"
please drop the GX from the name, I verified that it also works on
Meson8 and Meson8b with very little changes

> +       depends on ARCH_MESON || COMPILE_TEST
> +       default ARCH_MESON
> +       help
> +         Say yes to support of Measuring a set of internal SoC clocks
> +         from the debugfs interface.
> +
>  config MESON_GX_SOCINFO
>         bool "Amlogic Meson GX SoC Information driver"
>         depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> index 0ab16d35ac36..2cc0f9c2f715 100644
> --- a/drivers/soc/amlogic/Makefile
> +++ b/drivers/soc/amlogic/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
> +obj-$(CONFIG_MESON_GX_CLK_MEASURE) += meson-gx-clk-measure.o
>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> diff --git a/drivers/soc/amlogic/meson-gx-clk-measure.c b/drivers/soc/amlogic/meson-gx-clk-measure.c
> new file mode 100644
> index 000000000000..da1a0001cef9
> --- /dev/null
> +++ b/drivers/soc/amlogic/meson-gx-clk-measure.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2017 BayLibre, SAS
nitpick; 2017-2018

> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/bitfield.h>
> +#include <linux/seq_file.h>
> +#include <linux/debugfs.h>
> +#include <linux/regmap.h>
> +
> +#define MSR_CLK_DUTY           0x0
> +#define MSR_CLK_REG0           0x4
> +#define MSR_CLK_REG1           0x8
> +#define MSR_CLK_REG2           0xc
> +
> +#define MSR_CLK_DIV            GENMASK(15, 0)
I would call this MSR_DURATION (see my comment on the divider below)

> +#define MSR_ENABLE             BIT(16)
> +#define MSR_CONT               BIT(17) /* continuous measurement */
> +#define MSR_INTR               BIT(18) /* interrupts */
> +#define MSR_RUN                        BIT(19)
> +#define MSR_CLK_SRC            GENMASK(26, 20)
> +#define MSR_BUSY               BIT(31)
> +
> +#define MSR_VAL_MASK           GENMASK(15, 0)
> +
> +#define DIV_MIN                        32
> +#define DIV_STEP               32
> +#define DIV_MAX                        640
> +
> +#define CLK_MSR_MAX            128
> +
> +struct meson_gx_msr_id {
> +       struct meson_gx_msr *priv;
> +       unsigned int id;
> +       const char *name;
> +};
> +
> +struct meson_gx_msr {
> +       struct regmap *regmap;
> +       struct meson_gx_msr_id msr_table[CLK_MSR_MAX];
> +};
can you drop the "_gx" from these two structs and all functions below please?

> +
> +#define CLK_MSR_ID(__id, __name) \
> +       [__id] = {.id = __id, .name = __name,}
> +
> +static struct meson_gx_msr_id clk_msr_gx[CLK_MSR_MAX] = {
> +       CLK_MSR_ID(0, "ring_osc_out_ee_0"),
> +       CLK_MSR_ID(1, "ring_osc_out_ee_1"),
> +       CLK_MSR_ID(2, "ring_osc_out_ee_2"),
> +       CLK_MSR_ID(3, "a53_ring_osc"),
> +       CLK_MSR_ID(4, "gp0_pll"),
> +       CLK_MSR_ID(6, "enci"),
> +       CLK_MSR_ID(7, "clk81"),
> +       CLK_MSR_ID(8, "encp"),
> +       CLK_MSR_ID(9, "encl"),
> +       CLK_MSR_ID(10, "vdac"),
> +       CLK_MSR_ID(11, "rgmii_tx"),
> +       CLK_MSR_ID(12, "pdm"),
> +       CLK_MSR_ID(13, "amclk"),
> +       CLK_MSR_ID(14, "fec_0"),
> +       CLK_MSR_ID(15, "fec_1"),
> +       CLK_MSR_ID(16, "fec_2"),
> +       CLK_MSR_ID(17, "sys_pll_div16"),
> +       CLK_MSR_ID(18, "sys_cpu_div16"),
> +       CLK_MSR_ID(19, "hdmitx_sys"),
> +       CLK_MSR_ID(20, "rtc_osc_out"),
> +       CLK_MSR_ID(21, "i2s_in_src0"),
> +       CLK_MSR_ID(22, "eth_phy_ref"),
> +       CLK_MSR_ID(23, "hdmi_todig"),
> +       CLK_MSR_ID(26, "sc_int"),
> +       CLK_MSR_ID(28, "sar_adc"),
> +       CLK_MSR_ID(31, "mpll_test_out"),
> +       CLK_MSR_ID(32, "vdec"),
> +       CLK_MSR_ID(35, "mali"),
> +       CLK_MSR_ID(36, "hdmi_tx_pixel"),
> +       CLK_MSR_ID(37, "i958"),
> +       CLK_MSR_ID(38, "vdin_meas"),
> +       CLK_MSR_ID(39, "pcm_sclk"),
> +       CLK_MSR_ID(40, "pcm_mclk"),
> +       CLK_MSR_ID(41, "eth_rx_or_rmii"),
> +       CLK_MSR_ID(42, "mp0_out"),
> +       CLK_MSR_ID(43, "fclk_div5"),
> +       CLK_MSR_ID(44, "pwm_b"),
> +       CLK_MSR_ID(45, "pwm_a"),
> +       CLK_MSR_ID(46, "vpu"),
> +       CLK_MSR_ID(47, "ddr_dpll_pt"),
> +       CLK_MSR_ID(48, "mp1_out"),
> +       CLK_MSR_ID(49, "mp2_out"),
> +       CLK_MSR_ID(50, "mp3_out"),
> +       CLK_MSR_ID(51, "nand_core"),
> +       CLK_MSR_ID(52, "sd_emmc_b"),
> +       CLK_MSR_ID(53, "sd_emmc_a"),
> +       CLK_MSR_ID(55, "vid_pll_div_out"),
> +       CLK_MSR_ID(56, "cci"),
> +       CLK_MSR_ID(57, "wave420l_c"),
> +       CLK_MSR_ID(58, "wave420l_b"),
> +       CLK_MSR_ID(59, "hcodec"),
> +       CLK_MSR_ID(60, "alt_32k"),
> +       CLK_MSR_ID(61, "gpio_msr"),
> +       CLK_MSR_ID(62, "hevc"),
> +       CLK_MSR_ID(66, "vid_lock"),
> +       CLK_MSR_ID(70, "pwm_f"),
> +       CLK_MSR_ID(71, "pwm_e"),
> +       CLK_MSR_ID(72, "pwm_d"),
> +       CLK_MSR_ID(73, "pwm_c"),
> +       CLK_MSR_ID(75, "aoclkx2_int"),
> +       CLK_MSR_ID(76, "aoclk_int"),
> +       CLK_MSR_ID(77, "rng_ring_osc_0"),
> +       CLK_MSR_ID(78, "rng_ring_osc_1"),
> +       CLK_MSR_ID(79, "rng_ring_osc_2"),
> +       CLK_MSR_ID(80, "rng_ring_osc_3"),
> +       CLK_MSR_ID(81, "vapb"),
> +       CLK_MSR_ID(82, "ge2d"),
> +};
> +
> +static int meson_gx_measure_id(struct meson_gx_msr_id *clk_msr_id,
> +                              unsigned int divider)
I would replace "divider" with duration. Amlogic's kernel code
mentions that this is value is in microseconds.
during my tests I could confirm that bigger "divider" value means
better precision - if this was a divider then lower values should
probably give higher precision

> +{
> +       struct meson_gx_msr *priv = clk_msr_id->priv;
> +       unsigned int val;
> +       int ret;
> +
> +       regmap_write(priv->regmap, MSR_CLK_REG0, 0);
> +
> +       /* Set measurement divider */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_DIV,
> +                          FIELD_PREP(MSR_CLK_DIV, divider - 1));
> +
> +       /* Set ID */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_SRC,
> +                          FIELD_PREP(MSR_CLK_SRC, clk_msr_id->id));
> +
> +       /* Enable & Start */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0,
> +                          MSR_RUN | MSR_ENABLE,
> +                          MSR_RUN | MSR_ENABLE);
> +
> +       ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
> +                                      val, !(val & MSR_BUSY), 10, 10000);
> +       if (ret)
> +               return ret;
> +
> +       /* Disable */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
> +
> +       /* Get the value in multiple of gate time counts */
> +       regmap_read(priv->regmap, MSR_CLK_REG2, &val);
> +
> +       if (val >= MSR_VAL_MASK)
> +               return -EINVAL;
> +
> +       return DIV_ROUND_CLOSEST((val & MSR_VAL_MASK) * 1000000,
> +                                divider);
the 32-bit SoCs want a bit of love here:
please use DIV_ROUND_CLOSEST_ULL and  cast 1MHz to u64

> +}
> +
> +static int meson_gx_measure_best_id(struct meson_gx_msr_id *clk_msr_id,
> +                                   unsigned int *precision)
> +{
> +       unsigned int divider = DIV_MAX;
> +       int ret;
> +
> +       /* Start from max divider and down to min divider */
> +       do {
> +               ret = meson_gx_measure_id(clk_msr_id, divider);
> +               if (ret >= 0)
> +                       *precision = (2 * 1000000) / divider;
> +               else
> +                       divider -= DIV_STEP;
> +       } while (divider >= DIV_MIN && ret == -EINVAL);
> +
> +       return ret;
> +}
> +
> +static int clk_msr_show(struct seq_file *s, void *data)
> +{
> +       struct meson_gx_msr_id *clk_msr_id = s->private;
> +       unsigned int precision = 0;
> +       int val;
> +
> +       val = meson_gx_measure_best_id(clk_msr_id, &precision);
> +       if (val < 0)
> +               return val;
> +
> +       seq_printf(s, "%d\t+/-%dHz\n", val, precision);
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(clk_msr);
> +
> +static int clk_msr_summary_show(struct seq_file *s, void *data)
> +{
> +       struct meson_gx_msr_id *msr_table = s->private;
> +       unsigned int precision = 0;
> +       int val, i;
> +
> +       seq_puts(s, "  clock                     rate    precision\n");
> +       seq_puts(s, "---------------------------------------------\n");
> +
> +       for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
> +               if (!msr_table[i].name)
> +                       continue;
> +
> +               val = meson_gx_measure_best_id(&msr_table[i], &precision);
> +               if (val < 0)
> +                       return val;
> +
> +               seq_printf(s, " %-20s %10d    +/-%dHz\n",
> +                          msr_table[i].name, val, precision);
> +       }
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(clk_msr_summary);
> +
> +static const struct regmap_config clk_msr_regmap_config = {
nitpick: meson_clk_msr_regmap_config (for consistency)

> +       .reg_bits = 32,
> +       .val_bits = 32,
> +       .reg_stride = 4,
> +       .max_register = MSR_CLK_REG2,
> +};
> +
> +static int meson_gx_msr_probe(struct platform_device *pdev)
> +{
> +       const struct meson_gx_msr_id *match_data;
> +       struct meson_gx_msr *priv;
> +       struct resource *res;
> +       struct dentry *root, *clks;
> +       void __iomem *base;
> +       int i;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(struct meson_gx_msr),
> +                           GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       match_data = device_get_match_data(&pdev->dev);
> +       if (!match_data) {
> +               dev_err(&pdev->dev, "failed to get match data\n");
> +               return -ENODEV;
> +       }
> +
> +       memcpy(priv->msr_table, match_data, sizeof(priv->msr_table));
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(base)) {
> +               dev_err(&pdev->dev, "io resource mapping failed\n");
> +               return PTR_ERR(base);
> +       }
> +
> +       priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> +                                             &clk_msr_regmap_config);
> +       if (IS_ERR(priv->regmap))
> +               return PTR_ERR(priv->regmap);
> +
> +       root = debugfs_create_dir("meson-clk-msr", NULL);
> +       clks = debugfs_create_dir("clks", root);
> +
> +       debugfs_create_file("measure_summary", 0444, root,
> +                           priv->msr_table, &clk_msr_summary_fops);
> +
> +       for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
> +               if (!priv->msr_table[i].name)
> +                       continue;
> +
> +               priv->msr_table[i].priv = priv;
> +
> +               debugfs_create_file(priv->msr_table[i].name, 0444, clks,
> +                                   &priv->msr_table[i], &clk_msr_fops);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id meson_gx_msr_match_table[] = {
> +       {
> +               .compatible = "amlogic,meson-gx-clk-measure",
> +               .data = (void *)clk_msr_gx,
> +       },
if you want you can fold this with the patch that I've attached, then
we have Meson8 and Meson8b support as well :)

> +       { /* sentinel */ }
> +};
> +
> +static struct platform_driver meson_gx_msr_driver = {
> +       .probe  = meson_gx_msr_probe,
> +       .driver = {
> +               .name           = "meson_gx_msr",
> +               .of_match_table = meson_gx_msr_match_table,
> +       },
> +};
> +builtin_platform_driver(meson_gx_msr_driver);
> --
> 2.19.1
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 32bit-meson.patch
Type: text/x-patch
Size: 2822 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181117/27ee246b/attachment-0001.bin>
