From: robherring2@gmail.com (Rob Herring)
Date: Mon, 11 Mar 2013 21:26:37 -0500
Subject: [PATCH 3/3] ARM: arch_timer: use the 64-bit sched_clock setup
In-Reply-To: <1363055197-17296-1-git-send-email-robherring2@gmail.com>
References: <1363055197-17296-1-git-send-email-robherring2@gmail.com>
Message-ID: <1363055197-17296-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that the ARM sched_clock code can support using 64-bit counters, call
setup_sched_clock_64 instead.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/kernel/arch_timer.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index d957a51..d813ae6 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -22,11 +22,6 @@ static unsigned long arch_timer_read_counter_long(void)
 	return arch_timer_read_counter();
 }
 
-static u32 arch_timer_read_counter_u32(void)
-{
-	return arch_timer_read_counter();
-}
-
 static struct delay_timer arch_delay_timer;
 
 static void __init arch_timer_delay_timer_register(void)
@@ -55,7 +50,6 @@ int __init arch_timer_sched_clock_init(void)
 	if (arch_timer_get_rate() == 0)
 		return -ENXIO;
 
-	setup_sched_clock(arch_timer_read_counter_u32,
-			  32, arch_timer_get_rate());
+	setup_sched_clock_64(arch_timer_read_counter, arch_timer_get_rate());
 	return 0;
 }
-- 
1.7.10.4
