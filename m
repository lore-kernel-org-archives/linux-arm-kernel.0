From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Apr 2012 13:55:57 +0100
Subject: [PATCH v4 5/7] ARM: architected timers: add support for UP timer
In-Reply-To: <1335531359-32128-1-git-send-email-marc.zyngier@arm.com>
References: <1335531359-32128-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1335531359-32128-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_LOCAL_TIMERS is not defined, let the architected timer
driver register a single clock_event_device that is used as a
global timer.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/arch_timer.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index 1a34eee..154f0a1 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -246,6 +246,8 @@ static struct local_timer_ops arch_timer_ops __cpuinitdata = {
 	.stop	= arch_timer_stop,
 };
 
+static struct clock_event_device arch_timer_global_evt;
+
 static int __init arch_timer_common_register(void)
 {
 	int err;
@@ -280,6 +282,17 @@ static int __init arch_timer_common_register(void)
 	}
 
 	err = local_timer_register(&arch_timer_ops);
+	if (err) {
+		/*
+		 * We couldn't register as a local timer (could be
+		 * because we're on a UP platform, or because some
+		 * other local timer is already present...). Try as a
+		 * global timer instead.
+		 */
+		arch_timer_global_evt.cpumask = cpumask_of(0);
+		err = arch_timer_setup(&arch_timer_global_evt);
+	}
+
 	if (err)
 		goto out_free_irq;
 
-- 
1.7.7.1
