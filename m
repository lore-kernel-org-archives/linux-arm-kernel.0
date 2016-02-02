From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  2 Feb 2016 14:19:34 +0100
Subject: [PATCH 3/3] kallsyms: remove --page-offset command line option
In-Reply-To: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1454419174-21290-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The --page-offset command line option was only used for ARM, to filter
symbol addresses below CONFIG_PAGE_OFFSET. This is no longer needed, so
remove the functionality altogether.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/kallsyms.c | 27 ++++----------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 02473b71643b..ce36fc02fe8c 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -63,7 +63,6 @@ static unsigned int table_size, table_cnt;
 static int all_symbols = 0;
 static int absolute_percpu = 0;
 static char symbol_prefix_char = '\0';
-static unsigned long long kernel_start_addr = 0;
 static int base_relative = 0;
 
 int token_profit[0x10000];
@@ -229,9 +228,6 @@ static int symbol_valid(struct sym_entry *s)
 	char *sym_name = (char *)s->sym + 1;
 
 
-	if (s->addr < kernel_start_addr)
-		return 0;
-
 	/* skip prefix char */
 	if (symbol_prefix_char && *sym_name == symbol_prefix_char)
 		sym_name++;
@@ -742,21 +738,11 @@ static void record_relative_base(void)
 {
 	unsigned int i;
 
-	if (kernel_start_addr > 0) {
-		/*
-		 * If the kernel start address was specified, use that as
-		 * the relative base rather than going through the table,
-		 * since it should be a reasonable default, and values below
-		 * it will be ignored anyway.
-		 */
-		relative_base = kernel_start_addr;
-	} else {
-		relative_base = -1ULL;
-		for (i = 0; i < table_cnt; i++)
-			if (!symbol_absolute(&table[i]) &&
-			    table[i].addr < relative_base)
-				relative_base = table[i].addr;
-	}
+	relative_base = -1ULL;
+	for (i = 0; i < table_cnt; i++)
+		if (!symbol_absolute(&table[i]) &&
+		    table[i].addr < relative_base)
+			relative_base = table[i].addr;
 }
 
 int main(int argc, char **argv)
@@ -774,9 +760,6 @@ int main(int argc, char **argv)
 				if ((*p == '"' && *(p+2) == '"') || (*p == '\'' && *(p+2) == '\''))
 					p++;
 				symbol_prefix_char = *p;
-			} else if (strncmp(argv[i], "--page-offset=", 14) == 0) {
-				const char *p = &argv[i][14];
-				kernel_start_addr = strtoull(p, NULL, 16);
 			} else if (strcmp(argv[i], "--base-relative") == 0)
 				base_relative = 1;
 			else
-- 
2.5.0
