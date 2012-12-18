From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Dec 2012 12:06:54 +0000
Subject: [RFC PATCH 1/5] ARM: remove useless guard in smp.c
In-Reply-To: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
References: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1355832418-31692-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we only provide an implementation of smp_timer_broadcast in
smp.c if GENERIC_CLOCKEVENTS_BROADCAST is selected. As
smp_timer_broadcast is only used in smp.c, smp.c depends on SMP, and
GENERIC_CLOCKEVENTS_BROADCAST is selected by SMP, this is unnecessary.

This patch removes the redundant guard.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/kernel/smp.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index fbc8b26..21954bc 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -473,14 +473,10 @@ static void ipi_timer(void)
 	evt->event_handler(evt);
 }
 
-#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 static void smp_timer_broadcast(const struct cpumask *mask)
 {
 	smp_cross_call(mask, IPI_TIMER);
 }
-#else
-#define smp_timer_broadcast	NULL
-#endif
 
 static void broadcast_timer_set_mode(enum clock_event_mode mode,
 	struct clock_event_device *evt)
-- 
1.7.0.4
