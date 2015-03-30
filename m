From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Mar 2015 13:49:26 +0200
Subject: [RFC PATCH 1/2] Kbuild: kallsyms: ignore veneers emitted by the ARM
 linker
In-Reply-To: <1427716167-25078-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427716167-25078-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1427716167-25078-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When linking large kernels on ARM, the linker will insert veneers
(i.e., PLT like stubs) when function symbols are out of reach for
the ordinary relative branch/branch-and-link instructions.

However, due to the fact that the kallsyms region sits in .rodata,
which is between .text and .init.text, additional veneers may be
emitted in the second pass due to the fact that the size of the
kallsyms region itself has pushed the .init.text section further
down, resulting in additional veneers to be emitted.

So ignore the veneers when generating the symbol table. Veneers
have no corresponding source code, and they will not turn up in
backtraces anyway.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/kallsyms.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index c6d33bd15b04..6668c87d599f 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -212,6 +212,12 @@ static int symbol_valid(struct sym_entry *s)
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
 	int offset = 1;
 
@@ -244,13 +250,18 @@ static int symbol_valid(struct sym_entry *s)
 	}
 
 	/* Exclude symbols which vary between passes. */
-	if (strstr((char *)s->sym + offset, "_compiled."))
-		return 0;
-
 	for (i = 0; special_symbols[i]; i++)
 		if( strcmp((char *)s->sym + offset, special_symbols[i]) == 0 )
 			return 0;
 
+	for (i = 0; special_suffixes[i]; i++) {
+		char *sym_name = (char *)s->sym + offset;
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
