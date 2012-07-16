From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 16 Jul 2012 22:21:45 +0400
Subject: [PATCH 1/4] ARM: clps711x/p720t: Replace __initcall by .init_early
 call
Message-ID: <1342462908-18547-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we are trying to do to support multiple machines in a single kernel,
we need to eliminate the use of __initcall to be used for all machines.
Using .init_early call solves this problem.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/p720t.c |   34 +++++++++++++++-------------------
 1 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-clps711x/p720t.c b/arch/arm/mach-clps711x/p720t.c
index 42ee8f3..f266d90 100644
--- a/arch/arm/mach-clps711x/p720t.c
+++ b/arch/arm/mach-clps711x/p720t.c
@@ -86,17 +86,7 @@ static void __init p720t_map_io(void)
 	iotable_init(p720t_io_desc, ARRAY_SIZE(p720t_io_desc));
 }
 
-MACHINE_START(P720T, "ARM-Prospector720T")
-	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.atag_offset	= 0x100,
-	.fixup		= fixup_p720t,
-	.map_io		= p720t_map_io,
-	.init_irq	= clps711x_init_irq,
-	.timer		= &clps711x_timer,
-	.restart	= clps711x_restart,
-MACHINE_END
-
-static int p720t_hw_init(void)
+static void __init p720t_init_early(void)
 {
 	/*
 	 * Power down as much as possible in case we don't
@@ -111,13 +101,19 @@ static int p720t_hw_init(void)
 	PLD_CODEC = 0;
 	PLD_TCH   = 0;
 	PLD_SPI   = 0;
-#ifndef CONFIG_DEBUG_LL
-	PLD_COM2  = 0;
-	PLD_COM1  = 0;
-#endif
-
-	return 0;
+	if (!IS_ENABLED(CONFIG_DEBUG_LL)) {
+		PLD_COM2 = 0;
+		PLD_COM1 = 0;
+	}
 }
 
-__initcall(p720t_hw_init);
-
+MACHINE_START(P720T, "ARM-Prospector720T")
+	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
+	.atag_offset	= 0x100,
+	.fixup		= fixup_p720t,
+	.init_early	= p720t_init_early,
+	.map_io		= p720t_map_io,
+	.init_irq	= clps711x_init_irq,
+	.timer		= &clps711x_timer,
+	.restart	= clps711x_restart,
+MACHINE_END
-- 
1.7.3.4
