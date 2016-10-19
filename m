From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Oct 2016 16:58:34 +0100
Subject: [PATCH] arm64: Add support for additional relocations in the kexec
 purgatory code
Message-ID: <1476892714-27304-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiling the kexec-tools with gcc6, the following additional
reolcations are generated in the purgatory.ro file:

R_AARCH64_ADR_PREL_PG_HI21
R_AARCH64_ADD_ABS_LO12_NC
R_AARCH64_LDST64_ABS_LO12_NC

This patch modifies the arm64 machine_apply_elf_rel() function to handle
these relocations.

Cc: Geoff Levand <geoff@infradead.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 kexec/arch/arm64/kexec-arm64.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 2e8839a..e067a23 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -550,6 +550,14 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
 # define R_AARCH64_ADR_PREL_LO21 274
 #endif
 
+#if !defined(R_AARCH64_ADR_PREL_PG_HI21)
+# define R_AARCH64_ADR_PREL_PG_HI21 275
+#endif
+
+#if !defined(R_AARCH64_ADD_ABS_LO12_NC)
+# define R_AARCH64_ADD_ABS_LO12_NC 277
+#endif
+
 #if !defined(R_AARCH64_JUMP26)
 # define R_AARCH64_JUMP26 282
 #endif
@@ -558,10 +566,15 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
 # define R_AARCH64_CALL26 283
 #endif
 
+#if !defined(R_AARCH64_LDST64_ABS_LO12_NC)
+# define R_AARCH64_LDST64_ABS_LO12_NC 286
+#endif
+
 	uint64_t *loc64;
 	uint32_t *loc32;
 	uint64_t *location = (uint64_t *)ptr;
 	uint64_t data = *location;
+	uint64_t imm;
 	const char *type = NULL;
 
 	switch(r_type) {
@@ -585,6 +598,19 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
 		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
 			+ (((value - address) << 3) & 0xffffe0));
 		break;
+	case R_AARCH64_ADR_PREL_PG_HI21:
+		type = "ADR_PREL_PG_HI21";
+		imm = ((value & ~0xfff) - (address & ~0xfff)) >> 12;
+		loc32 = ptr;
+		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
+			+ ((imm & 3) << 29) + ((imm & 0x1ffffc) << (5 - 2)));
+		break;
+	case R_AARCH64_ADD_ABS_LO12_NC:
+		type = "R_AARCH64_ADD_ABS_LO12_NC";
+		loc32 = ptr;
+		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
+			+ ((value & 0xfff) << 10));
+		break;
 	case R_AARCH64_JUMP26:
 		type = "JUMP26";
 		loc32 = ptr;
@@ -597,6 +623,15 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
 		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
 			+ (((value - address) >> 2) & 0x3ffffff));
 		break;
+	case R_AARCH64_LDST64_ABS_LO12_NC:
+		if (value & 7)
+			die("%s: ERROR Unaligned value: %lx\n", __func__,
+				value);
+		type = "R_AARCH64_LDST64_ABS_LO12_NC";
+		loc32 = ptr;
+		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
+			+ ((value & 0xff8) << (10 - 3)));
+		break;
 	default:
 		die("%s: ERROR Unknown type: %lu\n", __func__, r_type);
 		break;
-- 
2.10.0
