From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 20 Jan 2017 10:21:03 +0000
Subject: [PATCH] arm: module: handle negative R_ARM_PREL31 addends correctly
Message-ID: <1484907663-32322-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the spec 'ELF for the ARM Architecture' (IHI 0044E),
addends for R_ARM_PREL31 relocations are 31-bit signed quantities,
so we need to sign extend the value to 32 bits before it can be used
as an offset in the calculation of the relocated value.

We have not been bitten by this because these relocations are usually
emitted against the start of a section, which means the addends never
assume negative values in practice. But it is a bug nonetheless, so fix
it.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
This is something I spotted while looking into adding support for
R_ARM_REL32 relocations. Feel free to ignore if it is guaranteed in some
way that these relocations can never be emitted with negative addends.

 arch/arm/kernel/module.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 29629fe02ce5..20d8374711e2 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -155,7 +155,15 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		       break;
 
 		case R_ARM_PREL31:
-			offset = *(u32 *)loc + sym->st_value - loc;
+			offset = (*(s32 *)loc << 1) >> 1; /* sign extend */
+			offset += sym->st_value - loc;
+			if (offset >= 0x40000000 || offset < -0x40000000) {
+				pr_err("%s: section %u reloc %u sym '%s': relocation %u out of range (%#lx -> %#x)\n",
+				       module->name, relindex, i, symname,
+				       ELF32_R_TYPE(rel->r_info), loc,
+				       sym->st_value);
+				return -ENOEXEC;
+			}
 			*(u32 *)loc = offset & 0x7fffffff;
 			break;
 
-- 
2.7.4
