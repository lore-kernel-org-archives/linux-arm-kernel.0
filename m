From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Wed, 7 Jul 2010 21:13:20 +0400
Subject: [PATCH RFC 2/4] ARM: kgdb: Disable preemption before re-enabling
	interrupts
In-Reply-To: <20100707171222.GA16448@oksana.dev.rtsoft.ru>
References: <20100707171222.GA16448@oksana.dev.rtsoft.ru>
Message-ID: <20100707171320.GB20015@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have to disable preemption before enabling local IRQs because
local_irq_enable() makes it possible for the kernel to reschedule,
so the kernel might hit a breakpoint causing itself to re-enter
KGDB and die.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/arm/kernel/kgdb.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
index 5c61100..6ece654 100644
--- a/arch/arm/kernel/kgdb.c
+++ b/arch/arm/kernel/kgdb.c
@@ -167,9 +167,17 @@ static void kgdb_call_nmi_hook(void *ignored)
 
 void kgdb_roundup_cpus(unsigned long flags)
 {
+	/*
+	 * We have to disable preemption before enabling local
+	 * IRQs because local_irq_enable() makes it possible for
+	 * the kernel to reschedule, so the kernel might hit a
+	 * breakpoint causing itself to re-enter KGDB and die.
+	 */
+	preempt_disable();
        local_irq_enable();
        smp_call_function(kgdb_call_nmi_hook, NULL, 0);
        local_irq_disable();
+	preempt_enable();
 }
 
 #ifdef CONFIG_SMP
-- 
1.7.0.5
