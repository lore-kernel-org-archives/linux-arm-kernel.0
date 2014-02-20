From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Feb 2014 19:06:49 +0100
Subject: [PATCH RFC 3/5] Implement DT schema checker using hybrid approach
In-Reply-To: <1392919611-10746-1-git-send-email-t.figa@samsung.com>
References: <1392919611-10746-1-git-send-email-t.figa@samsung.com>
Message-ID: <1392919611-10746-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a proof of concept framework to implement schema checker
using a combined C and DTSS based approach.

Complex and generic bindings can be implemented directly in C and then
instantiated from simple device-specific bindings using DTS-like DTSS
language.

This is based on Stephen Warren's C based DT schema checker proof of
concept patch.

[original C based DT schema checker proof of concept]
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
[further development into hybrid solution]
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 Makefile         |   2 +-
 Makefile.dtc     |   5 +-
 checks.c         |  15 +++
 dtc.c            |  17 ++-
 dtc.h            |  26 +++++
 dtss-lexer.l     | 291 +++++++++++++++++++++++++++++++++++++++++++++++
 dtss-parser.y    | 341 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 schemas/schema.c | 311 ++++++++++++++++++++++++++++++++++++++++++++++++++
 schemas/schema.h |  89 +++++++++++++++
 srcpos.h         |   2 +
 treesource.c     |  22 ++++
 11 files changed, 1117 insertions(+), 4 deletions(-)
 create mode 100644 dtss-lexer.l
 create mode 100644 dtss-parser.y
 create mode 100644 schemas/schema.c
 create mode 100644 schemas/schema.h

diff --git a/Makefile b/Makefile
index 86f5ab3..0625fb8 100644
--- a/Makefile
+++ b/Makefile
@@ -15,7 +15,7 @@ EXTRAVERSION =
 LOCAL_VERSION =
 CONFIG_LOCALVERSION =
 
-CPPFLAGS = -I libfdt -I .
+CPPFLAGS = -I libfdt -I . -I schemas
 WARNINGS = -Werror -Wall -Wpointer-arith -Wcast-qual -Wnested-externs \
 	-Wstrict-prototypes -Wmissing-prototypes -Wredundant-decls -Wshadow
 CFLAGS = -g -Os -fPIC -Werror $(WARNINGS)
diff --git a/Makefile.dtc b/Makefile.dtc
index bece49b..bf19564 100644
--- a/Makefile.dtc
+++ b/Makefile.dtc
@@ -12,7 +12,8 @@ DTC_SRCS = \
 	livetree.c \
 	srcpos.c \
 	treesource.c \
-	util.c
+	util.c \
+	schemas/schema.c
 
-DTC_GEN_SRCS = dtc-lexer.lex.c dtc-parser.tab.c
+DTC_GEN_SRCS = dtc-lexer.lex.c dtc-parser.tab.c dtss-lexer.lex.c dtss-parser.tab.c
 DTC_OBJS = $(DTC_SRCS:%.c=%.o) $(DTC_GEN_SRCS:%.c=%.o)
diff --git a/checks.c b/checks.c
index 47eda65..7c85fcf 100644
--- a/checks.c
+++ b/checks.c
@@ -19,6 +19,7 @@
  */
 
 #include "dtc.h"
+#include "schemas/schema.h"
 
 #ifdef TRACE_CHECKS
 #define TRACE(c, ...) \
@@ -651,6 +652,18 @@ static void check_obsolete_chosen_interrupt_controller(struct check *c,
 }
 TREE_WARNING(obsolete_chosen_interrupt_controller, NULL);
 
+/*
+ * Schema checks
+ */
+
+static void check_schema(struct check *c, struct node *dt,
+				       struct node *node)
+{
+	if (schema_check_node(dt, node))
+		FAIL(c, "Schema check failed for %s", node->fullpath);
+}
+NODE_ERROR(schema, NULL);
+
 static struct check *check_table[] = {
 	&duplicate_node_names, &duplicate_property_names,
 	&node_name_chars, &node_name_format, &property_name_chars,
@@ -669,6 +682,8 @@ static struct check *check_table[] = {
 	&avoid_default_addr_size,
 	&obsolete_chosen_interrupt_controller,
 
+	&schema,
+
 	&always_fail,
 };
 
diff --git a/dtc.c b/dtc.c
index d36ccdc..1a5913b 100644
--- a/dtc.c
+++ b/dtc.c
@@ -20,6 +20,7 @@
 
 #include "dtc.h"
 #include "srcpos.h"
+#include "schemas/schema.h"
 
 /*
  * Command line options
@@ -49,7 +50,7 @@ static void fill_fullpaths(struct node *tree, const char *prefix)
 
 /* Usage related data. */
 static const char usage_synopsis[] = "dtc [options] <input file>";
-static const char usage_short_opts[] = "qI:O:o:V:d:R:S:p:fb:i:H:sW:E:hv";
+static const char usage_short_opts[] = "qI:O:o:V:d:R:S:p:fb:i:H:sW:E:x:hv";
 static struct option const usage_long_opts[] = {
 	{"quiet",            no_argument, NULL, 'q'},
 	{"in-format",         a_argument, NULL, 'I'},
@@ -67,6 +68,7 @@ static struct option const usage_long_opts[] = {
 	{"phandle",           a_argument, NULL, 'H'},
 	{"warning",           a_argument, NULL, 'W'},
 	{"error",             a_argument, NULL, 'E'},
+	{"schema",            a_argument, NULL, 'x'},
 	{"help",             no_argument, NULL, 'h'},
 	{"version",          no_argument, NULL, 'v'},
 	{NULL,               no_argument, NULL, 0x0},
@@ -97,6 +99,7 @@ static const char * const usage_opts_help[] = {
 	 "\t\tboth   - Both \"linux,phandle\" and \"phandle\" properties",
 	"\n\tEnable/disable warnings (prefix with \"no-\")",
 	"\n\tEnable/disable errors (prefix with \"no-\")",
+	"\n\tUse schema file"
 	"\n\tPrint this help and exit",
 	"\n\tPrint version and exit",
 	NULL,
@@ -105,10 +108,12 @@ static const char * const usage_opts_help[] = {
 int main(int argc, char *argv[])
 {
 	struct boot_info *bi;
+	struct boot_info *bi_schema;
 	const char *inform = "dts";
 	const char *outform = "dts";
 	const char *outname = "-";
 	const char *depname = NULL;
+	const char *schema = NULL;
 	bool force = false, sort = false;
 	const char *arg;
 	int opt;
@@ -185,6 +190,10 @@ int main(int argc, char *argv[])
 			parse_checks_option(false, true, optarg);
 			break;
 
+		case 'x':
+			schema = optarg;
+			break;
+
 		case 'h':
 			usage(NULL);
 		default:
@@ -220,6 +229,12 @@ int main(int argc, char *argv[])
 	else
 		die("Unknown input format \"%s\"\n", inform);
 
+	if (schema) {
+		bi_schema = schema_from_source(schema);
+		//dt_to_source(stdout, bi_schema);
+		build_schema_list(bi_schema);
+	}
+
 	if (depfile) {
 		fputc('\n', depfile);
 		fclose(depfile);
diff --git a/dtc.h b/dtc.h
index 9ce9d12..19d2d24 100644
--- a/dtc.h
+++ b/dtc.h
@@ -135,21 +135,43 @@ struct label {
 	struct label *next;
 };
 
+enum {
+	PROPERTY_DATA,
+	PROPERTY_USE,
+	PROPERTY_REQUIRE,
+	PROPERTY_MATCH,
+};
+
+#define PROPERTY_FLAG_OPTIONAL	(1 << 0)
+
 struct property {
 	bool deleted;
 	char *name;
 	struct data val;
+	unsigned int type;
+	unsigned int flags;
 
 	struct property *next;
 
 	struct label *labels;
 };
 
+enum {
+	NODE_DATA,
+	NODE_USE,
+	NODE_REQUIRE,
+};
+
+#define NODE_FLAG_OPTIONAL	(1 << 0)
+#define NODE_FLAG_INCOMPLETE	(1 << 1)
+
 struct node {
 	bool deleted;
 	char *name;
 	struct property *proplist;
 	struct node *children;
+	int type;
+	unsigned int flags;
 
 	struct node *parent;
 	struct node *next_sibling;
@@ -297,4 +319,8 @@ struct boot_info *dt_from_source(const char *f);
 
 struct boot_info *dt_from_fs(const char *dirname);
 
+/* Schema source */
+
+struct boot_info *schema_from_source(const char *fname);
+
 #endif /* _DTC_H */
diff --git a/dtss-lexer.l b/dtss-lexer.l
new file mode 100644
index 0000000..aee41f6
--- /dev/null
+++ b/dtss-lexer.l
@@ -0,0 +1,291 @@
+/*
+ * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+%option noyywrap nounput noinput never-interactive prefix="dtss_yy"
+
+%x INCLUDE
+%x BYTESTRING
+%x PROPNODENAME
+%s V1
+
+PROPNODECHAR	[a-zA-Z0-9,._+*$#?^@-]
+PATHCHAR	({PROPNODECHAR}|[/])
+LABEL		[a-zA-Z_][a-zA-Z0-9_]*
+STRING		\"([^\\"]|\\.)*\"
+CHAR_LITERAL	'([^']|\\')*'
+WS		[[:space:]]
+COMMENT		"/*"([^*]|\*+[^*/])*\*+"/"
+LINECOMMENT	"//".*\n
+
+%{
+#include "dtc.h"
+#include "srcpos.h"
+
+#define DTSS_YYLTYPE struct srcpos
+
+#include "dtss-parser.tab.h"
+
+DTSS_YYLTYPE dtss_yylloc;
+extern bool treesource_error;
+
+/* CAUTION: this will stop working if we ever use dtss_yyless() or dtss_yyunput() */
+#define	YY_USER_ACTION \
+	{ \
+		srcpos_update(&dtss_yylloc, dtss_yytext, dtss_yyleng); \
+	}
+
+/* #define LEXDEBUG	1 */
+
+#ifdef LEXDEBUG
+#define DPRINT(fmt, ...)	fprintf(stderr, fmt, ##__VA_ARGS__)
+#else
+#define DPRINT(fmt, ...)	do { } while (0)
+#endif
+
+static int dts_version = 1;
+
+#define BEGIN_DEFAULT()		DPRINT("<V1>\n"); \
+				BEGIN(V1); \
+
+static void push_input_file(const char *filename);
+static bool pop_input_file(void);
+static void lexical_error(const char *fmt, ...);
+%}
+
+%%
+<*>"/include/"{WS}*{STRING} {
+			char *name = strchr(dtss_yytext, '\"') + 1;
+			dtss_yytext[dtss_yyleng-1] = '\0';
+			push_input_file(name);
+		}
+
+<*>^"#"(line)?[ \t]+[0-9]+[ \t]+{STRING}([ \t]+[0-9]+)? {
+			char *line, *tmp, *fn;
+			/* skip text before line # */
+			line = dtss_yytext;
+			while (!isdigit(*line))
+				line++;
+			/* skip digits in line # */
+			tmp = line;
+			while (!isspace(*tmp))
+				tmp++;
+			/* "NULL"-terminate line # */
+			*tmp = '\0';
+			/* start of filename */
+			fn = strchr(tmp + 1, '"') + 1;
+			/* strip trailing " from filename */
+			tmp = strchr(fn, '"');
+			*tmp = 0;
+			/* -1 since #line is the number of the next line */
+			srcpos_set_line(xstrdup(fn), atoi(line) - 1);
+		}
+
+<*><<EOF>>		{
+			if (!pop_input_file()) {
+				yyterminate();
+			}
+		}
+
+<*>{STRING}	{
+			DPRINT("String: %s\n", dtss_yytext);
+			dtss_yylval.data = data_copy_escape_string(dtss_yytext+1,
+					dtss_yyleng-2);
+			return DT_STRING;
+		}
+
+<*>"/dtss-v1/"	{
+			DPRINT("Keyword: /dtss-v1/\n");
+			dts_version = 0x8001;
+			BEGIN_DEFAULT();
+			return DTSS_V1;
+		}
+
+<*>"/bits/"	{
+			DPRINT("Keyword: /bits/\n");
+			BEGIN_DEFAULT();
+			return DT_BITS;
+		}
+
+<*>"/delete-property/"	{
+			DPRINT("Keyword: /delete-property/\n");
+			DPRINT("<PROPNODENAME>\n");
+			BEGIN(PROPNODENAME);
+			return DT_DEL_PROP;
+		}
+
+<*>"/delete-node/"	{
+			DPRINT("Keyword: /delete-node/\n");
+			DPRINT("<PROPNODENAME>\n");
+			BEGIN(PROPNODENAME);
+			return DT_DEL_NODE;
+		}
+
+<*>"/match/"	{
+			DPRINT("Keyword: /match/\n");
+			return DTSS_MATCH;
+		}
+
+<*>"/require/"	{
+			DPRINT("Keyword: /require/\n");
+			return DTSS_REQUIRE;
+		}
+
+<*>"/use/"	{
+			DPRINT("Keyword: /use/\n");
+			return DTSS_USE;
+		}
+
+<*>"/incomplete/"	{
+			DPRINT("Keyword: /incomplete/\n");
+			return DTSS_INCOMPLETE;
+		}
+
+<*>"/optional/"	{
+			DPRINT("Keyword: /optional/\n");
+			return DTSS_OPTIONAL;
+		}
+
+<V1>([0-9]+|0[xX][0-9a-fA-F]+)(U|L|UL|LL|ULL)? {
+			char *e;
+			DPRINT("Integer Literal: '%s'\n", yytext);
+
+			errno = 0;
+			dtss_yylval.integer = strtoull(yytext, &e, 0);
+
+			assert(!(*e) || !e[strspn(e, "UL")]);
+
+			if (errno == ERANGE)
+				lexical_error("Integer literal '%s' out of range",
+					      yytext);
+			else
+				/* ERANGE is the only strtoull error triggerable
+				 *  by strings matching the pattern */
+				assert(errno == 0);
+			return DT_LITERAL;
+		}
+
+<*>{CHAR_LITERAL}	{
+			struct data d;
+			DPRINT("Character literal: %s\n", yytext);
+
+			d = data_copy_escape_string(yytext+1, yyleng-2);
+			if (d.len == 1) {
+				lexical_error("Empty character literal");
+				dtss_yylval.integer = 0;
+				return DT_CHAR_LITERAL;
+			}
+
+			dtss_yylval.integer = (unsigned char)d.val[0];
+
+			if (d.len > 2)
+				lexical_error("Character literal has %d"
+					      " characters instead of 1",
+					      d.len - 1);
+
+			return DT_CHAR_LITERAL;
+		}
+
+<*>\&{LABEL}	{	/* label reference */
+			DPRINT("Ref: %s\n", dtss_yytext+1);
+			dtss_yylval.labelref = xstrdup(dtss_yytext+1);
+			return DT_REF;
+		}
+
+<*>"&{/"{PATHCHAR}*\}	{	/* new-style path reference */
+			dtss_yytext[dtss_yyleng-1] = '\0';
+			DPRINT("Ref: %s\n", dtss_yytext+2);
+			dtss_yylval.labelref = xstrdup(dtss_yytext+2);
+			return DT_REF;
+		}
+
+<BYTESTRING>[0-9a-fA-F]{2} {
+			dtss_yylval.byte = strtol(dtss_yytext, NULL, 16);
+			DPRINT("Byte: %02x\n", (int)dtss_yylval.byte);
+			return DT_BYTE;
+		}
+
+<BYTESTRING>"]"	{
+			DPRINT("/BYTESTRING\n");
+			BEGIN_DEFAULT();
+			return ']';
+		}
+
+<PROPNODENAME>\\?{PROPNODECHAR}+ {
+			DPRINT("PropNodeName: %s\n", dtss_yytext);
+			dtss_yylval.propnodename = xstrdup((dtss_yytext[0] == '\\') ?
+							dtss_yytext + 1 : dtss_yytext);
+			BEGIN_DEFAULT();
+			return DT_PROPNODENAME;
+		}
+
+<*>{WS}+	/* eat whitespace */
+<*>{COMMENT}+	/* eat C-style comments */
+<*>{LINECOMMENT}+ /* eat C++-style comments */
+
+<*>.		{
+			DPRINT("Char: %c (\\x%02x)\n", dtss_yytext[0],
+				(unsigned)dtss_yytext[0]);
+			if (dtss_yytext[0] == '[') {
+				DPRINT("<BYTESTRING>\n");
+				BEGIN(BYTESTRING);
+			}
+			if ((dtss_yytext[0] == '{')
+			    || (dtss_yytext[0] == ';')) {
+				DPRINT("<PROPNODENAME>\n");
+				BEGIN(PROPNODENAME);
+			}
+			return dtss_yytext[0];
+		}
+
+%%
+
+static void push_input_file(const char *filename)
+{
+	assert(filename);
+
+	srcfile_push(filename);
+
+	dtss_yyin = current_srcfile->f;
+
+	dtss_yypush_buffer_state(dtss_yy_create_buffer(dtss_yyin, YY_BUF_SIZE));
+}
+
+
+static bool pop_input_file(void)
+{
+	if (srcfile_pop() == 0)
+		return false;
+
+	dtss_yypop_buffer_state();
+	dtss_yyin = current_srcfile->f;
+
+	return true;
+}
+
+static void lexical_error(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	srcpos_verror(&dtss_yylloc, "Lexical error", fmt, ap);
+	va_end(ap);
+
+	treesource_error = true;
+}
diff --git a/dtss-parser.y b/dtss-parser.y
new file mode 100644
index 0000000..1c807da
--- /dev/null
+++ b/dtss-parser.y
@@ -0,0 +1,341 @@
+/*
+ * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+%define api.prefix dtss_yy
+
+%{
+#include <stdio.h>
+
+#include "dtc.h"
+#include "srcpos.h"
+
+#define DTSS_YYLTYPE struct srcpos
+
+extern int dtss_yylex(void);
+extern void dtss_yyerror(char const *s);
+#define ERROR(loc, ...) \
+	do { \
+		srcpos_error((loc), "Error", __VA_ARGS__); \
+		treesource_error = true; \
+	} while (0)
+
+extern struct boot_info *the_boot_info;
+extern bool treesource_error;
+%}
+
+%union {
+	char *propnodename;
+	char *labelref;
+	unsigned int cbase;
+	uint8_t byte;
+	struct data data;
+
+	struct {
+		struct data	data;
+		int		bits;
+	} array;
+
+	struct property *prop;
+	struct property *proplist;
+	struct node *node;
+	struct node *nodelist;
+	struct reserve_info *re;
+	uint64_t integer;
+}
+
+%token DTSS_V1
+%token DT_BITS
+%token DT_DEL_PROP
+%token DT_DEL_NODE
+%token DTSS_INCOMPLETE
+%token DTSS_MATCH
+%token DTSS_USE
+%token DTSS_REQUIRE
+%token DTSS_OPTIONAL
+%token <propnodename> DT_PROPNODENAME
+%token <integer> DT_LITERAL
+%token <integer> DT_CHAR_LITERAL
+%token <cbase> DT_BASE
+%token <byte> DT_BYTE
+%token <data> DT_STRING
+%token <data> DTSS_TYPESPEC
+%token <labelref> DT_LABEL
+%token <labelref> DT_REF
+%token DT_INCBIN
+
+%type <data> propdata
+%type <data> propdataprefix
+%type <array> arrayprefix
+%type <data> bytestring
+%type <prop> propdef
+%type <proplist> proplist
+
+%type <node> schema
+%type <node> schemaroot
+%type <node> nodedef
+%type <node> subnode
+%type <nodelist> subnodes
+
+%type <integer> integer_prim
+
+%%
+
+sourcefile:
+	  DTSS_V1 ';' schema
+		{
+			the_boot_info = build_boot_info(NULL, $3, 0);
+		}
+	;
+
+schemaroot:
+	subnodes
+		{
+			$$ = build_node(NULL, $1);
+		}
+	;
+
+schema:
+	schemaroot
+		{
+			$$ = name_node($1, "/");
+		}
+	;
+
+nodedef:
+	  '{' proplist subnodes '}' ';'
+		{
+			$$ = build_node($2, $3);
+		}
+	;
+
+proplist:
+	  /* empty */
+		{
+			$$ = NULL;
+		}
+	| proplist propdef
+		{
+			$$ = chain_property($2, $1);
+		}
+	;
+
+propdef:
+	  DT_PROPNODENAME '=' propdata ';'
+		{
+			$$ = build_property($1, $3);
+		}
+	| DT_PROPNODENAME ';'
+		{
+			$$ = build_property($1, empty_data);
+		}
+	| DT_DEL_PROP DT_PROPNODENAME ';'
+		{
+			$$ = build_property_delete($2);
+		}
+	| DTSS_MATCH propdef
+		{
+			$2->type = PROPERTY_MATCH;
+			$$ = $2;
+		}
+	| DTSS_USE propdef
+		{
+			$2->type = PROPERTY_USE;
+			$$ = $2;
+		}
+	| DTSS_REQUIRE propdef
+		{
+			$2->type = PROPERTY_REQUIRE;
+			$$ = $2;
+		}
+	| DTSS_OPTIONAL propdef
+		{
+			$2->flags |= PROPERTY_FLAG_OPTIONAL;
+			$$ = $2;
+		}
+	;
+
+propdata:
+	  propdataprefix DT_STRING
+		{
+			$$ = data_merge($1, $2);
+		}
+	| propdataprefix arrayprefix '>'
+		{
+			$$ = data_merge($1, $2.data);
+		}
+	| propdataprefix '[' bytestring ']'
+		{
+			$$ = data_merge($1, $3);
+		}
+	| propdataprefix DT_INCBIN '(' DT_STRING ',' integer_prim ',' integer_prim ')'
+		{
+			FILE *f = srcfile_relative_open($4.val, NULL);
+			struct data d;
+
+			if ($6 != 0)
+				if (fseek(f, $6, SEEK_SET) != 0)
+					die("Couldn't seek to offset %llu in \"%s\": %s",
+					    (unsigned long long)$6, $4.val,
+					    strerror(errno));
+
+			d = data_copy_file(f, $8);
+
+			$$ = data_merge($1, d);
+			fclose(f);
+		}
+	| propdataprefix DT_INCBIN '(' DT_STRING ')'
+		{
+			FILE *f = srcfile_relative_open($4.val, NULL);
+			struct data d = empty_data;
+
+			d = data_copy_file(f, -1);
+
+			$$ = data_merge($1, d);
+			fclose(f);
+		}
+	;
+
+propdataprefix:
+	  /* empty */
+		{
+			$$ = empty_data;
+		}
+	| propdata ','
+		{
+			$$ = $1;
+		}
+	| propdataprefix DT_LABEL
+		{
+			$$ = data_add_marker($1, LABEL, $2);
+		}
+	;
+
+arrayprefix:
+	DT_BITS DT_LITERAL '<'
+		{
+			unsigned long long bits;
+
+			bits = $2;
+
+			if ((bits !=  8) && (bits != 16) &&
+			    (bits != 32) && (bits != 64)) {
+				ERROR(&@2, "Array elements must be"
+				      " 8, 16, 32 or 64-bits");
+				bits = 32;
+			}
+
+			$$.data = empty_data;
+			$$.bits = bits;
+		}
+	| '<'
+		{
+			$$.data = empty_data;
+			$$.bits = 32;
+		}
+	| arrayprefix integer_prim
+		{
+			if ($1.bits < 64) {
+				uint64_t mask = (1ULL << $1.bits) - 1;
+				/*
+				 * Bits above mask must either be all zero
+				 * (positive within range of mask) or all one
+				 * (negative and sign-extended). The second
+				 * condition is true if when we set all bits
+				 * within the mask to one (i.e. | in the
+				 * mask), all bits are one.
+				 */
+				if (($2 > mask) && (($2 | mask) != -1ULL))
+					ERROR(&@2, "Value out of range for"
+					      " %d-bit array element", $1.bits);
+			}
+
+			$$.data = data_append_integer($1.data, $2, $1.bits);
+		}
+	;
+
+integer_prim:
+	  DT_LITERAL
+	| DT_CHAR_LITERAL
+	;
+
+bytestring:
+	  /* empty */
+		{
+			$$ = empty_data;
+		}
+	| bytestring DT_BYTE
+		{
+			$$ = data_append_byte($1, $2);
+		}
+	;
+
+subnodes:
+	  /* empty */
+		{
+			$$ = NULL;
+		}
+	| subnode subnodes
+		{
+			$$ = chain_node($1, $2);
+		}
+	| subnode propdef
+		{
+			ERROR(&@2, "Properties must precede subnodes");
+			YYERROR;
+		}
+	;
+
+subnode:
+	  DT_PROPNODENAME nodedef
+		{
+			$$ = name_node($2, $1);
+		}
+	| DT_DEL_NODE DT_PROPNODENAME ';'
+		{
+			$$ = name_node(build_node_delete(), $2);
+		}
+	| DTSS_USE subnode
+		{
+			$2->type = NODE_USE;
+			$$ = $2;
+		}
+	| DTSS_REQUIRE subnode
+		{
+			$2->type = NODE_REQUIRE;
+			$$ = $2;
+		}
+	| DTSS_OPTIONAL subnode
+		{
+			$2->flags |= NODE_FLAG_OPTIONAL;
+			$$ = $2;
+		}
+	| DTSS_INCOMPLETE subnode
+		{
+			$2->flags |= NODE_FLAG_INCOMPLETE;
+			$$ = $2;
+		}
+	;
+
+%%
+
+void dtss_yyerror(char const *s)
+{
+	ERROR(&yylloc, "%s", s);
+}
diff --git a/schemas/schema.c b/schemas/schema.c
new file mode 100644
index 0000000..e5258cf
--- /dev/null
+++ b/schemas/schema.c
@@ -0,0 +1,311 @@
+/*
+ * Copyright (C) 2013 Stephen Warren <swarren@wwwdotorg.org>
+ *
+ * Copyright (C) 2014 Samsung Electronics Co., Ltd.
+ *	Tomasz Figa <t.figa@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+#include "schema.h"
+
+static struct schema_checker schema_list = {
+	.next = &schema_list,
+};
+
+int schema_check_node(struct node *root, struct node *node)
+{
+	const struct schema_checker *checker;
+	int match;
+	int checked = 0;
+
+	checker = schema_list.next;
+	for (; checker != &schema_list; checker = checker->next) {
+		match = checker->matchfn(node, checker);
+		if (!match)
+			continue;
+
+		pr_info("Node %s matches checker %s at level %d\n",
+			node->fullpath, checker->name, match);
+
+		checker->checkfn(root, node, checker);
+		checked = 1;
+	}
+
+	/*
+	 * FIXME: this is too noisy right now. Make it optional until schemas
+	 * for most bindings are implemented.
+	 */
+	if (!checked) {
+		pr_warn("no schema for node %s\n", node->fullpath);
+		return 0;
+	}
+
+	/*
+	 * FIXME: grab validation state from global somewhere.
+	 * Using global state avoids having check return values after every
+	 * function call, thus making the code less verbose and appear more
+	 * assertion-based.
+	 */
+	return 0;
+}
+
+int schema_match_path(struct node *node, const struct schema_checker *checker)
+{
+	return !strcmp(node->fullpath, checker->u.path.path);
+}
+
+int schema_match_compatible(struct node *node,
+				const struct schema_checker *checker)
+{
+	struct property *compat_prop;
+	int index;
+	const char *node_compat;
+	const char **test_compats;
+
+	compat_prop = get_property(node, "compatible");
+	if (!compat_prop)
+		return 0;
+
+	/*
+	 * Match with any compatible value of schema with any compatible
+	 * value of node being verified.
+	 */
+	for (node_compat = compat_prop->val.val, index = 0;
+			*node_compat;
+			node_compat += strlen(node_compat) + 1, index++) {
+		for (test_compats = checker->u.compatible.compats;
+				*test_compats; test_compats++) {
+			if (!strcmp(node_compat, *test_compats))
+				return 1;
+		}
+	}
+
+	return 0;
+}
+
+struct property *schema_get_param(struct node *params, const char *name)
+{
+	if (!params)
+		return NULL;
+
+	return get_property(params, name);
+}
+
+int schema_get_param_cell(struct node *params, const char *name, cell_t *val)
+{
+	struct property *prop;
+
+	prop = schema_get_param(params, name);
+	if (!prop)
+		return -ENOENT;
+
+	if (!prop->val.len)
+		return -EINVAL;
+
+	*val = propval_cell(prop);
+	return 0;
+}
+
+struct property *require_property(struct node *node, const char *name)
+{
+	struct property *prop;
+
+	prop = get_property(node, name);
+	if (!prop) {
+		/*
+		 * FIXME: set global error state. The same comment applies
+		 * everywhere.
+		 */
+		pr_err("node '%s' missing '%s' property\n",
+			node->fullpath, name);
+	}
+
+	return prop;
+}
+
+static void check_required_property(struct node *node, struct property *schema)
+{
+	struct property *prop;
+
+	prop = require_property(node, schema->name);
+	if (!prop)
+		return;
+
+	if (schema->val.len
+	    && (schema->val.len != prop->val.len
+	    || memcmp(schema->val.val, prop->val.val, prop->val.len)))
+		pr_err("node %s with wrong constant value of property %s\n",
+			node->fullpath, schema->name);
+}
+
+static void check_optional_property(struct node *node, struct property *schema)
+{
+	struct property *prop;
+
+	prop = get_property(node, schema->name);
+	if (!prop)
+		return;
+
+	check_required_property(node, schema);
+}
+
+/*
+ * FIXME: Use a more generic solution, which does not rely on linker
+ * specific features.
+ */
+extern const struct generic_schema __start_generic_schemas;
+extern const struct generic_schema __stop_generic_schemas;
+
+static void check_generic_schema(struct node *root, struct node *node,
+					const char *name,
+					struct node *schema_node,
+					bool required)
+{
+	const struct generic_schema *gs;
+	int i;
+	bool checked = false;
+	unsigned int count = &__stop_generic_schemas - &__start_generic_schemas;
+
+	pr_info("running schema \"%s\"\n", name);
+
+	gs = &__start_generic_schemas;
+	for (i = 0; i < count; ++i, ++gs) {
+		if (strcmp(gs->name, name))
+			continue;
+
+		gs->checkfn(gs, root, node, schema_node, required);
+
+		checked = true;
+	}
+
+	if (!checked)
+		pr_err("schema \"%s\" not found\n", name);
+}
+
+static void check_dtss_schema(struct node *root, struct node *node,
+			      const struct schema_checker *checker)
+{
+	struct property *prop_schema;
+	struct node *schema = checker->node, *node_schema;
+
+	for_each_property(schema, prop_schema) {
+		if (!strcmp(prop_schema->name, "compatible")
+		    || !strcmp(prop_schema->name, "device_type"))
+			continue;
+
+		switch (prop_schema->type) {
+		case PROPERTY_DATA:
+			if (prop_schema->flags & PROPERTY_FLAG_OPTIONAL)
+				check_optional_property(node, prop_schema);
+			else
+				check_required_property(node, prop_schema);
+			break;
+
+		case PROPERTY_REQUIRE:
+			check_generic_schema(root, node, prop_schema->name,
+						NULL, true);
+			break;
+
+		case PROPERTY_USE:
+			check_generic_schema(root, node, prop_schema->name,
+						NULL, false);
+			break;
+		}
+	}
+
+	for_each_child(schema, node_schema) {
+		switch (node_schema->type) {
+		case NODE_DATA:
+			/* TODO: verify subnodes */
+			break;
+
+		case NODE_REQUIRE:
+			check_generic_schema(root, node, node_schema->name,
+						node_schema, true);
+			break;
+
+		case NODE_USE:
+			check_generic_schema(root, node, node_schema->name,
+						node_schema, false);
+			break;
+		}
+	}
+
+	/* TODO: detect unknown properties */
+}
+
+void build_schema_list(struct boot_info *schema_tree)
+{
+	struct node *root, *schema;
+
+	root = get_node_by_path(schema_tree->dt, "/");
+	if (!root) {
+		pr_err("schema file missing / node\n");
+		return;
+	}
+
+	for_each_child(root, schema) {
+		struct schema_checker *sc = xmalloc(sizeof(*sc));
+		struct property *prop;
+
+		sc->node = schema;
+		sc->checkfn = check_dtss_schema;
+		sc->name = schema->name;
+
+		for_each_property(schema, prop)
+			if (prop->type == PROPERTY_MATCH)
+				goto found_match;
+
+		pr_err("schema '%s' without matching key\n", sc->name);
+		free(sc);
+		continue;
+
+found_match:
+		if (!strcmp(prop->name, "compatible")) {
+			int count;
+			const char **compats;
+			const char *compat;
+
+			count = propval_string_count(schema, prop) + 1;
+			compats = xmalloc(count * sizeof(*compats));
+
+			sc->u.compatible.compats = compats;
+
+			while ((compat = propval_next_string(prop, compat))) {
+				*compats = compat;
+				++compats;
+			}
+			*compats = NULL;
+
+			sc->matchfn = schema_match_compatible;
+			sc->next = schema_list.next;
+			schema_list.next = sc;
+		} else if (!strcmp(prop->name, "device_type")) {
+			sc->u.type.type = propval_next_string(prop, NULL);
+			sc->next = schema_list.next;
+			schema_list.next = sc;
+		} else if (!strcmp(prop->name, "path")) {
+			sc->u.path.path = propval_next_string(prop, NULL);
+			sc->matchfn = schema_match_path;
+			sc->next = schema_list.next;
+			schema_list.next = sc;
+		} else {
+			pr_err("wrong schema key type\n");
+			free(sc);
+		}
+	}
+}
diff --git a/schemas/schema.h b/schemas/schema.h
new file mode 100644
index 0000000..9972a17
--- /dev/null
+++ b/schemas/schema.h
@@ -0,0 +1,89 @@
+#ifndef _SCHEMAS_SCHEMA_H
+#define _SCHEMAS_SCHEMA_H
+
+#include "dtc.h"
+
+struct schema_checker;
+
+typedef int (schema_matcher_func)(struct node *node,
+					const struct schema_checker *checker);
+typedef void (schema_checker_func)(struct node *root, struct node *node,
+					const struct schema_checker *checker);
+
+struct schema_checker {
+	const char *name;
+	schema_matcher_func *matchfn;
+	schema_checker_func *checkfn;
+	struct node *node;
+	union {
+		struct {
+			const char *path;
+		} path;
+		struct {
+			const char **compats;
+		} compatible;
+		struct {
+			const char *type;
+		} type;
+	} u;
+	struct schema_checker *next;
+};
+
+int schema_check_node(struct node *root, struct node *node);
+
+int schema_match_path(struct node *node, const struct schema_checker *checker);
+int schema_match_compatible(struct node *node,
+				const struct schema_checker *checker);
+
+#define SCHEMA_MATCH_PATH(_name_, _path_) \
+	struct schema_checker schema_checker_##_name_ = { \
+		.name = #_name_, \
+		.matchfn = schema_match_path, \
+		.checkfn = checkfn_##_name_, \
+		.u.path.path = _path_, \
+	};
+
+#define SCHEMA_MATCH_COMPATIBLE(_name_) \
+	struct schema_checker schema_checker_##_name_ = { \
+		.name = #_name_, \
+		.matchfn = schema_match_compatible, \
+		.checkfn = checkfn_##_name_, \
+		.u.compatible.compats = compats_##_name_, \
+	};
+
+struct generic_schema;
+
+typedef void (generic_schema_checker_func)(const struct generic_schema *schema,
+					   struct node *root, struct node *node,
+					   struct node *params, bool required);
+
+struct generic_schema {
+	const char *name;
+	generic_schema_checker_func *checkfn;
+};
+
+#define __used		__attribute__((__used__))
+#define __section(S)	__attribute__ ((__section__(#S)))
+
+#define GENERIC_SCHEMA(_dt_name_, _name_)				\
+	static const struct generic_schema generic_schema_##_name_	\
+		__used __section(generic_schemas) = {			\
+			.name = _dt_name_,				\
+			.checkfn = generic_checkfn_##_name_,		\
+	};
+
+struct property *require_property(struct node *node, const char *propname);
+struct property *schema_get_param(struct node *params, const char *name);
+int schema_get_param_cell(struct node *params, const char *name, cell_t *val);
+
+void build_schema_list(struct boot_info *schema_tree);
+
+#define schema_err(s,fmt,args...)	pr_err("%s: " fmt, (s)->name, ##args)
+#define schema_warn(s,fmt,args...)	pr_warn("%s: " fmt, (s)->name, ##args)
+#define schema_info(s,fmt,args...)	pr_info("%s: " fmt, (s)->name, ##args)
+
+#define node_err(n,fmt,args...)		pr_err("%s: " fmt, (n)->fullpath, ##args)
+#define node_warn(n,fmt,args...)	pr_warn("%s: " fmt, (n)->fullpath, ##args)
+#define node_info(n,fmt,args...)	pr_info("%s: " fmt, (n)->fullpath, ##args)
+
+#endif
diff --git a/srcpos.h b/srcpos.h
index f81827b..b761522 100644
--- a/srcpos.h
+++ b/srcpos.h
@@ -75,7 +75,9 @@ struct srcpos {
     struct srcfile_state *file;
 };
 
+#ifndef YYLTYPE
 #define YYLTYPE struct srcpos
+#endif
 
 #define YYLLOC_DEFAULT(Current, Rhs, N)						\
 	do {									\
diff --git a/treesource.c b/treesource.c
index bf7a626..e50285c 100644
--- a/treesource.c
+++ b/treesource.c
@@ -25,6 +25,10 @@ extern FILE *yyin;
 extern int yyparse(void);
 extern YYLTYPE yylloc;
 
+extern FILE *dtss_yyin;
+extern int dtss_yyparse(void);
+extern YYLTYPE dtss_yylloc;
+
 struct boot_info *the_boot_info;
 bool treesource_error;
 
@@ -46,6 +50,24 @@ struct boot_info *dt_from_source(const char *fname)
 	return the_boot_info;
 }
 
+struct boot_info *schema_from_source(const char *fname)
+{
+	the_boot_info = NULL;
+	treesource_error = false;
+
+	srcfile_push(fname);
+	dtss_yyin = current_srcfile->f;
+	dtss_yylloc.file = current_srcfile;
+
+	if (dtss_yyparse() != 0)
+		die("Unable to parse input tree\n");
+
+	if (treesource_error)
+		die("Syntax error parsing input tree\n");
+
+	return the_boot_info;
+}
+
 static void write_prefix(FILE *f, int level)
 {
 	int i;
-- 
1.8.5.2
