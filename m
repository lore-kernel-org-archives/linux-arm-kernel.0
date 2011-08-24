From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 24 Aug 2011 11:23:55 +0200
Subject: [PATCH 3/3] mach-ux500: unlock I&D l2x0 caches before init
Message-ID: <1314177835-19186-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Apparently U8500 U-Boot versions may leave the l2x0 locked down
before executing the kernel. Make sure we unlock it before we
initialize the l2x0.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cache-l2x0.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index aa2d77f..f5c31f1 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -59,6 +59,16 @@ static int ux500_l2x0_init(void)
 	else
 		ux500_unknown_soc();
 
+	/*
+	 * Unlock Data and Instruction Lock if locked. Ux500 U-Boot versions
+	 * apparently locks both caches before jumping to the kernel.
+	 */
+	if (readl_relaxed(l2x0_base + L2X0_LOCKDOWN_WAY_D) & 0xFF)
+		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D);
+
+	if (readl_relaxed(l2x0_base + L2X0_LOCKDOWN_WAY_I) & 0xFF)
+		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I);
+
 	/* 64KB way size, 8 way associativity, force WA */
 	l2x0_init(l2x0_base, 0x3e060000, 0xc0000fff);
 
-- 
1.7.3.2
