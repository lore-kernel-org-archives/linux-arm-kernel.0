From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  1 Apr 2017 15:02:25 +0200
Subject: [PATCH 2/2] clk: meson: mpll: use 64bit math in rate_from_params
In-Reply-To: <20170401130225.8811-1-martin.blumenstingl@googlemail.com>
References: <20170401130225.8811-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170401130225.8811-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Meson8b the MPLL parent clock (fixed_pll) has a rate of 2550MHz.
Multiplying this with SDM_DEN results in a value greater than 32bits.
This is not a problem on the 64bit Meson GX SoCs, but it may result in
undefined behavior on the older 32bit Meson8b SoC.

While rate_from_params was only introduced recently to make the math
reusable from _round_rate and _recalc_rate the original bug exists much
longer.

Fixes: 1c50da4f27 ("clk: meson: add mpll support")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-mpll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index 551aa2a5b291..4306ad833a4f 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -62,6 +62,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/math64.h>
 #include "clkc.h"
 
 #define SDM_DEN 16384
@@ -81,7 +82,7 @@ static unsigned long rate_from_params(unsigned long parent_rate,
 	if (divisor == 0)
 		return 0;
 	else
-		return (parent_rate * SDM_DEN) / divisor;
+		return mul_u64_u32_div(parent_rate, SDM_DEN, divisor);
 }
 
 static void params_from_rate(unsigned long requested_rate,
-- 
2.12.1
