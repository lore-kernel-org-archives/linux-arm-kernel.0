From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 27 Dec 2016 15:05:53 +0100
Subject: [PATCH v4 4/4] clk: rockchip: add clock controller for rk3328
In-Reply-To: <1482820373-10186-5-git-send-email-zhangqing@rock-chips.com>
References: <1482820373-10186-1-git-send-email-zhangqing@rock-chips.com>
 <1482820373-10186-5-git-send-email-zhangqing@rock-chips.com>
Message-ID: <134827512.CtsoUKWxik@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

Am Dienstag, 27. Dezember 2016, 14:32:53 CET schrieb Elaine Zhang:
> Add the clock tree definition for the new rk3328 SoC.

looks good in general, I have some styling nitpicks below and would like
the grf-clocks solved differently, also explained below:


> diff --git a/drivers/clk/rockchip/clk-rk3328.c
> b/drivers/clk/rockchip/clk-rk3328.c new file mode 100644
> index 000000000000..9958ce7d0dcd
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-rk3328.c
> +static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {

[...]

> +	/*
> +	 * Clock-Architecture Diagram 8
> +	 */

blank line between two comment blocks please.
Same for similar setups in the code above.

> +	/* PD_GMAC */
> +
> +	COMPOSITE(ACLK_GMAC, "aclk_gmac", mux_2plls_hdmiphy_p, 0,
> +		  RK3328_CLKSEL_CON(35), 6, 2, MFLAGS, 0, 5, DFLAGS,
> +		  RK3328_CLKGATE_CON(3), 2, GFLAGS),
> +	COMPOSITE_NOMUX(PCLK_GMAC, "pclk_gmac", "aclk_gmac", 0,
> +			RK3328_CLKSEL_CON(25), 8, 3, DFLAGS,
> +			RK3328_CLKGATE_CON(9), 0, GFLAGS),
> +
> +	COMPOSITE(SCLK_MAC2IO_SRC, "clk_mac2io_src", mux_2plls_p, 0,
> +		  RK3328_CLKSEL_CON(27), 7, 1, MFLAGS, 0, 5, DFLAGS,
> +		  RK3328_CLKGATE_CON(3), 1, GFLAGS),
> +	GATE(SCLK_MAC2IO_REF, "clk_mac2io_ref", "clk_mac2io", 0,
> +	     RK3328_CLKGATE_CON(9), 7, GFLAGS),
> +	GATE(SCLK_MAC2IO_RX, "clk_mac2io_rx", "clk_mac2io", 0,
> +	     RK3328_CLKGATE_CON(9), 4, GFLAGS),
> +	GATE(SCLK_MAC2IO_TX, "clk_mac2io_tx", "clk_mac2io", 0,
> +	     RK3328_CLKGATE_CON(9), 5, GFLAGS),
> +	GATE(SCLK_MAC2IO_REFOUT, "clk_mac2io_refout", "clk_mac2io", 0,
> +	     RK3328_CLKGATE_CON(9), 6, GFLAGS),
> +	COMPOSITE(SCLK_MAC2IO_OUT, "clk_mac2io_out", mux_2plls_p, 0,
> +		  RK3328_CLKSEL_CON(27), 15, 1, MFLAGS, 8, 5, DFLAGS,
> +		  RK3328_CLKGATE_CON(3), 5, GFLAGS),
> +
> +	COMPOSITE(SCLK_MAC2PHY_SRC, "clk_mac2phy_src", mux_2plls_p, 0,
> +		  RK3328_CLKSEL_CON(26), 7, 1, MFLAGS, 0, 5, DFLAGS,
> +		  RK3328_CLKGATE_CON(3), 0, GFLAGS),
> +	GATE(SCLK_MAC2PHY_REF, "clk_mac2phy_ref", "clk_mac2phy", 0,
> +	     RK3328_CLKGATE_CON(9), 3, GFLAGS),
> +	GATE(SCLK_MAC2PHY_RXTX, "clk_mac2phy_rxtx", "clk_mac2phy", 0,
> +	     RK3328_CLKGATE_CON(9), 1, GFLAGS),
> +	COMPOSITE_NOMUX(SCLK_MAC2PHY_OUT, "clk_mac2phy_out", "clk_mac2phy", 0,
> +			RK3328_CLKSEL_CON(26), 8, 2, DFLAGS,
> +			RK3328_CLKGATE_CON(9), 2, GFLAGS),

Please look at the other clock drivers for indentation. I.e. don't align with 
the "(", but instead use the same indent everywhere.

This makes things like the register address always sit in the same position
and thus makes it easier to read the clock diagram.


> +	FACTOR(0, "xin12m", "xin24m", 0, 1, 2),
> +
> +	/*
> +	 * Clock-Architecture Diagram 9
> +	 */
> +

For the following long list of gates, just make it one line per gate and do 
not line-break them ... see other clock drivers for reference.

This long gate list is very uniform (= only gates) and reducing the number
of lines needed makes it easier to parse for those.

> +	/* PD_VOP */
> +	GATE(ACLK_RGA, "aclk_rga", "aclk_rga_pre", 0,
> +	     RK3328_CLKGATE_CON(21), 10, GFLAGS),
> +	GATE(0, "aclk_rga_niu", "aclk_rga_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(22), 3, GFLAGS),
> +	GATE(ACLK_VOP, "aclk_vop", "aclk_vop_pre", 0,
> +	     RK3328_CLKGATE_CON(21), 2, GFLAGS),
> +	GATE(0, "aclk_vop_niu", "aclk_vop_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(21), 4, GFLAGS),
> +
> +	GATE(ACLK_IEP, "aclk_iep", "aclk_vio_pre", 0,
> +	     RK3328_CLKGATE_CON(21), 6, GFLAGS),
> +	GATE(ACLK_CIF, "aclk_cif", "aclk_vio_pre", 0,
> +	     RK3328_CLKGATE_CON(21), 8, GFLAGS),
> +	GATE(ACLK_HDCP, "aclk_hdcp", "aclk_vio_pre", 0,
> +	     RK3328_CLKGATE_CON(21), 15, GFLAGS),
> +	GATE(0, "aclk_vio_niu", "aclk_vio_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(22), 2, GFLAGS),
> +
> +	GATE(HCLK_VOP, "hclk_vop", "hclk_vio_pre", 0,
> +	     RK3328_CLKGATE_CON(21), 3, GFLAGS),
> +	GATE(0, "hclk_vop_niu", "hclk_vio_pre", 0,
> +	     RK3328_CLKGATE_CON(21), 5, GFLAGS),
> +	GATE(HCLK_IEP, "hclk_iep", "hclk_vio_pre", 0,
> +	     RK3328_CLKGATE_CON(21), 7, GFLAGS),
> +	GATE(HCLK_CIF, "hclk_cif", "hclk_vio_pre", 0,
> +	     RK3328_CLKGATE_CON(21), 9, GFLAGS),
> +	GATE(HCLK_RGA, "hclk_rga", "hclk_vio_pre", 0,
> +	     RK3328_CLKGATE_CON(21), 11, GFLAGS),
> +	GATE(0, "hclk_ahb1tom", "hclk_vio_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(21), 12, GFLAGS),
> +	GATE(0, "pclk_vio_h2p", "hclk_vio_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(21), 13, GFLAGS),
> +	GATE(0, "hclk_vio_h2p", "hclk_vio_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(21), 14, GFLAGS),
> +	GATE(HCLK_HDCP, "hclk_hdcp", "hclk_vio_pre", 0,
> +	     RK3328_CLKGATE_CON(22), 0, GFLAGS),
> +	GATE(HCLK_VIO, "hclk_vio", "hclk_vio_pre", 0,
> +	     RK3328_CLKGATE_CON(22), 1, GFLAGS),
> +	GATE(PCLK_HDMI, "pclk_hdmi", "hclk_vio_pre", 0,
> +	     RK3328_CLKGATE_CON(22), 4, GFLAGS),
> +	GATE(PCLK_HDCP, "pclk_hdcp", "hclk_vio_pre", 0,
> +	     RK3328_CLKGATE_CON(22), 5, GFLAGS),
> +
> +	/* PD_PERI */
> +	GATE(0, "aclk_peri_noc", "aclk_peri", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(19), 11, GFLAGS),
> +	GATE(ACLK_USB3OTG, "aclk_usb3otg", "aclk_peri", 0,
> +	     RK3328_CLKGATE_CON(19), 4, GFLAGS),
> +
> +	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_peri", 0,
> +	     RK3328_CLKGATE_CON(19), 0, GFLAGS),
> +	GATE(HCLK_SDIO, "hclk_sdio", "hclk_peri", 0,
> +	     RK3328_CLKGATE_CON(19), 1, GFLAGS),
> +	GATE(HCLK_EMMC, "hclk_emmc", "hclk_peri", 0,
> +	     RK3328_CLKGATE_CON(19), 2, GFLAGS),
> +	GATE(HCLK_SDMMC_EXT, "hclk_sdmmc_ext", "hclk_peri", 0,
> +	     RK3328_CLKGATE_CON(19), 15, GFLAGS),
> +	GATE(HCLK_HOST0, "hclk_host0", "hclk_peri", 0,
> +	     RK3328_CLKGATE_CON(19), 6, GFLAGS),
> +	GATE(HCLK_HOST0_ARB, "hclk_host0_arb", "hclk_peri", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(19), 7, GFLAGS),
> +	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0,
> +	     RK3328_CLKGATE_CON(19), 8, GFLAGS),
> +	GATE(HCLK_OTG_PMU, "hclk_otg_pmu", "hclk_peri", 0,
> +	     RK3328_CLKGATE_CON(19), 9, GFLAGS),
> +	GATE(0, "hclk_peri_niu", "hclk_peri", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(19), 12, GFLAGS),
> +	GATE(0, "pclk_peri_niu", "hclk_peri", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(19), 13, GFLAGS),
> +
> +	/* PD_GMAC */
> +	GATE(ACLK_MAC2PHY, "aclk_mac2phy", "aclk_gmac", 0,
> +	     RK3328_CLKGATE_CON(26), 0, GFLAGS),
> +	GATE(ACLK_MAC2IO, "aclk_mac2io", "aclk_gmac", 0,
> +	     RK3328_CLKGATE_CON(26), 2, GFLAGS),
> +	GATE(0, "aclk_gmac_niu", "aclk_gmac", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(26), 4, GFLAGS),
> +	GATE(PCLK_MAC2PHY, "pclk_mac2phy", "pclk_gmac", 0,
> +	     RK3328_CLKGATE_CON(26), 1, GFLAGS),
> +	GATE(PCLK_MAC2IO, "pclk_mac2io", "pclk_gmac", 0,
> +	     RK3328_CLKGATE_CON(26), 3, GFLAGS),
> +	GATE(0, "pclk_gmac_niu", "pclk_gmac", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(26), 5, GFLAGS),
> +
> +	/* PD_BUS */
> +	GATE(0, "aclk_bus_niu", "aclk_bus_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(15), 12, GFLAGS),
> +	GATE(ACLK_DCF, "aclk_dcf", "aclk_bus_pre", 0,
> +	     RK3328_CLKGATE_CON(15), 11, GFLAGS),
> +	GATE(ACLK_TSP, "aclk_tsp", "aclk_bus_pre", 0,
> +	     RK3328_CLKGATE_CON(17), 12, GFLAGS),
> +	GATE(0, "aclk_intmem", "aclk_bus_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(15), 0, GFLAGS),
> +	GATE(ACLK_DMAC, "aclk_dmac_bus", "aclk_bus_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(15), 1, GFLAGS),
> +
> +	GATE(0, "hclk_rom", "hclk_bus_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(15), 2, GFLAGS),
> +	GATE(HCLK_I2S0_8CH, "hclk_i2s0_8ch", "hclk_bus_pre", 0,
> +	     RK3328_CLKGATE_CON(15), 3, GFLAGS),
> +	GATE(HCLK_I2S1_8CH, "hclk_i2s1_8ch", "hclk_bus_pre", 0,
> +	     RK3328_CLKGATE_CON(15), 4, GFLAGS),
> +	GATE(HCLK_I2S2_2CH, "hclk_i2s2_2ch", "hclk_bus_pre", 0,
> +	     RK3328_CLKGATE_CON(15), 5, GFLAGS),
> +	GATE(HCLK_SPDIF_8CH, "hclk_spdif_8ch", "hclk_bus_pre", 0,
> +	     RK3328_CLKGATE_CON(15), 6, GFLAGS),
> +	GATE(HCLK_TSP, "hclk_tsp", "hclk_bus_pre", 0,
> +	     RK3328_CLKGATE_CON(17), 11, GFLAGS),
> +	GATE(HCLK_CRYPTO_MST, "hclk_crypto_mst", "hclk_bus_pre", 0,
> +	     RK3328_CLKGATE_CON(15), 7, GFLAGS),
> +	GATE(HCLK_CRYPTO_SLV, "hclk_crypto_slv", "hclk_bus_pre", 0,
> +	     RK3328_CLKGATE_CON(15), 8, GFLAGS),
> +	GATE(0, "hclk_bus_niu", "hclk_bus_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(15), 13, GFLAGS),
> +	GATE(HCLK_PDM, "hclk_pdm", "hclk_bus_pre", 0,
> +	     RK3328_CLKGATE_CON(28), 0, GFLAGS),
> +
> +	GATE(0, "pclk_bus_niu", "pclk_bus", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(15), 14, GFLAGS),
> +	GATE(0, "pclk_efuse", "pclk_bus", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(15), 9, GFLAGS),
> +	GATE(0, "pclk_otp", "pclk_bus", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(28), 4, GFLAGS),
> +	GATE(PCLK_I2C0, "pclk_i2c0", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(15), 10, GFLAGS),
> +	GATE(PCLK_I2C1, "pclk_i2c1", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 0, GFLAGS),
> +	GATE(PCLK_I2C2, "pclk_i2c2", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 1, GFLAGS),
> +	GATE(PCLK_I2C3, "pclk_i2c3", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 2, GFLAGS),
> +	GATE(PCLK_TIMER, "pclk_timer0", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 3, GFLAGS),
> +	GATE(0, "pclk_stimer", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 4, GFLAGS),
> +	GATE(PCLK_SPI, "pclk_spi", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 5, GFLAGS),
> +	GATE(PCLK_PWM, "pclk_rk_pwm", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 6, GFLAGS),
> +	GATE(PCLK_GPIO0, "pclk_gpio0", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 7, GFLAGS),
> +	GATE(PCLK_GPIO1, "pclk_gpio1", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 8, GFLAGS),
> +	GATE(PCLK_GPIO2, "pclk_gpio2", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 9, GFLAGS),
> +	GATE(PCLK_GPIO3, "pclk_gpio3", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 10, GFLAGS),
> +	GATE(PCLK_UART0, "pclk_uart0", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 11, GFLAGS),
> +	GATE(PCLK_UART1, "pclk_uart1", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 12, GFLAGS),
> +	GATE(PCLK_UART2, "pclk_uart2", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 13, GFLAGS),
> +	GATE(PCLK_TSADC, "pclk_tsadc", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 14, GFLAGS),
> +	GATE(PCLK_DCF, "pclk_dcf", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(16), 15, GFLAGS),
> +	GATE(PCLK_GRF, "pclk_grf", "pclk_bus", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(17), 0, GFLAGS),
> +	GATE(0, "pclk_cru", "pclk_bus", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(17), 4, GFLAGS),
> +	GATE(0, "pclk_sgrf", "pclk_bus", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(17), 6, GFLAGS),
> +	GATE(0, "pclk_sim", "pclk_bus", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(17), 10, GFLAGS),
> +	GATE(PCLK_SARADC, "pclk_saradc", "pclk_bus", 0,
> +	     RK3328_CLKGATE_CON(17), 15, GFLAGS),
> +	GATE(0, "pclk_pmu", "pclk_bus", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(28), 3, GFLAGS),
> +
> +	GATE(PCLK_USB3PHY_OTG, "pclk_usb3phy_otg", "pclk_phy_pre", 0,
> +	     RK3328_CLKGATE_CON(28), 1, GFLAGS),
> +	GATE(PCLK_USB3PHY_PIPE, "pclk_usb3phy_pipe", "pclk_phy_pre", 0,
> +	     RK3328_CLKGATE_CON(28), 2, GFLAGS),
> +	GATE(PCLK_USB3_GRF, "pclk_usb3_grf", "pclk_phy_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(17), 2, GFLAGS),
> +	GATE(PCLK_USB2_GRF, "pclk_usb2_grf", "pclk_phy_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(17), 14, GFLAGS),
> +	GATE(0, "pclk_ddrphy", "pclk_phy_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(17), 13, GFLAGS),
> +	GATE(0, "pclk_acodecphy", "pclk_phy_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(17), 5, GFLAGS),
> +	GATE(PCLK_HDMIPHY, "pclk_hdmiphy", "pclk_phy_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(17), 7, GFLAGS),
> +	GATE(0, "pclk_vdacphy", "pclk_phy_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(17), 8, GFLAGS),
> +	GATE(0, "pclk_phy_niu", "pclk_phy_pre", CLK_IGNORE_UNUSED,
> +	     RK3328_CLKGATE_CON(15), 15, GFLAGS),




> +static void __init rk3328_clk_init(struct device_node *np)
> +{
> +	struct rockchip_clk_provider *ctx;
> +	void __iomem *reg_base;
> +
> +	reg_base = of_iomap(np, 0);
> +	if (!reg_base) {
> +		pr_err("%s: could not map cru region\n", __func__);
> +		return;
> +	}
> +
> +	rk3328_cru_base = reg_base;
> +
> +	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
> +	if (IS_ERR(ctx)) {
> +		pr_err("%s: rockchip clk init failed\n", __func__);
> +		iounmap(reg_base);
> +		return;
> +	}
> +
> +	rockchip_clk_register_plls(ctx, rk3328_pll_clks,
> +				   ARRAY_SIZE(rk3328_pll_clks),
> +				   RK3328_GRF_SOC_STATUS0);
> +	rockchip_clk_register_branches(ctx, rk3328_clk_branches,
> +				       ARRAY_SIZE(rk3328_clk_branches));
> +	rockchip_clk_protect_critical(rk3328_critical_clocks,
> +				      ARRAY_SIZE(rk3328_critical_clocks));
> +
> +	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
> +				     mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
> +				     &rk3328_cpuclk_data, rk3328_cpuclk_rates,
> +				     ARRAY_SIZE(rk3328_cpuclk_rates));
> +
> +	rockchip_register_softrst(np, 11, reg_base + RK3328_SOFTRST_CON(0),
> +				  ROCKCHIP_SOFTRST_HIWORD_MASK);
> +
> +	rockchip_register_restart_notifier(ctx, RK3328_GLB_SRST_FST, NULL);
> +
> +	rockchip_clk_of_add_provider(np, ctx);
> +
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +				       &rk3328_clk_panic_block);

please drop this notifier and asorted code above for dumping cru registers.


> +}
> +
> +CLK_OF_DECLARE(rk3328_cru, "rockchip,rk3328-cru", rk3328_clk_init);
> +
> +static void __init rk3328_grf_clk_init(struct device_node *np)
> +{
> +	struct rockchip_clk_provider *ctx;
> +	void __iomem *reg_base;
> +
> +	reg_base = of_iomap(np, 0);
> +	if (!reg_base) {
> +		pr_err("%s: could not map cru pmu region\n", __func__);
> +		return;
> +	}
> +
> +	ctx = rockchip_clk_init(np, reg_base, CLKGRF_NR_CLKS);
> +	if (IS_ERR(ctx)) {
> +		pr_err("%s: rockchip pmu clk init failed\n", __func__);
> +		return;
> +	}
> +
> +	rockchip_clk_register_branches(ctx, rk3328_clk_grf_branches,
> +				       ARRAY_SIZE(rk3328_clk_grf_branches));
> +
> +	rockchip_clk_of_add_provider(np, ctx);
> +}

We definitly don't want to bind against the regular GRF node. This causes a 
double mapping of the region and in general this isn't the clock-controller 
and just contains 2 clocks controls that somehow ended up in the GRF :-) .

Instead please take a look at the muxgrf clock patches I Cc'ed you on some 
minutes ago.


> +CLK_OF_DECLARE(rk3328_cru_grf, "rockchip,rk3328-grf", rk3328_grf_clk_init);
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h index
> 06acb7e0911f..7225997f8d52 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -91,6 +91,28 @@
>  #define RK3288_EMMC_CON0		0x218
>  #define RK3288_EMMC_CON1		0x21c
> 
> +#define RK3328_PLL_CON(x)		RK2928_PLL_CON(x)
> +#define RK3328_CLKSEL_CON(x)		((x) * 0x4 + 0x100)
> +#define RK3328_CLKGATE_CON(x)		((x) * 0x4 + 0x200)
> +#define RK3328_GRFCLKSEL_CON(x)		((x) * 0x4 + 0x100)
> +#define RK3328_GLB_SRST_FST		0x9c
> +#define RK3328_GLB_SRST_SND		0x98
> +#define RK3328_SOFTRST_CON(x)		((x) * 0x4 + 0x300)
> +#define RK3328_MODE_CON			0x80
> +#define RK3328_MISC_CON			0x84
-----
> +#define RK3328_DIV_ACLKM_MASK		0x7
> +#define RK3328_DIV_ACLKM_SHIFT		4
> +#define RK3328_DIV_PCLK_DBG_MASK	0xf
> +#define RK3328_DIV_PCLK_DBG_SHIFT	0
-----
please move these to the armclk defintion in the controller driver
where already the other definitions are


Thanks
Heiko
