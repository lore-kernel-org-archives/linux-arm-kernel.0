From: maxin.john@gmail.com (Maxin John)
Date: Fri, 6 May 2011 19:51:59 +0300
Subject: [PATCH] arm: kernel: module: Remove the r_offset check which is
	always false
Message-ID: <BANLkTin7e1xkXTWMLQ5fyAZStiCGO-Apug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checking the unsigned 'r_offset' for less than zero will always be false.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index fee7c36..fc74bd3 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -92,7 +92,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char
*strtab, unsigned int symindex,
                sym = ((Elf32_Sym *)symsec->sh_addr) + offset;
                symname = strtab + sym->st_name;

-               if (rel->r_offset < 0 || rel->r_offset >
dstsec->sh_size - sizeof(u32)) {
+               if (rel->r_offset > dstsec->sh_size - sizeof(u32)) {
                        pr_err("%s: section %u reloc %u sym '%s': out
of bounds relocation, offset %d size %u\n",
                               module->name, relindex, i, symname,
                               rel->r_offset, dstsec->sh_size);
