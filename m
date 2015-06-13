From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 13 Jun 2015 18:22:15 +0200
Subject: [PATCH 1/8] clk: rockchip: protect register macros against multipart
 values
In-Reply-To: <1434212542-17145-1-git-send-email-heiko@sntech.de>
References: <1434212542-17145-1-git-send-email-heiko@sntech.de>
Message-ID: <1434212542-17145-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macros calculate the correct offset from the id in the parameter.
If this parameter does not consist of a single number, the calculation
will return wrong registers in the best case or create unaligned accesses
in the worst case. So protect the calculations against such values.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 6b09267..92edb5f 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -31,22 +31,22 @@
 		((val) << (shift) | (mask) << ((shift) + 16))
 
 /* register positions shared by RK2928, RK3066 and RK3188 */
-#define RK2928_PLL_CON(x)		(x * 0x4)
+#define RK2928_PLL_CON(x)		((x) * 0x4)
 #define RK2928_MODE_CON		0x40
-#define RK2928_CLKSEL_CON(x)	(x * 0x4 + 0x44)
-#define RK2928_CLKGATE_CON(x)	(x * 0x4 + 0xd0)
+#define RK2928_CLKSEL_CON(x)	((x) * 0x4 + 0x44)
+#define RK2928_CLKGATE_CON(x)	((x) * 0x4 + 0xd0)
 #define RK2928_GLB_SRST_FST		0x100
 #define RK2928_GLB_SRST_SND		0x104
-#define RK2928_SOFTRST_CON(x)	(x * 0x4 + 0x110)
+#define RK2928_SOFTRST_CON(x)	((x) * 0x4 + 0x110)
 #define RK2928_MISC_CON		0x134
 
 #define RK3288_PLL_CON(x)		RK2928_PLL_CON(x)
 #define RK3288_MODE_CON			0x50
-#define RK3288_CLKSEL_CON(x)		(x * 0x4 + 0x60)
-#define RK3288_CLKGATE_CON(x)		(x * 0x4 + 0x160)
+#define RK3288_CLKSEL_CON(x)		((x) * 0x4 + 0x60)
+#define RK3288_CLKGATE_CON(x)		((x) * 0x4 + 0x160)
 #define RK3288_GLB_SRST_FST		0x1b0
 #define RK3288_GLB_SRST_SND		0x1b4
-#define RK3288_SOFTRST_CON(x)		(x * 0x4 + 0x1b8)
+#define RK3288_SOFTRST_CON(x)		((x) * 0x4 + 0x1b8)
 #define RK3288_MISC_CON			0x1e8
 #define RK3288_SDMMC_CON0		0x200
 #define RK3288_SDMMC_CON1		0x204
@@ -67,7 +67,7 @@ enum rockchip_pll_type {
 	.nr = _nr,				\
 	.nf = _nf,				\
 	.no = _no,				\
-	.bwadj = (_nf >> 1),			\
+	.bwadj = ((_nf) >> 1),			\
 }
 
 #define RK3066_PLL_RATE_BWADJ(_rate, _nr, _nf, _no, _bw)	\
-- 
2.1.4
