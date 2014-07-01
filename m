From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  1 Jul 2014 17:23:06 +0200
Subject: [PATCH] ARM: mvebu: fix SMP boot for Armada 38x and Armada 375 Z1 in
 big endian
Message-ID: <1404228186-21203-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMP boot on Armada 38x and Armada 375 Z1 is currently broken in
big-endian configurations, and this commit fixes it for both
platforms.

For Armada 375 Z1, the problem was in the
armada_375_smp_cpu1_enable_code part of the code that gets copied to
the Crypto SRAM as a work-around for an issue of the Z1 stepping. This
piece of code was not switching the CPU core to big-endian, and not
endian-swapping the value read from the Resume Address register (the
value is stored little-endian). Due to the introduction of the
conditional 'rev r1, r1' instruction, the offset between the 'ldr r0,
[pc, #4]' instruction and the value it was looking is different
between LE and BE configurations. To solve this, we instead use one
'adr' instruction followed by one 'ldr'.

For Armada 38x, the problem was simply that the CPU core was not
switched to big endian in the secondary CPU startup function.

This change was tested in LE and BE configurations on Armada 385,
Armada 375 Z1 and Armada 375 A0.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Jason, since the support for SMP was integrated in 3.16, this patch
should go in the 3.16-rc cycle. Thanks!

 arch/arm/mach-mvebu/headsmp-a9.S | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/headsmp-a9.S b/arch/arm/mach-mvebu/headsmp-a9.S
index 5925366..da5bb29 100644
--- a/arch/arm/mach-mvebu/headsmp-a9.S
+++ b/arch/arm/mach-mvebu/headsmp-a9.S
@@ -15,6 +15,8 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
+#include <asm/assembler.h>
+
 	__CPUINIT
 #define CPU_RESUME_ADDR_REG 0xf10182d4
 
@@ -22,13 +24,18 @@
 .global armada_375_smp_cpu1_enable_code_end
 
 armada_375_smp_cpu1_enable_code_start:
-	ldr     r0, [pc, #4]
+ARM_BE8(setend	be)
+	adr     r0, 1f
+	ldr	r0, [r0]
 	ldr     r1, [r0]
+ARM_BE8(rev	r1, r1)
 	mov     pc, r1
+1:
 	.word   CPU_RESUME_ADDR_REG
 armada_375_smp_cpu1_enable_code_end:
 
 ENTRY(mvebu_cortex_a9_secondary_startup)
+ARM_BE8(setend	be)
 	bl      v7_invalidate_l1
 	b	secondary_startup
 ENDPROC(mvebu_cortex_a9_secondary_startup)
-- 
2.0.0
