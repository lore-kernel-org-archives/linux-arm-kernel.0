From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:21:34 +0100
Subject: [PATCH 08/23] ARM: entry: no need to check parent IRQ mask in IRQ
	handler return
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbqxi-0002FC-KX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no point checking to see whether IRQs were masked in the parent
context when returning from IRQ handling - the fact that we're handling
an IRQ means that the parent context must have had IRQs unmasked.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 1e5f387..fd42e66 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -234,8 +234,9 @@ __irq_svc:
 #endif
 	ldr	r4, [sp, #S_PSR]		@ irqs are already disabled
 #ifdef CONFIG_TRACE_IRQFLAGS
-	tst	r4, #PSR_I_BIT
-	bleq	trace_hardirqs_on
+	@ The parent context IRQs must have been enabled to get here in
+	@ the first place, so there's no point checking the PSR I bit.
+	bl	trace_hardirqs_on
 #endif
 	svc_exit r4				@ return from exception
  UNWIND(.fnend		)
-- 
1.7.4.4
