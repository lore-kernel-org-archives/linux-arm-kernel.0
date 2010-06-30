From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Wed, 30 Jun 2010 13:09:10 +0300
Subject: [PATCH 2/4] crash: add support for ARM kernel image
In-Reply-To: <cover.1277891104.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1277891104.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <55d51316a7423a6da6ce952744933f9d8e532b7c.1277891104.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM kernel image is slightly different than the currently supported images so
implement necessary support for it.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 kernel.c            |    2 +-
 lkcd_vmdump_v2_v3.h |    4 ++--
 symbols.c           |    8 +++++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel.c b/kernel.c
index 5fc27d3..c24f7a4 100644
--- a/kernel.c
+++ b/kernel.c
@@ -736,7 +736,7 @@ verify_version(void)
 
 	if (!(sp = symbol_search("linux_banner")))
 		error(FATAL, "linux_banner symbol does not exist?\n");
-	else if ((sp->type == 'R') || (sp->type == 'r'))
+	else if ((sp->type == 'R') || (sp->type == 'r') || (sp->type == 'T'))
 		linux_banner = symbol_value("linux_banner");
 	else
 		get_symbol_data("linux_banner", sizeof(ulong), &linux_banner);
diff --git a/lkcd_vmdump_v2_v3.h b/lkcd_vmdump_v2_v3.h
index 006b0b6..afdcc53 100644
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
index e92de1a..a6c0449 100644
--- a/symbols.c
+++ b/symbols.c
@@ -490,7 +490,8 @@ get_text_init_space(void)
 		return;
 
 	if (((section = get_kernel_section(".text.init")) == NULL) &&
-	    ((section = get_kernel_section(".init.text")) == NULL)) {
+	    ((section = get_kernel_section(".init.text")) == NULL) &&
+	    ((section = get_kernel_section(".init")) == NULL)) {
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
-- 
1.5.6.5
