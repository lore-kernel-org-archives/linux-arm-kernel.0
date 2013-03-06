From: AChew@nvidia.com (Andrew Chew)
Date: Wed, 6 Mar 2013 15:51:16 -0800
Subject: [PATCH v6 09/10] clk: tegra: Implement clocks for Tegra114
In-Reply-To: <1360580700-10245-10-git-send-email-pdeschrijver@nvidia.com>
References: <1360580700-10245-1-git-send-email-pdeschrijver@nvidia.com>
 <1360580700-10245-10-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <643E69AA4436674C8F39DCC2C05F7638629CA50CB4@HQMAIL03.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: linux-tegra-owner at vger.kernel.org [mailto:linux-tegra-
> owner at vger.kernel.org] On Behalf Of Peter De Schrijver
> Sent: Monday, February 11, 2013 3:05 AM
> To: Peter De Schrijver
> Cc: linux-arm-kernel at lists.infradead.org; linux-tegra at vger.kernel.org
> Subject: [PATCH v6 09/10] clk: tegra: Implement clocks for Tegra114
>
> Implement clocks for Tegra114.
>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/clk/tegra/Makefile       |    1 +
>  drivers/clk/tegra/clk-tegra114.c | 2036
> ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 2037 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/clk/tegra/clk-tegra114.c
>
> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> index 2b41b0f..f49fac2 100644
> --- a/drivers/clk/tegra/Makefile
> +++ b/drivers/clk/tegra/Makefile
> @@ -9,3 +9,4 @@ obj-y                                 += clk-
> super.o
>
>  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
>  obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
> +obj-$(CONFIG_ARCH_TEGRA_114_SOC)     += clk-tegra114.o
> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
> new file mode 100644
> index 0000000..cd50c18
> --- /dev/null
> +++ b/drivers/clk/tegra/clk-tegra114.c

*snip for brevity*

> +static __initdata struct tegra_periph_init_data tegra_periph_clk_list[] = {

I don't think this should be marked as __initdata.  The stuff in this list
contain clock instances that are referenced after init.

> +     TEGRA_INIT_DATA_MUX("i2s0", NULL, "tegra30-i2s.0",
> mux_pllaout0_audio0_2x_pllp_clkm, CLK_SOURCE_I2S0, 30, &periph_l_regs,
> TEGRA_PERIPH_ON_APB, i2s0),
> +     TEGRA_INIT_DATA_MUX("i2s1", NULL, "tegra30-i2s.1",
> mux_pllaout0_audio1_2x_pllp_clkm, CLK_SOURCE_I2S1, 11, &periph_l_regs,
> TEGRA_PERIPH_ON_APB, i2s1),
> +     TEGRA_INIT_DATA_MUX("i2s2", NULL, "tegra30-i2s.2",
> mux_pllaout0_audio2_2x_pllp_clkm, CLK_SOURCE_I2S2, 18, &periph_l_regs,
> TEGRA_PERIPH_ON_APB, i2s2),
> +     TEGRA_INIT_DATA_MUX("i2s3", NULL, "tegra30-i2s.3",
> mux_pllaout0_audio3_2x_pllp_clkm, CLK_SOURCE_I2S3, 101,
> &periph_v_regs, TEGRA_PERIPH_ON_APB, i2s3),
> +     TEGRA_INIT_DATA_MUX("i2s4", NULL, "tegra30-i2s.4",
> mux_pllaout0_audio4_2x_pllp_clkm, CLK_SOURCE_I2S4, 102,
> &periph_v_regs, TEGRA_PERIPH_ON_APB, i2s4),
> +     TEGRA_INIT_DATA_MUX("spdif_out", "spdif_out", "tegra30-spdif",
> mux_pllaout0_audio_2x_pllp_clkm, CLK_SOURCE_SPDIF_OUT, 10,
> &periph_l_regs, TEGRA_PERIPH_ON_APB, spdif_out),
> +     TEGRA_INIT_DATA_MUX("spdif_in", "spdif_in", "tegra30-spdif",
> mux_pllp_pllc_pllm, CLK_SOURCE_SPDIF_IN, 10, &periph_l_regs,
> TEGRA_PERIPH_ON_APB, spdif_in),
> +     TEGRA_INIT_DATA_MUX("pwm", NULL, "pwm",
> mux_pllp_pllc_clk32_clkm, CLK_SOURCE_PWM, 17, &periph_l_regs,
> TEGRA_PERIPH_ON_APB, pwm),
> +     TEGRA_INIT_DATA_MUX("adx", NULL, "adx",
> mux_plla_pllc_pllp_clkm, CLK_SOURCE_ADX, 154, &periph_w_regs,
> TEGRA_PERIPH_ON_APB, adx),
> +     TEGRA_INIT_DATA_MUX("amx", NULL, "amx",
> mux_plla_pllc_pllp_clkm, CLK_SOURCE_AMX, 153, &periph_w_regs,
> TEGRA_PERIPH_ON_APB, amx),
> +     TEGRA_INIT_DATA_MUX("hda", "hda", "tegra30-hda",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_HDA, 125, &periph_v_regs,
> TEGRA_PERIPH_ON_APB, hda),
> +     TEGRA_INIT_DATA_MUX("hda2codec_2x", "hda2codec", "tegra30-
> hda", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_HDA2CODEC_2X, 111,
> &periph_v_regs, TEGRA_PERIPH_ON_APB, hda2codec_2x),
> +     TEGRA_INIT_DATA_MUX("sbc1", NULL, "tegra11-spi.0",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SBC1, 41, &periph_h_regs,
> TEGRA_PERIPH_ON_APB, sbc1),
> +     TEGRA_INIT_DATA_MUX("sbc2", NULL, "tegra11-spi.1",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SBC2, 44, &periph_h_regs,
> TEGRA_PERIPH_ON_APB, sbc2),
> +     TEGRA_INIT_DATA_MUX("sbc3", NULL, "tegra11-spi.2",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SBC3, 46, &periph_h_regs,
> TEGRA_PERIPH_ON_APB, sbc3),
> +     TEGRA_INIT_DATA_MUX("sbc4", NULL, "tegra11-spi.3",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SBC4, 68, &periph_u_regs,
> TEGRA_PERIPH_ON_APB, sbc4),
> +     TEGRA_INIT_DATA_MUX("sbc5", NULL, "tegra11-spi.4",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SBC5, 104, &periph_v_regs,
> TEGRA_PERIPH_ON_APB, sbc5),
> +     TEGRA_INIT_DATA_MUX("sbc6", NULL, "tegra11-spi.5",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SBC6, 105, &periph_v_regs,
> TEGRA_PERIPH_ON_APB, sbc6),
> +     TEGRA_INIT_DATA_MUX8("ndflash", NULL, "tegra_nand",
> mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_NDFLASH, 13,
> &periph_u_regs, TEGRA_PERIPH_ON_APB, ndspeed),
> +     TEGRA_INIT_DATA_MUX8("ndspeed", NULL, "tegra_nand_speed",
> mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_NDSPEED, 80,
> &periph_u_regs, TEGRA_PERIPH_ON_APB, ndspeed),
> +     TEGRA_INIT_DATA_MUX("vfir", NULL, "vfir",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_VFIR, 7, &periph_l_regs,
> TEGRA_PERIPH_ON_APB, vfir),
> +     TEGRA_INIT_DATA_MUX("sdmmc1", NULL, "sdhci-tegra.0",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC1, 14, &periph_l_regs, 0,
> sdmmc1),
> +     TEGRA_INIT_DATA_MUX("sdmmc2", NULL, "sdhci-tegra.1",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC2, 9, &periph_l_regs, 0,
> sdmmc2),
> +     TEGRA_INIT_DATA_MUX("sdmmc3", NULL, "sdhci-tegra.2",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC3, 69, &periph_u_regs, 0,
> sdmmc3),
> +     TEGRA_INIT_DATA_MUX("sdmmc4", NULL, "sdhci-tegra.3",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC4, 15, &periph_l_regs, 0,
> sdmmc4),
> +     TEGRA_INIT_DATA_INT("vde", NULL, "vde",
> mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_VDE, 61, &periph_h_regs, 0,
> vde),
> +     TEGRA_INIT_DATA_MUX("csite", NULL, "csite",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_CSITE, 73, &periph_u_regs,
> TEGRA_PERIPH_ON_APB, csite),

The csite clock needs to be marked CLK_IGNORE_UNUSED, otherwise
drivers/clk/clk.c's clk_disable_unused() will disable it after init, and JTAG
won't work after that point.

> +     TEGRA_INIT_DATA_MUX("la", NULL, "la", mux_pllp_pllc_pllm_clkm,
> CLK_SOURCE_LA, 76, &periph_u_regs, TEGRA_PERIPH_ON_APB, la),
> +     TEGRA_INIT_DATA_MUX("trace", NULL, "trace",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_TRACE, 77, &periph_u_regs,
> TEGRA_PERIPH_ON_APB, trace),
> +     TEGRA_INIT_DATA_MUX("owr", NULL, "tegra_w1",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_OWR, 71, &periph_u_regs,
> TEGRA_PERIPH_ON_APB, owr),
> +     TEGRA_INIT_DATA_MUX("nor", NULL, "tegra-nor",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_NOR, 42, &periph_h_regs, 0, nor),
> +     TEGRA_INIT_DATA_MUX("mipi", NULL, "mipi",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_MIPI, 50, &periph_h_regs,
> TEGRA_PERIPH_ON_APB, mipi),
> +     TEGRA_INIT_DATA_I2C("i2c1", "div-clk", "tegra11-i2c.0",
> mux_pllp_clkm, CLK_SOURCE_I2C1, 12, &periph_l_regs, i2c1),
> +     TEGRA_INIT_DATA_I2C("i2c2", "div-clk", "tegra11-i2c.1",
> mux_pllp_clkm, CLK_SOURCE_I2C2, 54, &periph_h_regs, i2c2),
> +     TEGRA_INIT_DATA_I2C("i2c3", "div-clk", "tegra11-i2c.2",
> mux_pllp_clkm, CLK_SOURCE_I2C3, 67, &periph_u_regs, i2c3),
> +     TEGRA_INIT_DATA_I2C("i2c4", "div-clk", "tegra11-i2c.3",
> mux_pllp_clkm, CLK_SOURCE_I2C4, 103, &periph_v_regs, i2c4),
> +     TEGRA_INIT_DATA_I2C("i2c5", "div-clk", "tegra11-i2c.4",
> mux_pllp_clkm, CLK_SOURCE_I2C5, 47, &periph_h_regs, i2c5),
> +     TEGRA_INIT_DATA_UART("uarta", NULL, "tegra_uart.0",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTA, 6, &periph_l_regs, uarta),
> +     TEGRA_INIT_DATA_UART("uartb", NULL, "tegra_uart.1",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTB, 7, &periph_l_regs, uartb),
> +     TEGRA_INIT_DATA_UART("uartc", NULL, "tegra_uart.2",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTC, 55, &periph_h_regs, uartc),
> +     TEGRA_INIT_DATA_UART("uartd", NULL, "tegra_uart.3",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTD, 65, &periph_u_regs, uartd),
> +     TEGRA_INIT_DATA_UART("uarte", NULL, "tegra_uart.4",
> mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTE, 66, &periph_u_regs, uarte),
> +     TEGRA_INIT_DATA_INT("3d", NULL, "3d",
> mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_3D, 24, &periph_l_regs, 0,
> gr_3d),
> +     TEGRA_INIT_DATA_INT("2d", NULL, "2d",
> mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_2D, 21, &periph_l_regs, 0,
> gr_2d),
> +     TEGRA_INIT_DATA_MUX("vi_sensor", "vi_sensor", "tegra_camera",
> mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_VI_SENSOR, 20,
> &periph_l_regs, TEGRA_PERIPH_NO_RESET, vi_sensor),
> +     TEGRA_INIT_DATA_INT8("vi", "vi", "tegra_camera",
> mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_VI, 20, &periph_l_regs, 0, vi),
> +     TEGRA_INIT_DATA_INT8("epp", NULL, "epp",
> mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_EPP, 19, &periph_l_regs, 0,
> epp),
> +     TEGRA_INIT_DATA_INT8("msenc", NULL, "msenc",
> mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_MSENC, 91, &periph_h_regs,
> TEGRA_PERIPH_WAR_1005168, msenc),
> +     TEGRA_INIT_DATA_INT8("tsec", NULL, "tsec",
> mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_TSEC, 83, &periph_u_regs, 0,
> tsec),
> +     TEGRA_INIT_DATA_INT8("host1x", NULL, "host1x",
> mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_HOST1X, 28, &periph_l_regs,
> 0, host1x),
> +     TEGRA_INIT_DATA_MUX8("hdmi", NULL, "hdmi",
> mux_pllp_pllm_plld_plla_pllc_plld2_clkm, CLK_SOURCE_HDMI, 51,
> &periph_h_regs, 0, hdmi),
> +     TEGRA_INIT_DATA_MUX("cilab", "cilab", "tegra_camera",
> mux_pllp_pllc_clkm, CLK_SOURCE_CILAB, 144, &periph_w_regs, 0, cilab),
> +     TEGRA_INIT_DATA_MUX("cilcd", "cilcd", "tegra_camera",
> mux_pllp_pllc_clkm, CLK_SOURCE_CILCD, 145, &periph_w_regs, 0, cilcd),
> +     TEGRA_INIT_DATA_MUX("cile", "cile", "tegra_camera",
> mux_pllp_pllc_clkm, CLK_SOURCE_CILE, 146, &periph_w_regs, 0, cile),
> +     TEGRA_INIT_DATA_MUX("dsialp", "dsialp", "tegradc.0",
> mux_pllp_pllc_clkm, CLK_SOURCE_DSIALP, 147, &periph_w_regs, 0, dsialp),
> +     TEGRA_INIT_DATA_MUX("dsiblp", "dsiblp", "tegradc.1",
> mux_pllp_pllc_clkm, CLK_SOURCE_DSIBLP, 148, &periph_w_regs, 0, dsiblp),
> +     TEGRA_INIT_DATA_MUX("tsensor", NULL, "tegra-tsensor",
> mux_pllp_pllc_clkm_clk32, CLK_SOURCE_TSENSOR, 100, &periph_v_regs,
> TEGRA_PERIPH_ON_APB, tsensor),
> +     TEGRA_INIT_DATA_MUX("actmon", NULL, "actmon",
> mux_pllp_pllc_clk32_clkm, CLK_SOURCE_ACTMON, 119, &periph_v_regs, 0,
> actmon),
> +     TEGRA_INIT_DATA_MUX8("extern1", NULL, "extern1",
> mux_plla_clk32_pllp_clkm_plle, CLK_SOURCE_EXTERN1, 120,
> &periph_v_regs, 0, extern1),
> +     TEGRA_INIT_DATA_MUX8("extern2", NULL, "extern2",
> mux_plla_clk32_pllp_clkm_plle, CLK_SOURCE_EXTERN2, 121,
> &periph_v_regs, 0, extern2),
> +     TEGRA_INIT_DATA_MUX8("extern3", NULL, "extern3",
> mux_plla_clk32_pllp_clkm_plle, CLK_SOURCE_EXTERN3, 122,
> &periph_v_regs, 0, extern3),
> +     TEGRA_INIT_DATA_MUX("i2cslow", NULL, "i2cslow",
> mux_pllp_pllc_clk32_clkm, CLK_SOURCE_I2CSLOW, 81, &periph_u_regs,
> TEGRA_PERIPH_ON_APB, i2cslow),
> +     TEGRA_INIT_DATA_INT8("se", NULL, "se",
> mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_SE, 127, &periph_v_regs,
> TEGRA_PERIPH_ON_APB, se),
> +     TEGRA_INIT_DATA_INT_FLAGS("mselect", NULL, "mselect",
> mux_pllp_clkm, CLK_SOURCE_MSELECT, 99, &periph_v_regs, 0, mselect,
> CLK_IGNORE_UNUSED),
> +     TEGRA_INIT_DATA_MUX8("soc_therm", NULL, "soc_therm",
> mux_pllm_pllc_pllp_plla, CLK_SOURCE_SOC_THERM, 78, &periph_u_regs,
> TEGRA_PERIPH_ON_APB, soc_therm),
> +     TEGRA_INIT_DATA_XUSB("xusb_host_src", "host_src", "tegra_xhci",
> mux_clkm_pllp_pllc_pllre, CLK_SOURCE_XUSB_HOST_SRC, 143,
> &periph_w_regs, TEGRA_PERIPH_ON_APB | TEGRA_PERIPH_NO_RESET,
> xusb_host_src),
> +     TEGRA_INIT_DATA_XUSB("xusb_falcon_src", "falcon_src",
> "tegra_xhci", mux_clkm_pllp_pllc_pllre, CLK_SOURCE_XUSB_FALCON_SRC,
> 143, &periph_w_regs, TEGRA_PERIPH_NO_RESET, xusb_falcon_src),
> +     TEGRA_INIT_DATA_XUSB("xusb_fs_src", "fs_src", "tegra_xhci",
> mux_clkm_48M_pllp_480M, CLK_SOURCE_XUSB_FS_SRC, 143,
> &periph_w_regs, TEGRA_PERIPH_NO_RESET, xusb_fs_src),
> +     TEGRA_INIT_DATA_XUSB("xusb_ss_src", "ss_src", "tegra_xhci",
> mux_clkm_pllre_clk32_480M_pllc_ref, CLK_SOURCE_XUSB_SS_SRC, 143,
> &periph_w_regs, TEGRA_PERIPH_NO_RESET, xusb_ss_src),
> +     TEGRA_INIT_DATA_XUSB("xusb_dev_src", "dev_src", "tegra_xhci",
> mux_clkm_pllp_pllc_pllre, CLK_SOURCE_XUSB_DEV_SRC, 95,
> &periph_u_regs, TEGRA_PERIPH_ON_APB | TEGRA_PERIPH_NO_RESET,
> xusb_dev_src),
> +     TEGRA_INIT_DATA_AUDIO("d_audio", "d_audio", "tegra30-ahub",
> CLK_SOURCE_D_AUDIO, 106, &periph_v_regs, TEGRA_PERIPH_ON_APB,
> d_audio),
> +     TEGRA_INIT_DATA_AUDIO("dam0", NULL, "tegra30-dam.0",
> CLK_SOURCE_DAM0, 108, &periph_v_regs, TEGRA_PERIPH_ON_APB,
> dam0),
> +     TEGRA_INIT_DATA_AUDIO("dam1", NULL, "tegra30-dam.1",
> CLK_SOURCE_DAM1, 109, &periph_v_regs, TEGRA_PERIPH_ON_APB,
> dam1),
> +     TEGRA_INIT_DATA_AUDIO("dam2", NULL, "tegra30-dam.2",
> CLK_SOURCE_DAM2, 110, &periph_v_regs, TEGRA_PERIPH_ON_APB,
> dam2),
> +};
> +
> +static __initdata struct tegra_periph_init_data
> tegra_periph_nodiv_clk_list[] = {

I don't think this should be marked as __initdata.  The stuff in this list
contain clock instances that are referenced after init.

> +     TEGRA_INIT_DATA_NODIV("disp1", NULL, "tegradc.0",
> mux_pllp_pllm_plld_plla_pllc_plld2_clkm, CLK_SOURCE_DISP1, 29, 3, 27,
> &periph_l_regs, 0, disp1),
> +     TEGRA_INIT_DATA_NODIV("disp2", NULL, "tegradc.1",
> mux_pllp_pllm_plld_plla_pllc_plld2_clkm, CLK_SOURCE_DISP2, 29, 3, 26,
> &periph_l_regs, 0, disp2),

For disp1 and disp2, the mux mask should be 7, not 3.

> +};
> +
> +static __init void tegra114_periph_clk_init(void __iomem *clk_base)
> +{
> +     struct tegra_periph_init_data *data;
> +     struct clk *clk;
> +     int i;
> +     u32 val;
> +
> +     /* apbdma */
> +     clk = tegra_clk_register_periph_gate("apbdma", "clk_m", 0,
> clk_base,
> +                               0, 34, &periph_h_regs,
> +                               periph_clk_enb_refcnt);
> +     clks[apbdma] = clk;
> +
> +     /* rtc */
> +     clk = tegra_clk_register_periph_gate("rtc", "clk_32k",
> +                                 TEGRA_PERIPH_ON_APB |
> +                                 TEGRA_PERIPH_NO_RESET, clk_base,
> +                                 0, 4, &periph_l_regs,
> +                                 periph_clk_enb_refcnt);
> +     clk_register_clkdev(clk, NULL, "rtc-tegra");
> +     clks[rtc] = clk;
> +
> +     /* kbc */
> +     clk = tegra_clk_register_periph_gate("kbc", "clk_32k",
> +                                 TEGRA_PERIPH_ON_APB |
> +                                 TEGRA_PERIPH_NO_RESET, clk_base,
> +                                 0, 36, &periph_h_regs,
> +                                 periph_clk_enb_refcnt);
> +     clks[kbc] = clk;
> +
> +     /* timer */
> +     clk = tegra_clk_register_periph_gate("timer", "clk_m", 0, clk_base,
> +                               0, 5, &periph_l_regs,
> +                               periph_clk_enb_refcnt);
> +     clk_register_clkdev(clk, NULL, "timer");
> +     clks[timer] = clk;
> +
> +     /* kfuse */
> +     clk = tegra_clk_register_periph_gate("kfuse", "clk_m",
> +                               TEGRA_PERIPH_ON_APB, clk_base,  0, 40,
> +                               &periph_h_regs, periph_clk_enb_refcnt);
> +     clks[kfuse] = clk;
> +
> +     /* fuse */
> +     clk = tegra_clk_register_periph_gate("fuse", "clk_m",
> +                               TEGRA_PERIPH_ON_APB, clk_base,  0, 39,
> +                               &periph_h_regs, periph_clk_enb_refcnt);
> +     clks[fuse] = clk;
> +
> +     /* fuse_burn */
> +     clk = tegra_clk_register_periph_gate("fuse_burn", "clk_m",
> +                               TEGRA_PERIPH_ON_APB, clk_base,  0, 39,
> +                               &periph_h_regs, periph_clk_enb_refcnt);
> +     clks[fuse_burn] = clk;
> +
> +     /* apbif */
> +     clk = tegra_clk_register_periph_gate("apbif", "clk_m",
> +                               TEGRA_PERIPH_ON_APB, clk_base,  0, 107,
> +                               &periph_v_regs, periph_clk_enb_refcnt);
> +     clks[apbif] = clk;
> +
> +     /* hda2hdmi */
> +     clk = tegra_clk_register_periph_gate("hda2hdmi", "clk_m",
> +                                 TEGRA_PERIPH_ON_APB, clk_base,  0, 128,
> +                                 &periph_w_regs, periph_clk_enb_refcnt);
> +     clks[hda2hdmi] = clk;
> +
> +     /* vcp */
> +     clk = tegra_clk_register_periph_gate("vcp", "clk_m", 0, clk_base,  0,
> +                               29, &periph_l_regs,
> +                               periph_clk_enb_refcnt);
> +     clks[vcp] = clk;
> +
> +     /* bsea */
> +     clk = tegra_clk_register_periph_gate("bsea", "clk_m", 0, clk_base,
> +                               0, 62, &periph_h_regs,
> +                               periph_clk_enb_refcnt);
> +     clks[bsea] = clk;
> +
> +     /* bsev */
> +     clk = tegra_clk_register_periph_gate("bsev", "clk_m", 0, clk_base,
> +                               0, 63, &periph_h_regs,
> +                               periph_clk_enb_refcnt);
> +     clks[bsev] = clk;
> +
> +     /* mipi-cal */
> +     clk = tegra_clk_register_periph_gate("mipi-cal", "clk_m", 0, clk_base,
> +                                0, 56, &periph_h_regs,
> +                               periph_clk_enb_refcnt);
> +     clks[mipi_cal] = clk;
> +
> +     /* usbd */
> +     clk = tegra_clk_register_periph_gate("usbd", "clk_m", 0, clk_base,
> +                               0, 22, &periph_l_regs,
> +                               periph_clk_enb_refcnt);
> +     clks[usbd] = clk;
> +
> +     /* usb2 */
> +     clk = tegra_clk_register_periph_gate("usb2", "clk_m", 0, clk_base,
> +                               0, 58, &periph_h_regs,
> +                               periph_clk_enb_refcnt);
> +     clks[usb2] = clk;
> +
> +     /* usb3 */
> +     clk = tegra_clk_register_periph_gate("usb3", "clk_m", 0, clk_base,
> +                               0, 59, &periph_h_regs,
> +                               periph_clk_enb_refcnt);
> +     clks[usb3] = clk;
> +
> +     /* csi */
> +     clk = tegra_clk_register_periph_gate("csi", "pll_p_out3", 0, clk_base,
> +                                0, 52, &periph_h_regs,
> +                               periph_clk_enb_refcnt);
> +     clks[csi] = clk;
> +
> +     /* isp */
> +     clk = tegra_clk_register_periph_gate("isp", "clk_m", 0, clk_base, 0,
> +                               23, &periph_l_regs,
> +                               periph_clk_enb_refcnt);
> +     clks[isp] = clk;
> +
> +     /* csus */
> +     clk = tegra_clk_register_periph_gate("csus", "clk_m",
> +                               TEGRA_PERIPH_NO_RESET, clk_base, 0, 92,
> +                               &periph_u_regs, periph_clk_enb_refcnt);
> +     clks[csus] = clk;
> +
> +     /* dds */
> +     clk = tegra_clk_register_periph_gate("dds", "clk_m",
> +                               TEGRA_PERIPH_ON_APB, clk_base, 0, 150,
> +                               &periph_w_regs, periph_clk_enb_refcnt);
> +     clks[dds] = clk;
> +
> +     /* dp2 */
> +     clk = tegra_clk_register_periph_gate("dp2", "clk_m",
> +                               TEGRA_PERIPH_ON_APB, clk_base, 0, 152,
> +                               &periph_w_regs, periph_clk_enb_refcnt);
> +     clks[dp2] = clk;
> +
> +     /* dtv */
> +     clk = tegra_clk_register_periph_gate("dtv", "clk_m",
> +                                 TEGRA_PERIPH_ON_APB, clk_base, 0, 79,
> +                                 &periph_u_regs, periph_clk_enb_refcnt);
> +     clks[dtv] = clk;
> +
> +     /* dsia */
> +     clk = clk_register_mux(NULL, "dsia_mux",
> mux_plld_out0_plld2_out0,
> +                            ARRAY_SIZE(mux_plld_out0_plld2_out0), 0,
> +                            clk_base + PLLD_BASE, 25, 1, 0, &pll_d_lock);
> +     clks[dsia_mux] = clk;
> +     clk = tegra_clk_register_periph_gate("dsia", "dsia_mux", 0, clk_base,
> +                                 0, 48, &periph_h_regs,
> +                                 periph_clk_enb_refcnt);
> +     clks[dsia] = clk;
> +
> +     /* dsib */
> +     clk = clk_register_mux(NULL, "dsib_mux",
> mux_plld_out0_plld2_out0,
> +                            ARRAY_SIZE(mux_plld_out0_plld2_out0), 0,
> +                            clk_base + PLLD2_BASE, 25, 1, 0, &pll_d2_lock);
> +     clks[dsib_mux] = clk;
> +     clk = tegra_clk_register_periph_gate("dsib", "dsib_mux", 0,
> clk_base,
> +                                 0, 82, &periph_u_regs,
> +                                 periph_clk_enb_refcnt);
> +     clks[dsib] = clk;
> +
> +     /* xusb_hs_src */
> +     val = readl(clk_base + CLK_SOURCE_XUSB_SS_SRC);
> +     val |= BIT(25); /* always select PLLU_60M */
> +     writel(val, clk_base + CLK_SOURCE_XUSB_SS_SRC);
> +
> +     clk = clk_register_fixed_factor(NULL, "xusb_hs_src", "pll_u_60M", 0,
> +                                     1, 1);
> +     clks[xusb_hs_src] = clk;
> +
> +     /* xusb_host */
> +     clk = tegra_clk_register_periph_gate("xusb_host", "xusb_host_src",
> 0,
> +                                 clk_base, 0, 89, &periph_u_regs,
> +                                 periph_clk_enb_refcnt);
> +     clks[xusb_host] = clk;
> +
> +     /* xusb_ss */
> +     clk = tegra_clk_register_periph_gate("xusb_ss", "xusb_ss_src", 0,
> +                                 clk_base, 0, 156, &periph_w_regs,
> +                                 periph_clk_enb_refcnt);
> +     clks[xusb_host] = clk;
> +
> +     /* xusb_dev */
> +     clk = tegra_clk_register_periph_gate("xusb_dev", "xusb_dev_src",
> 0,
> +                                 clk_base, 0, 95, &periph_u_regs,
> +                                 periph_clk_enb_refcnt);
> +     clks[xusb_dev] = clk;
> +
> +     for (i = 0; i < ARRAY_SIZE(tegra_periph_clk_list); i++) {
> +             data = &tegra_periph_clk_list[i];
> +             clk = tegra_clk_register_periph(data->name, data-
> >parent_names,
> +                             data->num_parents, &data->periph,
> +                             clk_base, data->offset, data->flags);
> +             clks[data->clk_id] = clk;
> +     }
> +
> +     for (i = 0; i < ARRAY_SIZE(tegra_periph_nodiv_clk_list); i++) {
> +             data = &tegra_periph_nodiv_clk_list[i];
> +             clk = tegra_clk_register_periph_nodiv(data->name,
> +                             data->parent_names, data->num_parents,
> +                             &data->periph, clk_base, data->offset);
> +             clks[data->clk_id] = clk;
> +     }
> +}

Shouldn't we call clk_register_clkdev for each of these clocks?
