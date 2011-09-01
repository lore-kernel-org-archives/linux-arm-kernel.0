From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 1 Sep 2011 11:41:33 +0200
Subject: [PATCH] mach-ux500: unlock I&D l2x0 caches before init
Message-ID: <1314870093-5758-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Apparently U8500 U-Boot versions may leave the l2x0 locked down
before executing the kernel. Make sure we unlock it before we
initialize the l2x0. This fixes a performance problem reported
by Jan Rinze.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: Adrian Bunk <adrian.bunk@movial.com>
Reported-by: Jan Rinze <janrinze@gmail.com>
Tested-by: Robert Marklund <robert.marklund@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cache-l2x0.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 9d09e4d..96ef556 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -70,3 +70,18 @@ static int ux500_l2x0_init(void)
 }
 
 early_initcall(ux500_l2x0_init);
+
+static int ux500_l2x0_unlock(void)
+{
+	/*
+	 * Unlock Data and Instruction Lock if locked. Ux500 U-Boot versions
+	 * apparently locks both caches before jumping to the kernel.
+	 */
+	if (readl_relaxed(l2x0_base + L2X0_LOCKDOWN_WAY_D) & 0xFF)
+		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D);
+
+	if (readl_relaxed(l2x0_base + L2X0_LOCKDOWN_WAY_I) & 0xFF)
+		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I);
+}
+
+arch_initcall(ux500_l2x0_unlock);
-- 
1.7.3.2
