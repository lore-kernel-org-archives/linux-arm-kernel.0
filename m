From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 17 Aug 2017 03:23:46 -0400
Subject: [PATCH v2 7/8] binfmt_elf: don't attempt to load FDPIC binaries
In-Reply-To: <20170817072347.19990-1-nicolas.pitre@linaro.org>
References: <20170817072347.19990-1-nicolas.pitre@linaro.org>
Message-ID: <20170817072347.19990-8-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On platforms where both ELF and ELF-FDPIC variants are available, the
regular ELF loader will happily identify FDPIC binaries as proper ELF
and load them without the necessary FDPIC fixups, resulting in an
immediate user space crash. Let's prevent binflt_elf from loading those
binaries so binfmt_elf_fdpic has a chance to pick them up. For those
architectures that don't define elf_check_fdpic(), a default version
returning false is provided.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 fs/binfmt_elf.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 879ff9c7ff..84d64afaea 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -51,6 +51,11 @@
 #define user_siginfo_t siginfo_t
 #endif
 
+/* That's for binfmt_elf_fdpic to deal with */
+#ifndef elf_check_fdpic
+#define elf_check_fdpic(ex) false
+#endif
+
 static int load_elf_binary(struct linux_binprm *bprm);
 static unsigned long elf_map(struct file *, unsigned long, struct elf_phdr *,
 				int, int, unsigned long);
@@ -541,7 +546,8 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	if (interp_elf_ex->e_type != ET_EXEC &&
 	    interp_elf_ex->e_type != ET_DYN)
 		goto out;
-	if (!elf_check_arch(interp_elf_ex))
+	if (!elf_check_arch(interp_elf_ex) ||
+	    elf_check_fdpic(interp_elf_ex))
 		goto out;
 	if (!interpreter->f_op->mmap)
 		goto out;
@@ -718,6 +724,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out;
 	if (!elf_check_arch(&loc->elf_ex))
 		goto out;
+	if (elf_check_fdpic(&loc->elf_ex))
+		goto out;
 	if (!bprm->file->f_op->mmap)
 		goto out;
 
@@ -817,7 +825,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (memcmp(loc->interp_elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
 			goto out_free_dentry;
 		/* Verify the interpreter has a valid arch */
-		if (!elf_check_arch(&loc->interp_elf_ex))
+		if (!elf_check_arch(&loc->interp_elf_ex) ||
+		    elf_check_fdpic(&loc->interp_elf_ex))
 			goto out_free_dentry;
 
 		/* Load the interpreter program headers */
@@ -1189,6 +1198,8 @@ static int load_elf_library(struct file *file)
 	if (elf_ex.e_type != ET_EXEC || elf_ex.e_phnum > 2 ||
 	    !elf_check_arch(&elf_ex) || !file->f_op->mmap)
 		goto out;
+	if (elf_check_fdpic(&elf_ex))
+		goto out;
 
 	/* Now read in all of the header information */
 
-- 
2.9.5
