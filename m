From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 22 Sep 2011 15:47:05 +0200
Subject: [PATCH 7/7] ARM: ux500: Reprogram timers upon resume
Message-ID: <1316699225-21459-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

On ux500 the MTU timer blocks are powered off during
suspend/resume, so these need some reinitialization when
coming back from suspend.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/timer.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index 36a82bf..08c55a5 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -53,6 +53,13 @@ static void __init ux500_timer_init(void)
 	clksrc_dbx500_prcmu_init();
 }
 
+static void ux500_timer_reset(void)
+{
+	nmdk_clkevt_reset();
+	nmdk_clksrc_reset();
+}
+
 struct sys_timer ux500_timer = {
 	.init		= ux500_timer_init,
+	.resume		= ux500_timer_reset,
 };
-- 
1.7.3.2
