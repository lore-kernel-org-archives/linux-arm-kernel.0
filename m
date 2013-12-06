From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri,  6 Dec 2013 15:04:42 +0000
Subject: [PATCH v2] ARM: add support for the Cortex-A12 processor
Message-ID: <1386342282-8769-1-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A12 behaves as the A7/A15 does with respect to setting the SMP bit, and
doesn't require TLB ops broadcasting to be explicitly enabled like the A9 does.

Note that as the ACTLR cannot (usually) be written from non-secure, it is the
responsibility of the bootloader/firmware to set this bit per core - it is
done here in Linux as last resort in case of bad firmware.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
---
This V2 patch also adds A12 in asm/cputype.h, necessary for KVM, perf, among
other things.

 arch/arm/include/asm/cputype.h |    1 +
 arch/arm/mm/proc-v7.S          |   11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 9672e97..b2d81bb 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -70,6 +70,7 @@
 #define ARM_CPU_PART_CORTEX_A5		0xC050
 #define ARM_CPU_PART_CORTEX_A15		0xC0F0
 #define ARM_CPU_PART_CORTEX_A7		0xC070
+#define ARM_CPU_PART_CORTEX_A12		0xC0D0
 
 #define ARM_CPU_XSCALE_ARCH_MASK	0xe000
 #define ARM_CPU_XSCALE_ARCH_V1		0x2000
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index c63d9bd..33788ff 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -185,6 +185,7 @@ __v7_cr7mp_setup:
 	mov	r10, #(1 << 0)			@ Cache/TLB ops broadcasting
 	b	1f
 __v7_ca7mp_setup:
+__v7_ca12mp_setup:
 __v7_ca15mp_setup:
 	mov	r10, #0
 1:
@@ -479,6 +480,16 @@ __v7_ca7mp_proc_info:
 	.size	__v7_ca7mp_proc_info, . - __v7_ca7mp_proc_info
 
 	/*
+	 * ARM Ltd. Cortex A12 processor.
+	 */
+	.type	__v7_ca12mp_proc_info, #object
+__v7_ca12mp_proc_info:
+	.long	0x410fc0d0
+	.long	0xff0ffff0
+	__v7_proc __v7_ca12mp_setup
+	.size	__v7_ca12mp_proc_info, . - __v7_ca12mp_proc_info
+
+	/*
 	 * ARM Ltd. Cortex A15 processor.
 	 */
 	.type	__v7_ca15mp_proc_info, #object
-- 
1.7.9.5
