From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 23 Oct 2014 20:14:28 +0200
Subject: [PATCH 2/4] ARM: mvebu: Move SCU power up in a function
In-Reply-To: <1414088070-12510-1-git-send-email-gregory.clement@free-electrons.com>
References: <1414088070-12510-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1414088070-12510-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow reusing the same function in the secondary_startup
for the Cortex A9 SoC.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu_ll.S | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
index a945756cfb45..0505010474a9 100644
--- a/arch/arm/mach-mvebu/pmsu_ll.S
+++ b/arch/arm/mach-mvebu/pmsu_ll.S
@@ -12,6 +12,18 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
+
+ENTRY(power_up_scu)
+	mrc     p15, 4, r1, c15, c0	@ get SCU base address
+	orr	r1, r1, #0x8		@ SCU CPU Power Status Register
+	mrc	15, 0, r0, cr0, cr0, 5	@ get the CPU ID
+	and	r0, r0, #15
+	add	r1, r1, r0
+	mov	r0, #0x0
+	strb	r0, [r1]		@ switch SCU power state to Normal mode
+	ret	lr
+ENDPROC(power_up_scu)
+
 /*
  * This is the entry point through which CPUs exiting cpuidle deep
  * idle state are going.
@@ -27,13 +39,7 @@ ENTRY(armada_38x_cpu_resume)
 	/* do we need it for Armada 38x*/
 ARM_BE8(setend	be )			@ go BE8 if entered LE
 	bl	v7_invalidate_l1
-	mrc     p15, 4, r1, c15, c0	@ get SCU base address
-	orr	r1, r1, #0x8		@ SCU CPU Power Status Register
-	mrc	15, 0, r0, cr0, cr0, 5	@ get the CPU ID
-	and	r0, r0, #15
-	add	r1, r1, r0
-	mov	r0, #0x0
-	strb	r0, [r1]		@ switch SCU power state to Normal mode
+	bl	power_up_scu
 	b	cpu_resume
 ENDPROC(armada_38x_cpu_resume)
 
-- 
1.9.1
