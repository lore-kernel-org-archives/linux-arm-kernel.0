From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 20 Apr 2010 11:50:52 +0300
Subject: [PATCH 6/8] arm: allow passing an ELF64 header to elf_check_arch()
In-Reply-To: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <0f69b7e1155e6a1d2f9e8131bfd648d9a03e8763.1271752135.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to shut following compiler warning when CONFIG_PROC_VMCORE is
enabled:

fs/proc/vmcore.c: In function 'parse_crash_elf64_headers':
fs/proc/vmcore.c:500: warning: passing argument 1 of 'elf_check_arch' from
incompatible pointer type

ELF32 and ELF64 headers have common fields of same size (namely e_ident and
e_machine) which are checked in arm_elf_check_arch().

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/include/asm/elf.h |    4 ++--
 arch/arm/kernel/elf.c      |    6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index bff0564..aa71815 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -92,8 +92,8 @@ struct elf32_hdr;
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-extern int elf_check_arch(const struct elf32_hdr *);
-#define elf_check_arch elf_check_arch
+extern int arm_elf_check_arch(const struct elf32_hdr *);
+#define elf_check_arch(x) arm_elf_check_arch((const struct elf32_hdr *)(x))
 
 extern int arm_elf_read_implies_exec(const struct elf32_hdr *, int);
 #define elf_read_implies_exec(ex,stk) arm_elf_read_implies_exec(&(ex), stk)
diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index d4a0da1..14e501b 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -4,11 +4,13 @@
 #include <linux/binfmts.h>
 #include <linux/elf.h>
 
-int elf_check_arch(const struct elf32_hdr *x)
+int arm_elf_check_arch(const struct elf32_hdr *x)
 {
 	unsigned int eflags;
 
 	/* Make sure it's an ARM executable */
+	if (x->e_ident[EI_CLASS] != ELF_CLASS)
+		return 0;
 	if (x->e_machine != EM_ARM)
 		return 0;
 
@@ -35,7 +37,7 @@ int elf_check_arch(const struct elf32_hdr *x)
 	}
 	return 1;
 }
-EXPORT_SYMBOL(elf_check_arch);
+EXPORT_SYMBOL(arm_elf_check_arch);
 
 void elf_set_personality(const struct elf32_hdr *x)
 {
-- 
1.5.6.5
