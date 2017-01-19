From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 19 Jan 2017 22:11:32 +0000
Subject: [PATCH] arm: module: add support for R_ARM_REL32 relocations
Message-ID: <1484863892-5818-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for R_ARM_REL32 relocations in the module loader,
which will be used by the modversions code when (if) it switches
to using relative references to refer to CRC values.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/elf.h | 1 +
 arch/arm/kernel/module.c   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index d2315ffd8f12..d450a59ca121 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -50,6 +50,7 @@ typedef struct user_fp elf_fpregset_t;
 #define R_ARM_NONE		0
 #define R_ARM_PC24		1
 #define R_ARM_ABS32		2
+#define R_ARM_REL32		3
 #define R_ARM_CALL		28
 #define R_ARM_JUMP24		29
 #define R_ARM_TARGET1		38
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 4f14b5ce6535..29629fe02ce5 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -159,6 +159,10 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			*(u32 *)loc = offset & 0x7fffffff;
 			break;
 
+		case R_ARM_REL32:
+			*(u32 *)loc += sym->st_value - loc;
+			break;
+
 		case R_ARM_MOVW_ABS_NC:
 		case R_ARM_MOVT_ABS:
 			offset = tmp = __mem_to_opcode_arm(*(u32 *)loc);
-- 
2.7.4
