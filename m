From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 30 Mar 2013 12:37:03 +0100
Subject: PCI support for IMX6
In-Reply-To: <20130329185500.GB30029@amd.pavel.ucw.cz>
References: <20130329185500.GB30029@amd.pavel.ucw.cz>
Message-ID: <20130330113703.GA21042@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> What is the state of PCI support for IMX6? I have board that has
> e1000e connected via PCI, and I'd like to get network to work.
> 
> I'm currently trying to port PCI support from 3.0, but it does not
> look exactly easy.

This is what I ended up with. Currently it is unable to turn on clock
for PCI, thus it hangs. If someone has any ideas, let me know...
									Pavel

diff --git a/arch/arm/boot/dts/imx6q-sbc6x.dts b/arch/arm/boot/dts/imx6q-sbc6x.dts
index 9549b6f..6066625 100644
--- a/arch/arm/boot/dts/imx6q-sbc6x.dts
+++ b/arch/arm/boot/dts/imx6q-sbc6x.dts
@@ -23,4 +23,10 @@
 	status = "okay";
 };
 
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet_1>;
+	phy-mode = "rgmii";
+	status = "okay";
+};
 
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4c9c6f9..75ef3b0 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -7,6 +7,7 @@ config ARCH_MXC
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
+	select MIGHT_HAVE_PCI
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index c4ce090..b8b70c7 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -112,4 +112,6 @@ obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd51-baseboard.o
 obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
 obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
 
+obj-$(CONFIG_PCI) += pcie.o
+
 obj-y += devices/
diff --git a/arch/arm/mach-imx/crm_regs.h b/arch/arm/mach-imx/crm_regs.h
new file mode 100644
index 0000000..417894b
--- /dev/null
+++ b/arch/arm/mach-imx/crm_regs.h
@@ -0,0 +1,542 @@
+/*
+ * Copyright 2008-2012 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#ifndef __ARCH_ARM_MACH_MX6_CRM_REGS_H__
+#define __ARCH_ARM_MACH_MX6_CRM_REGS_H__
+
+/* IOMUXC */
+#define MXC_IOMUXC_BASE			MX6_IO_ADDRESS(MX6Q_IOMUXC_BASE_ADDR)
+#define IOMUXC_GPR0			(iomux_base + 0x00)
+#define IOMUXC_GPR1			(iomux_base + 0x04)
+#define IOMUXC_GPR2			(iomux_base + 0x08)
+#define IOMUXC_GPR3			(iomux_base + 0x0C)
+#define IOMUXC_GPR4			(iomux_base + 0x10)
+#define IOMUXC_GPR5			(iomux_base + 0x14)
+#define IOMUXC_GPR6			(iomux_base + 0x18)
+#define IOMUXC_GPR7			(iomux_base + 0x1C)
+#define IOMUXC_GPR8			(iomux_base + 0x20)
+#define IOMUXC_GPR9			(iomux_base + 0x24)
+#define IOMUXC_GPR10			(iomux_base + 0x28)
+#define IOMUXC_GPR11			(iomux_base + 0x2C)
+#define IOMUXC_GPR12			(iomux_base + 0x30)
+#define IOMUXC_GPR13			(iomux_base + 0x34)
+
+#define IOMUXC_GPR3_OCRAM_CTL_EN	(0xf << 21)
+#define IOMUXC_GPR4_VDOA_CACHE_EN	(0xf << 28)
+#define IOMUXC_GPR4_VPU_CACHE_EN	(0xcc)
+#define IOMUXC_GPR4_IPU_CACHE_EN	(0x3)
+#define IOMUXC_GPR6_IPU1_QOS		(0x007f007f)
+#define IOMUXC_GPR7_IPU2_QOS		(0x007f007f)
+
+/* MMDC */
+#define MXC_MMDC_P0_BASE		MX6_IO_ADDRESS(MMDC_P0_BASE_ADDR)
+#define MMDC_MDMISC_OFFSET		(MXC_MMDC_P0_BASE + 0x18)
+#define MMDC_MDMISC_DDR_TYPE_MASK	(0x3 << 3)
+#define MMDC_MDMISC_DDR_TYPE_OFFSET	(3)
+
+/* PLLs */
+#define MXC_PLL_BASE			MX6_IO_ADDRESS(ANATOP_BASE_ADDR)
+#define PLL1_SYS_BASE_ADDR		(MXC_PLL_BASE + 0x0)
+#define PLL2_528_BASE_ADDR		(MXC_PLL_BASE + 0x30)
+#define PLL3_480_USB1_BASE_ADDR		(MXC_PLL_BASE + 0x10)
+#define PLL4_AUDIO_BASE_ADDR		(MXC_PLL_BASE + 0x70)
+#define PLL5_VIDEO_BASE_ADDR		(MXC_PLL_BASE + 0xA0)
+#define PLL6_MLB_BASE_ADDR		(MXC_PLL_BASE + 0xD0)
+#define PLL7_480_USB2_BASE_ADDR		(MXC_PLL_BASE + 0x20)
+#define PLL8_ENET_BASE_ADDR		(MXC_PLL_BASE + 0xE0)
+#define PFD_480_BASE_ADDR		(MXC_PLL_BASE + 0xF0)
+#define PFD_528_BASE_ADDR		(MXC_PLL_BASE + 0x100)
+#define ANADIG_REG_CORE		(MXC_PLL_BASE + 0x140)
+#define ANADIG_MISC1_REG		(MXC_PLL_BASE + 0x160)
+#define ANATOP_LVDS_CLK1_SRC_SATA	0xB
+#define ANATOP_LVDS_CLK1_OBEN_MASK	0x400
+#define ANATOP_LVDS_CLK1_IBEN_MASK	0x1000
+#define ANATOP_LVDS_CLK2_OBEN_MASK  0x800
+#define ANATOP_LVDS_CLK2_IBEN_MASK  0x2000
+#define ANA_MISC2_BASE_ADDR		(MXC_PLL_BASE + 0x170)
+
+#define PLL_SETREG_OFFSET		0x4
+#define PLL_CLRREG_OFFSET		0x8
+#define PLL_TOGGLE_OFFSET		0x0C
+#define PLL_NUM_DIV_OFFSET		0x10
+#define PLL_DENOM_DIV_OFFSET		0x20
+#define PLL_528_SS_OFFSET		0x10
+#define PLL_528_NUM_DIV_OFFSET		0x20
+#define PLL_528_DENOM_DIV_OFFSET	0x30
+
+/* Common PLL register bit defines. */
+#define ANADIG_PLL_LOCK				(1 << 31)
+#define ANADIG_PLL_BYPASS			(1 << 16)
+#define ANADIG_PLL_BYPASS_CLK_SRC_MASK		(0x3 << 14)
+#define ANADIG_PLL_BYPASS_CLK_SRC_OFFSET	(14)
+#define ANADIG_PLL_ENABLE			(1 << 13)
+#define ANADIG_PLL_POWER_DOWN			(1 << 12)
+#define ANADIG_PLL_HOLD_RING_OFF		(1 << 11)
+
+/* PLL1_SYS defines */
+#define ANADIG_PLL_SYS_DIV_SELECT_MASK		(0x7F)
+#define ANADIG_PLL_SYS_DIV_SELECT_OFFSET	(0)
+#define ANADIG_PLL_SYS_BYPASS_MASK		(0x10000)
+#define ANADIG_PLL_SYS_BYPASS_OFFSET	(16)
+
+/* PLL2_528 defines */
+#define ANADIG_PLL_528_DIV_SELECT		(1)
+
+/* PLL3_480 defines. */
+#define ANADIG_PLL_480_EN_USB_CLKS		(1 << 6)
+#define ANADIG_PLL_480_DIV_SELECT_MASK		(0x3)
+#define ANADIG_PLL_480_DIV_SELECT_OFFSET	(0)
+
+/* PLL4_AUDIO PLL5_VIDEO defines. */
+#define ANADIG_PLL_AV_DIV_SELECT_MASK		(0x7F)
+#define ANADIG_PLL_AV_DIV_SELECT_OFFSET		(0)
+#define ANADIG_PLL_AV_TEST_DIV_SEL_MASK		(0x180000)
+#define ANADIG_PLL_AV_TEST_DIV_SEL_OFFSET	(19)
+
+/* PLL6_MLB defines. */
+#define ANADIG_PLL_MLB_LOCK			(1 << 31)
+#define ANADIG_PLL_MLB_FLT_RES_CFG_MASK		(0x7 << 26)
+#define ANADIG_PLL_MLB_FLT_RES_CFG_OFFSET	(26)
+#define ANADIG_PLL_MLB_RX_CLK_DELAY_CFG_MASK	(0x7 << 23)
+#define ANADIG_PLL_MLB_RX_CLK_DELAY_CFG_OFFSET	(23)
+#define ANADIG_PLL_MLB_VDDD_DELAY_CFG_MASK	(0x7 << 20)
+#define ANADIG_PLL_MLB_VDDD_DELAY_CFG_OFFSET	(20)
+#define ANADIG_PLL_MLB_VDDA_DELAY_CFG_MASK	(0x7 << 17)
+#define ANADIG_PLL_MLB_VDDA_DELAY_CFG_OFFSET	(17)
+#define ANADIG_PLL_MLB_BYPASS			(1 << 16)
+
+/* PLL8_ENET defines. */
+#define ANADIG_PLL_ENET_LOCK			(1 << 31)
+#define ANADIG_PLL_ENET_EN_SATA			(1 << 20)
+#define ANADIG_PLL_ENET_EN_PCIE			(1 << 19)
+#define ANADIG_PLL_ENET_BYPASS			(1 << 16)
+#define ANADIG_PLL_ENET_EN			(1 << 13)
+#define ANADIG_PLL_ENET_POWER_DOWN		(1 << 12)
+#define ANADIG_PLL_ENET_DIV_SELECT_MASK		(0x3)
+#define ANADIG_PLL_ENET_DIV_SELECT_OFFSET	(0)
+#define ANATOP_BYPASS_SRC_LVDS1         0x00004000
+
+/* PFD register defines. */
+#define ANADIG_PFD_FRAC_MASK			0x3F
+#define ANADIG_PFD3_CLKGATE			(1 << 31)
+#define ANADIG_PFD3_STABLE			(1 << 30)
+#define ANADIG_PFD3_FRAC_OFFSET			24
+#define ANADIG_PFD2_CLKGATE			(1 << 23)
+#define ANADIG_PFD2_STABLE			(1 << 22)
+#define ANADIG_PFD2_FRAC_OFFSET			16
+#define ANADIG_PFD1_CLKGATE			(1 << 15)
+#define ANADIG_PFD1_STABLE			(1 << 14)
+#define ANADIG_PFD1_FRAC_OFFSET			8
+#define ANADIG_PFD0_CLKGATE			(1 << 7)
+#define ANADIG_PFD0_STABLE			(1 << 6)
+#define ANADIG_PFD0_FRAC_OFFSET			0
+
+/* ANATOP  Regulator/LDO defines */
+#define ANADIG_REG_RAMP_RATE_MASK			0x03
+#define ANADIG_REG_RAMP_RATE_OFFSET			(0x3 << 27)
+#define ANADIG_REG_ADJUST_MASK				0xF
+#define ANADIG_REG_TARGET_MASK				0x1F
+#define ANADIG_REG2_SOC_ADJUST_OFFSET		23
+#define ANADIG_REG2_SOC_TARGET_OFFSET		18
+#define ANADIG_REG1_PU_ADJUST_OFFSET			14
+#define ANADIG_REG1_PU_TARGET_OFFSET			9
+#define ANADIG_REG0_CORE_ADJUST_OFFSET		5
+#define ANADIG_REG0_CORE_TARGET_OFFSET		0
+
+/* ANA MISC2 register defines */
+#define ANADIG_ANA_MISC2_REG1_BO_EN			(1 << 13)
+#define ANADIG_ANA_MISC2_CONTROL3_MASK		0xC0000000
+#define ANADIG_ANA_MISC2_CONTROL3_OFFSET	30
+
+#define MXC_CCM_BASE		MX6_IO_ADDRESS(CCM_BASE_ADDR)
+/* CCM Register Offsets. */
+#define MXC_CCM_CDCR_OFFSET			0x4C
+#define MXC_CCM_CACRR_OFFSET			0x10
+#define MXC_CCM_CDHIPR_OFFSET			0x48
+
+/* Register addresses of CCM*/
+#define MXC_CCM_CCR		(MXC_CCM_BASE + 0x00)
+#define MXC_CCM_CCDR		(MXC_CCM_BASE + 0x04)
+#define MXC_CCM_CSR		(MXC_CCM_BASE + 0x08)
+#define MXC_CCM_CCSR		(MXC_CCM_BASE + 0x0c)
+#define MXC_CCM_CACRR		(MXC_CCM_BASE + 0x10)
+#define MXC_CCM_CBCDR		(MXC_CCM_BASE + 0x14)
+#define MXC_CCM_CBCMR		(MXC_CCM_BASE + 0x18)
+#define MXC_CCM_CSCMR1		(MXC_CCM_BASE + 0x1c)
+#define MXC_CCM_CSCMR2		(MXC_CCM_BASE + 0x20)
+#define MXC_CCM_CSCDR1		(MXC_CCM_BASE + 0x24)
+#define MXC_CCM_CS1CDR		(MXC_CCM_BASE + 0x28)
+#define MXC_CCM_CS2CDR		(MXC_CCM_BASE + 0x2c)
+#define MXC_CCM_CDCDR		(MXC_CCM_BASE + 0x30)
+#define MXC_CCM_CHSCCDR		(MXC_CCM_BASE + 0x34)
+#define MXC_CCM_CSCDR2		(MXC_CCM_BASE + 0x38)
+#define MXC_CCM_CSCDR3		(MXC_CCM_BASE + 0x3c)
+#define MXC_CCM_CSCDR4		(MXC_CCM_BASE + 0x40)
+#define MXC_CCM_CWDR		(MXC_CCM_BASE + 0x44)
+#define MXC_CCM_CDHIPR		(MXC_CCM_BASE + 0x48)
+#define MXC_CCM_CDCR		(MXC_CCM_BASE + 0x4c)
+#define MXC_CCM_CTOR		(MXC_CCM_BASE + 0x50)
+#define MXC_CCM_CLPCR		(MXC_CCM_BASE + 0x54)
+#define MXC_CCM_CISR		(MXC_CCM_BASE + 0x58)
+#define MXC_CCM_CIMR		(MXC_CCM_BASE + 0x5c)
+#define MXC_CCM_CCOSR 		(MXC_CCM_BASE + 0x60)
+#define MXC_CCM_CGPR		(MXC_CCM_BASE + 0x64)
+#define MXC_CCM_CCGR0		(MXC_CCM_BASE + 0x68)
+#define MXC_CCM_CCGR1		(MXC_CCM_BASE + 0x6C)
+#define MXC_CCM_CCGR2		(MXC_CCM_BASE + 0x70)
+#define MXC_CCM_CCGR3		(MXC_CCM_BASE + 0x74)
+#define MXC_CCM_CCGR4		(MXC_CCM_BASE + 0x78)
+#define MXC_CCM_CCGR5		(MXC_CCM_BASE + 0x7C)
+#define MXC_CCM_CCGR6		(MXC_CCM_BASE + 0x80)
+#define MXC_CCM_CCGR7		(MXC_CCM_BASE + 0x84)
+#define MXC_CCM_CMEOR		(MXC_CCM_BASE + 0x88)
+
+/* Define the bits in register CCR */
+#define MXC_CCM_CCR_RBC_EN			(1 << 27)
+#define MXC_CCM_CCR_REG_BYPASS_CNT_MASK		(0x3F << 21)
+#define MXC_CCM_CCR_REG_BYPASS_CNT_OFFSET	(21)
+#define MXC_CCM_CCR_WB_COUNT_MASK		(0x7 << 16)
+#define MXC_CCM_CCR_WB_COUNT_OFFSET		(16)
+#define MXC_CCM_CCR_COSC_EN			(1 << 12)
+#define MXC_CCM_CCR_OSCNT_MASK			(0xFF)
+#define MXC_CCM_CCR_OSCNT_OFFSET		(0)
+
+/* Define the bits in register CCDR */
+#define MXC_CCM_CCDR_MMDC_CH1_HS_MASK		(1 << 16)
+#define MXC_CCM_CCDR_MMDC_CH0_HS_MASK		(1 << 17)
+
+/* Define the bits in register CSR */
+#define MXC_CCM_CSR_COSC_READY			(1 << 5)
+#define MXC_CCM_CSR_REF_EN_B			(1 << 0)
+
+/* Define the bits in register CCSR */
+#define MXC_CCM_CCSR_PDF_540M_AUTO_DIS		(1 << 15)
+#define MXC_CCM_CCSR_PDF_720M_AUTO_DIS		(1 << 14)
+#define MXC_CCM_CCSR_PDF_454M_AUTO_DIS		(1 << 13)
+#define MXC_CCM_CCSR_PDF_508M_AUTO_DIS		(1 << 12)
+#define MXC_CCM_CCSR_PDF_594M_AUTO_DIS		(1 << 11)
+#define MXC_CCM_CCSR_PDF_352M_AUTO_DIS		(1 << 10)
+#define MXC_CCM_CCSR_PDF_400M_AUTO_DIS		(1 << 9)
+#define MXC_CCM_CCSR_STEP_SEL			(1 << 8)
+#define MXC_CCM_CCSR_PLL1_SW_CLK_SEL		(1 << 2)
+#define MXC_CCM_CCSR_PLL2_SW_CLK_SEL		(1 << 1)
+#define MXC_CCM_CCSR_PLL3_SW_CLK_SEL		(1 << 0)
+
+/* Define the bits in register CACRR */
+#define MXC_CCM_CACRR_ARM_PODF_OFFSET		(0)
+#define MXC_CCM_CACRR_ARM_PODF_MASK		(0x7)
+
+/* Define the bits in register CBCDR */
+#define MXC_CCM_CBCDR_PERIPH_CLK2_PODF_MASK	(0x7 << 27)
+#define MXC_CCM_CBCDR_PERIPH_CLK2_PODF_OFFSET	(27)
+#define MXC_CCM_CBCDR_PERIPH2_CLK_SEL		(1 << 26)
+#define MXC_CCM_CBCDR_PERIPH_CLK_SEL		(1 << 25)
+#define MXC_CCM_CBCDR_MMDC_CH0_PODF_MASK	(0x7 << 19)
+#define MXC_CCM_CBCDR_MMDC_CH0_PODF_OFFSET	(19)
+#define MXC_CCM_CBCDR_AXI_PODF_MASK		(0x7 << 16)
+#define MXC_CCM_CBCDR_AXI_PODF_OFFSET		(16)
+#define MXC_CCM_CBCDR_AHB_PODF_MASK		(0x7 << 10)
+#define MXC_CCM_CBCDR_AHB_PODF_OFFSET		(10)
+#define MXC_CCM_CBCDR_IPG_PODF_MASK		(0x3 << 8)
+#define MXC_CCM_CBCDR_IPG_PODF_OFFSET		(8)
+#define MXC_CCM_CBCDR_AXI_ALT_SEL_MASK		(1 << 7)
+#define MXC_CCM_CBCDR_AXI_ALT_SEL_OFFSET	(7)
+#define MXC_CCM_CBCDR_AXI_SEL			(1 << 6)
+#define MXC_CCM_CBCDR_MMDC_CH1_PODF_MASK	(0x7 << 3)
+#define MXC_CCM_CBCDR_MMDC_CH1_PODF_OFFSET	(3)
+#define MXC_CCM_CBCDR_PERIPH2_CLK2_PODF_MASK	(0x7 << 0)
+#define MXC_CCM_CBCDR_PERIPH2_CLK2_PODF_OFFSET	(0)
+
+/* Define the bits in register CBCMR */
+#define MXC_CCM_CBCMR_GPU3D_SHADER_PODF_MASK		(0x7 << 29)
+#define MXC_CCM_CBCMR_GPU3D_SHADER_PODF_OFFSET		(29)
+#define MXC_CCM_CBCMR_GPU3D_CORE_PODF_MASK		(0x7 << 26)
+#define MXC_CCM_CBCMR_GPU3D_CORE_PODF_OFFSET		(26)
+#define MXC_CCM_CBCMR_GPU2D_CORE_PODF_MASK		(0x7 << 23)
+#define MXC_CCM_CBCMR_GPU2D_CORE_PODF_OFFSET		(23)
+#define MXC_CCM_CBCMR_PRE_PERIPH2_CLK_SEL_MASK		(0x3 << 21)
+#define MXC_CCM_CBCMR_PRE_PERIPH2_CLK_SEL_OFFSET	(21)
+#define MXC_CCM_CBCMR_PERIPH2_CLK2_SEL			(1 << 20)
+#define MXC_CCM_CBCMR_PRE_PERIPH_CLK_SEL_MASK		(0x3 << 18)
+#define MXC_CCM_CBCMR_PRE_PERIPH_CLK_SEL_OFFSET		(18)
+#define MXC_CCM_CBCMR_GPU2D_CLK_SEL_MASK		(0x3 << 16)
+#define MXC_CCM_CBCMR_GPU2D_CLK_SEL_OFFSET		(16)
+#define MXC_CCM_CBCMR_MLB_CLK_SEL_MASK			(0x3 << 16)
+#define MXC_CCM_CBCMR_MLB_CLK_SEL_OFFSET		(16)
+#define MXC_CCM_CBCMR_VPU_AXI_CLK_SEL_MASK		(0x3 << 14)
+#define MXC_CCM_CBCMR_VPU_AXI_CLK_SEL_OFFSET		(14)
+#define MXC_CCM_CBCMR_PERIPH_CLK2_SEL_MASK		(0x3 << 12)
+#define MXC_CCM_CBCMR_PERIPH_CLK2_SEL_OFFSET		(12)
+#define MXC_CCM_CBCMR_VDOAXI_CLK_SEL			(1 << 11)
+#define MXC_CCM_CBCMR_PCIE_AXI_CLK_SEL			(1 << 10)
+#define MXC_CCM_CBCMR_GPU3D_SHADER_CLK_SEL_MASK		(0x3 << 8)
+#define MXC_CCM_CBCMR_GPU3D_SHADER_CLK_SEL_OFFSET	(8)
+#define MXC_CCM_CBCMR_GPU3D_CORE_CLK_SEL_MASK		(0x3 << 4)
+#define MXC_CCM_CBCMR_GPU3D_CORE_CLK_SEL_OFFSET		(4)
+#define MXC_CCM_CBCMR_GPU3D_AXI_CLK_SEL			(1 << 1)
+#define MXC_CCM_CBCMR_GPU2D_AXI_CLK_SEL			(1 << 0)
+
+/* Define the bits in register CSCMR1 */
+#define MXC_CCM_CSCMR1_ACLK_EMI_SLOW_MASK		(0x3 << 29)
+#define MXC_CCM_CSCMR1_ACLK_EMI_SLOW_OFFSET		(29)
+#define MXC_CCM_CSCMR1_ACLK_EMI_MASK			(0x3 << 27)
+#define MXC_CCM_CSCMR1_ACLK_EMI_OFFSET			(27)
+#define MXC_CCM_CSCMR1_ACLK_EMI_SLOW_PODF_MASK		(0x7 << 23)
+#define MXC_CCM_CSCMR1_ACLK_EMI_SLOW_PODF_OFFSET	(23)
+#define MXC_CCM_CSCMR1_ACLK_EMI_PODF_MASK		(0x7 << 20)
+#define MXC_CCM_CSCMR1_ACLK_EMI_PODF_OFFSET		(20)
+#define MXC_CCM_CSCMR1_USDHC4_CLK_SEL			(1 << 19)
+#define MXC_CCM_CSCMR1_USDHC3_CLK_SEL			(1 << 18)
+#define MXC_CCM_CSCMR1_USDHC2_CLK_SEL			(1 << 17)
+#define MXC_CCM_CSCMR1_USDHC1_CLK_SEL			(1 << 16)
+#define MXC_CCM_CSCMR1_SSI3_CLK_SEL_MASK		(0x3 << 14)
+#define MXC_CCM_CSCMR1_SSI3_CLK_SEL_OFFSET		(14)
+#define MXC_CCM_CSCMR1_SSI2_CLK_SEL_MASK		(0x3 << 12)
+#define MXC_CCM_CSCMR1_SSI2_CLK_SEL_OFFSET		(12)
+#define MXC_CCM_CSCMR1_SSI1_CLK_SEL_MASK		(0x3 << 10)
+#define MXC_CCM_CSCMR1_SSI1_CLK_SEL_OFFSET		(10)
+#define MXC_CCM_CSCMR1_PERCLK_CLK_SEL_MASK		(0x1 << 6)
+#define MXC_CCM_CSCMR1_PERCLK_CLK_SEL_OFFSET	(6)
+#define MXC_CCM_CSCMR1_PERCLK_PODF_MASK			(0x3F)
+#define MXC_CCM_CSCMR1_PERCLK_PODF_OFFSET		(0)
+
+/* Define the bits in register CSCMR2 */
+#define MXC_CCM_CSCMR2_ESAI_CLK_SEL_MASK		(0x3 << 19)
+#define MXC_CCM_CSCMR2_ESAI_CLK_SEL_OFFSET		(19)
+#define MXC_CCM_CSCMR2_LDB_DI1_IPU_DIV			(1 << 11)
+#define MXC_CCM_CSCMR2_LDB_DI0_IPU_DIV			(1 << 10)
+#define MXC_CCM_CSCMR2_CAN_CLK_PODF_MASK		(0x3F << 2)
+#define MXC_CCM_CSCMR2_CAN_CLK_PODF_OFFSET		(2)
+
+/* Define the bits in register CSCDR1 */
+#define MXC_CCM_CSCDR1_VPU_AXI_PODF_MASK		(0x7 << 25)
+#define MXC_CCM_CSCDR1_VPU_AXI_PODF_OFFSET		(25)
+#define MXC_CCM_CSCDR1_USDHC4_PODF_MASK			(0x7 << 22)
+#define MXC_CCM_CSCDR1_USDHC4_PODF_OFFSET		(22)
+#define MXC_CCM_CSCDR1_USDHC3_PODF_MASK			(0x7 << 19)
+#define MXC_CCM_CSCDR1_USDHC3_PODF_OFFSET		(19)
+#define MXC_CCM_CSCDR1_USDHC2_PODF_MASK			(0x7 << 16)
+#define MXC_CCM_CSCDR1_USDHC2_PODF_OFFSET		(16)
+#define MXC_CCM_CSCDR1_USDHC1_PODF_MASK			(0x7 << 11)
+#define MXC_CCM_CSCDR1_USDHC1_PODF_OFFSET		(11)
+#define MXC_CCM_CSCDR1_USBOH3_CLK_PRED_OFFSET		(8)
+#define MXC_CCM_CSCDR1_USBOH3_CLK_PRED_MASK		(0x7 << 8)
+#define MXC_CCM_CSCDR1_USBOH3_CLK_PODF_OFFSET		(6)
+#define MXC_CCM_CSCDR1_UART_CLK_SEL_MASK		(0x1 << 6)
+#define MXC_CCM_CSCDR1_UART_CLK_SEL_OFFSET		(6)
+#define MXC_CCM_CSCDR1_USBOH3_CLK_PODF_MASK		(0x3 << 6)
+#define MXC_CCM_CSCDR1_UART_CLK_PODF_MASK		(0x3F)
+#define MXC_CCM_CSCDR1_UART_CLK_PODF_OFFSET		(0)
+
+/* Define the bits in register CS1CDR */
+#define MXC_CCM_CS1CDR_ESAI_CLK_PODF_MASK		(0x7 << 25)
+#define MXC_CCM_CS1CDR_ESAI_CLK_PODF_OFFSET		(25)
+#define MXC_CCM_CS1CDR_SSI3_CLK_PRED_MASK		(0x7 << 22)
+#define MXC_CCM_CS1CDR_SSI3_CLK_PRED_OFFSET		(22)
+#define MXC_CCM_CS1CDR_SSI3_CLK_PODF_MASK		(0x3F << 16)
+#define MXC_CCM_CS1CDR_SSI3_CLK_PODF_OFFSET		(16)
+#define MXC_CCM_CS1CDR_ESAI_CLK_PRED_MASK		(0x7 << 9)
+#define MXC_CCM_CS1CDR_ESAI_CLK_PRED_OFFSET		(9)
+#define MXC_CCM_CS1CDR_SSI1_CLK_PRED_MASK		(0x7 << 6)
+#define MXC_CCM_CS1CDR_SSI1_CLK_PRED_OFFSET		(6)
+#define MXC_CCM_CS1CDR_SSI1_CLK_PODF_MASK		(0x3F)
+#define MXC_CCM_CS1CDR_SSI1_CLK_PODF_OFFSET		(0)
+
+/* Define the bits in register CS2CDR */
+#define MXC_CCM_CS2CDR_ENFC_CLK_PODF_MASK		(0x3F << 21)
+#define MXC_CCM_CS2CDR_ENFC_CLK_PODF_OFFSET		(21)
+#define MXC_CCM_CS2CDR_ENFC_CLK_PRED_MASK		(0x7 << 18)
+#define MXC_CCM_CS2CDR_ENFC_CLK_PRED_OFFSET		(18)
+#define MXC_CCM_CS2CDR_ENFC_CLK_SEL_MASK		(0x3 << 16)
+#define MXC_CCM_CS2CDR_ENFC_CLK_SEL_OFFSET		(16)
+#define MXC_CCM_CS2CDR_LDB_DI1_CLK_SEL_MASK		(0x7 << 12)
+#define MXC_CCM_CS2CDR_LDB_DI1_CLK_SEL_OFFSET		(12)
+#define MXC_CCM_CS2CDR_LDB_DI0_CLK_SEL_MASK		(0x7 << 9)
+#define MXC_CCM_CS2CDR_LDB_DI0_CLK_SEL_OFFSET		(9)
+#define MXC_CCM_CS2CDR_SSI2_CLK_PRED_MASK		(0x7 << 6)
+#define MXC_CCM_CS2CDR_SSI2_CLK_PRED_OFFSET		(6)
+#define MXC_CCM_CS2CDR_SSI2_CLK_PODF_MASK		(0x3F)
+#define MXC_CCM_CS2CDR_SSI2_CLK_PODF_OFFSET		(0)
+
+/* Define the bits in register CDCDR */
+#define MXC_CCM_CDCDR_HSI_TX_PODF_MASK			(0x7 << 29)
+#define MXC_CCM_CDCDR_HSI_TX_PODF_OFFSET		(29)
+#define MXC_CCM_CDCDR_HSI_TX_CLK_SEL			(1 << 28)
+#define MXC_CCM_CDCDR_SPDIF0_CLK_PRED_MASK		(0x7 << 25)
+#define MXC_CCM_CDCDR_SPDIF0_CLK_PRED_OFFSET		(25)
+#define MXC_CCM_CDCDR_SPDIF0_CLK_PODF_MASK		(0x7 << 22)
+#define MXC_CCM_CDCDR_SPDIF0_CLK_PODF_OFFSET		(22)
+#define MXC_CCM_CDCDR_SPDIF0_CLK_SEL_MASK		(0x3 << 20)
+#define MXC_CCM_CDCDR_SPDIF0_CLK_SEL_OFFSET		(20)
+#define MXC_CCM_CDCDR_SPDIF1_CLK_PRED_MASK		(0x7 << 12)
+#define MXC_CCM_CDCDR_SPDIF1_CLK_PRED_OFFSET		(12)
+#define MXC_CCM_CDCDR_SPDIF1_CLK_PODF_MASK		(0x7 << 9)
+#define MXC_CCM_CDCDR_SPDIF1_CLK_PODF_OFFSET		(9)
+#define MXC_CCM_CDCDR_SPDIF1_CLK_SEL_MASK		(0x3 << 7)
+#define MXC_CCM_CDCDR_SPDIF1_CLK_SEL_OFFSET		(7)
+
+/* Define the bits in register CHSCCDR */
+#define MXC_CCM_CHSCCDR_IPU1_DI1_PRE_CLK_SEL_MASK	(0x7 << 15)
+#define MXC_CCM_CHSCCDR_IPU1_DI1_PRE_CLK_SEL_OFFSET	(15)
+#define MXC_CCM_CHSCCDR_IPU1_DI1_PODF_MASK		(0x7 << 12)
+#define MXC_CCM_CHSCCDR_IPU1_DI1_PODF_OFFSET		(12)
+#define MXC_CCM_CHSCCDR_IPU1_DI1_CLK_SEL_MASK		(0x7 << 9)
+#define MXC_CCM_CHSCCDR_IPU1_DI1_CLK_SEL_OFFSET		(9)
+#define MXC_CCM_CHSCCDR_IPU1_DI0_PRE_CLK_SEL_MASK	(0x7 << 6)
+#define MXC_CCM_CHSCCDR_IPU1_DI0_PRE_CLK_SEL_OFFSET	(6)
+#define MXC_CCM_CHSCCDR_IPU1_DI0_PODF_MASK		(0x7 << 3)
+#define MXC_CCM_CHSCCDR_IPU1_DI0_PODF_OFFSET		(3)
+#define MXC_CCM_CHSCCDR_IPU1_DI0_CLK_SEL_MASK		(0x7)
+#define MXC_CCM_CHSCCDR_IPU1_DI0_CLK_SEL_OFFSET		(0)
+
+/* Define the bits in register CSCDR2 */
+#define MXC_CCM_CSCDR2_ECSPI_CLK_PODF_MASK		(0x3F << 19)
+#define MXC_CCM_CSCDR2_ECSPI_CLK_PODF_OFFSET		(19)
+#define MXC_CCM_CSCDR2_ECSPI_CLK_SEL_MASK		(0x1 << 18)
+#define MXC_CCM_CSCDR2_ECSPI_CLK_SEL_OFFSET		(18)
+#define MXC_CCM_CSCDR2_IPU2_DI1_PRE_CLK_SEL_MASK	(0x7 << 15)
+#define MXC_CCM_CSCDR2_IPU2_DI1_PRE_CLK_SEL_OFFSET	(15)
+#define MXC_CCM_CSCDR2_IPU2_DI1_PODF_MASK		(0x7 << 12)
+#define MXC_CCM_CSCDR2_IPU2_DI1_PODF_OFFSET		(12)
+#define MXC_CCM_CSCDR2_IPU2_DI1_CLK_SEL_MASK		(0x7 << 9)
+#define MXC_CCM_CSCDR2_IPU2_DI1_CLK_SEL_OFFSET		(9)
+#define MXC_CCM_CSCDR2_IPU2_DI0_PRE_CLK_SEL_MASK	(0x7 << 6)
+#define MXC_CCM_CSCDR2_IPU2_DI0_PRE_CLK_SEL_OFFSET	(6)
+#define MXC_CCM_CSCDR2_IPU2_DI0_PODF_MASK		(0x7 << 3)
+#define MXC_CCM_CSCDR2_IPU2_DI0_PODF_OFFSET		(3)
+#define MXC_CCM_CSCDR2_IPU2_DI0_CLK_SEL_MASK		(0x7)
+#define MXC_CCM_CSCDR2_IPU2_DI0_CLK_SEL_OFFSET		(0)
+
+/* Define the bits in register CSCDR3 */
+#define MXC_CCM_CSCDR3_IPU2_HSP_PODF_MASK		(0x7 << 16)
+#define MXC_CCM_CSCDR3_IPU2_HSP_PODF_OFFSET		(16)
+#define MXC_CCM_CSCDR3_IPU2_HSP_CLK_SEL_MASK		(0x3 << 14)
+#define MXC_CCM_CSCDR3_IPU2_HSP_CLK_SEL_OFFSET		(14)
+#define MXC_CCM_CSCDR3_IPU1_HSP_PODF_MASK		(0x7 << 11)
+#define MXC_CCM_CSCDR3_IPU1_HSP_PODF_OFFSET		(11)
+#define MXC_CCM_CSCDR3_IPU1_HSP_CLK_SEL_MASK		(0x3 << 9)
+#define MXC_CCM_CSCDR3_IPU1_HSP_CLK_SEL_OFFSET		(9)
+
+/* Define the bits in register CDHIPR */
+#define MXC_CCM_CDHIPR_ARM_PODF_BUSY			(1 << 16)
+#define MXC_CCM_CDHIPR_PERIPH_CLK_SEL_BUSY		(1 << 5)
+#define MXC_CCM_CDHIPR_MMDC_CH0_PODF_BUSY		(1 << 4)
+#define MXC_CCM_CDHIPR_PERIPH2_CLK_SEL_BUSY		(1 << 3)
+#define MXC_CCM_CDHIPR_MMDC_CH1_PODF_BUSY		(1 << 2)
+#define MXC_CCM_CDHIPR_AHB_PODF_BUSY			(1 << 1)
+#define MXC_CCM_CDHIPR_AXI_PODF_BUSY			(1)
+
+/* Define the bits in register CLPCR */
+#define MXC_CCM_CLPCR_MASK_L2CC_IDLE			(1 << 27)
+#define MXC_CCM_CLPCR_MASK_SCU_IDLE			(1 << 26)
+#define MXC_CCM_CLPCR_MASK_CORE3_WFI			(1 << 25)
+#define MXC_CCM_CLPCR_MASK_CORE2_WFI			(1 << 24)
+#define MXC_CCM_CLPCR_MASK_CORE1_WFI			(1 << 23)
+#define MXC_CCM_CLPCR_MASK_CORE0_WFI			(1 << 22)
+#define MXC_CCM_CLPCR_BYP_MMDC_CH1_LPM_HS		(1 << 21)
+#define MXC_CCM_CLPCR_BYP_MMDC_CH0_LPM_HS		(1 << 19)
+#define MXC_CCM_CLPCR_WB_CORE_AT_LPM			(1 << 17)
+#define MXC_CCM_CLPCR_WB_PER_AT_LPM			(1 << 16)
+#define MXC_CCM_CLPCR_COSC_PWRDOWN			(1 << 11)
+#define MXC_CCM_CLPCR_STBY_COUNT_MASK			(0x3 << 9)
+#define MXC_CCM_CLPCR_STBY_COUNT_OFFSET			(9)
+#define MXC_CCM_CLPCR_VSTBY				(1 << 8)
+#define MXC_CCM_CLPCR_DIS_REF_OSC			(1 << 7)
+#define MXC_CCM_CLPCR_SBYOS				(1 << 6)
+#define MXC_CCM_CLPCR_ARM_CLK_DIS_ON_LPM		(1 << 5)
+#define MXC_CCM_CLPCR_LPSR_CLK_SEL_MASK			(0x3 << 3)
+#define MXC_CCM_CLPCR_LPSR_CLK_SEL_OFFSET		(3)
+#define MXC_CCM_CLPCR_BYPASS_PMIC_VFUNC_READY		(1 << 2)
+#define MXC_CCM_CLPCR_LPM_MASK				(0x3)
+#define MXC_CCM_CLPCR_LPM_OFFSET			(0)
+
+/* Define the bits in register CISR */
+#define MXC_CCM_CISR_ARM_PODF_LOADED			(1 << 26)
+#define MXC_CCM_CISR_MMDC_CH0_PODF_LOADED		(1 << 23)
+#define MXC_CCM_CISR_PERIPH_CLK_SEL_LOADED		(1 << 22)
+#define MXC_CCM_CISR_MMDC_CH1_PODF_LOADED		(1 << 21)
+#define MXC_CCM_CISR_AHB_PODF_LOADED			(1 << 20)
+#define MXC_CCM_CISR_PERIPH2_CLK_SEL_LOADED		(1 << 19)
+#define MXC_CCM_CISR_AXI_PODF_LOADED			(1 << 17)
+#define MXC_CCM_CISR_COSC_READY				(1 << 6)
+#define MXC_CCM_CISR_LRF_PLL				(1)
+
+/* Define the bits in register CIMR */
+#define MXC_CCM_CIMR_MASK_ARM_PODF_LOADED		(1 << 26)
+#define MXC_CCM_CIMR_MASK_MMDC_CH0_PODF_LOADED		(1 << 23)
+#define MXC_CCM_CIMR_MASK_PERIPH_CLK_SEL_LOADED		(1 << 22)
+#define MXC_CCM_CIMR_MASK_MMDC_CH1_PODF_LOADED		(1 << 21)
+#define MXC_CCM_CIMR_MASK_AHB_PODF_LOADED		(1 << 20)
+#define MXC_CCM_CIMR_MASK_PERIPH2_CLK_SEL_LOADED	(1 << 22)
+#define MXC_CCM_CIMR_MASK_AXI_PODF_LOADED		(1 << 17)
+#define MXC_CCM_CIMR_MASK_COSC_READY			(1 << 6)
+#define MXC_CCM_CIMR_MASK_LRF_PLL			(1)
+
+/* Define the bits in register CCOSR */
+#define MXC_CCM_CCOSR_CKO2_EN_OFFSET		(24)
+#define MXC_CCM_CCOSR_CKO2_DIV_MASK		(0x7 << 21)
+#define MXC_CCM_CCOSR_CKO2_DIV_OFFSET		(21)
+#define MXC_CCM_CCOSR_CKO2_SEL_OFFSET		(16)
+#define MXC_CCM_CCOSR_CKO2_SEL_MASK		(0x1F << 16)
+#define MXC_CCM_CCOSR_CKOL_MIRROR_CKO2_MASK	(1 << 8)
+#define MXC_CCM_CCOSR_CKOL_EN_OFFSET		7
+#define MXC_CCM_CCOSR_CKOL_EN			(0x1 << 7)
+#define MXC_CCM_CCOSR_CKOL_DIV_MASK		(0x7 << 4)
+#define MXC_CCM_CCOSR_CKOL_DIV_OFFSET		(4)
+#define MXC_CCM_CCOSR_CKOL_SEL_MASK		(0xF)
+#define MXC_CCM_CCOSR_CKOL_SEL_OFFSET		(0)
+
+/* Define the bits in registers CGPR */
+#define MXC_CCM_CGPR_EFUSE_PROG_SUPPLY_GATE	(1 << 4)
+#define MXC_CCM_CGPR_MMDC_EXT_CLK_DIS		(1 << 2)
+#define MXC_CCM_CGPR_PMIC_DELAY_SCALER		(1)
+#define MXC_CCM_CGPR_MEM_IPG_STOP_MASK		(1 << 1)
+#define MXC_CCM_CGPR_WAIT_MODE_FIX			(1 << 17)
+
+/* Define the bits in registers CCGRx */
+#define MXC_CCM_CCGRx_CG_MASK			0x3
+#define MXC_CCM_CCGRx_MOD_OFF			0x0
+#define MXC_CCM_CCGRx_MOD_ON			0x3
+#define MXC_CCM_CCGRx_MOD_IDLE			0x1
+
+#define MXC_CCM_CCGRx_CG15_MASK			(0x3 << 30)
+#define MXC_CCM_CCGRx_CG14_MASK			(0x3 << 28)
+#define MXC_CCM_CCGRx_CG13_MASK			(0x3 << 26)
+#define MXC_CCM_CCGRx_CG12_MASK			(0x3 << 24)
+#define MXC_CCM_CCGRx_CG11_MASK			(0x3 << 22)
+#define MXC_CCM_CCGRx_CG10_MASK			(0x3 << 20)
+#define MXC_CCM_CCGRx_CG9_MASK			(0x3 << 18)
+#define MXC_CCM_CCGRx_CG8_MASK			(0x3 << 16)
+#define MXC_CCM_CCGRx_CG7_MASK			(0x3 << 14)
+#define MXC_CCM_CCGRx_CG5_MASK			(0x3 << 10)
+#define MXC_CCM_CCGRx_CG4_MASK			(0x3 << 8)
+#define MXC_CCM_CCGRx_CG3_MASK			(0x3 << 6)
+#define MXC_CCM_CCGRx_CG2_MASK			(0x3 << 4)
+#define MXC_CCM_CCGRx_CG1_MASK			(0x3 << 2)
+#define MXC_CCM_CCGRx_CG0_MASK			(0x3 << 0)
+
+#define MXC_CCM_CCGRx_CG15_OFFSET		30
+#define MXC_CCM_CCGRx_CG14_OFFSET		28
+#define MXC_CCM_CCGRx_CG13_OFFSET		26
+#define MXC_CCM_CCGRx_CG12_OFFSET		24
+#define MXC_CCM_CCGRx_CG11_OFFSET		22
+#define MXC_CCM_CCGRx_CG10_OFFSET		20
+#define MXC_CCM_CCGRx_CG9_OFFSET		18
+#define MXC_CCM_CCGRx_CG8_OFFSET		16
+#define MXC_CCM_CCGRx_CG7_OFFSET		14
+#define MXC_CCM_CCGRx_CG6_OFFSET		12
+#define MXC_CCM_CCGRx_CG5_OFFSET		10
+#define MXC_CCM_CCGRx_CG4_OFFSET		8
+#define MXC_CCM_CCGRx_CG3_OFFSET		6
+#define MXC_CCM_CCGRx_CG2_OFFSET		4
+#define MXC_CCM_CCGRx_CG1_OFFSET		2
+#define MXC_CCM_CCGRx_CG0_OFFSET		0
+
+#endif				/* __ARCH_ARM_MACH_MX6_CRM_REGS_H__ */
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 04a02ba..7db6b4d 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -38,6 +38,7 @@
 #include "common.h"
 #include "cpuidle.h"
 #include "hardware.h"
+#include "pcie.h"
 
 #define IMX6Q_ANALOG_DIGPROG	0x260
 
@@ -190,6 +191,139 @@ static void __init imx6q_usb_init(void)
 	}
 }
 
+#define SBC6X_PCIE_PWR                  IMX_GPIO_NR(1, 3)
+#define SBC6X_PCIE_RST                  IMX_GPIO_NR(1, 8)
+
+#include "pcie.h"
+struct imx_pcie_data {
+        int id;
+        resource_size_t iobase;
+        resource_size_t iosize;
+	resource_size_t irq;
+};
+
+struct platform_device *__init imx_add_pcie(
+	const struct imx_pcie_data *data,
+	const struct imx_pcie_platform_data *pdata);
+
+static const struct imx_pcie_platform_data mx6_sbc6x_pcie_data __initconst = {
+        .pcie_pwr_en    =  SBC6X_PCIE_PWR,
+        .pcie_rst       =  SBC6X_PCIE_RST,
+        .pcie_wake_up   = -EINVAL,
+        .pcie_dis       = -EINVAL,
+};
+
+#define imx_pcie_data_entry_single(soc, _id, _hwid, size)               \
+        {                                                               \
+	.id = _id,                                              \
+                .iobase = soc ## _PCIE ## _hwid ## _BASE_ADDR,  \
+                .iosize = size,                                         \
+                .irq    = soc ## _INT_PCIE ## _hwid,                    \
+			}
+
+#define imx_pcie_data_entry(soc, _id, _hwid, _size)                     \
+        [_id] = imx_pcie_data_entry_single(soc, _id, _hwid, _size)
+
+#ifdef CONFIG_SOC_IMX6Q
+#define MX6Q_PCIE_BASE_ADDR (PCIE_ARB_END_ADDR - SZ_16K + 1)
+#define MX6Q_INT_PCIE MXC_INT_PCIE_3
+const struct imx_pcie_data imx6q_pcie_data __initconst =
+	imx_pcie_data_entry_single(MX6Q, 0, , SZ_16K);
+#endif
+
+#define imx6q_add_pcie(pdata) imx_add_pcie(&imx6q_pcie_data, pdata)
+
+
+
+struct platform_device *imx_add_platform_device_dmamask(
+	const char *name, int id,
+	const struct resource *res, unsigned int num_resources,
+	const void *data, size_t size_data, u64 dmamask);
+
+struct platform_device *__init imx_add_platform_device_dmamask(
+		const char *name, int id,
+		const struct resource *res, unsigned int num_resources,
+		const void *data, size_t size_data, u64 dmamask)
+{
+	int ret = -ENOMEM;
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc(name, id);
+	if (!pdev)
+		goto err;
+
+	if (dmamask) {
+		/*
+		 * This memory isn't freed when the device is put,
+		 * I don't have a nice idea for that though.  Conceptually
+		 * dma_mask in struct device should not be a pointer.
+		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
+		 */
+		pdev->dev.dma_mask =
+			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
+		if (!pdev->dev.dma_mask)
+			/* ret is still -ENOMEM; */
+			goto err;
+
+		*pdev->dev.dma_mask = dmamask;
+		pdev->dev.coherent_dma_mask = dmamask;
+	}
+
+	if (res) {
+		ret = platform_device_add_resources(pdev, res, num_resources);
+		if (ret)
+			goto err;
+	}
+
+	if (data) {
+		ret = platform_device_add_data(pdev, data, size_data);
+		if (ret)
+			goto err;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+err:
+		if (dmamask)
+			kfree(pdev->dev.dma_mask);
+		platform_device_put(pdev);
+		return ERR_PTR(ret);
+	}
+
+	return pdev;
+}
+
+static inline struct platform_device *imx_add_platform_device(
+	const char *name, int id,
+	const struct resource *res, unsigned int num_resources,
+	const void *data, size_t size_data)
+{
+        return imx_add_platform_device_dmamask(
+		name, id, res, num_resources, data, size_data, 0);
+}
+
+struct platform_device *__init imx_add_pcie(
+	const struct imx_pcie_data *data,
+	const struct imx_pcie_platform_data *pdata)
+{
+        struct resource res[] = {
+                {
+                        .start = data->iobase,
+                        .end = data->iobase + data->iosize - 1,
+                        .flags = IORESOURCE_MEM,
+                }, {
+                        .start = data->irq,
+                        .end = data->irq,
+                        .flags = IORESOURCE_IRQ,
+                },
+        };
+
+        return imx_add_platform_device("imx-pcie", -1,
+				       res, ARRAY_SIZE(res),
+				       pdata, sizeof(*pdata));
+}
+
+
 static void __init imx6q_init_machine(void)
 {
 	if (of_machine_is_compatible("fsl,imx6q-sabrelite"))
@@ -200,6 +334,10 @@ static void __init imx6q_init_machine(void)
 	imx6q_pm_init();
 	imx6q_usb_init();
 	imx6q_1588_init();
+
+	printk("FIXME: initializing Pcie\n");
+        /* Add PCIe RC interface support */
+        imx6q_add_pcie(&mx6_sbc6x_pcie_data);
 }
 
 #define OCOTP_CFG3			0x440
diff --git a/arch/arm/mach-imx/pcie.c b/arch/arm/mach-imx/pcie.c
new file mode 100644
index 0000000..9d4f6a6
--- /dev/null
+++ b/arch/arm/mach-imx/pcie.c
@@ -0,0 +1,822 @@
+/*
+ * arch/arm/mach-mx6/pcie.c
+ *
+ * PCIe host controller driver for IMX6 SOCs
+ *
+ * Copyright (C) 2012 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * Bits taken from arch/arm/mach-dove/pcie.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+
+#include "pcie.h"
+
+#include <asm/sizes.h>
+
+#include "crm_regs.h"
+
+/* Register Definitions */
+#define PRT_LOG_R_BaseAddress 0x700
+
+/* Register DB_R0 */
+/* Debug Register 0 */
+#define DB_R0 (PRT_LOG_R_BaseAddress + 0x28)
+#define DB_R0_RegisterSize 32
+#define DB_R0_RegisterResetValue 0x0
+#define DB_R0_RegisterResetMask 0xFFFFFFFF
+/* End of Register Definition for DB_R0 */
+
+/* Register DB_R1 */
+/* Debug Register 1 */
+#define DB_R1 (PRT_LOG_R_BaseAddress + 0x2c)
+#define DB_R1_RegisterSize 32
+#define DB_R1_RegisterResetValue 0x0
+#define DB_R1_RegisterResetMask 0xFFFFFFFF
+/* End of Register Definition for DB_R1 */
+
+#define ATU_R_BaseAddress 0x900
+#define ATU_VIEWPORT_R (ATU_R_BaseAddress + 0x0)
+#define ATU_REGION_CTRL1_R (ATU_R_BaseAddress + 0x4)
+#define ATU_REGION_CTRL2_R (ATU_R_BaseAddress + 0x8)
+#define ATU_REGION_LOWBASE_R (ATU_R_BaseAddress + 0xC)
+#define ATU_REGION_UPBASE_R (ATU_R_BaseAddress + 0x10)
+#define ATU_REGION_LIMIT_ADDR_R (ATU_R_BaseAddress + 0x14)
+#define ATU_REGION_LOW_TRGT_ADDR_R (ATU_R_BaseAddress + 0x18)
+#define ATU_REGION_UP_TRGT_ADDR_R (ATU_R_BaseAddress + 0x1C)
+
+/* GPR1: iomuxc_gpr1_pcie_ref_clk_en(iomuxc_gpr1[16]) */
+#define iomuxc_gpr1_pcie_ref_clk_en		(1 << 16)
+/* GPR1: iomuxc_gpr1_test_powerdown(iomuxc_gpr1_18) */
+#define iomuxc_gpr1_test_powerdown		(1 << 18)
+
+/* GPR12: iomuxc_gpr12_los_level(iomuxc_gpr12[8:4]) */
+#define iomuxc_gpr12_los_level			(0x1F << 4)
+/* GPR12: iomuxc_gpr12_app_ltssm_enable(iomuxc_gpr12[10]) */
+#define iomuxc_gpr12_app_ltssm_enable		(1 << 10)
+/* GPR12: iomuxc_gpr12_device_type(iomuxc_gpr12[15:12]) */
+#define iomuxc_gpr12_device_type		(0xF << 12)
+
+/* GPR8: iomuxc_gpr8_tx_deemph_gen1(iomuxc_gpr8[5:0]) */
+#define iomuxc_gpr8_tx_deemph_gen1		(0x3F << 0)
+/* GPR8: iomuxc_gpr8_tx_deemph_gen2_3p5db(iomuxc_gpr8[11:6]) */
+#define iomuxc_gpr8_tx_deemph_gen2_3p5db	(0x3F << 6)
+/* GPR8: iomuxc_gpr8_tx_deemph_gen2_6db(iomuxc_gpr8[17:12]) */
+#define iomuxc_gpr8_tx_deemph_gen2_6db		(0x3F << 12)
+/* GPR8: iomuxc_gpr8_tx_swing_full(iomuxc_gpr8[24:18]) */
+#define iomuxc_gpr8_tx_swing_full		(0x7F << 18)
+/* GPR8: iomuxc_gpr8_tx_swing_low(iomuxc_gpr8[31:25]) */
+#define iomuxc_gpr8_tx_swing_low		(0x7F << 25)
+
+/* Registers of PHY */
+/* Register PHY_STS_R */
+/* PHY Status Register */
+#define PHY_STS_R (PRT_LOG_R_BaseAddress + 0x110)
+
+/* Register PHY_CTRL_R */
+/* PHY Control Register */
+#define PHY_CTRL_R (PRT_LOG_R_BaseAddress + 0x114)
+
+#define SSP_CR_SUP_DIG_MPLL_OVRD_IN_LO 0x0011
+/* FIELD: RES_ACK_IN_OVRD [15:15]
+// FIELD: RES_ACK_IN [14:14]
+// FIELD: RES_REQ_IN_OVRD [13:13]
+// FIELD: RES_REQ_IN [12:12]
+// FIELD: RTUNE_REQ_OVRD [11:11]
+// FIELD: RTUNE_REQ [10:10]
+// FIELD: MPLL_MULTIPLIER_OVRD [9:9]
+// FIELD: MPLL_MULTIPLIER [8:2]
+// FIELD: MPLL_EN_OVRD [1:1]
+// FIELD: MPLL_EN [0:0]
+*/
+
+#define SSP_CR_SUP_DIG_ATEOVRD 0x0010
+/* FIELD: ateovrd_en [2:2]
+// FIELD: ref_usb2_en [1:1]
+// FIELD: ref_clkdiv2 [0:0]
+*/
+
+#define SSP_CR_LANE0_DIG_RX_OVRD_IN_LO 0x1005
+/* FIELD: RX_LOS_EN_OVRD [13:13]
+// FIELD: RX_LOS_EN [12:12]
+// FIELD: RX_TERM_EN_OVRD [11:11]
+// FIELD: RX_TERM_EN [10:10]
+// FIELD: RX_BIT_SHIFT_OVRD [9:9]
+// FIELD: RX_BIT_SHIFT [8:8]
+// FIELD: RX_ALIGN_EN_OVRD [7:7]
+// FIELD: RX_ALIGN_EN [6:6]
+// FIELD: RX_DATA_EN_OVRD [5:5]
+// FIELD: RX_DATA_EN [4:4]
+// FIELD: RX_PLL_EN_OVRD [3:3]
+// FIELD: RX_PLL_EN [2:2]
+// FIELD: RX_INVERT_OVRD [1:1]
+// FIELD: RX_INVERT [0:0]
+*/
+
+#define SSP_CR_LANE0_DIG_RX_ASIC_OUT 0x100D
+/* FIELD: LOS [2:2]
+// FIELD: PLL_STATE [1:1]
+// FIELD: VALID [0:0]
+*/
+
+/* control bus bit definition */
+#define PCIE_CR_CTL_DATA_LOC 0
+#define PCIE_CR_CTL_CAP_ADR_LOC 16
+#define PCIE_CR_CTL_CAP_DAT_LOC 17
+#define PCIE_CR_CTL_WR_LOC 18
+#define PCIE_CR_CTL_RD_LOC 19
+#define PCIE_CR_STAT_DATA_LOC 0
+#define PCIE_CR_STAT_ACK_LOC 16
+
+#define PCIE_CAP_STRUC_BaseAddress 0x70
+
+/* Register LNK_CAP */
+/* PCIE Link cap */
+#define LNK_CAP (PCIE_CAP_STRUC_BaseAddress + 0xc)
+#define LNK_CAP_RegisterSize 32
+#define LNK_CAP_RegisterResetValue 0x011cc12
+#define LNK_CAP_RegisterResetMask 0xffffffff
+
+/* End of Register Definitions */
+
+#define PCIE_DBI_BASE_ADDR	(PCIE_ARB_END_ADDR - SZ_16K + 1)
+
+#define  PCIE_CONF_BUS(b)		(((b) & 0xFF) << 16)
+#define  PCIE_CONF_DEV(d)		(((d) & 0x1F) << 11)
+#define  PCIE_CONF_FUNC(f)		(((f) & 0x7) << 8)
+#define  PCIE_CONF_REG(r)		((r) & ~0x3)
+
+
+#define PERIPBASE_VIRT 0xF2000000
+#define MX6_IO_ADDRESS(x) (void __force __iomem *)((x) + PERIPBASE_VIRT)
+
+
+static void __iomem *base;
+static void __iomem *dbi_base;
+
+void *iomux_base;
+
+enum {
+	MemRdWr = 0,
+	MemRdLk = 1,
+	IORdWr = 2,
+	CfgRdWr0 = 4,
+	CfgRdWr1 = 5
+};
+
+struct imx_pcie_port {
+	u8			index;
+	u8			root_bus_nr;
+	void __iomem		*base;
+	void __iomem		*dbi_base;
+	spinlock_t		conf_lock;
+
+	char			io_space_name[16];
+	char			mem_space_name[16];
+
+	struct resource		res[2];
+};
+
+static struct imx_pcie_port imx_pcie_port[1];
+static int num_pcie_ports;
+
+static int pcie_phy_cr_read(int addr, int *data);
+static int pcie_phy_cr_write(int addr, int data);
+static void change_field(int *in, int start, int end, int val);
+
+/* IMX PCIE GPR configure routines */
+static inline void imx_pcie_clrset(u32 mask, u32 val, void __iomem *addr)
+{
+	printk("FIXME: Addr is %lx\n", addr);
+	writel(((readl(addr) & ~mask) | (val & mask)), addr);
+}
+
+static struct imx_pcie_port *bus_to_port(int bus)
+{
+	int i;
+
+	for (i = num_pcie_ports - 1; i >= 0; i--) {
+		int rbus = imx_pcie_port[i].root_bus_nr;
+		if (rbus != -1 && rbus == bus)
+			break;
+	}
+
+	return i >= 0 ? imx_pcie_port + i : NULL;
+}
+
+static int __init imx_pcie_setup(int nr, struct pci_sys_data *sys)
+{
+	struct imx_pcie_port *pp;
+
+	if (nr >= num_pcie_ports)
+		return 0;
+
+	pp = &imx_pcie_port[nr];
+	pp->root_bus_nr = sys->busnr;
+
+	/*
+	 * IORESOURCE_IO
+	 */
+	snprintf(pp->io_space_name, sizeof(pp->io_space_name),
+		 "PCIe %d I/O", pp->index);
+	pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
+	pp->res[0].name = pp->io_space_name;
+	if (pp->index == 0) {
+		pp->res[0].start = PCIE_ARB_BASE_ADDR;
+		pp->res[0].end = pp->res[0].start + SZ_1M - 1;
+	}
+	pp->res[0].flags = IORESOURCE_IO;
+	if (request_resource(&ioport_resource, &pp->res[0]))
+		panic("Request PCIe IO resource failed\n");
+// FIXME
+//	sys->resource[0] = &pp->res[0];
+
+	/*
+	 * IORESOURCE_MEM
+	 */
+	snprintf(pp->mem_space_name, sizeof(pp->mem_space_name),
+			"PCIe %d MEM", pp->index);
+	pp->mem_space_name[sizeof(pp->mem_space_name) - 1] = 0;
+	pp->res[1].name = pp->mem_space_name;
+	if (pp->index == 0) {
+		pp->res[1].start = PCIE_ARB_BASE_ADDR + SZ_1M;
+		pp->res[1].end = pp->res[1].start + SZ_16M - SZ_2M - 1;
+	}
+	pp->res[1].flags = IORESOURCE_MEM;
+	if (request_resource(&iomem_resource, &pp->res[1]))
+		panic("Request PCIe Memory resource failed\n");
+//	sys->resource[1] = &pp->res[1];
+
+//	sys->resource[2] = NULL;
+
+	return 1;
+}
+
+static int imx_pcie_link_up(void __iomem *dbi_base)
+{
+	/* Check the pcie link up or link down */
+	int iterations = 200;
+	u32 rc, ltssm, rx_valid, temp;
+
+	do {
+		/* link is debug bit 36 debug 1 start in bit 32 */
+		rc = readl(dbi_base + DB_R1) & (0x1 << (36 - 32)) ;
+		iterations--;
+		usleep_range(2000, 3000);
+
+		/* From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
+		 * Wait 2ms (LTSSM timeout is 24ms, PHY lock is ~5us in gen2).
+		 * If (MAC/LTSSM.state == Recovery.RcvrLock)
+		 * && (PHY/rx_valid==0) then pulse PHY/rx_reset. Transition
+		 * to gen2 is stuck
+		 */
+		pcie_phy_cr_read(SSP_CR_LANE0_DIG_RX_ASIC_OUT, &rx_valid);
+		ltssm = readl(dbi_base + DB_R0) & 0x3F;
+		if ((ltssm == 0x0D) && ((rx_valid & 0x01) == 0)) {
+			pr_info("Transition to gen2 is stuck, reset PHY!\n");
+			pcie_phy_cr_read(SSP_CR_LANE0_DIG_RX_OVRD_IN_LO, &temp);
+			change_field(&temp, 3, 3, 0x1);
+			change_field(&temp, 5, 5, 0x1);
+			pcie_phy_cr_write(SSP_CR_LANE0_DIG_RX_OVRD_IN_LO,
+					0x0028);
+			usleep_range(2000, 3000);
+			pcie_phy_cr_read(SSP_CR_LANE0_DIG_RX_OVRD_IN_LO, &temp);
+			change_field(&temp, 3, 3, 0x0);
+			change_field(&temp, 5, 5, 0x0);
+			pcie_phy_cr_write(SSP_CR_LANE0_DIG_RX_OVRD_IN_LO,
+					0x0000);
+		}
+
+		if ((iterations < 0))
+			pr_info("link up failed, DB_R0:0x%08x, DB_R1:0x%08x!\n"
+					, readl(dbi_base + DB_R0)
+					, readl(dbi_base + DB_R1));
+	} while (!rc && iterations);
+
+	if (!rc)
+		return 0;
+	return 1;
+}
+
+static void imx_pcie_regions_setup(void __iomem *dbi_base)
+{
+	/*
+	 * i.MX6 defines 16MB in the AXI address map for PCIe.
+	 *
+	 * That address space excepted the pcie registers is
+	 * split and defined into different regions by iATU,
+	 * with sizes and offsets as follows:
+	 *
+	 * 0x0100_0000 --- 0x010F_FFFF 1MB IORESOURCE_IO
+	 * 0x0110_0000 --- 0x01EF_FFFF 14MB IORESOURCE_MEM
+	 * 0x01F0_0000 --- 0x01FF_FFFF 1MB Cfg + Registers
+	 */
+
+	/* CMD reg:I/O space, MEM space, and Bus Master Enable */
+	writel(readl(dbi_base + PCI_COMMAND)
+			| PCI_COMMAND_IO
+			| PCI_COMMAND_MEMORY
+			| PCI_COMMAND_MASTER,
+			dbi_base + PCI_COMMAND);
+
+	/* Set the CLASS_REV of RC CFG header to PCI_CLASS_BRIDGE_PCI */
+	writel(readl(dbi_base + PCI_CLASS_REVISION)
+			| (PCI_CLASS_BRIDGE_PCI << 16),
+			dbi_base + PCI_CLASS_REVISION);
+
+	/*
+	 * region0 outbound used to access target cfg
+	 */
+	writel(0, dbi_base + ATU_VIEWPORT_R);
+	writel(PCIE_ARB_END_ADDR - SZ_1M + 1, dbi_base + ATU_REGION_LOWBASE_R);
+	writel(PCIE_ARB_END_ADDR, dbi_base + ATU_REGION_LIMIT_ADDR_R);
+	writel(0, dbi_base + ATU_REGION_UPBASE_R);
+
+	writel(0, dbi_base + ATU_REGION_LOW_TRGT_ADDR_R);
+	writel(0, dbi_base + ATU_REGION_UP_TRGT_ADDR_R);
+	writel(CfgRdWr0, dbi_base + ATU_REGION_CTRL1_R);
+	writel((1<<31), dbi_base + ATU_REGION_CTRL2_R);
+}
+
+static int imx_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
+			int size, u32 *val)
+{
+	struct imx_pcie_port *pp = bus_to_port(bus->number);
+	u32 va_address;
+
+	if (pp) {
+		if (devfn != 0) {
+			*val = 0xffffffff;
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+
+		va_address = (u32)dbi_base + (where & ~0x3);
+	} else
+		va_address = (u32)base + (PCIE_CONF_BUS(bus->number - 1) +
+					  PCIE_CONF_DEV(PCI_SLOT(devfn)) +
+					  PCIE_CONF_FUNC(PCI_FUNC(devfn)) +
+					  PCIE_CONF_REG(where));
+
+	*val = readl(va_address);
+
+	if (size == 1)
+		*val = (*val >> (8 * (where & 3))) & 0xFF;
+	else if (size == 2)
+		*val = (*val >> (8 * (where & 3))) & 0xFFFF;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int imx_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
+			int where, int size, u32 val)
+{
+	struct imx_pcie_port *pp = bus_to_port(bus->number);
+	u32 va_address = 0, mask = 0, tmp = 0;
+	int ret = PCIBIOS_SUCCESSFUL;
+
+	if (pp) {
+		if (devfn != 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		va_address = (u32)dbi_base + (where & ~0x3);
+	} else
+		va_address = (u32)base + (PCIE_CONF_BUS(bus->number - 1) +
+					  PCIE_CONF_DEV(PCI_SLOT(devfn)) +
+					  PCIE_CONF_FUNC(PCI_FUNC(devfn)) +
+					  PCIE_CONF_REG(where));
+
+	if (size == 4) {
+		writel(val, va_address);
+		goto exit;
+	}
+
+	if (size == 2)
+		mask = ~(0xFFFF << ((where & 0x3) * 8));
+	else if (size == 1)
+		mask = ~(0xFF << ((where & 0x3) * 8));
+	else
+		ret = PCIBIOS_BAD_REGISTER_NUMBER;
+
+	tmp = readl(va_address) & mask;
+	tmp |= val << ((where & 0x3) * 8);
+	writel(tmp, va_address);
+exit:
+
+	return ret;
+}
+
+static struct pci_ops imx_pcie_ops = {
+	.read = imx_pcie_rd_conf,
+	.write = imx_pcie_wr_conf,
+};
+
+static struct pci_bus __init *
+imx_pcie_scan_bus(int nr, struct pci_sys_data *sys)
+{
+	struct pci_bus *bus;
+
+	if (nr < num_pcie_ports) {
+		bus = pci_scan_bus(sys->busnr, &imx_pcie_ops, sys);
+	} else {
+		bus = NULL;
+		BUG();
+	}
+
+	return bus;
+}
+
+static int __init imx_pcie_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return MXC_INT_PCIE_3;
+}
+
+static struct hw_pci imx_pci __initdata = {
+	.nr_controllers	= 1,
+	.swizzle	= pci_std_swizzle,
+	.setup		= imx_pcie_setup,
+	.scan		= imx_pcie_scan_bus,
+	.map_irq	= imx_pcie_map_irq,
+};
+
+/* PHY CR bus acess routines */
+static int pcie_phy_cr_ack_polling(int max_iterations, int exp_val)
+{
+	u32 temp_rd_data, wait_counter = 0;
+
+	do {
+		temp_rd_data = readl(dbi_base + PHY_STS_R);
+		temp_rd_data = (temp_rd_data >> PCIE_CR_STAT_ACK_LOC) & 0x1;
+		wait_counter++;
+	} while ((wait_counter < max_iterations) && (temp_rd_data != exp_val));
+
+	if (temp_rd_data != exp_val)
+		return 0 ;
+	return 1 ;
+}
+
+static int pcie_phy_cr_cap_addr(int addr)
+{
+	u32 temp_wr_data;
+
+	/* write addr */
+	temp_wr_data = addr << PCIE_CR_CTL_DATA_LOC ;
+	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
+
+	/* capture addr */
+	temp_wr_data |= (0x1 << PCIE_CR_CTL_CAP_ADR_LOC);
+	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
+
+	/* wait for ack */
+	if (!pcie_phy_cr_ack_polling(100, 1))
+		return 0;
+
+	/* deassert cap addr */
+	temp_wr_data = addr << PCIE_CR_CTL_DATA_LOC;
+	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
+
+	/* wait for ack de-assetion */
+	if (!pcie_phy_cr_ack_polling(100, 0))
+		return 0 ;
+
+	return 1 ;
+}
+
+static int pcie_phy_cr_read(int addr , int *data)
+{
+	u32 temp_rd_data, temp_wr_data;
+
+	/*  write addr */
+	/* cap addr */
+	if (!pcie_phy_cr_cap_addr(addr))
+		return 0;
+
+	/* assert rd signal */
+	temp_wr_data = 0x1 << PCIE_CR_CTL_RD_LOC;
+	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
+
+	/* wait for ack */
+	if (!pcie_phy_cr_ack_polling(100, 1))
+		return 0;
+
+	/* after got ack return data */
+	temp_rd_data = readl(dbi_base + PHY_STS_R);
+	*data = (temp_rd_data & (0xffff << PCIE_CR_STAT_DATA_LOC)) ;
+
+	/* deassert rd signal */
+	temp_wr_data = 0x0;
+	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
+
+	/* wait for ack de-assetion */
+	if (!pcie_phy_cr_ack_polling(100, 0))
+		return 0 ;
+
+	return 1 ;
+
+}
+
+static int pcie_phy_cr_write(int addr, int data)
+{
+	u32 temp_wr_data;
+
+	/* write addr */
+	/* cap addr */
+	if (!pcie_phy_cr_cap_addr(addr))
+		return 0 ;
+
+	temp_wr_data = data << PCIE_CR_CTL_DATA_LOC;
+	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
+
+	/* capture data */
+	temp_wr_data |= (0x1 << PCIE_CR_CTL_CAP_DAT_LOC);
+	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
+
+	/* wait for ack */
+	if (!pcie_phy_cr_ack_polling(100, 1))
+		return 0 ;
+
+	/* deassert cap data */
+	temp_wr_data = data << PCIE_CR_CTL_DATA_LOC;
+	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
+
+	/* wait for ack de-assetion */
+	if (!pcie_phy_cr_ack_polling(100, 0))
+		return 0;
+
+	/* assert wr signal */
+	temp_wr_data = 0x1 << PCIE_CR_CTL_WR_LOC;
+	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
+
+	/* wait for ack */
+	if (!pcie_phy_cr_ack_polling(100, 1))
+		return 0;
+
+	/* deassert wr signal */
+	temp_wr_data = data << PCIE_CR_CTL_DATA_LOC;
+	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
+
+	/* wait for ack de-assetion */
+	if (!pcie_phy_cr_ack_polling(100, 0))
+		return 0;
+
+	temp_wr_data = 0x0 ;
+	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
+
+	return 1 ;
+}
+
+static void change_field(int *in, int start, int end, int val)
+{
+	int mask;
+
+	mask = ((0xFFFFFFFF << start) ^ (0xFFFFFFFF << (end + 1))) & 0xFFFFFFFF;
+	*in = (*in & ~mask) | (val << start);
+}
+
+static void imx_pcie_enable_controller(struct device *dev)
+{
+	struct clk *pcie_clk;
+	struct imx_pcie_platform_data *pdata = dev->platform_data;
+
+	/* Enable PCIE power */
+	gpio_request(pdata->pcie_pwr_en, "PCIE POWER_EN");
+
+	/* activate PCIE_PWR_EN */
+	gpio_direction_output(pdata->pcie_pwr_en, 1);
+
+	imx_pcie_clrset(iomuxc_gpr1_test_powerdown, 0 << 18, IOMUXC_GPR1);
+
+/* FIXME */
+#define PCIE_CLK "pcie_ref"
+	/* enable the clks */
+	pcie_clk = clk_get(NULL, PCIE_CLK);
+	if (IS_ERR(pcie_clk)) {
+		pr_err("no pcie (?) clock.\n");
+	} else if (clk_enable(pcie_clk)) {
+		pr_err("can't enable pcie clock.\n");
+		clk_put(pcie_clk);
+	}
+
+	imx_pcie_clrset(iomuxc_gpr1_pcie_ref_clk_en, 1 << 16, IOMUXC_GPR1);
+}
+
+static void card_reset(struct device *dev)
+{
+	struct imx_pcie_platform_data *pdata = dev->platform_data;
+
+	/* PCIE RESET */
+	gpio_request(pdata->pcie_rst, "PCIE RESET");
+
+	/* activate PERST_B */
+	gpio_direction_output(pdata->pcie_rst, 0);
+
+	/* Add one reset to the pcie external device */
+	msleep(100);
+
+	/* deactive PERST_B */
+	gpio_direction_output(pdata->pcie_rst, 1);
+}
+
+static void __init add_pcie_port(void __iomem *base, void __iomem *dbi_base,
+		struct imx_pcie_platform_data *pdata)
+{
+	struct clk *pcie_clk;
+
+	if (imx_pcie_link_up(dbi_base)) {
+		struct imx_pcie_port *pp = &imx_pcie_port[num_pcie_ports++];
+
+		pr_info("IMX PCIe port: link up.\n");
+
+		pp->index = 0;
+		pp->root_bus_nr = -1;
+		pp->base = base;
+		pp->dbi_base = dbi_base;
+		spin_lock_init(&pp->conf_lock);
+		memset(pp->res, 0, sizeof(pp->res));
+	} else {
+		pr_info("IMX PCIe port: link down!\n");
+		/* Release the clocks, and disable the power */
+
+		pcie_clk = clk_get(NULL, PCIE_CLK);
+		if (IS_ERR(pcie_clk))
+			pr_err("no pcie clock.\n");
+
+		clk_disable(pcie_clk);
+		clk_put(pcie_clk);
+
+		imx_pcie_clrset(iomuxc_gpr1_pcie_ref_clk_en, 0 << 16,
+				IOMUXC_GPR1);
+
+		/* Disable PCIE power */
+		gpio_request(pdata->pcie_pwr_en, "PCIE POWER_EN");
+
+		/* activate PCIE_PWR_EN */
+		gpio_direction_output(pdata->pcie_pwr_en, 0);
+
+		imx_pcie_clrset(iomuxc_gpr1_test_powerdown, 1 << 18,
+				IOMUXC_GPR1);
+	}
+}
+
+static int imx_pcie_pltfm_probe(struct platform_device *pdev)
+{
+	struct resource *mem;
+	struct device *dev = &pdev->dev;
+	struct imx_pcie_platform_data *pdata = dev->platform_data;
+
+	printk("imx_pcie_pltfm_probe\n");
+
+	printk("FIXME: preparing for  Pcie\n");
+	{
+		iomux_base = ioremap(MX6Q_IOMUXC_BASE_ADDR, SZ_16K);
+		printk("FIXME: %lx, mapped at %lx\n", MX6Q_IOMUXC_BASE_ADDR, iomux_base);
+		printk("FIXME: sanity check %lx\n", phys_to_virt(MX6Q_IOMUXC_BASE_ADDR));
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(dev, "no mmio space\n");
+		return -EINVAL;
+	}
+
+	base = ioremap_nocache(PCIE_ARB_END_ADDR - SZ_1M + 1, SZ_1M - SZ_16K);
+	if (!base) {
+		pr_err("error with ioremap in function %s\n", __func__);
+		return -EIO;
+	}
+
+	dbi_base = devm_ioremap(dev, mem->start, resource_size(mem));
+	if (!dbi_base) {
+		dev_err(dev, "can't map %pR\n", mem);
+		return -ENOMEM;
+	}
+
+	printk("imx_pcie_pltfm_probe: clrsets\n");
+	/* FIXME the field name should be aligned to RM */
+	imx_pcie_clrset(iomuxc_gpr12_app_ltssm_enable, 0 << 10, IOMUXC_GPR12);
+
+	printk("imx_pcie_pltfm_probe: clrsets1\n");
+
+	/* configure constant input signal to the pcie ctrl and phy */
+	imx_pcie_clrset(iomuxc_gpr12_device_type, PCI_EXP_TYPE_ROOT_PORT << 12,
+			IOMUXC_GPR12);
+	imx_pcie_clrset(iomuxc_gpr12_los_level, 9 << 4, IOMUXC_GPR12);
+
+	printk("imx_pcie_pltfm_probe: clrsets2\n");
+	imx_pcie_clrset(iomuxc_gpr8_tx_deemph_gen1, 0 << 0, IOMUXC_GPR8);
+	imx_pcie_clrset(iomuxc_gpr8_tx_deemph_gen2_3p5db, 0 << 6, IOMUXC_GPR8);
+	imx_pcie_clrset(iomuxc_gpr8_tx_deemph_gen2_6db, 20 << 12, IOMUXC_GPR8);
+	imx_pcie_clrset(iomuxc_gpr8_tx_swing_full, 127 << 18, IOMUXC_GPR8);
+	imx_pcie_clrset(iomuxc_gpr8_tx_swing_low, 127 << 25, IOMUXC_GPR8);
+
+
+	printk("imx_pcie_pltfm_probe: controller\n");
+	/* Enable the pwr, clks and so on */
+	imx_pcie_enable_controller(dev);
+
+	/* togle the external card's reset */
+	card_reset(dev) ;
+
+	usleep_range(3000, 4000);
+	imx_pcie_regions_setup(dbi_base);
+	usleep_range(3000, 4000);
+
+	/* start link up */
+	imx_pcie_clrset(iomuxc_gpr12_app_ltssm_enable, 1 << 10, IOMUXC_GPR12);
+
+	/* add the pcie port */
+	add_pcie_port(base, dbi_base, pdata);
+
+
+	printk("imx_pcie_pltfm_probe: common init\n");
+
+	pci_common_init(&imx_pci);
+	return 0;
+}
+
+static int imx_pcie_pltfm_remove(struct platform_device *pdev)
+{
+	struct clk *pcie_clk;
+	struct device *dev = &pdev->dev;
+	struct imx_pcie_platform_data *pdata = dev->platform_data;
+	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	/* Release clocks, and disable power  */
+	pcie_clk = clk_get(NULL, PCIE_CLK);
+	if (IS_ERR(pcie_clk))
+		pr_err("no pcie clock.\n");
+
+	if (pcie_clk) {
+		clk_disable(pcie_clk);
+		clk_put(pcie_clk);
+	}
+
+	imx_pcie_clrset(iomuxc_gpr1_pcie_ref_clk_en, 0 << 16, IOMUXC_GPR1);
+
+	/* Disable PCIE power */
+	gpio_request(pdata->pcie_pwr_en, "PCIE POWER_EN");
+
+	/* activate PCIE_PWR_EN */
+	gpio_direction_output(pdata->pcie_pwr_en, 0);
+
+	imx_pcie_clrset(iomuxc_gpr1_test_powerdown, 1 << 18, IOMUXC_GPR1);
+
+	iounmap(base);
+	iounmap(dbi_base);
+	release_mem_region(iomem->start, resource_size(iomem));
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver imx_pcie_pltfm_driver = {
+	.driver = {
+		.name	= "imx-pcie",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= imx_pcie_pltfm_probe,
+	.remove		= imx_pcie_pltfm_remove,
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Driver init/exit                                                          *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __init imx_pcie_drv_init(void)
+{
+	return platform_driver_register(&imx_pcie_pltfm_driver);
+}
+
+static void __exit imx_pcie_drv_exit(void)
+{
+	platform_driver_unregister(&imx_pcie_pltfm_driver);
+}
+
+module_init(imx_pcie_drv_init);
+module_exit(imx_pcie_drv_exit);
+
+MODULE_DESCRIPTION("i.MX PCIE platform driver");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/mach-imx/pcie.h b/arch/arm/mach-imx/pcie.h
new file mode 100644
index 0000000..39efcae
--- /dev/null
+++ b/arch/arm/mach-imx/pcie.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2012 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef __ASM_ARCH_IMX_PCIE_H
+#define __ASM_ARCH_IMX_PCIE_H
+
+/**
+ * struct imx_pcie_platform_data - optional platform data for pcie on i.MX
+ *
+ * @pcie_pwr_en:	used for enable/disable pcie power (-EINVAL if unused)
+ * @pcie_rst:		used for reset pcie ep (-EINVAL if unused)
+ * @pcie_wake_up:	used for wake up (-EINVAL if unused)
+ * @pcie_dis:		used for disable pcie ep (-EINVAL if unused)
+ */
+
+struct imx_pcie_platform_data {
+	unsigned int pcie_pwr_en;
+	unsigned int pcie_rst;
+	unsigned int pcie_wake_up;
+	unsigned int pcie_dis;
+};
+
+/* FIXME: defines that may not belong here */
+#define PCIE_ARB_BASE_ADDR 0x01000000
+#define PCIE_ARB_END_ADDR 0x01FFFFFF
+#define MXC_INT_PCIE_3 155
+#define MX6Q_IOMUXC_BASE_ADDR (AIPS1_OFF_BASE_ADDR + 0x60000)
+#define AIPS1_ARB_BASE_ADDR 0x02000000
+#define ATZ1_BASE_ADDR AIPS1_ARB_BASE_ADDR
+#define AIPS1_OFF_BASE_ADDR (ATZ1_BASE_ADDR + 0x80000)
+
+#define pci_std_swizzle pci_common_swizzle
+
+#endif /* __ASM_ARCH_IMX_PCIE_H */

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
