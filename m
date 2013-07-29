From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 29 Jul 2013 19:37:23 +0400
Subject: [PATCH v2] ARM: imx: pllv1: Fix PLL calculation for i.MX27
Message-ID: <1375112243-1557-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MFN bit 9 on i.MX27 has a different meaning than in other SOCs. This
is a just sign bit. This patch makes different calculation for i.MX27.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-pllv1.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
index c1eaee3..a289ccd 100644
--- a/arch/arm/mach-imx/clk-pllv1.c
+++ b/arch/arm/mach-imx/clk-pllv1.c
@@ -25,6 +25,11 @@ struct clk_pllv1 {
 
 #define to_clk_pllv1(clk) (container_of(clk, struct clk_pllv1, clk))
 
+static inline bool allow_signed_mfn(void)
+{
+	return !cpu_is_mx1() && !cpu_is_mx21();
+}
+
 static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
@@ -59,9 +64,14 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
 	/*
 	 * On all i.MXs except i.MX1 and i.MX21 mfn is a 10bit
 	 * 2's complements number
+	 * On i.MX27 the bit 9 is the sign bit.
 	 */
-	if (!cpu_is_mx1() && !cpu_is_mx21() && mfn >= 0x200)
-		mfn_abs = 0x400 - mfn;
+	if (allow_signed_mfn() && (mfn & 0x200)) {
+		if (cpu_is_mx27())
+			mfn_abs = mfn & 0x1ff;
+		else
+			mfn_abs = 0x400 - mfn;
+	}
 
 	rate = parent_rate * 2;
 	rate /= pd + 1;
@@ -70,7 +80,7 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
 
 	do_div(ll, mfd + 1);
 
-	if (!cpu_is_mx1() && !cpu_is_mx21() && mfn >= 0x200)
+	if (allow_signed_mfn() && (mfn & 0x200))
 		ll = -ll;
 
 	ll = (rate * mfi) + ll;
-- 
1.8.1.5
