From: mmayer@broadcom.com (Markus Mayer)
Date: Mon, 24 Sep 2012 15:48:05 -0700
Subject: [PATCH 1/1] Fix segfault in DTC
In-Reply-To: <1348526885-2113-1-git-send-email-mmayer@broadcom.com>
References: <1348526885-2113-1-git-send-email-mmayer@broadcom.com>
Message-ID: <1348526885-2113-2-git-send-email-mmayer@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prior to this change, an empty input file would cause a segfault, because
yylloc had never been initialized. There was never any characters for the
lexer to match, so YY_USER_ACTION was never executed before the parse error
was detected.

When the parser printed the error message, it tried to include the name of
the file, but the structure holding the file name (yylloc.file, referenced
as pos->file) had never been initialized.

Without the fix:

$ ./dtc /dev/null
DTC: dts->dts  on file "/dev/null"
Segmentation fault (core dumped)

$ gdb dtc core
Program terminated with signal 11, Segmentation fault.
    at scripts/dtc/srcpos.c:194
194			fname = pos->file->name;
(gdb) bt
    at scripts/dtc/srcpos.c:194
    fmt=0x40d769 "%s", va=0x7fffbf027148) at scripts/dtc/srcpos.c:220
    at scripts/dtc/dtc-parser.tab.c:1920
    at scripts/dtc/treesource.c:38
    at scripts/dtc/dtc.c:203
(gdb) p *pos
$1 = {first_line = 0, first_column = 0, last_line = 0, last_column = 0,
  file = 0x0}

With the fix:

$ ./dtc /dev/null
DTC: dts->dts  on file "/dev/null"
Error: /dev/null:1.1 syntax error
FATAL ERROR: Unable to parse input tree

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 scripts/dtc/treesource.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/scripts/dtc/treesource.c b/scripts/dtc/treesource.c
index c09aafa..b461b88 100644
--- a/scripts/dtc/treesource.c
+++ b/scripts/dtc/treesource.c
@@ -29,11 +29,15 @@ int treesource_error;
 
 struct boot_info *dt_from_source(const char *fname)
 {
+	extern YYLTYPE yylloc;
+
 	the_boot_info = NULL;
 	treesource_error = 0;
 
 	srcfile_push(fname);
 	yyin = current_srcfile->f;
+	/* Initialize yylloc->file to avoid segfault on empty input */
+	srcpos_update(&yylloc, NULL, 0);
 
 	if (yyparse() != 0)
 		die("Unable to parse input tree\n");
-- 
1.7.5.4
