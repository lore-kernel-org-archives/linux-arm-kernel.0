From: panand@redhat.com (Pratyush Anand)
Date: Wed, 26 Oct 2016 10:10:23 +0530
Subject: [PATCH] arm64: Add support of R_AARCH64_PREL32 relocation in purgatory
Message-ID: <0eb8a908f617e0f957df7fb3ef293596f47e6832.1477456661.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc version in fedora koji is  6.2.1-2.fc25. kexec-tools compiled with this
gcc produced another relocation error:

machine_apply_elf_rel: ERROR Unknown type: 261

This patch fixes the above error.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 kexec/arch/arm64/kexec-arm64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 218f0bc832cd..b12de4772412 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -720,6 +720,10 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
 # define R_AARCH64_ABS64 257
 #endif
 
+#if !defined(R_AARCH64_PREL32)
+# define R_AARCH64_PREL32 261
+#endif
+
 #if !defined(R_AARCH64_LD_PREL_LO19)
 # define R_AARCH64_LD_PREL_LO19 273
 #endif
@@ -761,6 +765,11 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
 		loc64 = ptr;
 		*loc64 = cpu_to_elf64(ehdr, elf64_to_cpu(ehdr, *loc64) + value);
 		break;
+	case R_AARCH64_PREL32:
+		type = "PREL32";
+		loc32 = ptr;
+		*loc32 = cpu_to_elf32(ehdr, elf32_to_cpu(ehdr, *loc32) + value - address);
+		break;
 	case R_AARCH64_LD_PREL_LO19:
 		type = "LD_PREL_LO19";
 		loc32 = ptr;
-- 
2.7.4
