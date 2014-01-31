From: dave.long@linaro.org (David Long)
Date: Fri, 31 Jan 2014 13:33:13 -0500
Subject: [PATCH] Detect section mismatches in thumb relocations
Message-ID: <1391193193-28572-1-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

Add processing for normally encountered thumb relocation types so that
section mismatches will be detected.

Signed-off-by: David A. Long <dave.long@linaro.org>
---
 scripts/mod/modpost.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 1785576..9e6c996 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1498,6 +1498,16 @@ static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 #define R_ARM_JUMP24	29
 #endif
 
+#ifndef	R_ARM_THM_CALL
+#define	R_ARM_THM_CALL		10
+#endif
+#ifndef	R_ARM_THM_JUMP24
+#define	R_ARM_THM_JUMP24	30
+#endif
+#ifndef	R_ARM_THM_JUMP19
+#define	R_ARM_THM_JUMP19	51
+#endif
+
 static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
@@ -1511,6 +1521,9 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 	case R_ARM_PC24:
 	case R_ARM_CALL:
 	case R_ARM_JUMP24:
+	case R_ARM_THM_CALL:
+	case R_ARM_THM_JUMP24:
+	case R_ARM_THM_JUMP19:
 		/* From ARM ABI: ((S + A) | T) - P */
 		r->r_addend = (int)(long)(elf->hdr +
 		              sechdr->sh_offset +
-- 
1.8.1.2
