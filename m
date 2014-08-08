From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Fri, 08 Aug 2014 15:53:56 +0400
Subject: [PATCH] arm: module: add support for R_ARM_TARGET1 relocations
Message-ID: <1407498836-2797-1-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel module build with GCOV profiling fails to load with the
following error:

 $ insmod test_module.ko
   test_module: unknown relocation: 38
   insmod: can't insert 'test_module.ko': invalid module format

This happens because constructor pointers in the .init_array section
have not supported R_ARM_TARGET1 relocation type.

Documentation (ELF for the ARM Architecture) says:
    "The relocation must be processed either in the same way as R_ARM_REL32 or
     as R_ARM_ABS32: a virtual platform must specify which method is used."

Since kernel expects to see absolute addresses in .init_array R_ARM_TARGET1
relocation type should be treated the same way as R_ARM_ABS32.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm/include/asm/elf.h | 1 +
 arch/arm/kernel/module.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index f4b46d3..afb9caf 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -50,6 +50,7 @@ typedef struct user_fp elf_fpregset_t;
 #define R_ARM_ABS32		2
 #define R_ARM_CALL		28
 #define R_ARM_JUMP24		29
+#define R_ARM_TARGET1		38
 #define R_ARM_V4BX		40
 #define R_ARM_PREL31		42
 #define R_ARM_MOVW_ABS_NC	43
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 45e4781..6a4dffe 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -91,6 +91,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			break;
 
 		case R_ARM_ABS32:
+		case R_ARM_TARGET1:
 			*(u32 *)loc += sym->st_value;
 			break;
 
-- 
1.8.5.5
