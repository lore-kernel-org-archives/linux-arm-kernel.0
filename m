From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 29 Mar 2010 12:26:33 +0300
Subject: [RFC 07/10] arm: allow passing an ELF64 header to elf_check_arch()
In-Reply-To: <49c5365fe4f794390ca2a4de75365953e211ab3f.1269854500.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<7b747cd930c20ae4a625c981d88e2773c706fce9.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<e3c9449c42a735f9acee8e50af33762ffcadf7b4.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<0f8c479602b8957c49db7ac56b8f90ac6f4da5dc.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<5d4c557a427346c129c8f6cc43c5819177c05ff5.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<f05417b66eedd3c1fe32b433dcdae71a2a151da5.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<49c5365fe4f794390ca2a4de75365953e211ab3f.1269854500.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <01f3321661bf5d6fc4ba83a0e9fdaf99a7673abc.1269854500.git.ext-mika.1.westerberg@nokia.com>
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
