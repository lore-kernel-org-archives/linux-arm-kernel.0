From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Dec 2015 01:26:25 -0500 (EST)
Subject: [PATCH] ARM: Runtime patch udiv/sdiv instructions into
 __aeabi_{u}idiv()
Message-ID: <alpine.LFD.2.20.1512110105450.26920@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The ARM compiler inserts calls to __aeabi_uidiv() and
__aeabi_idiv() when it needs to perform division on signed and
unsigned integers. If a processor has support for the udiv and
sdiv instructions, the kernel may overwrite the beginning of those
functions with those instructions and a "bx lr" to get better
performance.

To ensure those functions are aligned to a 32-bit word for easier
patching (which might not always be the case in Thumb mode) and the
two patched instructions for each case are contained in the same cache
line, a 8-byte alignment is enforced when ARM_PATCH_IDIV is configured.

This was heavily inspired by a previous patch by Stephen Boyd.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

---

This is my counter proposal to Stephen's version. Those patches and the 
discussion that followed are available here:

  http://news.gmane.org/group/gmane.linux.kbuild.devel/thread=14007

I think what I propose here is much simpler and less intrusive.  Going
to the full call site patching provides between moderate to no 
additional performance benefits depending on the CPU core.  That should 
probably be compared with this solution with benchmark results to 
determine if it is worth it.

Of course the ultimate performance will come from having gcc emit those 
div instructions directly, but that would make the kernel binary 
incompatible with some systems in a multi-arch config. Hence it has to 
be a separate config option.


diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 34e1569a11..efea5fa975 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1604,6 +1604,21 @@ config THUMB2_AVOID_R_ARM_THM_JUMP11
 config ARM_ASM_UNIFIED
 	bool
 
+config ARM_PATCH_IDIV
+	bool "Runtime patch udiv/sdiv instructions into __aeabi_{u}idiv()"
+	depends on CPU_32v7 && !XIP_KERNEL
+	default y
+	help
+	  Some v7 CPUs have support for the udiv and sdiv instructions
+	  that can be used to implement the __aeabi_uidiv and __aeabi_idiv
+	  functions provided by the ARM runtime ABI.
+
+	  Enabling this option allows the kernel to modify itself to replace
+	  the first two instructions of these library functions with the
+	  udiv or sdiv plus "bx lr" instructions. Typically this will be
+	  faster and less power intensive than running the original library
+	  support code to do integer division.
+
 config AEABI
 	bool "Use the ARM EABI to compile the kernel"
 	help
diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 85e374f873..48c77d422a 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -250,8 +250,14 @@ static inline int cpu_is_pj4(void)
 
 	return 0;
 }
+
+static inline bool __attribute_const__ cpu_is_pj4_nomp(void)
+{
+	return read_cpuid_part() == 0x56005810;
+}
 #else
-#define cpu_is_pj4()	0
+#define cpu_is_pj4()		0
+#define cpu_is_pj4_nomp()	0
 #endif
 
 static inline int __attribute_const__ cpuid_feature_extract_field(u32 features,
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 20edd349d3..d8614775a8 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -375,6 +375,77 @@ void __init early_print(const char *str, ...)
 	printk("%s", buf);
 }
 
+#ifdef CONFIG_ARM_PATCH_IDIV
+
+/* "sdiv r0, r0, r1" or "mrc p6, 1, r0, CR0, CR1, 4" if we're on pj4 w/o MP */
+static inline u32 __attribute_const__ sdiv_instruction(void)
+{
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+		u32 insn = __opcode_thumb32_compose(0xfb90, 0xf0f1);
+		if (cpu_is_pj4_nomp())
+			insn = __opcode_thumb32_compose(0xee30, 0x0691);
+		return __opcode_to_mem_thumb32(insn);
+	}
+
+	if (cpu_is_pj4_nomp())
+		return __opcode_to_mem_arm(0xee300691);
+	return __opcode_to_mem_arm(0xe710f110);
+}
+
+/* "udiv r0, r0, r1" or "mrc p6, 1, r0, CR0, CR1, 0" if we're on pj4 w/o MP */
+static inline u32 __attribute_const__ udiv_instruction(void)
+{
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+		u32 insn = __opcode_thumb32_compose(0xfbb0, 0xf0f1);
+		if (cpu_is_pj4_nomp())
+			insn = __opcode_thumb32_compose(0xee30, 0x0611);
+		return __opcode_to_mem_thumb32(insn);
+	}
+
+	if (cpu_is_pj4_nomp())
+		return __opcode_to_mem_arm(0xee300611);
+	return __opcode_to_mem_arm(0xe730f110);
+}
+
+/* "bx lr" */
+static inline u32 __attribute_const__ bx_lr_instruction(void)
+{
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+		u32 insn = __opcode_thumb32_compose(0x4770, 0x46c0);
+		return __opcode_to_mem_thumb32(insn);
+	}
+	
+	return __opcode_to_mem_arm(0xe12fff1e);
+}
+
+static void __init patch_aeabi_uidiv(void)
+{
+	extern void __aeabi_uidiv(void);
+	extern void __aeabi_idiv(void);
+	uintptr_t fn_addr;
+	unsigned int mask;
+
+	mask = IS_ENABLED(CONFIG_THUMB2_KERNEL) ? HWCAP_IDIVT : HWCAP_IDIVA;
+	if (!(elf_hwcap & mask))
+		return;
+
+	pr_info("CPU: div instructions available: patching division code\n");
+
+	fn_addr = ((uintptr_t)&__aeabi_uidiv) & ~1;
+	((u32 *)fn_addr)[0] = udiv_instruction();
+	((u32 *)fn_addr)[1] = bx_lr_instruction();
+	flush_icache_range(fn_addr, fn_addr + 8);
+
+	fn_addr = ((uintptr_t)&__aeabi_idiv) & ~1;
+	((u32 *)fn_addr)[0] = sdiv_instruction();
+	((u32 *)fn_addr)[1] = bx_lr_instruction();
+	flush_icache_range(fn_addr, fn_addr + 8);
+}
+
+#else
+static inline void patch_aeabi_uidiv(void) { }
+#endif
+
 static void __init cpuid_init_hwcaps(void)
 {
 	int block;
@@ -642,6 +713,7 @@ static void __init setup_processor(void)
 	elf_hwcap = list->elf_hwcap;
 
 	cpuid_init_hwcaps();
+	patch_aeabi_uidiv();
 
 #ifndef CONFIG_ARM_THUMB
 	elf_hwcap &= ~(HWCAP_THUMB | HWCAP_IDIVT);
diff --git a/arch/arm/lib/lib1funcs.S b/arch/arm/lib/lib1funcs.S
index af2267f6a5..9397b2e532 100644
--- a/arch/arm/lib/lib1funcs.S
+++ b/arch/arm/lib/lib1funcs.S
@@ -205,6 +205,10 @@ Boston, MA 02111-1307, USA.  */
 .endm
 
 
+#ifdef CONFIG_ARM_PATCH_IDIV
+	.align	3
+#endif
+
 ENTRY(__udivsi3)
 ENTRY(__aeabi_uidiv)
 UNWIND(.fnstart)
@@ -253,6 +257,10 @@ UNWIND(.fnstart)
 UNWIND(.fnend)
 ENDPROC(__umodsi3)
 
+#ifdef CONFIG_ARM_PATCH_IDIV
+	.align 3
+#endif
+
 ENTRY(__divsi3)
 ENTRY(__aeabi_idiv)
 UNWIND(.fnstart)
