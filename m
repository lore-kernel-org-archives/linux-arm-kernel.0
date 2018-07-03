From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue, 3 Jul 2018 21:18:14 +0200
Subject: [PATCH 1/3] soc: amlogic: Add Meson GX Clock Measure driver
In-Reply-To: <1530624110-4687-2-git-send-email-narmstrong@baylibre.com>
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
 <1530624110-4687-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAFBinCDBEbVSEzhM2WOhxNX1DZLiSrkeo7GWdxGzBpOUH3PKQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Tue, Jul 3, 2018 at 3:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
> The precision is in the order of the MHz.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/soc/amlogic/Kconfig                |   8 ++
>  drivers/soc/amlogic/Makefile               |   1 +
>  drivers/soc/amlogic/meson-gx-clk-measure.c | 224 +++++++++++++++++++++++++++++
>  3 files changed, 233 insertions(+)
>  create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c
>
> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> index b04f6e4..4a3217d 100644
> --- a/drivers/soc/amlogic/Kconfig
> +++ b/drivers/soc/amlogic/Kconfig
> @@ -1,5 +1,13 @@
>  menu "Amlogic SoC drivers"
>
> +config MESON_GX_CLK_MEASURE
> +       bool "Amlogic Meson GX SoC Clock Measure driver"
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
> index 8fa3218..a0ad966 100644
> --- a/drivers/soc/amlogic/Makefile
> +++ b/drivers/soc/amlogic/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_MESON_GX_CLK_MEASURE) += meson-gx-clk-measure.o
>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> diff --git a/drivers/soc/amlogic/meson-gx-clk-measure.c b/drivers/soc/amlogic/meson-gx-clk-measure.c
> new file mode 100644
> index 0000000..434d9f3
> --- /dev/null
> +++ b/drivers/soc/amlogic/meson-gx-clk-measure.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2017 BayLibre, SAS
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
> +#define MSR_ENABLE             BIT(16)
> +#define MSR_CONT               BIT(17) /* continuous measurement */
> +#define MSR_INTR               BIT(18) /* interrupts */
> +#define MSR_RUN                        BIT(19)
> +#define MSR_CLK_SRC            GENMASK(26, 20)
> +#define MSR_BUSY               BIT(31)
> +
> +#define MSR_VAL_MASK           GENMASK(15, 0)
> +
> +#define DIV_50US               64
> +
> +#define CLK_MSR_MAX            128
> +
> +struct meson_gx_msr {
> +       struct regmap *regmap;
> +};
> +
> +struct meson_gx_msr_id {
> +       struct meson_gx_msr *priv;
> +       unsigned int id;
> +       const char *name;
> +};
> +
> +#define CLK_MSR_ID(__id, __name) \
> +       [__id] = {.id = __id, .name = __name,}
> +
> +static struct meson_gx_msr_id clk_msr[CLK_MSR_MAX] = {
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
AFAIK the Chips&Media WAVE420L video codec is only available on GXM (S912)
I assume reading this on GXBB or GXL simply reads 0?

> +       CLK_MSR_ID(59, "hcodec"),
> +       CLK_MSR_ID(60, "alt_32k"),
> +       CLK_MSR_ID(61, "gpio_msr"),
> +       CLK_MSR_ID(62, "hevc"),
> +       CLK_MSR_ID(66, "vid_lock"),
> +       CLK_MSR_ID(70, "pwm_f"),
> +       CLK_MSR_ID(71, "pwm_e"),
> +       CLK_MSR_ID(72, "pwm_d"),
> +       CLK_MSR_ID(73, "pwm_C"),
should this be pwm_c (instead of pwm_C)?

> +       CLK_MSR_ID(75, "aoclkx2_int"),
> +       CLK_MSR_ID(76, "aoclk_int"),
> +       CLK_MSR_ID(77, "rng_ring_osc_0"),
> +       CLK_MSR_ID(78, "rng_ring_osc_1"),
> +       CLK_MSR_ID(79, "rng_ring_osc_2"),
> +       CLK_MSR_ID(80, "rng_ring_osc_3"),
> +       CLK_MSR_ID(81, "vapb"),
> +       CLK_MSR_ID(82, "ge2d"),
> +};
I did a quick check whether the clock IDs are really the same for all GX SoCs:
apart from clocks missing on older SoCs (see for example the WAVE420L
clocks above) there were only minor renames but no conflicts!

> +
> +static int meson_gx_measure_id(struct meson_gx_msr *priv, unsigned int id)
> +{
> +       unsigned int val;
> +       int ret;
> +
> +       regmap_write(priv->regmap, MSR_CLK_REG0, 0);
> +
> +       /* Set measurement gate to 50uS */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_DIV,
> +                          FIELD_PREP(MSR_CLK_DIV, DIV_50US));
> +
> +       /* Set ID */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_SRC,
> +                          FIELD_PREP(MSR_CLK_SRC, id));
> +
> +       /* Enable & Start */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0,
> +                          MSR_RUN | MSR_ENABLE,
> +                          MSR_RUN | MSR_ENABLE);
> +
> +       ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
> +                                      val, !(val & MSR_BUSY), 10, 1000);
> +       if (ret)
> +               return ret;
> +
> +       /* Disable */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
> +
> +       /* Get the value in MHz*64 */
> +       regmap_read(priv->regmap, MSR_CLK_REG2, &val);
> +
> +       return (((val + 31) & MSR_VAL_MASK) / 64) * 1000000;
> +}
> +
> +static int clk_msr_show(struct seq_file *s, void *data)
> +{
> +       struct meson_gx_msr_id *clk_msr_id = s->private;
> +       int val;
> +
> +       val = meson_gx_measure_id(clk_msr_id->priv, clk_msr_id->id);
> +       if (val < 0)
> +               return val;
> +
> +       seq_printf(s, "%d\n", val);
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(clk_msr);
have you considered modelling this as clock driver instead?

> +
> +static const struct regmap_config clk_msr_regmap_config = {
> +       .reg_bits = 32,
> +       .val_bits = 32,
> +       .reg_stride = 4,
> +       .max_register = MSR_CLK_REG2,
> +};
> +
> +static int meson_gx_msr_probe(struct platform_device *pdev)
> +{
> +       struct meson_gx_msr *priv;
> +       struct resource *res;
> +       struct dentry *root;
> +       void __iomem *base;
> +       int i;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(struct meson_gx_msr),
> +                           GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
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
> +
> +       for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
> +               if (!clk_msr[i].name)
> +                       continue;
> +
> +               clk_msr[i].priv = priv;
> +
> +               debugfs_create_file(clk_msr[i].name, 0444, root,
> +                                   &clk_msr[i], &clk_msr_fops);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id meson_gx_msr_match_table[] = {
> +       { .compatible = "amlogic,meson-gx-clk-measure" },
maybe pass the meson_gx_msr_id table here because it seems easy to add
support for AXG and Meson8/Meson8b/Meson8m2 later on


Regards
Martin
-------------- next part --------------
		[82] = "Cts_ge2d_clk       ",
		[81] = "Cts_vapbclk        ",
		[80] = "Rng_ring_osc_clk[3]",
		[79] = "Rng_ring_osc_clk[2]",
		[78] = "Rng_ring_osc_clk[1]",
		[77] = "Rng_ring_osc_clk[0]",
		[76] = "cts_aoclk_int      ",
		[75] = "cts_aoclkx2_int    ",
		[74] = "0                  ",
		[73] = "cts_pwm_C_clk      ",
		[72] = "cts_pwm_D_clk      ",
		[71] = "cts_pwm_E_clk      ",
		[70] = "cts_pwm_F_clk      ",
		[69] = "0                  ",
		[68] = "0                  ",
		[67] = "0                  ",
		[66] = "cts_vid_lock_clk   ",
		[65] = "0                  ",
		[64] = "0                  ",
		[63] = "0                  ",
		[62] = "cts_hevc_clk       ",
		[61] = "gpio_clk_msr       ",
		[60] = "alt_32k_clk        ",
		[59] = "cts_hcodec_clk     ",
		[58] = "0                  ",
		[57] = "0					",
		[56] = "0					",
		[55] = "vid_pll_div_clk_out	",
		[54] = "0					",
		[53] = "Sd_emmc_clk_A		",
		[52] = "Sd_emmc_clk_B		",
		[51] = "Cts_nand_core_clk	",
		[50] = "Mp3_clk_out			",
		[49] = "mp2_clk_out			",
		[48] = "mp1_clk_out			",
		[47] = "ddr_dpll_pt_clk		",
		[46] = "cts_vpu_clk			",
		[45] = "cts_pwm_A_clk		",
		[44] = "cts_pwm_B_clk		",
		[43] = "fclk_div5			",
		[42] = "mp0_clk_out			",
		[41] = "eth_rx_clk_or_clk_rmii",
		[40] = "cts_pcm_mclk			",
		[39] = "cts_pcm_sclk			",
		[38] = "cts_vdin_meas_clk			",
		[37] = "cts_clk_i958			",
		[36] = "cts_hdmi_tx_pixel_clk ",
		[35] = "cts_mali_clk			",
		[34] = "0					",
		[33] = "0					",
		[32] = "cts_vdec_clk			",
		[31] = "MPLL_CLK_TEST_OUT	",
		[30] = "0					",
		[29] = "0					",
		[28] = "cts_sar_adc_clk					   ",
		[27] = "0					   ",
		[26] = "sc_clk_int			   ",
		[25] = "0					   ",
		[24] = "0					   ",
		[23] = "HDMI_CLK_TODIG		   ",
		[22] = "eth_phy_ref_clk		   ",
		[21] = "i2s_clk_in_src0		   ",
		[20] = "rtc_osc_clk_out		   ",
		[19] = "cts_hdmitx_sys_clk	   ",
		[18] = "sys_cpu_clk_div16		   ",
		[17] = "sys_pll_div16					   ",
		[16] = "cts_FEC_CLK_2		   ",
		[15] = "cts_FEC_CLK_1		   ",
		[14] = "cts_FEC_CLK_0		   ",
		[13] = "cts_amclk			   ",
		[12] = "Cts_pdm_clk			   ",
		[11] = "rgmii_tx_clk_to_phy	   ",
		[10] = "cts_vdac_clk			   ",
		[9] = "cts_encl_clk			  ",
		[8] = "cts_encp_clk			  ",
		[7] = "clk81					  ",
		[6] = "cts_enci_clk			  ",
		[5] = "0						  ",
		[4] = "gp0_pll_clk			  ",
		[3] = "A53_ring_osc_clk		  ",
		[2] = "am_ring_osc_clk_out_ee[2]",
		[1] = "am_ring_osc_clk_out_ee[1]",
		[0] = "am_ring_osc_clk_out_ee[0]",
-------------- next part --------------
A non-text attachment was scrubbed...
Name: gxbb-to-gxl.diff
Type: text/x-patch
Size: 937 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180703/9e904351/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: gxl-to-gxm.diff
Type: text/x-patch
Size: 1012 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180703/9e904351/attachment-0001.bin>
-------------- next part --------------
		[82] = "Cts_ge2d_clk       ",
		[81] = "Cts_vapbclk        ",
		[80] = "Rng_ring_osc_clk[3]",
		[79] = "Rng_ring_osc_clk[2]",
		[78] = "Rng_ring_osc_clk[1]",
		[77] = "Rng_ring_osc_clk[0]",
		[76] = "cts_aoclk_int      ",
		[75] = "cts_aoclkx2_int    ",
		[74] = "0                  ",
		[73] = "cts_pwm_C_clk      ",
		[72] = "cts_pwm_D_clk      ",
		[71] = "cts_pwm_E_clk      ",
		[70] = "cts_pwm_F_clk      ",
		[69] = "0                  ",
		[68] = "0                  ",
		[67] = "0                  ",
		[66] = "cts_vid_lock_clk   ",
		[65] = "0                  ",
		[64] = "0                  ",
		[63] = "0                  ",
		[62] = "cts_hevc_clk       ",
		[61] = "gpio_clk_msr       ",
		[60] = "alt_32k_clk        ",
		[59] = "cts_hcodec_clk     ",
		[58] = "cts_wave420l_bclk                  ",
		[57] = "cts_wave420l_cclk	",
		[56] = "cts_cci_clk			",
		[55] = "vid_pll_div_clk_out	",
		[54] = "0					",
		[53] = "Sd_emmc_clk_A		",
		[52] = "Sd_emmc_clk_B		",
		[51] = "Cts_nand_core_clk	",
		[50] = "Mp3_clk_out			",
		[49] = "mp2_clk_out			",
		[48] = "mp1_clk_out			",
		[47] = "ddr_dpll_pt_clk		",
		[46] = "cts_vpu_clk			",
		[45] = "cts_pwm_A_clk		",
		[44] = "cts_pwm_B_clk		",
		[43] = "fclk_div5			",
		[42] = "mp0_clk_out			",
		[41] = "eth_rx_clk_or_clk_rmii",
		[40] = "cts_pcm_mclk			",
		[39] = "cts_pcm_sclk			",
		[38] = "cts_vdin_meas_clk			",
		[37] = "cts_clk_i958			",
		[36] = "cts_hdmi_tx_pixel_clk ",
		[35] = "cts_mali_clk			",
		[34] = "0					",
		[33] = "0					",
		[32] = "cts_vdec_clk			",
		[31] = "MPLL_CLK_TEST_OUT	",
		[30] = "0					",
		[29] = "0					",
		[28] = "cts_sar_adc_clk					   ",
		[27] = "0					   ",
		[26] = "sc_clk_int			   ",
		[25] = "0					   ",
		[24] = "sys_cpu1_clk_div16			",
		[23] = "HDMI_CLK_TODIG		   ",
		[22] = "eth_phy_ref_clk		   ",
		[21] = "i2s_clk_in_src0		   ",
		[20] = "rtc_osc_clk_out		   ",
		[19] = "cts_hdmitx_sys_clk	   ",
		[18] = "sys_cpu_clk_div16		   ",
		[17] = "sys_pll_div16					   ",
		[16] = "cts_FEC_CLK_2		   ",
		[15] = "cts_FEC_CLK_1		   ",
		[14] = "cts_FEC_CLK_0		   ",
		[13] = "cts_amclk			   ",
		[12] = "Cts_pdm_clk			   ",
		[11] = "mac_eth_tx_clk	   ",
		[10] = "cts_vdac_clk			   ",
		[9] = "cts_encl_clk			  ",
		[8] = "cts_encp_clk			  ",
		[7] = "clk81					  ",
		[6] = "cts_enci_clk			  ",
		[5] = "0						  ",
		[4] = "gp0_pll_clk			  ",
		[3] = "A53_ring_osc_clk		  ",
		[2] = "am_ring_osc_clk_out_ee[2]",
		[1] = "am_ring_osc_clk_out_ee[1]",
		[0] = "am_ring_osc_clk_out_ee[0]",
-------------- next part --------------
		[82] = "Cts_ge2d_clk       ",
		[81] = "Cts_vapbclk        ",
		[80] = "Rng_ring_osc_clk[3]",
		[79] = "Rng_ring_osc_clk[2]",
		[78] = "Rng_ring_osc_clk[1]",
		[77] = "Rng_ring_osc_clk[0]",
		[76] = "cts_aoclk_int      ",
		[75] = "cts_aoclkx2_int    ",
		[74] = "0                  ",
		[73] = "cts_pwm_C_clk      ",
		[72] = "cts_pwm_D_clk      ",
		[71] = "cts_pwm_E_clk      ",
		[70] = "cts_pwm_F_clk      ",
		[69] = "0                  ",
		[68] = "0                  ",
		[67] = "0                  ",
		[66] = "cts_vid_lock_clk   ",
		[65] = "0                  ",
		[64] = "0                  ",
		[63] = "0                  ",
		[62] = "cts_hevc_clk       ",
		[61] = "gpio_clk_msr       ",
		[60] = "alt_32k_clk        ",
		[59] = "cts_hcodec_clk     ",
		[58] = "0                  ",
		[57] = "0					",
		[56] = "0					",
		[55] = "vid_pll_div_clk_out	",
		[54] = "0					",
		[53] = "Sd_emmc_clk_A		",
		[52] = "Sd_emmc_clk_B		",
		[51] = "Cts_nand_core_clk	",
		[50] = "Mp3_clk_out			",
		[49] = "mp2_clk_out			",
		[48] = "mp1_clk_out			",
		[47] = "ddr_dpll_pt_clk		",
		[46] = "cts_vpu_clk			",
		[45] = "cts_pwm_A_clk		",
		[44] = "cts_pwm_B_clk		",
		[43] = "fclk_div5			",
		[42] = "mp0_clk_out			",
		[41] = "eth_rx_clk_or_clk_rmii",
		[40] = "cts_pcm_mclk			",
		[39] = "cts_pcm_sclk			",
		[38] = "0					",
		[37] = "cts_clk_i958			",
		[36] = "cts_hdmi_tx_pixel_clk ",
		[35] = "cts_mali_clk			",
		[34] = "0					",
		[33] = "0					",
		[32] = "cts_vdec_clk			",
		[31] = "MPLL_CLK_TEST_OUT	",
		[30] = "0					",
		[29] = "0					",
		[28] = "0					   ",
		[27] = "0					   ",
		[26] = "sc_clk_int			   ",
		[25] = "0					   ",
		[24] = "0					   ",
		[23] = "HDMI_CLK_TODIG		   ",
		[22] = "eth_phy_ref_clk		   ",
		[21] = "i2s_clk_in_src0		   ",
		[20] = "rtc_osc_clk_out		   ",
		[19] = "cts_hdmitx_sys_clk	   ",
		[18] = "A53_clk_div16		   ",
		[17] = "0					   ",
		[16] = "cts_FEC_CLK_2		   ",
		[15] = "cts_FEC_CLK_1		   ",
		[14] = "cts_FEC_CLK_0		   ",
		[13] = "cts_amclk			   ",
		[12] = "Cts_pdm_clk			   ",
		[11] = "rgmii_tx_clk_to_phy	   ",
		[10] = "cts_vdac_clk			   ",
		[9] = "cts_encl_clk			  " ,
		[8] = "cts_encp_clk			  " ,
		[7] = "clk81					  " ,
		[6] = "cts_enci_clk			  " ,
		[5] = "0						  " ,
		[4] = "gp0_pll_clk			  " ,
		[3] = "A53_ring_osc_clk		  " ,
		[2] = "am_ring_osc_clk_out_ee[2]" ,
		[1] = "am_ring_osc_clk_out_ee[1]" ,
		[0] = "am_ring_osc_clk_out_ee[0]" ,
