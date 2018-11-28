From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 17:30:07 +0800
Subject: [PATCH 09/15] clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC output
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
Message-ID: <20181128093013.24442-11-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the R40, in addition to a mux between the RTC's own RC oscillator and
an external 32768 Hz crystal, which are muxed inside the RTC module, the
CCU also has its own RC oscillator, which runs at around 2 MHz, and can
be muxed with the LOSC output from the RTC. This muxed output is called
"SYS 32K" in the module clock diagram, but otherwise referred to as the
LOSC throughout the CCU documentation.

The RC oscillator is not very accurate, even though it has an undocumented
calibration function. We really want a precise clock at 32768 Hz,
instead of something at around 32 KHz. This patch forces the SYS 32K
clock to use the RTC output as its parent, and doesn't bother
registering the internal oscillator nor a clock mux.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index 582ebd41d20d..a22d11aa38ba 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -1284,6 +1284,9 @@ static struct regmap_config sun8i_r40_ccu_regmap_config = {
 	.writeable_reg	= sun8i_r40_ccu_regmap_accessible_reg,
 };
 
+#define SUN8I_R40_SYS_32K_CLK_REG 0x310
+#define SUN8I_R40_SYS_32K_CLK_KEY (0x16AA << 16)
+
 static int sun8i_r40_ccu_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -1312,6 +1315,14 @@ static int sun8i_r40_ccu_probe(struct platform_device *pdev)
 	val &= ~GENMASK(25, 20);
 	writel(val, reg + SUN8I_R40_USB_CLK_REG);
 
+	/*
+	 * Force SYS 32k (otherwise known as LOSC throughout the CCU)
+	 * clock parent to LOSC output from RTC module instead of the
+	 * CCU's internal RC oscillator divided output.
+	 */
+	writel(SUN8I_R40_SYS_32K_CLK_KEY | BIT(8),
+	       reg + SUN8I_R40_SYS_32K_CLK_REG);
+
 	regmap = devm_regmap_init_mmio(&pdev->dev, reg,
 				       &sun8i_r40_ccu_regmap_config);
 	if (IS_ERR(regmap))
-- 
2.20.0.rc1
