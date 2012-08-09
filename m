From: yuxu@marvell.com (Yu Xu)
Date: Thu,  9 Aug 2012 11:33:23 +0800
Subject: [PATCH] ARM: mmp: add USB3.0 PHY support
Message-ID: <1344483203-17446-1-git-send-email-yuxu@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB 3.0 PHY support.

Signed-off-by: Yu Xu <yuxu@marvell.com>
---
 arch/arm/mach-mmp/devices.c               |  227 +++++++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/regs-usb.h |   94 ++++++++++++
 2 files changed, 321 insertions(+)

diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index dd2d8b1..699522b 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -349,3 +349,230 @@ struct platform_device pxa168_device_u2ootg = {
 #endif /* CONFIG_USB_MV_OTG */
 
 #endif
+
+#ifdef CONFIG_USB_MV_U3D
+static u32 u3d_phy_read(u32 base, u32 reg)
+{
+	u32 addr, data;
+	addr = base;
+	data = base + 0x4;
+
+	writel_relaxed(reg, addr);
+	return readl_relaxed(data);
+}
+
+static void u3d_phy_set(u32 base, u32 reg, u32 value)
+{
+	u32 addr, data;
+	u32 tmp;
+	addr = base;
+	data = base + 0x4;
+
+	writel_relaxed(reg, addr);
+	tmp = readl_relaxed(data);
+	tmp |= value;
+	writel_relaxed(tmp, data);
+}
+
+static void u3d_phy_clear(u32 base, u32 reg, u32 value)
+{
+	u32 addr, data;
+	u32 tmp;
+	addr = base;
+	data = base + 0x4;
+
+	writel_relaxed(reg, addr);
+	tmp = readl_relaxed(data);
+	tmp &= ~value;
+	writel_relaxed(tmp, data);
+}
+
+static void u3d_phy_write(u32 base, u32 reg, u32 value)
+{
+	u32 addr, data;
+	addr = base;
+	data = base + 0x4;
+
+	writel_relaxed(reg, addr);
+	writel_relaxed(value, data);
+}
+
+static void u3d_phy_reg_print(u32 base, u32 reg)
+{
+	u32 data;
+	data = u3d_phy_read(base, reg);
+	pr_debug("phy reg 0x%x: phy data 0x%x\n", reg, data);
+}
+
+void pxa_u3d_phy_deinit(void __iomem *usb3phy)
+{
+	u32 base, val;
+
+	pr_debug("%s\n", __func__);
+
+	base = (unsigned int)usb3phy;
+
+	/* Power down Reference Analog current, bit 15
+	 * Power down PLL, bit 14
+	 * Power down Receiver, bit 13
+	 * Power down Transmitter, bit 12
+	 * of USB3_POWER_PLL_CONTROL register
+	 */
+	val = u3d_phy_read(base, USB3_POWER_PLL_CONTROL);
+	val &= ~(USB3_POWER_PLL_CONTROL_PU);
+	u3d_phy_write(base, USB3_POWER_PLL_CONTROL, val);
+}
+
+int pxa_u3d_phy_init(void __iomem *usb3phy)
+{
+	u32 count;
+	u32 base, val;
+
+	pr_debug("%s\n", __func__);
+
+	/* enable usb3 phy */
+	base = (unsigned int)usb3phy;
+
+	val = u3d_phy_read(base, USB3_POWER_PLL_CONTROL);
+	val &= ~(USB3_POWER_PLL_CONTROL_PU_MASK);
+	val |= 0xF << USB3_POWER_PLL_CONTROL_PU_SHIFT;
+	u3d_phy_write(base, USB3_POWER_PLL_CONTROL, val);
+	udelay(100);
+
+	u3d_phy_write(base, USB3_RESET_CONTROL, USB3_RESET_CONTROL_RESET_PIPE);
+	udelay(100);
+
+	u3d_phy_write(base, USB3_RESET_CONTROL,
+		USB3_RESET_CONTROL_RESET_PIPE | USB3_RESET_CONTROL_RESET_PHY);
+	udelay(100);
+
+	val = u3d_phy_read(base, USB3_POWER_PLL_CONTROL);
+	val &= ~(USB3_POWER_PLL_CONTROL_REF_FREF_SEL_MASK
+		| USB3_POWER_PLL_CONTROL_PHY_MODE_MASK);
+	val |=  (USB3_PLL_25MHZ << USB3_POWER_PLL_CONTROL_REF_FREF_SEL_SHIFT)
+		| (0x5 << USB3_POWER_PLL_CONTROL_PHY_MODE_SHIFT);
+	u3d_phy_write(base, USB3_POWER_PLL_CONTROL, val);
+	udelay(100);
+
+	u3d_phy_clear(base, USB3_KVCO_CALI_CONTROL,
+		USB3_KVCO_CALI_CONTROL_USE_MAX_PLL_RATE_MASK);
+	udelay(100);
+
+	val = u3d_phy_read(base, USB3_SQUELCH_FFE);
+	val &= ~(USB3_SQUELCH_FFE_FFE_CAP_SEL_MASK
+		| USB3_SQUELCH_FFE_FFE_RES_SEL_MASK
+		| USB3_SQUELCH_FFE_SQ_THRESH_IN_MASK);
+	val |= ((0xD << USB3_SQUELCH_FFE_FFE_CAP_SEL_SHIFT)
+		| (0x7 << USB3_SQUELCH_FFE_FFE_RES_SEL_SHIFT)
+		| (0x8 << USB3_SQUELCH_FFE_SQ_THRESH_IN_SHIFT));
+	u3d_phy_write(base, USB3_SQUELCH_FFE, val);
+	udelay(100);
+
+	val = u3d_phy_read(base, USB3_GEN1_SET0);
+	val &= ~USB3_GEN1_SET0_G1_TX_SLEW_CTRL_EN_MASK;
+	val |= 1 << USB3_GEN1_SET0_G1_TX_EMPH_EN_SHIFT;
+	u3d_phy_write(base, USB3_GEN1_SET0, val);
+	udelay(100);
+
+	val = u3d_phy_read(base, USB3_GEN2_SET0);
+	val &= ~(USB3_GEN2_SET0_G2_TX_AMP_MASK
+		| USB3_GEN2_SET0_G2_TX_EMPH_AMP_MASK
+		| USB3_GEN2_SET0_G2_TX_SLEW_CTRL_EN_MASK);
+	val |= ((0x14 << USB3_GEN2_SET0_G2_TX_AMP_SHIFT)
+		| (1 << USB3_GEN2_SET0_G2_TX_AMP_ADJ_SHIFT)
+		| (0xA << USB3_GEN2_SET0_G2_TX_EMPH_AMP_SHIFT)
+		| (1 << USB3_GEN2_SET0_G2_TX_EMPH_EN_SHIFT));
+	u3d_phy_write(base, USB3_GEN2_SET0, val);
+	udelay(100);
+
+	u3d_phy_read(base, USB3_TX_EMPPH);
+	val &= ~(USB3_TX_EMPPH_AMP_MASK
+		| USB3_TX_EMPPH_EN_MASK
+		| USB3_TX_EMPPH_AMP_FORCE_MASK
+		| USB3_TX_EMPPH_PAR1_MASK
+		| USB3_TX_EMPPH_PAR2_MASK);
+	val |= ((0xB << USB3_TX_EMPPH_AMP_SHIFT)
+		| (1 << USB3_TX_EMPPH_EN_SHIFT)
+		| (1 << USB3_TX_EMPPH_AMP_FORCE_SHIFT)
+		| (0x1C << USB3_TX_EMPPH_PAR1_SHIFT)
+		| (1 << USB3_TX_EMPPH_PAR2_SHIFT));
+
+	u3d_phy_write(base, USB3_TX_EMPPH, val);
+	udelay(100);
+
+	val = u3d_phy_read(base, USB3_GEN2_SET1);
+	val &= ~(USB3_GEN2_SET1_G2_RX_SELMUPI_MASK
+		| USB3_GEN2_SET1_G2_RX_SELMUPF_MASK
+		| USB3_GEN2_SET1_G2_RX_SELMUFI_MASK
+		| USB3_GEN2_SET1_G2_RX_SELMUFF_MASK);
+	val |= ((1 << USB3_GEN2_SET1_G2_RX_SELMUPI_SHIFT)
+		| (1 << USB3_GEN2_SET1_G2_RX_SELMUPF_SHIFT)
+		| (1 << USB3_GEN2_SET1_G2_RX_SELMUFI_SHIFT)
+		| (1 << USB3_GEN2_SET1_G2_RX_SELMUFF_SHIFT));
+	u3d_phy_write(base, USB3_GEN2_SET1, val);
+	udelay(100);
+
+	val = u3d_phy_read(base, USB3_DIGITAL_LOOPBACK_EN);
+	val &= ~USB3_DIGITAL_LOOPBACK_EN_SEL_BITS_MASK;
+	val |= 1 << USB3_DIGITAL_LOOPBACK_EN_SEL_BITS_SHIFT;
+	u3d_phy_write(base, USB3_DIGITAL_LOOPBACK_EN, val);
+	udelay(100);
+
+	val = u3d_phy_read(base, USB3_IMPEDANCE_TX_SSC);
+	val &= ~USB3_IMPEDANCE_TX_SSC_SSC_AMP_MASK;
+	val |= 0xC << USB3_IMPEDANCE_TX_SSC_SSC_AMP_SHIFT;
+	u3d_phy_write(base, USB3_IMPEDANCE_TX_SSC, val);
+	udelay(100);
+
+	val = u3d_phy_read(base, USB3_IMPEDANCE_CALI_CTRL);
+	val &= ~USB3_IMPEDANCE_CALI_CTRL_IMP_CAL_THR_MASK;
+	val |= 0x4 << USB3_IMPEDANCE_CALI_CTRL_IMP_CAL_THR_SHIFT;
+	u3d_phy_write(base, USB3_IMPEDANCE_CALI_CTRL, val);
+	udelay(100);
+
+	val = u3d_phy_read(base, USB3_PHY_ISOLATION_MODE);
+	val &= ~(USB3_PHY_ISOLATION_MODE_PHY_GEN_RX_MASK
+		| USB3_PHY_ISOLATION_MODE_PHY_GEN_TX_MASK
+		| USB3_PHY_ISOLATION_MODE_TX_DRV_IDLE_MASK);
+	val |= ((1 << USB3_PHY_ISOLATION_MODE_PHY_GEN_RX_SHIFT)
+		| (1 << USB3_PHY_ISOLATION_MODE_PHY_GEN_TX_SHIFT));
+	u3d_phy_write(base, USB3_PHY_ISOLATION_MODE, val);
+	udelay(100);
+
+	val = u3d_phy_read(base, USB3_TXDETRX);
+	val &= ~(USB3_TXDETRX_VTHSEL_MASK);
+	val |= 0x1 << USB3_TXDETRX_VTHSEL_SHIFT;
+	u3d_phy_write(base, USB3_TXDETRX, val);
+	udelay(100);
+
+	u3d_phy_reg_print(base, USB3_KVCO_CALI_CONTROL);
+
+	pr_debug("%s: start calibration", __func__);
+
+calstart:
+	/* Perform Manual Calibration */
+	u3d_phy_set(base, USB3_KVCO_CALI_CONTROL,
+		1 << USB3_KVCO_CALI_CONTROL_CAL_START_SHIFT);
+
+	mdelay(1);
+
+	count = 0;
+	while (1) {
+		val = u3d_phy_read(base, USB3_KVCO_CALI_CONTROL);
+		if (val & (1 << USB3_KVCO_CALI_CONTROL_CAL_DONE_SHIFT))
+			break;
+		else if (count > 50) {
+			pr_debug("calibration failure, retry...\n");
+			goto calstart;
+		}
+		count++;
+		mdelay(1);
+	}
+
+	/* active PIPE interface */
+	u3d_phy_write(base, USB3_PIPE_SM_CTRL,
+		1 << USB3_PIPE_SM_CTRL_PHY_INIT_DONE);
+
+	return 0;
+}
+#endif /* CONFIG_USB_MV_U3D */
diff --git a/arch/arm/mach-mmp/include/mach/regs-usb.h b/arch/arm/mach-mmp/include/mach/regs-usb.h
index b047bf4..5bac566 100644
--- a/arch/arm/mach-mmp/include/mach/regs-usb.h
+++ b/arch/arm/mach-mmp/include/mach/regs-usb.h
@@ -250,4 +250,98 @@
 #define	HSIC_USB_CLK_PHY		0x0
 #define HSIC_USB_CLK_PMU		0x1
 
+/* For USB3 PHY */
+#define USB3_POWER_PLL_CONTROL		0x1
+#define USB3_KVCO_CALI_CONTROL		0x2
+#define USB3_IMPEDANCE_CALI_CTRL	0x3
+#define USB3_IMPEDANCE_TX_SSC		0x4
+#define USB3_SQUELCH_FFE		0x6
+#define USB3_GEN1_SET0			0xD
+#define USB3_GEN2_SET0			0xF
+#define USB3_GEN2_SET1			0x10
+#define USB3_DIGITAL_LOOPBACK_EN	0x23
+#define USB3_PHY_ISOLATION_MODE		0x26
+#define USB3_TXDETRX			0x48
+#define USB3_TX_EMPPH			0x5E
+#define USB3_RESET_CONTROL		0x90
+#define USB3_PIPE_SM_CTRL		0x91
+
+#define USB3_RESET_CONTROL_RESET_PIPE			0x1
+#define USB3_RESET_CONTROL_RESET_PHY			0x2
+
+#define USB3_POWER_PLL_CONTROL_REF_FREF_SEL_MASK	(0x1F << 0)
+#define USB3_POWER_PLL_CONTROL_REF_FREF_SEL_SHIFT	0
+#define USB3_PLL_25MHZ					0x2
+#define USB3_PLL_26MHZ					0x5
+#define USB3_POWER_PLL_CONTROL_PHY_MODE_MASK		(0x7 << 5)
+#define USB3_POWER_PLL_CONTROL_PHY_MODE_SHIFT		5
+#define USB3_POWER_PLL_CONTROL_PU_MASK			(0xF << 12)
+#define USB3_POWER_PLL_CONTROL_PU_SHIFT			12
+#define USB3_POWER_PLL_CONTROL_PU			(0xF << 12)
+
+#define USB3_KVCO_CALI_CONTROL_USE_MAX_PLL_RATE_MASK	(0x1 << 12)
+#define USB3_KVCO_CALI_CONTROL_USE_MAX_PLL_RATE_SHIFT	12
+#define USB3_KVCO_CALI_CONTROL_CAL_DONE_SHIFT		14
+#define USB3_KVCO_CALI_CONTROL_CAL_START_SHIFT		15
+
+#define USB3_SQUELCH_FFE_FFE_CAP_SEL_MASK		0xF
+#define USB3_SQUELCH_FFE_FFE_CAP_SEL_SHIFT		0
+#define USB3_SQUELCH_FFE_FFE_RES_SEL_MASK		(0x7 << 4)
+#define USB3_SQUELCH_FFE_FFE_RES_SEL_SHIFT		4
+#define USB3_SQUELCH_FFE_SQ_THRESH_IN_MASK		(0x1F << 8)
+#define USB3_SQUELCH_FFE_SQ_THRESH_IN_SHIFT		8
+
+#define USB3_GEN1_SET0_G1_TX_SLEW_CTRL_EN_MASK		(0x1 << 15)
+#define USB3_GEN1_SET0_G1_TX_EMPH_EN_SHIFT		11
+
+#define USB3_GEN2_SET0_G2_TX_AMP_MASK			(0x1F << 1)
+#define USB3_GEN2_SET0_G2_TX_AMP_SHIFT			1
+#define USB3_GEN2_SET0_G2_TX_AMP_ADJ_SHIFT		6
+#define USB3_GEN2_SET0_G2_TX_EMPH_AMP_MASK		(0xF << 7)
+#define USB3_GEN2_SET0_G2_TX_EMPH_AMP_SHIFT		7
+#define USB3_GEN2_SET0_G2_TX_EMPH_EN_MASK		(0x1 << 11)
+#define USB3_GEN2_SET0_G2_TX_EMPH_EN_SHIFT		11
+#define USB3_GEN2_SET0_G2_TX_SLEW_CTRL_EN_MASK		(0x1 << 15)
+#define USB3_GEN2_SET0_G2_TX_SLEW_CTRL_EN_SHIFT		15
+
+#define USB3_GEN2_SET1_G2_RX_SELMUPI_MASK		(0x7 << 0)
+#define USB3_GEN2_SET1_G2_RX_SELMUPI_SHIFT		0
+#define USB3_GEN2_SET1_G2_RX_SELMUPF_MASK		(0x7 << 3)
+#define USB3_GEN2_SET1_G2_RX_SELMUPF_SHIFT		3
+#define USB3_GEN2_SET1_G2_RX_SELMUFI_MASK		(0x3 << 6)
+#define USB3_GEN2_SET1_G2_RX_SELMUFI_SHIFT		6
+#define USB3_GEN2_SET1_G2_RX_SELMUFF_MASK		(0x3 << 8)
+#define USB3_GEN2_SET1_G2_RX_SELMUFF_SHIFT		8
+
+#define USB3_DIGITAL_LOOPBACK_EN_SEL_BITS_MASK		(0x3 << 10)
+#define USB3_DIGITAL_LOOPBACK_EN_SEL_BITS_SHIFT		10
+
+#define USB3_IMPEDANCE_CALI_CTRL_IMP_CAL_THR_MASK	(0x7 << 12)
+#define USB3_IMPEDANCE_CALI_CTRL_IMP_CAL_THR_SHIFT	12
+
+#define USB3_IMPEDANCE_TX_SSC_SSC_AMP_MASK		(0x3F << 0)
+#define USB3_IMPEDANCE_TX_SSC_SSC_AMP_SHIFT		0
+
+#define USB3_PHY_ISOLATION_MODE_PHY_GEN_RX_MASK		0xF
+#define USB3_PHY_ISOLATION_MODE_PHY_GEN_RX_SHIFT	0
+#define USB3_PHY_ISOLATION_MODE_PHY_GEN_TX_MASK		(0xF << 4)
+#define USB3_PHY_ISOLATION_MODE_PHY_GEN_TX_SHIFT	4
+#define USB3_PHY_ISOLATION_MODE_TX_DRV_IDLE_MASK	(0x1 << 8)
+
+#define USB3_TXDETRX_VTHSEL_MASK			(0x3 << 4)
+#define USB3_TXDETRX_VTHSEL_SHIFT			4
+
+#define USB3_TX_EMPPH_AMP_MASK				(0xF << 0)
+#define USB3_TX_EMPPH_AMP_SHIFT				0
+#define USB3_TX_EMPPH_EN_MASK				(0x1 << 6)
+#define USB3_TX_EMPPH_EN_SHIFT				6
+#define USB3_TX_EMPPH_AMP_FORCE_MASK			(0x1 << 7)
+#define USB3_TX_EMPPH_AMP_FORCE_SHIFT			7
+#define USB3_TX_EMPPH_PAR1_MASK				(0x1F << 8)
+#define USB3_TX_EMPPH_PAR1_SHIFT			8
+#define USB3_TX_EMPPH_PAR2_MASK				(0x1 << 13)
+#define USB3_TX_EMPPH_PAR2_SHIFT			13
+
+#define USB3_PIPE_SM_CTRL_PHY_INIT_DONE			15
+
 #endif /* __ASM_ARCH_PXA_U2O_H */
-- 
1.7.9.5
