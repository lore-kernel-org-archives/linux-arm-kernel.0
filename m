From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 17 Mar 2010 08:52:38 -0700
Subject: [PATCH 1/6] davinci: timers: don't enable timer until clocksource is
	initialized
In-Reply-To: <1268841163-5868-1-git-send-email-khilman@deeprootsystems.com>
References: <1268841163-5868-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1268841163-5868-2-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On da830, when the same timer is used for clocksource and clockevent,
the timer can be started before the clockevent is
registered/initialzed.  This creates a window where a timer
interrupt might fire before the clockevent handler has been
setup and causes a crash.

This patch moves the actual enable/start of the timer after
the clockevent has ben registered.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/time.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 42d985b..9e0b106 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -253,8 +253,6 @@ static void __init timer_init(void)
 			irq = USING_COMPARE(t) ? dtip[i].cmp_irq : irq;
 			setup_irq(irq, &t->irqaction);
 		}
-
-		timer32_config(&timers[i]);
 	}
 }
 
@@ -331,6 +329,7 @@ static void __init davinci_timer_init(void)
 	unsigned int clocksource_id;
 	static char err[] __initdata = KERN_ERR
 		"%s: can't register clocksource!\n";
+	int i;
 
 	clockevent_id = soc_info->timer_info->clockevent_id;
 	clocksource_id = soc_info->timer_info->clocksource_id;
@@ -389,6 +388,9 @@ static void __init davinci_timer_init(void)
 
 	clockevent_davinci.cpumask = cpumask_of(0);
 	clockevents_register_device(&clockevent_davinci);
+
+	for (i=0; i< ARRAY_SIZE(timers); i++)
+		timer32_config(&timers[i]);
 }
 
 struct sys_timer davinci_timer = {
-- 
1.7.0.2
