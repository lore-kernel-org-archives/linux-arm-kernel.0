From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:22:15 +0100
Subject: [PATCH 10/23] ARM: entry: prefetch abort helper: pass aborted pc in
	r4 rather than r0
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1QbqyN-0002FM-0A@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This avoids unnecessary instructions for CPUs which implement the IFAR
(instruction fault address register).

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S |    2 +-
 arch/arm/mm/pabort-legacy.S  |    3 ++-
 arch/arm/mm/pabort-v6.S      |    3 ++-
 arch/arm/mm/pabort-v7.S      |    2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 353b639..ee425f7 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -45,7 +45,7 @@
 	.endm
 
 	.macro	pabt_helper
-	mov	r0, r4			@ pass address of aborted instruction.
+	@ PABORT handler takes fault address in r4
 #ifdef MULTI_PABORT
 	ldr	ip, .LCprocfns
 	mov	lr, pc
diff --git a/arch/arm/mm/pabort-legacy.S b/arch/arm/mm/pabort-legacy.S
index 87970eb..8a5d8aa 100644
--- a/arch/arm/mm/pabort-legacy.S
+++ b/arch/arm/mm/pabort-legacy.S
@@ -4,7 +4,7 @@
 /*
  * Function: legacy_pabort
  *
- * Params  : r0 = address of aborted instruction
+ * Params  : r4 = address of aborted instruction
  *
  * Returns : r0 = address of abort
  *	   : r1 = Simulated IFSR with section translation fault status
@@ -14,6 +14,7 @@
 
 	.align	5
 ENTRY(legacy_pabort)
+	mov	r0, r4
 	mov	r1, #5
 	mov	pc, lr
 ENDPROC(legacy_pabort)
diff --git a/arch/arm/mm/pabort-v6.S b/arch/arm/mm/pabort-v6.S
index 06e3d1e..eaac1cb 100644
--- a/arch/arm/mm/pabort-v6.S
+++ b/arch/arm/mm/pabort-v6.S
@@ -4,7 +4,7 @@
 /*
  * Function: v6_pabort
  *
- * Params  : r0 = address of aborted instruction
+ * Params  : r4 = address of aborted instruction
  *
  * Returns : r0 = address of abort
  *	   : r1 = IFSR
@@ -14,6 +14,7 @@
 
 	.align	5
 ENTRY(v6_pabort)
+	mov	r0, r4
 	mrc	p15, 0, r1, c5, c0, 1		@ get IFSR
 	mov	pc, lr
 ENDPROC(v6_pabort)
diff --git a/arch/arm/mm/pabort-v7.S b/arch/arm/mm/pabort-v7.S
index a8b3b30..b515e0b 100644
--- a/arch/arm/mm/pabort-v7.S
+++ b/arch/arm/mm/pabort-v7.S
@@ -4,7 +4,7 @@
 /*
  * Function: v6_pabort
  *
- * Params  : r0 = address of aborted instruction
+ * Params  : r4 = address of aborted instruction
  *
  * Returns : r0 = address of abort
  *	   : r1 = IFSR
-- 
1.7.4.4
