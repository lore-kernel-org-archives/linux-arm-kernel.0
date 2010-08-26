From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Thu, 26 Aug 2010 15:02:29 +0300
Subject: [PATCH v2 3/6] crash: add support for ARM kernel image
In-Reply-To: <cover.1282822832.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1282822832.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <00390eaa9f45436a54092c518abb1f8022f2fd9c.1282822832.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM kernel image is slightly different than the currently supported images so
implement necessary support for it.

Signed-off-by: Jan Karlsson <jan.karlsson@sonyericsson.com>
Signed-off-by: Thomas F?nge <thomas.fange@sonyericsson.com>
Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 kernel.c            |    3 ++-
 lkcd_vmdump_v2_v3.h |    4 ++--
 symbols.c           |   15 +++++++++++++--
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel.c b/kernel.c
index 03c620b..5dc2c45 100755
--- a/kernel.c
+++ b/kernel.c
@@ -757,7 +757,8 @@ verify_version(void)
 
 	if (!(sp = symbol_search("linux_banner")))
 		error(FATAL, "linux_banner symbol does not exist?\n");
-	else if ((sp->type == 'R') || (sp->type == 'r'))
+	else if ((sp->type == 'R') || (sp->type == 'r') ||
+		 (machine_type("ARM") && sp->type == 'T'))
 		linux_banner = symbol_value("linux_banner");
 	else
 		get_symbol_data("linux_banner", sizeof(ulong), &linux_banner);
diff --git a/lkcd_vmdump_v2_v3.h b/lkcd_vmdump_v2_v3.h
index 006b0b6..afdcc53 100755
--- a/lkcd_vmdump_v2_v3.h
+++ b/lkcd_vmdump_v2_v3.h
@@ -35,7 +35,7 @@
 #include <asm/vmdump.h>                 /* for architecture-specific header */
 #endif
 
-#if defined(X86) || defined(PPC) || defined(S390) || defined(S390X)
+#if defined(ARM) || defined(X86) || defined(PPC) || defined(S390) || defined(S390X)
 
 /*
  * Kernel header file for Linux crash dumps.
@@ -92,7 +92,7 @@ typedef struct _dump_header_asm_s {
 
 #endif /* _ASM_VMDUMP_H */
 
-#endif /* X86 || PPC */
+#endif /* ARM || X86 || PPC */
 
 #if defined(ALPHA) || defined(IA64) || defined(X86_64) || defined(PPC64)
 
diff --git a/symbols.c b/symbols.c
index 5ce2f61..3109ae8 100755
--- a/symbols.c
+++ b/symbols.c
@@ -490,7 +490,8 @@ get_text_init_space(void)
 		return;
 
 	if (((section = get_kernel_section(".text.init")) == NULL) &&
-	    ((section = get_kernel_section(".init.text")) == NULL)) {
+	    ((section = get_kernel_section(".init.text")) == NULL) &&
+	    (machine_type("ARM") && (section = get_kernel_section(".init")) == NULL)) {
 		error(WARNING, "cannot determine text init space\n");
 		return;
 	}
@@ -2660,6 +2661,11 @@ is_kernel(char *file)
 				goto bailout;
 			break;
 
+		case EM_ARM:
+			if (machine_type_mismatch(file, "ARM", NULL, 0))
+				goto bailout;
+			break;
+
 		default:
 			if (machine_type_mismatch(file, "(unknown)", NULL, 0))
 				goto bailout;
@@ -2748,7 +2754,7 @@ is_shared_object(char *file)
 		switch (swap16(elf32->e_machine, swap))
 		{
 		case EM_386:
-			if (machine_type("X86"))
+			if (machine_type("X86") || machine_type("ARM"))
 				return TRUE;
 			break;
 
@@ -2756,6 +2762,11 @@ is_shared_object(char *file)
 			if (machine_type("S390"))
 				return TRUE;
 			break;
+
+		case EM_ARM:
+			if (machine_type("ARM"))
+				return TRUE;
+			break;
 		}
 
 		if (CRASHDEBUG(1))
-- 
1.5.6.5
