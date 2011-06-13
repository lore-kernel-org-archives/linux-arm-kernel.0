From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2011 18:17:12 +0100
Subject: [PATCH 07/14] ARM: suspend: move sa1100 to use proper suspend func
	arg0
In-Reply-To: <20110613171446.GF13643@n2100.arm.linux.org.uk>
References: <20110613171446.GF13643@n2100.arm.linux.org.uk>
Message-ID: <E1QWAlE-0002e7-HC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the previous commit, we introduced an official way to supply an
argument to the suspend function.  Convert the sa1100 suspend code
to use this method.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pxa/sleep.S |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/sleep.S b/arch/arm/mach-pxa/sleep.S
index 6f53688..613ddfa 100644
--- a/arch/arm/mach-pxa/sleep.S
+++ b/arch/arm/mach-pxa/sleep.S
@@ -59,7 +59,7 @@ ENTRY(pxa27x_cpu_suspend)
 	mra	r2, r3, acc0
 #endif
 	stmfd	sp!, {r2 - r12, lr}		@ save registers on stack
-	mov	r4, r0				@ save sleep mode
+	mov	r2, r0				@ save sleep mode
 	ldr	r3, =pxa_cpu_resume		@ resume function
 	bl	cpu_suspend
 
@@ -67,7 +67,7 @@ ENTRY(pxa27x_cpu_suspend)
 	@ (also workaround for sighting 28071)
 
 	@ prepare value for sleep mode
-	mov	r1, r4				@ sleep mode
+	mov	r1, r0				@ sleep mode
 
 	@ prepare pointer to physical address 0 (virtual mapping in generic.c)
 	mov	r2, #UNCACHED_PHYS_0
@@ -109,11 +109,11 @@ ENTRY(pxa27x_cpu_suspend)
 
 ENTRY(pxa25x_cpu_suspend)
 	stmfd	sp!, {r2 - r12, lr}		@ save registers on stack
-	mov	r4, r0				@ save sleep mode
+	mov	r2, r0				@ save sleep mode
 	ldr	r3, =pxa_cpu_resume		@ resume function
 	bl	cpu_suspend
 	@ prepare value for sleep mode
-	mov	r1, r4				@ sleep mode
+	mov	r1, r0				@ sleep mode
 
 	@ prepare pointer to physical address 0 (virtual mapping in generic.c)
 	mov	r2, #UNCACHED_PHYS_0
-- 
1.7.4.4
