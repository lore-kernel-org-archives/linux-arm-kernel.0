From: martink@posteo.de (Martin Kepplinger)
Date: Thu, 19 Feb 2015 13:08:09 +0100
Subject: [PATCH] arch: arm [mach-imx] use sign_extend32() for sign_extension
In-Reply-To: <1424347689-2636-1-git-send-email-martink@posteo.de>
References: <1424347689-2636-1-git-send-email-martink@posteo.de>
Message-ID: <1424347689-2636-2-git-send-email-martink@posteo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 arch/arm/mach-imx/clk-pllv2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv2.c b/arch/arm/mach-imx/clk-pllv2.c
index 20889d5..1bbd08c 100644
--- a/arch/arm/mach-imx/clk-pllv2.c
+++ b/arch/arm/mach-imx/clk-pllv2.c
@@ -5,6 +5,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/bitops.h>
 
 #include <asm/div64.h>
 
@@ -88,11 +89,10 @@ static unsigned long __clk_pllv2_recalc_rate(unsigned long parent_rate,
 	mfi = (mfi <= 5) ? 5 : mfi;
 	mfd = dp_mfd & MXC_PLL_DP_MFD_MASK;
 	mfn = mfn_abs = dp_mfn & MXC_PLL_DP_MFN_MASK;
-	/* Sign extend to 32-bits */
-	if (mfn >= 0x04000000) {
-		mfn |= 0xFC000000;
+
+	mfn = sign_extend32(mfn, 26);
+	if (mfn < 0)
 		mfn_abs = -mfn;
-	}
 
 	ref_clk = 2 * parent_rate;
 	if (dbl != 0)
-- 
2.1.4
