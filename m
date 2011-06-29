From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:20:14 +0100
Subject: [PATCH 04/23] ARM: entry: prefetch/data abort helpers: avoid
	corrupting r4
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1QbqwQ-0002Ew-6l@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace r4 with ip for calling abort helpers - ip is allowed to be
corrupted by called functions in the ABI, so it makes more sense to
use such a register.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index dbe9eb8..6855f6d 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -47,9 +47,9 @@
 	.macro	pabt_helper
 	mov	r0, r2			@ pass address of aborted instruction.
 #ifdef MULTI_PABORT
-	ldr	r4, .LCprocfns
+	ldr	ip, .LCprocfns
 	mov	lr, pc
-	ldr	pc, [r4, #PROCESSOR_PABT_FUNC]
+	ldr	pc, [ip, #PROCESSOR_PABT_FUNC]
 #else
 	bl	CPU_PABORT_HANDLER
 #endif
@@ -67,9 +67,9 @@
 	@ the fault status register in r1.  r9 must be preserved.
 	@
 #ifdef MULTI_DABORT
-	ldr	r4, .LCprocfns
+	ldr	ip, .LCprocfns
 	mov	lr, pc
-	ldr	pc, [r4, #PROCESSOR_DABT_FUNC]
+	ldr	pc, [ip, #PROCESSOR_DABT_FUNC]
 #else
 	bl	CPU_DABORT_HANDLER
 #endif
-- 
1.7.4.4
