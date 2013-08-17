From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 17 Aug 2013 10:06:34 +0400
Subject: [PATCH v3] ARM: imx: pllv1: Fix PLL calculation for i.MX27
Message-ID: <1376719594-19419-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MFN bit 9 on i.MX27 has a different meaning than in other SOCs. This
is a just sign bit. This patch makes different calculation for i.MX27.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-pllv1.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
index c1eaee3..d21d14c 100644
--- a/arch/arm/mach-imx/clk-pllv1.c
+++ b/arch/arm/mach-imx/clk-pllv1.c
@@ -18,6 +18,11 @@
  *
  * PLL clock version 1, found on i.MX1/21/25/27/31/35
  */
+
+#define MFN_BITS	(10)
+#define MFN_SIGN	(BIT(MFN_BITS - 1))
+#define MFN_MASK	(MFN_SIGN - 1)
+
 struct clk_pllv1 {
 	struct clk_hw	hw;
 	void __iomem	*base;
@@ -25,6 +30,11 @@ struct clk_pllv1 {
 
 #define to_clk_pllv1(clk) (container_of(clk, struct clk_pllv1, clk))
 
+static inline bool mfn_is_negative(unsigned int mfn)
+{
+	return !cpu_is_mx1() && !cpu_is_mx21() && (mfn & MFN_SIGN);
+}
+
 static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
@@ -58,10 +68,15 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
 
 	/*
 	 * On all i.MXs except i.MX1 and i.MX21 mfn is a 10bit
-	 * 2's complements number
+	 * 2's complements number.
+	 * On i.MX27 the bit 9 is the sign bit.
 	 */
-	if (!cpu_is_mx1() && !cpu_is_mx21() && mfn >= 0x200)
-		mfn_abs = 0x400 - mfn;
+	if (mfn_is_negative(mfn)) {
+		if (cpu_is_mx27())
+			mfn_abs = mfn & MFN_MASK;
+		else
+			mfn_abs = BIT(MFN_BITS) - mfn;
+	}
 
 	rate = parent_rate * 2;
 	rate /= pd + 1;
@@ -70,7 +85,7 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
 
 	do_div(ll, mfd + 1);
 
-	if (!cpu_is_mx1() && !cpu_is_mx21() && mfn >= 0x200)
+	if (mfn_is_negative(mfn))
 		ll = -ll;
 
 	ll = (rate * mfi) + ll;
-- 
1.8.1.5
