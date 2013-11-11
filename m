From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 11 Nov 2013 20:29:20 +0000
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
Message-ID: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consumers of the Linux kernel's build products are beginning to hardcode
the filenames of the dtbs generated.  Since the dtb filenames are
currently the dts filename s/dts/dtb/, this prevents the kernel
community from renaming dts files as needed.

Let's provide a consistent naming structure for consumers to script
against.  Or at least, as consistent as the dts properties themselves.

With this patch, adding the '-L' option to the dtc commandline will
cause dtc to create a symlink to the generated dtb, using the board
compatible string as the filename, eg:

  globalscale,mirabox.dtb -> armada-370-mirabox.dtb

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
All,

I'm sending this RFC to see if this is how we want to go about this.  If it's
acceptable, I'll resend to the dtc maintainers

thx,

Jason.

 dtc.c      | 12 ++++++++++--
 dtc.h      |  1 +
 flattree.c | 30 ++++++++++++++++++++++++++++++
 srcpos.c   | 20 ++++++++++++++++++--
 srcpos.h   |  2 ++
 5 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/dtc.c b/dtc.c
index e3c96536fd9d..cb2bb1b7ce1f 100644
--- a/dtc.c
+++ b/dtc.c
@@ -49,7 +49,7 @@ static void fill_fullpaths(struct node *tree, const char *prefix)
 
 /* Usage related data. */
 static const char usage_synopsis[] = "dtc [options] <input file>";
-static const char usage_short_opts[] = "qI:O:o:V:d:R:S:p:fb:i:H:sW:E:hv";
+static const char usage_short_opts[] = "qI:O:o:V:d:R:S:p:fb:i:H:sW:E:Lhv";
 static struct option const usage_long_opts[] = {
 	{"quiet",            no_argument, NULL, 'q'},
 	{"in-format",         a_argument, NULL, 'I'},
@@ -67,6 +67,7 @@ static struct option const usage_long_opts[] = {
 	{"phandle",           a_argument, NULL, 'H'},
 	{"warning",           a_argument, NULL, 'W'},
 	{"error",             a_argument, NULL, 'E'},
+	{"sym-link",         no_argument, NULL, 'L'},
 	{"help",             no_argument, NULL, 'h'},
 	{"version",          no_argument, NULL, 'v'},
 	{NULL,               no_argument, NULL, 0x0},
@@ -97,6 +98,7 @@ static const char * const usage_opts_help[] = {
 	 "\t\tboth   - Both \"linux,phandle\" and \"phandle\" properties",
 	"\n\tEnable/disable warnings (prefix with \"no-\")",
 	"\n\tEnable/disable errors (prefix with \"no-\")",
+	"\n\tCreate a symlink to the dtb named by board compatible string",
 	"\n\tPrint this help and exit",
 	"\n\tPrint version and exit",
 	NULL,
@@ -109,7 +111,7 @@ int main(int argc, char *argv[])
 	const char *outform = "dts";
 	const char *outname = "-";
 	const char *depname = NULL;
-	int force = 0, sort = 0;
+	int force = 0, sort = 0, mksymlink = 0;
 	const char *arg;
 	int opt;
 	FILE *outf = NULL;
@@ -184,6 +186,9 @@ int main(int argc, char *argv[])
 		case 'E':
 			parse_checks_option(false, true, optarg);
 			break;
+		case 'L':
+			mksymlink = 1;
+			break;
 
 		case 'h':
 			usage(NULL);
@@ -247,6 +252,9 @@ int main(int argc, char *argv[])
 		dt_to_source(outf, bi);
 	} else if (streq(outform, "dtb")) {
 		dt_to_blob(outf, bi, outversion);
+		if (mksymlink) {
+			dt_to_symlink(bi, outname);
+		}
 	} else if (streq(outform, "asm")) {
 		dt_to_asm(outf, bi, outversion);
 	} else if (streq(outform, "null")) {
diff --git a/dtc.h b/dtc.h
index 264a20cf66a8..0cdb558fead1 100644
--- a/dtc.h
+++ b/dtc.h
@@ -254,6 +254,7 @@ void process_checks(int force, struct boot_info *bi);
 
 void dt_to_blob(FILE *f, struct boot_info *bi, int version);
 void dt_to_asm(FILE *f, struct boot_info *bi, int version);
+void dt_to_symlink(struct boot_info *bi, const char *outname);
 
 struct boot_info *dt_from_blob(const char *fname);
 
diff --git a/flattree.c b/flattree.c
index 665dad7bb465..e1720dec4389 100644
--- a/flattree.c
+++ b/flattree.c
@@ -577,6 +577,36 @@ void dt_to_asm(FILE *f, struct boot_info *bi, int version)
 	data_free(strbuf);
 }
 
+void dt_to_symlink(struct boot_info *bi, const char *outname)
+{
+	struct property *prop;
+	const char *board;
+	int symlen;
+	char *symname;
+	char *dname;
+	char *bname;
+
+	prop = get_property(bi->dt, "compatible");
+	board = prop->val.val;
+
+	symlen = strlen(outname) + prop->val.len;
+	symname = xmalloc(symlen);
+
+	dname = xdirname(outname);
+	bname = xbasename(outname);
+
+	snprintf(symname, symlen, "%s/%s.dtb", dname, board);
+
+	/* create the symlink */
+	if (symlink(bname, symname) == -1) {
+		die("Couldn't create symlink %s: %s\n", symlink, strerror(errno));
+	}
+
+	free(symname);
+	free(dname);
+	free(bname);
+}
+
 struct inbuf {
 	char *base, *limit, *ptr;
 };
diff --git a/srcpos.c b/srcpos.c
index c20bc5315bc1..5f9e032330ea 100644
--- a/srcpos.c
+++ b/srcpos.c
@@ -34,7 +34,7 @@ struct search_path {
 static struct search_path *search_path_head, **search_path_tail;
 
 
-static char *dirname(const char *path)
+char *xdirname(const char *path)
 {
 	const char *slash = strrchr(path, '/');
 
@@ -49,6 +49,22 @@ static char *dirname(const char *path)
 	return NULL;
 }
 
+char *xbasename(const char *path)
+{
+	const char *slash = strrchr(path, '/');
+
+	if (slash) {
+		int len = strlen(path) - (slash - path);
+		char *base = xmalloc(len + 1);
+
+		memcpy(base, slash + 1, len);
+		base[len] = '\0';
+		return base;
+	}
+
+	return NULL;
+}
+
 FILE *depfile; /* = NULL */
 struct srcfile_state *current_srcfile; /* = NULL */
 
@@ -150,7 +166,7 @@ void srcfile_push(const char *fname)
 	srcfile = xmalloc(sizeof(*srcfile));
 
 	srcfile->f = srcfile_relative_open(fname, &srcfile->name);
-	srcfile->dir = dirname(srcfile->name);
+	srcfile->dir = xdirname(srcfile->name);
 	srcfile->prev = current_srcfile;
 
 	srcfile->lineno = 1;
diff --git a/srcpos.h b/srcpos.h
index 93a27123c2e9..a6b6ad308d52 100644
--- a/srcpos.h
+++ b/srcpos.h
@@ -57,6 +57,8 @@ FILE *srcfile_relative_open(const char *fname, char **fullnamep);
 void srcfile_push(const char *fname);
 int srcfile_pop(void);
 
+char *xdirname(const char *path);
+char *xbasename(const char *path);
 /**
  * Add a new directory to the search path for input files
  *
-- 
1.8.4.2
