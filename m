From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 02 Jun 2010 18:02:56 +0100
Subject: [PATCH v2 8/8] ARM: Do not compile the Thumb-2 module relocations
	on an ARM kernel
In-Reply-To: <20100602170039.18569.41823.stgit@e102109-lin.cambridge.arm.com>
References: <20100602170039.18569.41823.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100602170256.18569.89549.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/module.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index aab7fca..6b46058 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -102,7 +102,9 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		unsigned long loc;
 		Elf32_Sym *sym;
 		s32 offset;
+#ifdef CONFIG_THUMB2_KERNEL
 		u32 upper, lower, sign, j1, j2;
+#endif
 
 		offset = ELF32_R_SYM(rel->r_info);
 		if (offset < 0 || offset > (symsec->sh_size / sizeof(Elf32_Sym))) {
@@ -185,6 +187,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 					(offset & 0x0fff);
 			break;
 
+#ifdef CONFIG_THUMB2_KERNEL
 		case R_ARM_THM_CALL:
 		case R_ARM_THM_JUMP24:
 			upper = *(u16 *)loc;
@@ -266,6 +269,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 						  ((offset & 0x0700) << 4) |
 						  (offset & 0x00ff));
 			break;
+#endif
 
 		default:
 			printk(KERN_ERR "%s: unknown relocation: %u\n",
