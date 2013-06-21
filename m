From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 21 Jun 2013 19:48:18 -0400
Subject: [PATCH 4/8] ARM: mm: Pass the constant as an argument to
 fixup_pv_table()
In-Reply-To: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
References: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1371858502-10083-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current fixup_pv_table() API hardcoded the constant to be
patched. Make that as an argument to fixup_pv_table() so that
different type of instructions can be patched.

This is preparatory patch to add the subsequent 64 bit patching.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/memory.h |    2 ++
 arch/arm/kernel/head.S        |    3 +--
 arch/arm/kernel/module.c      |    4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 5944092..3d4f79c 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -175,6 +175,8 @@
 
 extern phys_addr_t (*arch_virt_to_idmap) (unsigned long x);
 extern unsigned long __pv_phys_offset;
+extern unsigned long __pv_offset;
+
 #define PHYS_OFFSET __pv_phys_offset
 
 #define __pv_stub(from,to,instr,type)			\
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 45e8935..764e83b 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -604,11 +604,10 @@ ENDPROC(__fixup_a_pv_table)
 
 ENTRY(fixup_pv_table)
 	stmfd	sp!, {r4 - r7, lr}
-	ldr	r2, 2f			@ get address of __pv_phys_offset
 	mov	r3, #0			@ no offset
 	mov	r4, r0			@ r0 = table start
 	add	r5, r0, r1		@ r1 = table size
-	ldr	r6, [r2, #4]		@ get __pv_offset
+	mov	r6, r2			@ get constant to be patched
 	bl	__fixup_a_pv_table
 	ldmfd	sp!, {r4 - r7, pc}
 ENDPROC(fixup_pv_table)
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 1e9be5d..1ac071b 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -265,7 +265,7 @@ static const Elf_Shdr *find_mod_section(const Elf32_Ehdr *hdr,
 	return NULL;
 }
 
-extern void fixup_pv_table(const void *, unsigned long);
+extern void fixup_pv_table(const void *, unsigned long, unsigned long);
 extern void fixup_smp(const void *, unsigned long);
 
 int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
@@ -319,7 +319,7 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
 	s = find_mod_section(hdr, sechdrs, ".pv_table");
 	if (s)
-		fixup_pv_table((void *)s->sh_addr, s->sh_size);
+		fixup_pv_table((void *)s->sh_addr, s->sh_size, __pv_offset);
 #endif
 	s = find_mod_section(hdr, sechdrs, ".alt.smp.init");
 	if (s && !is_smp())
-- 
1.7.9.5
