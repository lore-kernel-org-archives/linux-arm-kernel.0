From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Sep 2018 23:51:43 -0700
Subject: [PATCH v3 8/9] jump_table: move entries into ro_after_init region
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
Message-ID: <20180919065144.25010-9-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __jump_table sections emitted into the core kernel and into
each module consist of statically initialized references into
other parts of the code, and with the exception of entries that
point into init code, which are defused at post-init time, these
data structures are never modified.

So let's move them into the ro_after_init section, to prevent them
from being corrupted inadvertently by buggy code, or deliberately
by an attacker.

Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/s390/kernel/vmlinux.lds.S    |  1 +
 include/asm-generic/vmlinux.lds.h | 11 +++++++----
 kernel/module.c                   |  9 +++++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index b43f8d33a369..4042bbf3f9ad 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -66,6 +66,7 @@ SECTIONS
 		 *(.data..ro_after_init)
 	}
 	EXCEPTION_TABLE(16)
+	JUMP_TABLE_DATA
 	. = ALIGN(PAGE_SIZE);
 	__end_ro_after_init = .;
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7b75ff6e2fce..f09ee3c544bc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -253,10 +253,6 @@
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
-	. = ALIGN(8);                                                   \
-	__start___jump_table = .;					\
-	KEEP(*(__jump_table))                                           \
-	__stop___jump_table = .;					\
 	. = ALIGN(8);							\
 	__start___verbose = .;						\
 	KEEP(*(__verbose))                                              \
@@ -300,6 +296,12 @@
 	. = __start_init_task + THREAD_SIZE;				\
 	__end_init_task = .;
 
+#define JUMP_TABLE_DATA							\
+	. = ALIGN(8);							\
+	__start___jump_table = .;					\
+	KEEP(*(__jump_table))						\
+	__stop___jump_table = .;
+
 /*
  * Allow architectures to handle ro_after_init data on their
  * own by defining an empty RO_AFTER_INIT_DATA.
@@ -308,6 +310,7 @@
 #define RO_AFTER_INIT_DATA						\
 	__start_ro_after_init = .;					\
 	*(.data..ro_after_init)						\
+	JUMP_TABLE_DATA							\
 	__end_ro_after_init = .;
 #endif
 
diff --git a/kernel/module.c b/kernel/module.c
index 6746c85511fe..49a405891587 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3315,6 +3315,15 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	 * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
 	 */
 	ndx = find_sec(info, ".data..ro_after_init");
+	if (ndx)
+		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
+	/*
+	 * Mark the __jump_table section as ro_after_init as well: these data
+	 * structures are never modified, with the exception of entries that
+	 * refer to code in the __init section, which are annotated as such
+	 * at module load time.
+	 */
+	ndx = find_sec(info, "__jump_table");
 	if (ndx)
 		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
 
-- 
2.17.1
