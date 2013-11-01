From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 1 Nov 2013 17:02:23 +0800
Subject: [PATCH 1/3] ARM: imx: add sleep for pllv3 relock
In-Reply-To: <1383296545-18652-1-git-send-email-shawn.guo@linaro.org>
References: <1383296545-18652-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1383296545-18652-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pllv3 relock time varies in the range of 50us ~ 500us, depending on
the specific PLL type, e.g. 50us for ARM PLL and 450us for Audio/Video
PLL.  Let's add a usleep_range() call instead of doing busy wait during
relock.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-pllv3.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index f6640b6..c9ca191 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -12,6 +12,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
@@ -66,6 +67,7 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
 			break;
 		if (time_after(jiffies, timeout))
 			break;
+		usleep_range(50, 500);
 	} while (1);
 
 	if (readl_relaxed(pll->base) & BM_PLL_LOCK)
-- 
1.7.9.5
