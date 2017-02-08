From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 8 Feb 2017 11:06:14 +0800
Subject: i.MX7 clock support broken
In-Reply-To: <20170207142225.zitac2r7g3kvowjw@pengutronix.de>
References: <20170207142225.zitac2r7g3kvowjw@pengutronix.de>
Message-ID: <20170208030613.GK3407@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Frank, who is the author and submitter of i.MX7 clock driver.

Shawn

On Tue, Feb 07, 2017 at 03:22:25PM +0100, Sascha Hauer wrote:
> Hi All,
> 
> I recently adopted the i.MX7 clock tree from Linux to barebox and wondered
> why ethernet doesn't work. I found out that the clock tree in Linux is quite
> different from what the reference manual describes and also quite different
> from the hardware I have on my desk. There are several clocks that only exist
> in the driver, but not in the actual hardware and also several clocks which
> are in hardware, but not in the driver.
> 
> These clocks exist in the driver only, but not in the hardware:
> 
> clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate4("arm_a7_root_clk", "arm_a7_div", base + 0x4000, 0);
> clks[IMX7D_ARM_M4_ROOT_CLK] = imx_clk_gate4("arm_m4_root_clk", "arm_m4_div", base + 0x4010, 0);
> clks[IMX7D_ARM_M0_ROOT_CLK] = imx_clk_gate4("arm_m0_root_clk", "arm_m0_div", base + 0x4020, 0);
> clks[IMX7D_USB_HSIC_ROOT_CLK] = imx_clk_gate4("usb_hsic_root_clk", "usb_hsic_post_div", base + 0x4420, 0);
> clks[IMX7D_PCIE_PHY_ROOT_CLK] = imx_clk_gate4("pcie_phy_root_clk", "pcie_phy_post_div", base + 0x4600, 0);
> clks[IMX7D_SPDIF_ROOT_CLK] = imx_clk_gate4("spdif_root_clk", "spdif_post_div", base + 0x44d0, 0);
> clks[IMX7D_ENET1_REF_ROOT_CLK] = imx_clk_gate4("enet1_ref_root_clk", "enet1_ref_post_div", base + 0x44e0, 0);
> clks[IMX7D_ENET1_TIME_ROOT_CLK] = imx_clk_gate4("enet1_time_root_clk", "enet1_time_post_div", base + 0x44f0, 0);
> clks[IMX7D_ENET2_REF_ROOT_CLK] = imx_clk_gate4("enet2_ref_root_clk", "enet2_ref_post_div", base + 0x4500, 0);
> clks[IMX7D_ENET2_TIME_ROOT_CLK] = imx_clk_gate4("enet2_time_root_clk", "enet2_time_post_div", base + 0x4510, 0);
> clks[IMX7D_ENET_PHY_REF_ROOT_CLK] = imx_clk_gate4("enet_phy_ref_root_clk", "enet_phy_ref_post_div", base + 0x4520, 0);
> clks[IMX7D_AUDIO_MCLK_ROOT_CLK] = imx_clk_gate4("audio_mclk_root_clk", "audio_mclk_post_div", base + 0x4790, 0);
> clks[IMX7D_WRCLK_ROOT_CLK] = imx_clk_gate4("wrclk_root_clk", "wrclk_post_div", base + 0x47a0, 0);
> clks[IMX7D_ADC_ROOT_CLK] = imx_clk_gate4("adc_root_clk", "ipg_root_clk", base + 0x4200, 0);
> 
> And these clocks are described in the reference manual, but not handled
> in the driver:
> 
> CCM_CCGR7 sim_m 0x4070
> CCM_CCGR8 sim_s 0x4080
> CCM_CCGR9 sim_wakeup 0x4090
> CCM_CCGR10 ipmux1 0x40A0
> CCM_CCGR11 ipmux2 0x40B0
> CCM_CCGR12 ipmux3 0x40C0
> CCM_CCGR16 rom 0x4100
> CCM_CCGR33 anatop 0x4210
> CCM_CCGR34 sctr 0x4220
> CCM_CCGR35 ocotp 0x4230
> CCM_CCGR36 caam 0x4240
> CCM_CCGR37 snvs 0x4250
> CCM_CCGR38 rdc 0x4260
> CCM_CCGR39 mu 0x4270
> CCM_CCGR40 hs 0x4280
> CCM_CCGR41 dvfs 0x4290
> CCM_CCGR42 qos 0x42A0
> CCM_CCGR43 qos_dispmix 0x42B0
> CCM_CCGR44 qos_megamix 0x42C0
> CCM_CCGR45 csu 0x42D0
> CCM_CCGR46 dbgmon 0x42E0
> CCM_CCGR47 debug 0x42F0
> CCM_CCGR49 sec_debug 0x4310
> CCM_CCGR64 sema1 0x4400
> CCM_CCGR65 sema2 0x4410
> CCM_CCGR68 perfmon1 0x4440
> CCM_CCGR69 perfmon2 0x4450
> CCM_CCGR76 pxp 0x44C0
> CCM_CCGR104 usb_ctrl 0x4680
> CCM_CCGR105 usb_hsic 0x4690
> CCM_CCGR106 usb_phy1 0x46A0
> CCM_CCGR107 usb_phy2 0x46B0
> CCM_CCGR112 enet1 0x4700
> CCM_CCGR113 enet2 0x4710
> CCM_CCGR160 gpio1 0x4A00
> CCM_CCGR161 gpio2 0x4A10
> CCM_CCGR162 gpio3 0x4A20
> CCM_CCGR163 gpio4 0x4A30
> CCM_CCGR164 gpio5 0x4A40
> CCM_CCGR165 gpio6 0x4A50
> CCM_CCGR166 gpio7 0x4A60
> CCM_CCGR168 iomux 0x4A80
> CCM_CCGR169 iomux_lpsr 0x4A90
> CCM_CCGR170 kpp 0x4AA0
> 
> It seems most stuff works in the Kernel when the clocks are left
> enabled in the bootloader, but for example the real ethernet clocks
> are never handled in the kernel.
> 
> Also I stumbled upon the gate at offset 0x4130. The same gate is
> registered as 5 different gates in the kernel without being handled
> as a shared gate:
> 
> clks[IMX7D_NAND_USDHC_BUS_ROOT_CLK] = imx_clk_gate4("nand_usdhc_root_clk", "nand_usdhc_post_div", base + 0x4130, 0);
> clks[IMX7D_DRAM_ROOT_CLK] = imx_clk_gate4("dram_root_clk", "dram_post_div", base + 0x4130, 0);
> clks[IMX7D_DRAM_PHYM_ROOT_CLK] = imx_clk_gate4("dram_phym_root_clk", "dram_phym_cg", base + 0x4130, 0);
> clks[IMX7D_DRAM_PHYM_ALT_ROOT_CLK] = imx_clk_gate4("dram_phym_alt_root_clk", "dram_phym_alt_post_div", base + 0x4130, 0);
> clks[IMX7D_DRAM_ALT_ROOT_CLK] = imx_clk_gate4("dram_alt_root_clk", "dram_alt_post_div", base + 0x4130, 0);
> 
> I don't have a patch for this, just hope that somebody @NXP has a better
> clue what's going on and maybe there already is a fix somewhere floating
> around.
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
