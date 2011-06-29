From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:26:36 +0100
Subject: [PATCH 23/23] ARM: entry: no need to reload the SPSR value from
	struct pt_regs
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbr2a-0002Gi-Fw@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SVC IRQ, prefetch and data abort handlers preserve the SPSR value
via r5 across the exception.  Rather than re-loading it from pt_regs,
use the preserved value instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 3fa90ae..047ed5d 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -195,10 +195,6 @@ __dabt_svc:
 	@
 	disable_irq_notrace
 
-	@
-	@ restore SPSR and restart the instruction
-	@
-	ldr	r5, [sp, #S_PSR]
 #ifdef CONFIG_TRACE_IRQFLAGS
 	tst	r5, #PSR_I_BIT
 	bleq	trace_hardirqs_on
@@ -223,7 +219,7 @@ __irq_svc:
 	tst	r0, #_TIF_NEED_RESCHED
 	blne	svc_preempt
 #endif
-	ldr	r5, [sp, #S_PSR]
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 	@ The parent context IRQs must have been enabled to get here in
 	@ the first place, so there's no point checking the PSR I bit.
@@ -308,10 +304,6 @@ __pabt_svc:
 	@
 	disable_irq_notrace
 
-	@
-	@ restore SPSR and restart the instruction
-	@
-	ldr	r5, [sp, #S_PSR]
 #ifdef CONFIG_TRACE_IRQFLAGS
 	tst	r5, #PSR_I_BIT
 	bleq	trace_hardirqs_on
-- 
1.7.4.4
