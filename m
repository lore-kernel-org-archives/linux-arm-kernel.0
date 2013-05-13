From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 13 May 2013 12:26:07 -0700
Subject: [PATCHv6 03/11] ARM: smp: Remove duplicate dummy timer implementation
In-Reply-To: <1368473175-4841-1-git-send-email-sboyd@codeaurora.org>
References: <1368473175-4841-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1368473175-4841-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop ARM's version of the dummy timer now that we have a generic
implementation in drivers/clocksource.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/smp.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 47ab905..4dc883a 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -503,24 +503,6 @@ void tick_broadcast(const struct cpumask *mask)
 }
 #endif
 
-static void broadcast_timer_set_mode(enum clock_event_mode mode,
-	struct clock_event_device *evt)
-{
-}
-
-static void __cpuinit broadcast_timer_setup(struct clock_event_device *evt)
-{
-	evt->name	= "dummy_timer";
-	evt->features	= CLOCK_EVT_FEAT_ONESHOT |
-			  CLOCK_EVT_FEAT_PERIODIC |
-			  CLOCK_EVT_FEAT_DUMMY;
-	evt->rating	= 100;
-	evt->mult	= 1;
-	evt->set_mode	= broadcast_timer_set_mode;
-
-	clockevents_register_device(evt);
-}
-
 static struct local_timer_ops *lt_ops;
 
 #ifdef CONFIG_LOCAL_TIMERS
@@ -544,8 +526,8 @@ static void __cpuinit percpu_timer_setup(void)
 
 	evt->cpumask = cpumask_of(cpu);
 
-	if (!lt_ops || lt_ops->setup(evt))
-		broadcast_timer_setup(evt);
+	if (lt_ops)
+		lt_ops->setup(evt);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
