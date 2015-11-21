From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Nov 2015 17:23:15 -0800
Subject: [RFC/PATCH 1/3] scripts: Allow recordmcount to be used without
 tracing enabled
In-Reply-To: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1448068997-26631-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the next patch we're going to modify recordmcount to also
record locations of calls to __aeabi_{u}idiv(). Lay the
groundwork for this by adding a flag to recordmcount that
indicates if we're expected to find calls to mcount or not.

Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: M?ns Rullg?rd <mans@mansr.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 kernel/trace/Kconfig    |  4 ++++
 scripts/Makefile.build  | 15 +++++----------
 scripts/recordmcount.c  | 10 +++++++---
 scripts/recordmcount.h  |  2 +-
 scripts/recordmcount.pl | 11 ++++++++---
 5 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 8d6363f42169..578b666ed7d9 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -57,6 +57,10 @@ config HAVE_C_RECORDMCOUNT
 	help
 	  C version of recordmcount available?
 
+config RUN_RECORDMCOUNT
+	def_bool y
+	depends on DYNAMIC_FTRACE && HAVE_FTRACE_MCOUNT_RECORD
+
 config TRACER_MAX_TRACE
 	bool
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 01df30af4d4a..22f2eb10d434 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -210,7 +210,7 @@ cmd_modversions =								\
 	fi;
 endif
 
-ifdef CONFIG_FTRACE_MCOUNT_RECORD
+ifdef CONFIG_RUN_RECORDMCOUNT
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
   RECORDMCOUNT_FLAGS = -w
@@ -219,26 +219,21 @@ endif
 # The empty.o file is created in the make process in order to determine
 #  the target endianness and word size. It is made before all other C
 #  files, including recordmcount.
-sub_cmd_record_mcount =					\
+cmd_record_mcount =					\
 	if [ $(@) != "scripts/mod/empty.o" ]; then	\
-		$(objtree)/scripts/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
+		$(objtree)/scripts/recordmcount $(RECORDMCOUNT_FLAGS) $(if $(findstring $(CC_FLAGS_FTRACE),$(_c_flags)),-t,) "$(@)";	\
 	fi;
 recordmcount_source := $(srctree)/scripts/recordmcount.c \
 		    $(srctree)/scripts/recordmcount.h
 else
-sub_cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
+cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
 	"$(LD)" "$(NM)" "$(RM)" "$(MV)" \
-	"$(if $(part-of-module),1,0)" "$(@)";
+	"$(if $(part-of-module),1,0)" "$(if $(findstring $(CC_FLAGS_FTRACE),$(_c_flags)),1,0)" "$(@)";
 recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif
-cmd_record_mcount =						\
-	if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =	\
-	     "$(CC_FLAGS_FTRACE)" ]; then			\
-		$(sub_cmd_record_mcount)			\
-	fi;
 endif
 
 define rule_cc_o_c
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 698768bdc581..b6b4a5df647a 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -54,6 +54,7 @@ static struct stat sb;	/* Remember .st_size, etc. */
 static jmp_buf jmpenv;	/* setjmp/longjmp per-file error escape */
 static const char *altmcount;	/* alternate mcount symbol name */
 static int warn_on_notrace_sect; /* warn when section has mcount not being recorded */
+static int trace_mcount; /* Record mcount callers */
 
 /* setjmp() return values */
 enum {
@@ -453,19 +454,22 @@ main(int argc, char *argv[])
 	int c;
 	int i;
 
-	while ((c = getopt(argc, argv, "w")) >= 0) {
+	while ((c = getopt(argc, argv, "wt")) >= 0) {
 		switch (c) {
 		case 'w':
 			warn_on_notrace_sect = 1;
 			break;
+		case 't':
+			trace_mcount = 1;
+			break;
 		default:
-			fprintf(stderr, "usage: recordmcount [-w] file.o...\n");
+			fprintf(stderr, "usage: recordmcount [-wt] file.o...\n");
 			return 0;
 		}
 	}
 
 	if ((argc - optind) < 1) {
-		fprintf(stderr, "usage: recordmcount [-w] file.o...\n");
+		fprintf(stderr, "usage: recordmcount [-wt] file.o...\n");
 		return 0;
 	}
 
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index b9897e2be404..6e196dba748d 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -323,7 +323,7 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 	get_sym_str_and_relp(relhdr, ehdr, &sym0, &str0, &relp);
 
 	for (t = nrel; t; --t) {
-		if (!mcountsym)
+		if (trace_mcount && !mcountsym)
 			mcountsym = get_mcountsym(sym0, relp, str0);
 
 		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 826470d7f000..cff3040ddbdc 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -113,20 +113,25 @@ $P =~ s@.*/@@g;
 
 my $V = '0.1';
 
-if ($#ARGV != 11) {
-	print "usage: $P arch endian bits objdump objcopy cc ld nm rm mv is_module inputfile\n";
+if ($#ARGV != 12) {
+	print "usage: $P arch endian bits objdump objcopy cc ld nm rm mv is_module is_traced inputfile\n";
 	print "version: $V\n";
 	exit(1);
 }
 
 my ($arch, $endian, $bits, $objdump, $objcopy, $cc,
-    $ld, $nm, $rm, $mv, $is_module, $inputfile) = @ARGV;
+    $ld, $nm, $rm, $mv, $is_module, $is_traced, $inputfile) = @ARGV;
 
 # This file refers to mcount and shouldn't be ftraced, so lets' ignore it
 if ($inputfile =~ m,kernel/trace/ftrace\.o$,) {
     exit(0);
 }
 
+# We only trace mcount calls
+if ($is_traced eq "0") {
+    exit(0);
+}
+
 # Acceptable sections to record.
 my %text_sections = (
      ".text" => 1,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
