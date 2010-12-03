From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:20:17 +0000
Subject: [PATCH 04/22] ARM: SMP: remove IRQ-disabling for smp_cross_call()
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POc77-0007rF-1w@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we've now removed the spinlock and bitmask, we have nothing left
which requires interrupts to be disabled when sending an IPI.  All
current IPI-sending implementations use the GIC, which also does not
require interrupts disabled when calling gic_raise_softirq().

Remove the now unnecessary IRQ disable.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 78d55c6..4878e51 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -383,16 +383,10 @@ void __init smp_prepare_boot_cpu(void)
 
 static void send_ipi_message(const struct cpumask *mask, enum ipi_msg_type msg)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
-
 	/*
 	 * Call the platform specific cross-CPU call function.
 	 */
 	smp_cross_call(mask, msg);
-
-	local_irq_restore(flags);
 }
 
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
-- 
1.6.2.5
