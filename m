From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 10 Nov 2014 08:31:49 +0100
Subject: [PATCH] ARM: at91: remove useless init_time for DT-only SoCs
Message-ID: <1415604709-24185-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commits bcf8c7e7703bb2bbde66bec26a81fed4be9cd1d4 and
4bf7753b8ab7c704ca864b1653367ea9cfe68a25 introduced compilation errors
("error: 'NR_IRQS_LEGACY' undeclared (first use in this function)") because
they remove the asm/irq.h inclusion while the init_time function needs it
for the NR_IRQS_LEGACY definition.

In the other hand, the point of these commits is to remove board file
support, and init_time is only needed when booting non-DT boards, we can
thus safely remove init_time functions.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Hi Olof,

You recently pulled some changes on Nicolas' at91-cleanup tag and two of
those commits (see above for commit hashes) are actually introducing
compilation errors.
This patch fixes those compilation errors.

Best Regards,

Boris

 arch/arm/mach-at91/at91sam9g45.c | 6 ------
 arch/arm/mach-at91/at91sam9rl.c  | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index dd03f65..2ad0db4 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -34,13 +34,7 @@ static void __init at91sam9g45_initialize(void)
 	at91_sysirq_mask_rtt(AT91SAM9G45_BASE_RTT);
 }
 
-static void __init at91sam9g45_init_time(void)
-{
-	at91sam926x_pit_init(NR_IRQS_LEGACY + AT91_ID_SYS);
-}
-
 AT91_SOC_START(at91sam9g45)
 	.map_io = at91sam9g45_map_io,
 	.init = at91sam9g45_initialize,
-	.init_time = at91sam9g45_init_time,
 AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 6ca7fc5..bd7e568 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -46,13 +46,7 @@ static void __init at91sam9rl_initialize(void)
 	at91_sysirq_mask_rtt(AT91SAM9RL_BASE_RTT);
 }
 
-static void __init at91sam9rl_init_time(void)
-{
-	at91sam926x_pit_init(NR_IRQS_LEGACY + AT91_ID_SYS);
-}
-
 AT91_SOC_START(at91sam9rl)
 	.map_io = at91sam9rl_map_io,
 	.init = at91sam9rl_initialize,
-	.init_time = at91sam9rl_init_time,
 AT91_SOC_END
-- 
1.9.1
