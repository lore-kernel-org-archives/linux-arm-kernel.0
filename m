From: junxiao.bi@windriver.com (Junxiao Bi)
Date: Thu, 8 Dec 2011 18:07:52 +0800
Subject: [PATCH 6/6] ARM: support kernel modules in BE8 mode
In-Reply-To: <1323338872-24716-1-git-send-email-junxiao.bi@windriver.com>
References: <1323338872-24716-1-git-send-email-junxiao.bi@windriver.com>
Message-ID: <1323338872-24716-7-git-send-email-junxiao.bi@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stanley.Miao <stanley.miao@windriver.com>

In BE8 mode, data must be manipulated in big endian format while
text must be little endian. Therefore, when relocating the text
section of module in BE8 mode, we must convert the location offset
of the text to big endian from the native little endian. After
the relocation is complete, the location offset value is re-written
as little endian.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Signed-off-by: Junxiao Bi <junxiao.bi@windriver.com>
---
 arch/arm/Makefile        |    1 +
 arch/arm/kernel/module.c |   63 +++++++++++++++++++++++++++------------------
 2 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index dfcf3b0..c858184 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -13,6 +13,7 @@
 LDFLAGS_vmlinux	:=-p --no-undefined -X
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
+LDFLAGS_MODULE	+= --be8
 endif
 
 OBJCOPYFLAGS	:=-O binary -R .comment -S
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 1e9be5d..9b32c8f 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -24,6 +24,7 @@
 #include <asm/sections.h>
 #include <asm/smp_plat.h>
 #include <asm/unwind.h>
+#include <asm/opcodes.h>
 
 #ifdef CONFIG_XIP_KERNEL
 /*
@@ -60,6 +61,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		Elf32_Sym *sym;
 		const char *symname;
 		s32 offset;
+		u32 instr32;
 #ifdef CONFIG_THUMB2_KERNEL
 		u32 upper, lower, sign, j1, j2;
 #endif
@@ -95,7 +97,8 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		case R_ARM_PC24:
 		case R_ARM_CALL:
 		case R_ARM_JUMP24:
-			offset = (*(u32 *)loc & 0x00ffffff) << 2;
+			instr32 = __mem_to_opcode_arm(*(u32 *)loc);
+			offset = (instr32 & 0x00ffffff) << 2;
 			if (offset & 0x02000000)
 				offset -= 0x04000000;
 
@@ -112,8 +115,8 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 
 			offset >>= 2;
 
-			*(u32 *)loc &= 0xff000000;
-			*(u32 *)loc |= offset & 0x00ffffff;
+			*(u32 *)loc = __opcode_to_mem_arm((instr32 & 0xff000000)
+						| (offset & 0x00ffffff));
 			break;
 
 	       case R_ARM_V4BX:
@@ -121,9 +124,9 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			* other bits to re-code instruction as
 			* MOV PC,Rm.
 			*/
-		       *(u32 *)loc &= 0xf000000f;
-		       *(u32 *)loc |= 0x01a0f000;
-		       break;
+			instr32 = __mem_to_opcode_arm(*(u32 *)loc) & 0xf000000f;
+			*(u32 *)loc = __opcode_to_mem_arm(instr32 | 0x01a0f000);
+			break;
 
 		case R_ARM_PREL31:
 			offset = *(u32 *)loc + sym->st_value - loc;
@@ -132,7 +135,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 
 		case R_ARM_MOVW_ABS_NC:
 		case R_ARM_MOVT_ABS:
-			offset = *(u32 *)loc;
+			offset = __mem_to_opcode_arm(*(u32 *)loc);
 			offset = ((offset & 0xf0000) >> 4) | (offset & 0xfff);
 			offset = (offset ^ 0x8000) - 0x8000;
 
@@ -140,16 +143,17 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			if (ELF32_R_TYPE(rel->r_info) == R_ARM_MOVT_ABS)
 				offset >>= 16;
 
-			*(u32 *)loc &= 0xfff0f000;
-			*(u32 *)loc |= ((offset & 0xf000) << 4) |
-					(offset & 0x0fff);
+			instr32 = __mem_to_opcode_arm(*(u32 *)loc) & 0xfff0f000;
+			*(u32 *)loc = __opcode_to_mem_arm(instr32 |
+					((offset & 0xf000) << 4) |
+					(offset & 0x0fff));
 			break;
 
 #ifdef CONFIG_THUMB2_KERNEL
 		case R_ARM_THM_CALL:
 		case R_ARM_THM_JUMP24:
-			upper = *(u16 *)loc;
-			lower = *(u16 *)(loc + 2);
+			upper = __mem_to_opcode_thumb16(*(u16 *)loc);
+			lower = __mem_to_opcode_thumb16(*(u16 *)(loc + 2));
 
 			/*
 			 * 25 bit signed address range (Thumb-2 BL and B.W
@@ -198,17 +202,22 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			sign = (offset >> 24) & 1;
 			j1 = sign ^ (~(offset >> 23) & 1);
 			j2 = sign ^ (~(offset >> 22) & 1);
-			*(u16 *)loc = (u16)((upper & 0xf800) | (sign << 10) |
-					    ((offset >> 12) & 0x03ff));
-			*(u16 *)(loc + 2) = (u16)((lower & 0xd000) |
-						  (j1 << 13) | (j2 << 11) |
-						  ((offset >> 1) & 0x07ff));
+			*(u16 *)loc = __opcode_to_mem_thumb16((u16)(
+						(upper & 0xf800) |
+						(sign << 10) |
+						((offset >> 12) & 0x03ff)
+						));
+			*(u16 *)(loc + 2) = __opcode_to_mem_thumb16((u16)(
+						(lower & 0xd000) |
+						(j1 << 13) | (j2 << 11) |
+						((offset >> 1) & 0x07ff)
+						));
 			break;
 
 		case R_ARM_THM_MOVW_ABS_NC:
 		case R_ARM_THM_MOVT_ABS:
-			upper = *(u16 *)loc;
-			lower = *(u16 *)(loc + 2);
+			upper = __mem_to_opcode_thumb16(*(u16 *)loc);
+			lower = __mem_to_opcode_thumb16(*(u16 *)(loc + 2));
 
 			/*
 			 * MOVT/MOVW instructions encoding in Thumb-2:
@@ -229,12 +238,16 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			if (ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVT_ABS)
 				offset >>= 16;
 
-			*(u16 *)loc = (u16)((upper & 0xfbf0) |
-					    ((offset & 0xf000) >> 12) |
-					    ((offset & 0x0800) >> 1));
-			*(u16 *)(loc + 2) = (u16)((lower & 0x8f00) |
-						  ((offset & 0x0700) << 4) |
-						  (offset & 0x00ff));
+			*(u16 *)loc = __opcode_to_mem_thumb16((u16)(
+					(upper & 0xfbf0) |
+					((offset & 0xf000) >> 12) |
+					((offset & 0x0800) >> 1)
+					));
+			*(u16 *)(loc + 2) = __opcode_to_mem_thumb16((u16)(
+					(lower & 0x8f00) |
+					((offset & 0x0700) << 4) |
+					(offset & 0x00ff)
+					));
 			break;
 #endif
 
-- 
1.7.0.4
