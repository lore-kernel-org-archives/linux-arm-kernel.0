From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Mar 2011 15:13:03 +0000
Subject: [RFC PATCHv2 20/20] ARM: simplify percpu_timer_ack
In-Reply-To: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1300201983-26124-21-git-send-email-marc.zyngier@arm.com>
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
index 85af863..6e1942b 100644
--- a/arch/arm/kernel/percpu_timer.c
+++ b/arch/arm/kernel/percpu_timer.c
@@ -60,24 +60,18 @@ void percpu_timer_register(struct local_timer_ops *ops)
  *
  * If a local timer interrupt has occurred, acknowledge and return 1.
  * Otherwise, return 0.
- *
- * This can be overloaded by platform code that doesn't provide its
- * timer in timer_fns way (msm at the moment). Once all platforms have
- * migrated, the weak alias can be removed.
  */
 static int percpu_timer_ack(void)
 {
 	return timer_ops->ack();
 }
 
-int local_timer_ack(void) __attribute__ ((weak, alias("percpu_timer_ack")));
-
 asmlinkage void __exception_irq_entry do_local_timer(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	int cpu = smp_processor_id();
 
-	if (local_timer_ack()) {
+	if (percpu_timer_ack()) {
 		__inc_irq_stat(cpu, local_timer_irqs);
 		percpu_timer_run();
 	}
-- 
1.7.0.4
