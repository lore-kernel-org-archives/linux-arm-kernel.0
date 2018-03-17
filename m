From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 17 Mar 2018 17:28:47 +0800
Subject: [PATCH net-next 02/12] clk: sunxi-ng: r40: export a regmap to access
 the GMAC register
In-Reply-To: <20180317092857.4396-1-wens@csie.org>
References: <20180317092857.4396-1-wens@csie.org>
Message-ID: <20180317092857.4396-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>

There's a GMAC configuration register, which exists on A64/A83T/H3/H5 in
the syscon part, in the CCU of R40 SoC.

Export a regmap of the CCU.

Read access is not restricted to all registers, but only the GMAC
register is allowed to be written.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index c3aa839a453d..54c7a6106206 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -1251,9 +1251,35 @@ static struct ccu_mux_nb sun8i_r40_cpu_nb = {
 	.bypass_index	= 1, /* index of 24 MHz oscillator */
 };
 
+/*
+ * Add a regmap for the GMAC driver (dwmac-sun8i) to access the
+ * GMAC configuration register.
+ * Only this register is allowed to be written, in order to
+ * prevent overriding critical clock configuration.
+ */
+
+#define SUN8I_R40_GMAC_CFG_REG 0x164
+static bool sun8i_r40_ccu_regmap_writeable_reg(struct device *dev,
+					       unsigned int reg)
+{
+	if (reg == SUN8I_R40_GMAC_CFG_REG)
+		return true;
+	return false;
+}
+
+static struct regmap_config sun8i_r40_ccu_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= 0x320, /* PLL_LOCK_CTRL_REG */
+
+	.writeable_reg	= sun8i_r40_ccu_regmap_writeable_reg,
+};
+
 static int sun8i_r40_ccu_probe(struct platform_device *pdev)
 {
 	struct resource *res;
+	struct regmap *regmap;
 	void __iomem *reg;
 	u32 val;
 	int ret;
@@ -1278,6 +1304,11 @@ static int sun8i_r40_ccu_probe(struct platform_device *pdev)
 	val &= ~GENMASK(25, 20);
 	writel(val, reg + SUN8I_R40_USB_CLK_REG);
 
+	regmap = devm_regmap_init_mmio(&pdev->dev, reg,
+				       &sun8i_r40_ccu_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	ret = sunxi_ccu_probe(pdev->dev.of_node, reg, &sun8i_r40_ccu_desc);
 	if (ret)
 		return ret;
-- 
2.16.2
