From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jul 2010 10:04:37 +0100
Subject: issue: insert kernel module failed with CONFIG_HIGHMEM enabled
In-Reply-To: <20100729074239.GA13756@n2100.arm.linux.org.uk>
References: <AANLkTi=SZVbAnBSZn_khGE4hZM9gsGr7H0whkBBU4TED@mail.gmail.com>
	<20100729074239.GA13756@n2100.arm.linux.org.uk>
Message-ID: <20100729090437.GB14880@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 08:42:40AM +0100, Russell King - ARM Linux wrote:
> Are you building the kernel and module using THUMB2?  Unfortunately,
> these error messages don't tell me what type the failing relocation is.

If you reproduce the problem with this patch applied, and re-report the
error message, it should answer some of those questions.

Thanks.

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index c628bdf..c5098dc 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -101,23 +101,25 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 	for (i = 0; i < relsec->sh_size / sizeof(Elf32_Rel); i++, rel++) {
 		unsigned long loc;
 		Elf32_Sym *sym;
+		const char *symname;
 		s32 offset;
 		u32 upper, lower, sign, j1, j2;
 
 		offset = ELF32_R_SYM(rel->r_info);
 		if (offset < 0 || offset > (symsec->sh_size / sizeof(Elf32_Sym))) {
-			printk(KERN_ERR "%s: bad relocation, section %d reloc %d\n",
+			pr_err("%s: section %u reloc %u: bad relocation sym offset\n",
 				module->name, relindex, i);
 			return -ENOEXEC;
 		}
 
 		sym = ((Elf32_Sym *)symsec->sh_addr) + offset;
+		symname = strtab + sym->st_name;
 
 		if (rel->r_offset < 0 || rel->r_offset > dstsec->sh_size - sizeof(u32)) {
-			printk(KERN_ERR "%s: out of bounds relocation, "
-				"section %d reloc %d offset %d size %d\n",
-				module->name, relindex, i, rel->r_offset,
-				dstsec->sh_size);
+			pr_err("%s: section %u reloc %u sym '%s': "
+			       "out of bounds relocation, offset %d size %u\n",
+			       module->name, relindex, i, symname,
+			       rel->r_offset, dstsec->sh_size);
 			return -ENOEXEC;
 		}
 
@@ -143,10 +145,11 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			if (offset & 3 ||
 			    offset <= (s32)0xfe000000 ||
 			    offset >= (s32)0x02000000) {
-				printk(KERN_ERR
-				       "%s: relocation out of range, section "
-				       "%d reloc %d sym '%s'\n", module->name,
-				       relindex, i, strtab + sym->st_name);
+				pr_err("%s: section %u reloc %u sym '%s': "
+				       "relocation %u out of range (%#lx -> %#x)\n",
+				       module->name, relindex, i, symname,
+				       ELF32_R_TYPE(rel->r_info), loc,
+				       sym->st_value);
 				return -ENOEXEC;
 			}
 
@@ -218,10 +221,11 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			if (!(offset & 1) ||
 			    offset <= (s32)0xff000000 ||
 			    offset >= (s32)0x01000000) {
-				printk(KERN_ERR
-				       "%s: relocation out of range, section "
-				       "%d reloc %d sym '%s'\n", module->name,
-				       relindex, i, strtab + sym->st_name);
+				pr_err("%s: section %u reloc %u sym '%s': "
+				       "relocation %u out of range (%#lx -> %#x)\n",
+				       module->name, relindex, i, symname,
+				       ELF32_R_TYPE(rel->r_info), loc,
+				       sym->st_value);
 				return -ENOEXEC;
 			}
 
