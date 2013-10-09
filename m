From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 9 Oct 2013 16:04:03 +0800
Subject: [PATCH] ARM: imx: reset core along with enable/disable operation
Message-ID: <1381305843-26478-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From hotplug stress test result, resetting core during enable/disable
operation can improve cpu hotplug stability.  So let's set
SRC reset bit in imx_enable_cpu() for the core when its enable bit is
accessed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/src.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 10a6b1a..4754373 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -91,6 +91,7 @@ void imx_enable_cpu(int cpu, bool enable)
 	spin_lock(&scr_lock);
 	val = readl_relaxed(src_base + SRC_SCR);
 	val = enable ? val | mask : val & ~mask;
+	val |= 1 << (BP_SRC_SCR_CORE1_RST + cpu - 1);
 	writel_relaxed(val, src_base + SRC_SCR);
 	spin_unlock(&scr_lock);
 }
-- 
1.7.9.5
