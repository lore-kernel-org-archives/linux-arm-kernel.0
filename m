From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:57:33 +0100
Subject: [PATCH v1 18/18] ARM: simplify percpu_timer_ack
In-Reply-To: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
References: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307113053-30209-19-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no provider of local_timer_ack anymore after the conversion
of msm to the percpu_timer interface. Remove the weak local_timer_ack
symbol and directly call percpu_timer_ack.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/percpu_timer.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/percpu_timer.c b/arch/arm/kernel/percpu_timer.c
index f442d3f..da796cb 100644
--- a/arch/arm/kernel/percpu_timer.c
+++ b/arch/arm/kernel/percpu_timer.c
@@ -56,10 +56,6 @@ void percpu_timer_register(struct local_timer_ops *ops)
  *
  * If a local timer interrupt has occurred, acknowledge and return 1.
  * Otherwise, return 0.
- *
- * This can be overloaded by platform code that doesn't provide its
- * timer in timer_fns way (msm at the moment). Once all platforms have
- * migrated, the weak alias can be removed.
  * If no ack() function has been registered, consider the acknowledgement
  * to be done.
  */
@@ -71,8 +67,6 @@ static int percpu_timer_ack(void)
 	return 1;
 }
 
-int local_timer_ack(void) __attribute__ ((weak, alias("percpu_timer_ack")));
-
 /*
  * Timer (local or broadcast) support
  */
@@ -82,7 +76,7 @@ irqreturn_t percpu_timer_handler(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
 
-	if (local_timer_ack()) {
+	if (percpu_timer_ack()) {
 		evt->event_handler(evt);
 		return IRQ_HANDLED;
 	}
-- 
1.7.0.4
