From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Jun 2013 16:01:43 +0200
Subject: scripts/kallsyms: Avoid ARM veneer symbols
Message-ID: <2983817.Xe2505Drlj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building ARM kernels that exceed a certain size, the linker
will add "veneers" that allow long branches. Unfortunately,
using a longer kallsyms section may lead to the extra veneers
being needed, which leads to inconsistent kallsyms data with the
message

Inconsistent kallsyms data
Try make KALLSYMS_EXTRA_PASS=1 as a workaround

In some case, not just one but up to three extra passes were
needed before getting to a state that needed no extra veneers.
The easiest solution is to skip veneers in kallsyms in the
same way we already skip a couple of other symbols.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 487ac6f..53ec0bb 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -69,14 +69,32 @@ static void usage(void)
 	exit(1);
 }
 
-/*
- * This ignores the intensely annoying "mapping symbols" found
- * in ARM ELF files: $a, $t and $d.
- */
 static inline int is_arm_mapping_symbol(const char *str)
 {
-	return str[0] == '$' && strchr("atd", str[1])
-	       && (str[2] == '\0' || str[2] == '.');
+	size_t len;
+
+	/*
+	 * This ignores the intensely annoying "mapping symbols" found
+	 * in ARM ELF files: $a, $t and $d.
+	 */
+	if (str[0] == '$' && strchr("atd", str[1])
+	       && (str[2] == '\0' || str[2] == '.'))
+		return 1;
+
+	len = strlen(str);
+	if (len < 10)
+		return 0;
+
+	/*
+	 * This ignores any __.*_veneer symbol, which get
+	 * inserted for large kernels, in order to avoid
+	 * inconsistent data.
+	 */
+	if (str[0] == '_' && str[1] == '_' &&
+	    strcmp(str + len - 7, "_veneer") == 0)
+		return 1; 
+
+	return 0;
 }
 
 static int read_symbol_tr(const char *sym, unsigned long long addr)
