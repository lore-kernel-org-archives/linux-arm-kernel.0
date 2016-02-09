From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  9 Feb 2016 10:31:02 +0100
Subject: [PATCH v3 3/3] kallsyms: remove --page-offset command line option
In-Reply-To: <1455010262-28894-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455010262-28894-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1455010262-28894-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The --page-offset command line option was only used for ARM, to filter
symbol addresses below CONFIG_PAGE_OFFSET. This is no longer needed, so
remove the functionality altogether.

Acked-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/kallsyms.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 638b143ee60f..de9b74b083c2 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -63,7 +63,6 @@ static unsigned int table_size, table_cnt;
 static int all_symbols = 0;
 static int absolute_percpu = 0;
 static char symbol_prefix_char = '\0';
-static unsigned long long kernel_start_addr = 0;
 static int base_relative = 0;
 
 int token_profit[0x10000];
@@ -228,10 +227,6 @@ static int symbol_valid(struct sym_entry *s)
 	int i;
 	char *sym_name = (char *)s->sym + 1;
 
-
-	if (s->addr < kernel_start_addr)
-		return 0;
-
 	/* skip prefix char */
 	if (symbol_prefix_char && *sym_name == symbol_prefix_char)
 		sym_name++;
@@ -765,9 +760,6 @@ int main(int argc, char **argv)
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
