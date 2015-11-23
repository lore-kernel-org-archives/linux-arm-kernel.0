From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Nov 2015 12:49:55 -0800
Subject: [RFC/PATCH 3/3] ARM: Replace calls to __aeabi_{u}idiv with
 udiv/sdiv instructions
In-Reply-To: <yw1xd1v3d117.fsf@unicorn.mansr.com>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <1448068997-26631-4-git-send-email-sboyd@codeaurora.org>
 <yw1xd1v3d117.fsf@unicorn.mansr.com>
Message-ID: <20151123204955.GC19156@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21, M?ns Rullg?rd wrote:
> Stephen Boyd <sboyd@codeaurora.org> writes:
> 
> > +static int module_patch_aeabi_uidiv(unsigned long loc, const Elf32_Sym *sym)
> > +{
> > +	extern char __aeabi_uidiv[], __aeabi_idiv[];
> > +	unsigned long udiv_addr = (unsigned long)__aeabi_uidiv;
> > +	unsigned long sdiv_addr = (unsigned long)__aeabi_idiv;
> > +	unsigned int udiv_insn, sdiv_insn, mask;
> > +
> > +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> > +		mask = HWCAP_IDIVT;
> > +		udiv_insn = __opcode_to_mem_thumb32(0xfbb0f0f1);
> > +		sdiv_insn = __opcode_to_mem_thumb32(0xfb90f0f1);
> > +	} else {
> > +		mask = HWCAP_IDIVA;
> > +		udiv_insn = __opcode_to_mem_arm(0xe730f110);
> > +		sdiv_insn = __opcode_to_mem_arm(0xe710f110);
> > +	}
> > +
> > +	if (elf_hwcap & mask) {
> > +		if (sym->st_value == udiv_addr) {
> > +			*(u32 *)loc = udiv_insn;
> > +			return 1;
> > +		} else if (sym->st_value == sdiv_addr) {
> > +			*(u32 *)loc = sdiv_insn;
> > +			return 1;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> [...]
> 
> > +static void __init patch_aeabi_uidiv(void)
> > +{
> > +	extern unsigned long *__start_udiv_loc[], *__stop_udiv_loc[];
> > +	extern unsigned long *__start_idiv_loc[], *__stop_idiv_loc[];
> > +	unsigned long **p;
> > +	unsigned int udiv_insn, sdiv_insn, mask;
> > +
> > +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> > +		mask = HWCAP_IDIVT;
> > +		udiv_insn = __opcode_to_mem_thumb32(0xfbb0f0f1);
> > +		sdiv_insn = __opcode_to_mem_thumb32(0xfb90f0f1);
> > +	} else {
> > +		mask = HWCAP_IDIVA;
> > +		udiv_insn = __opcode_to_mem_arm(0xe730f110);
> > +		sdiv_insn = __opcode_to_mem_arm(0xe710f110);
> > +	}
> > +
> > +	if (elf_hwcap & mask) {
> > +		for (p = __start_udiv_loc; p < __stop_udiv_loc; p++) {
> > +			unsigned long *inst = *p;
> > +			*inst = udiv_insn;
> > +		}
> > +		for (p = __start_idiv_loc; p < __stop_idiv_loc; p++) {
> > +			unsigned long *inst = *p;
> > +			*inst = sdiv_insn;
> > +		}
> > +	}
> > +}
> 
> These functions are rather similar.  Perhaps they could be combined
> somehow.
> 

Yes. I have this patch on top, just haven't folded it in because
it doesn't reduce the lines of code.

----8<----
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] consolidate with module code

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/include/asm/setup.h |  3 +++
 arch/arm/kernel/module.c     | 16 +++++--------
 arch/arm/kernel/setup.c      | 54 +++++++++++++++++++++++++++-----------------
 3 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index e0adb9f1bf94..3f251cdb94ef 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -25,4 +25,7 @@ extern int arm_add_memory(u64 start, u64 size);
 extern void early_print(const char *str, ...);
 extern void dump_machine_table(void);
 
+extern void patch_uidiv(void *addr, size_t size);
+extern void patch_idiv(void *addr, size_t size);
+
 #endif
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 064e6ae60e08..684a68f1085b 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -22,6 +22,7 @@
 
 #include <asm/hwcap.h>
 #include <asm/pgtable.h>
+#include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/smp_plat.h>
 #include <asm/unwind.h>
@@ -58,24 +59,19 @@ static int module_patch_aeabi_uidiv(unsigned long loc, const Elf32_Sym *sym)
 	extern char __aeabi_uidiv[], __aeabi_idiv[];
 	unsigned long udiv_addr = (unsigned long)__aeabi_uidiv;
 	unsigned long sdiv_addr = (unsigned long)__aeabi_idiv;
-	unsigned int udiv_insn, sdiv_insn, mask;
+	unsigned int mask;
 
-	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
 		mask = HWCAP_IDIVT;
-		udiv_insn = __opcode_to_mem_thumb32(0xfbb0f0f1);
-		sdiv_insn = __opcode_to_mem_thumb32(0xfb90f0f1);
-	} else {
+	else
 		mask = HWCAP_IDIVA;
-		udiv_insn = __opcode_to_mem_arm(0xe730f110);
-		sdiv_insn = __opcode_to_mem_arm(0xe710f110);
-	}
 
 	if (elf_hwcap & mask) {
 		if (sym->st_value == udiv_addr) {
-			*(u32 *)loc = udiv_insn;
+			patch_uidiv(&loc, sizeof(loc));
 			return 1;
 		} else if (sym->st_value == sdiv_addr) {
-			*(u32 *)loc = sdiv_insn;
+			patch_idiv(&loc, sizeof(loc));
 			return 1;
 		}
 	}
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d2a3d165dcae..cb86012c47d1 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -376,33 +376,45 @@ void __init early_print(const char *str, ...)
 }
 
 #ifdef CONFIG_ARM_PATCH_UIDIV
+static void __init_or_module patch(u32 **addr, size_t count, u32 insn)
+{
+	for (; count != 0; count -= 4)
+		**addr++ = insn;
+}
+
+void __init_or_module patch_uidiv(void *addr, size_t size)
+{
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
+		patch(addr, size, __opcode_to_mem_thumb32(0xfbb0f0f1));
+	else
+		patch(addr, size, __opcode_to_mem_arm(0xe730f110));
+
+}
+
+void __init_or_module patch_idiv(void *addr, size_t size)
+{
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
+		patch(addr, size, __opcode_to_mem_thumb32(0xfb90f0f1));
+	else
+		patch(addr, size, __opcode_to_mem_arm(0xe710f110));
+}
+
 static void __init patch_aeabi_uidiv(void)
 {
-	extern unsigned long *__start_udiv_loc[], *__stop_udiv_loc[];
-	extern unsigned long *__start_idiv_loc[], *__stop_idiv_loc[];
-	unsigned long **p;
-	unsigned int udiv_insn, sdiv_insn, mask;
+	extern char __start_udiv_loc[], __stop_udiv_loc[];
+	extern char __start_idiv_loc[], __stop_idiv_loc[];
+	unsigned int mask;
 
-	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
 		mask = HWCAP_IDIVT;
-		udiv_insn = __opcode_to_mem_thumb32(0xfbb0f0f1);
-		sdiv_insn = __opcode_to_mem_thumb32(0xfb90f0f1);
-	} else {
+	else
 		mask = HWCAP_IDIVA;
-		udiv_insn = __opcode_to_mem_arm(0xe730f110);
-		sdiv_insn = __opcode_to_mem_arm(0xe710f110);
-	}
 
-	if (elf_hwcap & mask) {
-		for (p = __start_udiv_loc; p < __stop_udiv_loc; p++) {
-			unsigned long *inst = *p;
-			*inst = udiv_insn;
-		}
-		for (p = __start_idiv_loc; p < __stop_idiv_loc; p++) {
-			unsigned long *inst = *p;
-			*inst = sdiv_insn;
-		}
-	}
+	if (!(elf_hwcap & mask))
+		return;
+
+	patch_uidiv(__start_udiv_loc, __stop_udiv_loc - __start_udiv_loc);
+	patch_idiv(__start_idiv_loc, __stop_idiv_loc - __start_idiv_loc);
 }
 #else
 static void __init patch_aeabi_uidiv(void) { }
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
