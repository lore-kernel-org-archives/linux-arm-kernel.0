From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Jan 2017 15:13:12 +0000
Subject: [PATCH v2] arm: module: handle negative R_ARM_PREL31 addends correctly
Message-ID: <1485789192-6218-1-git-send-email-ard.biesheuvel@linaro.org>
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
v2: preserve bit 31 of the relocation target

 arch/arm/kernel/module.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 4f14b5ce6535..80254b47dc34 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -155,8 +155,17 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		       break;
 
 		case R_ARM_PREL31:
-			offset = *(u32 *)loc + sym->st_value - loc;
-			*(u32 *)loc = offset & 0x7fffffff;
+			offset = (*(s32 *)loc << 1) >> 1; /* sign extend */
+			offset += sym->st_value - loc;
+			if (offset >= 0x40000000 || offset < -0x40000000) {
+				pr_err("%s: section %u reloc %u sym '%s': relocation %u out of range (%#lx -> %#x)\n",
+				       module->name, relindex, i, symname,
+				       ELF32_R_TYPE(rel->r_info), loc,
+				       sym->st_value);
+				return -ENOEXEC;
+			}
+			*(u32 *)loc &= 0x80000000;
+			*(u32 *)loc |= offset & 0x7fffffff;
 			break;
 
 		case R_ARM_MOVW_ABS_NC:
-- 
2.7.4
