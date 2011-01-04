From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 04 Jan 2011 20:23:38 +0000
Subject: [RFC 5/5] ARM: P2V: extend to 16-bit translation offsets
In-Reply-To: <20110104202052.GE24935@n2100.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
Message-ID: <E1PaDPu-00023p-QG@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MSM's memory is aligned to 2MB, which is more than we can do with our
existing method as we're limited to the upper 8 bits.  Extend this by
using two instructions to 16 bits, automatically selected when MSM is
enabled.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig              |    5 ++++-
 arch/arm/include/asm/memory.h |   14 ++++++++++----
 arch/arm/kernel/head.S        |   18 ++++++++++++++++--
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 801192b..8a753cb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -200,7 +200,6 @@ config ARM_PATCH_PHYS_VIRT
 	bool "Patch physical to virtual translations at runtime (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	depends on !XIP_KERNEL && !THUMB2_KERNEL && MMU
-	depends on !ARCH_MSM
 	depends on !ARCH_REALVIEW || !SPARSEMEM
 	help
 	  Patch phys-to-virt translation functions at runtime according to
@@ -209,6 +208,10 @@ config ARM_PATCH_PHYS_VIRT
 	  This can only be used with non-XIP, non-Thumb2, MMU kernels where
 	  the base of physical memory is at a 16MB boundary.
 
+config ARM_PATCH_PHYS_VIRT_16BIT
+	def_bool y
+	depends on ARM_PATCH_PHYS_VIRT && ARCH_MSM
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 288b690..e2b54fd 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -157,26 +157,32 @@
 extern unsigned long __pv_phys_offset;
 #define PHYS_OFFSET __pv_phys_offset
 
-#define __pv_stub(from,to,instr)			\
+#define __pv_stub(from,to,instr,type)			\
 	__asm__("@ __pv_stub\n"				\
 	"1:	" instr "	%0, %1, %2\n"		\
 	"	.pushsection .pv_table,\"a\"\n"		\
 	"	.long	1b\n"				\
 	"	.popsection\n"				\
 	: "=r" (to)					\
-	: "r" (from), "I" (1))
+	: "r" (from), "I" (type))
 
 static inline unsigned long __virt_to_phys(unsigned long x)
 {
 	unsigned long t;
-	__pv_stub(x, t, "add");
+	__pv_stub(x, t, "add", 1);
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
+	__pv_stub(t, t, "add", 0);
+#endif
 	return t;
 }
 
 static inline unsigned long __phys_to_virt(unsigned long x)
 {
 	unsigned long t;
-	__pv_stub(x, t, "sub");
+	__pv_stub(x, t, "sub", 1);
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
+	__pv_stub(t, t, "sub", 0);
+#endif
 	return t;
 }
 #else
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 258b0ca..c0b77a0 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -463,18 +463,32 @@ __fixup_pv_table:
 	add	r5, r5, r3	@ adjust table end address
 	add	ip, ip, r3	@ our PHYS_OFFSET
 	str	ip, [r7, r3]!	@ save to __pv_phys_offset
+#ifndef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
 	mov	r6, r3, lsr #24	@ constant for add/sub instructions
 	teq	r3, r6, lsl #24 @ must be 16MiB aligned
+#else
+	mov	r6, r3, lsr #16	@ constant for add/sub instructions
+	teq	r3, r6, lsl #16	@ must be 64kiB aligned
+#endif
 	bne	__error
-	orr	r6, r6, #0x400	@ mask in rotate right 8 bits
 	str	r6, [r7, #4]	@ save to __pv_offset
 __fixup_a_pv_table:
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
+	and	r0, r6, #255	@ offset bits 23-16
+	mov	r6, r6, lsr #8	@ offset bits 31-24
+	orr	r0, r0, #0x400	@ mask in rotate right 8 bits
+#else
+	mov	r0, #0		@ just in case...
+#endif
+	orr	r6, r6, #0x400	@ mask in rotate right 8 bits
 2:	cmp	r4, r5
 	ldrlo	r7, [r4], #4
 	ldrlo	ip, [r7, r3]
+	tst	ip, #1		@ existing constant tells us LS or MS byte
 	bic	ip, ip, #0x000000ff
 	bic	ip, ip, #0x00000f00
-	orr	ip, ip, r6
+	orrne	ip, ip, r6	@ mask in offset bits 31-24
+	orreq	ip, ip, r0	@ mask in offset bits 23-16
 	strlo	ip, [r7, r3]
 	blo	2b
 	mov	pc, lr
-- 
1.6.2.5
