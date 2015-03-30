From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Mar 2015 15:20:31 +0200
Subject: [PATCH 1/2] Kbuild: kallsyms: ignore veneers emitted by the ARM linker
In-Reply-To: <1427721632-11665-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427721632-11665-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1427721632-11665-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When linking large kernels on ARM, the linker will insert veneers
(i.e., PLT like stubs) when function symbols are out of reach for
the ordinary relative branch/branch-and-link instructions.

However, due to the fact that the kallsyms region sits in .rodata,
which is between .text and .init.text, additional veneers may be
emitted in the second pass due to the fact that the size of the
kallsyms region itself has pushed the .init.text section further
apart, requiring even more veneers.

So ignore the veneers when generating the symbol table. Veneers
have no corresponding source code, and they will not turn up in
backtraces anyway.

This patch also lightly refactors the symbol_valid() function
to use a local 'sym_name' rather than the obfuscated 'sym + 1'
and 'sym + offset'

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/kallsyms.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index c6d33bd15b04..f4b016782f0d 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -212,15 +212,23 @@ static int symbol_valid(struct sym_entry *s)
 		"_SDA_BASE_",		/* ppc */
 		"_SDA2_BASE_",		/* ppc */
 		NULL };
+
+	static char *special_suffixes[] = {
+		"_compiled.",		/* gcc < 3.0: "gcc[0-9]_compiled." */
+		"_veneer",		/* arm */
+		NULL };
+
 	int i;
-	int offset = 1;
+	char *sym_name = (char *)s->sym + 1;
+
 
 	if (s->addr < kernel_start_addr)
 		return 0;
 
 	/* skip prefix char */
-	if (symbol_prefix_char && *(s->sym + 1) == symbol_prefix_char)
-		offset++;
+	if (symbol_prefix_char && *sym_name == symbol_prefix_char)
+		sym_name++;
+
 
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
@@ -235,22 +243,26 @@ static int symbol_valid(struct sym_entry *s)
 		 * rules.
 		 */
 		if ((s->addr == text_range_text->end &&
-				strcmp((char *)s->sym + offset,
+				strcmp(sym_name,
 				       text_range_text->end_sym)) ||
 		    (s->addr == text_range_inittext->end &&
-				strcmp((char *)s->sym + offset,
+				strcmp(sym_name,
 				       text_range_inittext->end_sym)))
 			return 0;
 	}
 
 	/* Exclude symbols which vary between passes. */
-	if (strstr((char *)s->sym + offset, "_compiled."))
-		return 0;
-
 	for (i = 0; special_symbols[i]; i++)
-		if( strcmp((char *)s->sym + offset, special_symbols[i]) == 0 )
+		if (strcmp(sym_name, special_symbols[i]) == 0)
 			return 0;
 
+	for (i = 0; special_suffixes[i]; i++) {
+		int l = strlen(sym_name) - strlen(special_suffixes[i]);
+
+		if (l >= 0 && strcmp(sym_name + l, special_suffixes[i]) == 0)
+			return 0;
+	}
+
 	return 1;
 }
 
-- 
1.8.3.2
