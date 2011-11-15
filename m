From: junxiao.bi@windriver.com (Junxiao Bi)
Date: Tue, 15 Nov 2011 10:06:25 +0800
Subject: [PATCH 6/6] ARM: support kernel modules in BE8 mode
In-Reply-To: <1321322785-2981-1-git-send-email-junxiao.bi@windriver.com>
References: <1321322785-2981-1-git-send-email-junxiao.bi@windriver.com>
Message-ID: <1321322785-2981-6-git-send-email-junxiao.bi@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stanley.Miao <stanley.miao@windriver.com>

In BE8 mode, data must be manipulated in big endian format while
text must be little endian. Therefore, when relocating the text
section of module in BE8 mode, we must convert the location offset
of the text to big endian from the native little endian. After
the relocation is complete, the location offset value is re-written
as little endian.

Since only BE8 mode has such special requirement while other big endian
mode not, cpu_to_le32 and le32_to_cpu can not be used to relocate the
text. We introduce write_instr* and read_instr* to do it.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Signed-off-by: Junxiao Bi <junxiao.bi@windriver.com>
---
 arch/arm/Makefile         |    1 +
 arch/arm/include/asm/io.h |   12 ++++++++++
 arch/arm/kernel/module.c  |   51 +++++++++++++++++++++++----------------------
 3 files changed, 39 insertions(+), 25 deletions(-)

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
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 065d100..4b6c7de 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -210,6 +210,18 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
  * Again, this are defined to perform little endian accesses.  See the
  * IO port primitives for more information.
  */
+#ifdef CONFIG_CPU_ENDIAN_BE8
+#define read_instr32(c)		__swab32(*(u32 *)(c))
+#define read_instr16(c)		__swab16(*(u16 *)(c))
+#define write_instr32(v, a)	(*(u32 *)(a) = __swab32((__force __u32)(v)))
+#define write_instr16(v, a)	(*(u16 *)(a) = __swab16((__force __u16)(v)))
+#else
+#define read_instr32(c)		(*(u32 *)(c))
+#define read_instr16(c)		(*(u16 *)(c))
+#define write_instr32(v, a)	(*(u32 *)(a) = (v))
+#define write_instr16(v, a)	(*(u16 *)(a) = (v))
+#endif
+
 #ifdef __mem_pci
 #define readb_relaxed(c) ({ u8  __r = __raw_readb(__mem_pci(c)); __r; })
 #define readw_relaxed(c) ({ u16 __r = le16_to_cpu((__force __le16) \
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 1e9be5d..b6a0f50 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -14,6 +14,7 @@
 #include <linux/moduleloader.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/io.h>
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
@@ -95,7 +96,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		case R_ARM_PC24:
 		case R_ARM_CALL:
 		case R_ARM_JUMP24:
-			offset = (*(u32 *)loc & 0x00ffffff) << 2;
+			offset = (read_instr32(loc) & 0x00ffffff) << 2;
 			if (offset & 0x02000000)
 				offset -= 0x04000000;
 
@@ -112,8 +113,8 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 
 			offset >>= 2;
 
-			*(u32 *)loc &= 0xff000000;
-			*(u32 *)loc |= offset & 0x00ffffff;
+			write_instr32((read_instr32(loc) & 0xff000000) |
+					(offset & 0x00ffffff), loc);
 			break;
 
 	       case R_ARM_V4BX:
@@ -121,9 +122,9 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			* other bits to re-code instruction as
 			* MOV PC,Rm.
 			*/
-		       *(u32 *)loc &= 0xf000000f;
-		       *(u32 *)loc |= 0x01a0f000;
-		       break;
+			write_instr32((read_instr32(loc) & 0xf000000f) |
+					0x01a0f000, loc);
+			break;
 
 		case R_ARM_PREL31:
 			offset = *(u32 *)loc + sym->st_value - loc;
@@ -132,7 +133,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 
 		case R_ARM_MOVW_ABS_NC:
 		case R_ARM_MOVT_ABS:
-			offset = *(u32 *)loc;
+			offset = read_instr32(loc);
 			offset = ((offset & 0xf0000) >> 4) | (offset & 0xfff);
 			offset = (offset ^ 0x8000) - 0x8000;
 
@@ -140,16 +141,16 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			if (ELF32_R_TYPE(rel->r_info) == R_ARM_MOVT_ABS)
 				offset >>= 16;
 
-			*(u32 *)loc &= 0xfff0f000;
-			*(u32 *)loc |= ((offset & 0xf000) << 4) |
-					(offset & 0x0fff);
+			write_instr32((read_instr32(loc) & 0xfff0f000) |
+					((offset & 0xf000) << 4) |
+					(offset & 0x0fff), loc);
 			break;
 
 #ifdef CONFIG_THUMB2_KERNEL
 		case R_ARM_THM_CALL:
 		case R_ARM_THM_JUMP24:
-			upper = *(u16 *)loc;
-			lower = *(u16 *)(loc + 2);
+			upper = read_instr16(loc);
+			lower = read_instr16(loc + 2);
 
 			/*
 			 * 25 bit signed address range (Thumb-2 BL and B.W
@@ -198,17 +199,17 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			sign = (offset >> 24) & 1;
 			j1 = sign ^ (~(offset >> 23) & 1);
 			j2 = sign ^ (~(offset >> 22) & 1);
-			*(u16 *)loc = (u16)((upper & 0xf800) | (sign << 10) |
-					    ((offset >> 12) & 0x03ff));
-			*(u16 *)(loc + 2) = (u16)((lower & 0xd000) |
-						  (j1 << 13) | (j2 << 11) |
-						  ((offset >> 1) & 0x07ff));
+			write_instr16((u16)((upper & 0xf800) | (sign << 10) |
+					((offset >> 12) & 0x03ff)), loc);
+			write_instr16((u16)((lower & 0xd000) | (j1 << 13) |
+					(j2 << 11) | ((offset >> 1) & 0x07ff)),
+					loc + 2);
 			break;
 
 		case R_ARM_THM_MOVW_ABS_NC:
 		case R_ARM_THM_MOVT_ABS:
-			upper = *(u16 *)loc;
-			lower = *(u16 *)(loc + 2);
+			upper = read_instr16(loc);
+			lower = read_instr16(loc + 2);
 
 			/*
 			 * MOVT/MOVW instructions encoding in Thumb-2:
@@ -229,12 +230,12 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			if (ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVT_ABS)
 				offset >>= 16;
 
-			*(u16 *)loc = (u16)((upper & 0xfbf0) |
-					    ((offset & 0xf000) >> 12) |
-					    ((offset & 0x0800) >> 1));
-			*(u16 *)(loc + 2) = (u16)((lower & 0x8f00) |
-						  ((offset & 0x0700) << 4) |
-						  (offset & 0x00ff));
+			write_instr16((u16)((upper & 0xfbf0) |
+					((offset & 0xf000) >> 12) |
+					((offset & 0x0800) >> 1)), loc);
+			write_instr16((u16)((lower & 0x8f00) |
+					((offset & 0x0700) << 4) |
+					(offset & 0x00ff)), loc + 2);
 			break;
 #endif
 
-- 
1.7.0.4
