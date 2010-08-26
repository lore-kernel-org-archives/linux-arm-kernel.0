From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Thu, 26 Aug 2010 15:02:28 +0300
Subject: [PATCH v2 2/6] configure/Makefile: add support for ARM targets
In-Reply-To: <cover.1282822832.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1282822832.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <a3ea7a89f09cc3d5e5677338cc7cb5d1e29f7922.1282822832.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to build for ARM targets. This includes native ARM build, and also
ARM on x86 (which works because of the same word size and endianness).

Signed-off-by: Jan Karlsson <jan.karlsson@sonyericsson.com>
Signed-off-by: Thomas F?nge <thomas.fange@sonyericsson.com>
Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 Makefile    |   18 +++++++++++++++---
 configure.c |   32 +++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index c2a2ac0..038c887 100644
--- a/Makefile
+++ b/Makefile
@@ -32,6 +32,12 @@ ifeq ($(ARCH), ppc64)
 CONF_FLAGS = -m64
 endif
 
+ifeq ($(TARGET), ARM)
+ifeq ($(ARCH), i386)
+GDB_CONF_FLAGS = --target=arm-elf-linux
+endif
+endif
+
 #
 # GDB, GDB_FILES, GDB_OFILES and GDB_PATCH_FILES will be configured automatically by configure 
 #
@@ -240,11 +246,17 @@ GDB_INCLUDE_DIRECTORY=./${GDB}/include
 
 REDHATFLAGS=-DREDHAT
 
+# target could be set on command line when invoking make. Like: make target=ARM
+# otherwise target will be the same as the host
+ifneq ($(target),)
+CONF_TARGET_FLAG="-t$(target)"
+endif
+
 # To build the extensions library by default, uncomment the third command
 # line below.  Otherwise they can be built by entering "make extensions".
 
 all: make_configure
-	@./configure -p "RPMPKG=${RPMPKG}" -b
+	@./configure ${CONF_TARGET_FLAG} -p "RPMPKG=${RPMPKG}" -b
 	@make --no-print-directory gdb_merge
 #	@make --no-print-directory extensions
 
@@ -254,7 +266,7 @@ gdb_merge: force
 	@echo "${LDFLAGS} -lz -ldl -rdynamic" > ${GDB}/gdb/mergelibs
 	@echo "../../${PROGRAM} ../../${PROGRAM}lib.a" > ${GDB}/gdb/mergeobj
 	@if [ ! -f ${GDB}/config.status ]; then \
-	  (cd ${GDB}; ./configure --with-separate-debug-dir=/usr/lib/debug \
+	  (cd ${GDB}; ./configure ${GDB_CONF_FLAGS} --with-separate-debug-dir=/usr/lib/debug \
 	    --with-bugurl="" --with-expat=no --with-python=no; \
 	  make --no-print-directory;) \
 	else (cd ${GDB}/gdb; make --no-print-directory;); fi
@@ -591,7 +603,7 @@ dis:
 	objdump --disassemble --line-numbers ${PROGRAM} > ${PROGRAM}.dis
 
 extensions: make_configure
-	@./configure -q -b
+	@./configure ${CONF_TARGET_FLAG} -q -b
 	@make --no-print-directory do_extensions
 
 do_extensions:
diff --git a/configure.c b/configure.c
index 627bb83..a4b3a0e 100755
--- a/configure.c
+++ b/configure.c
@@ -90,6 +90,7 @@ void make_spec_file(struct supported_gdb_version *);
 #undef S390X
 #undef PPC64
 #undef X86_64
+#undef ARM
 
 #define X86     1
 #define ALPHA   2
@@ -99,6 +100,7 @@ void make_spec_file(struct supported_gdb_version *);
 #define S390X   6
 #define PPC64   7
 #define X86_64  8
+#define ARM	9
 
 #define TARGET_X86    "TARGET=X86"
 #define TARGET_ALPHA  "TARGET=ALPHA"
@@ -108,6 +110,7 @@ void make_spec_file(struct supported_gdb_version *);
 #define TARGET_S390X  "TARGET=S390X"
 #define TARGET_PPC64  "TARGET=PPC64"
 #define TARGET_X86_64 "TARGET=X86_64"
+#define TARGET_ARM    "TARGET=ARM"
 
 #define TARGET_CFLAGS_X86    "TARGET_CFLAGS=-D_FILE_OFFSET_BITS=64"
 #define TARGET_CFLAGS_ALPHA  "TARGET_CFLAGS="
@@ -117,6 +120,7 @@ void make_spec_file(struct supported_gdb_version *);
 #define TARGET_CFLAGS_S390X  "TARGET_CFLAGS="
 #define TARGET_CFLAGS_PPC64  "TARGET_CFLAGS=-m64"
 #define TARGET_CFLAGS_X86_64 "TARGET_CFLAGS="
+#define TARGET_CFLAGS_ARM    "TARGET_CFLAGS=-D_FILE_OFFSET_BITS=64"
 
 /*
  *  The original plan was to allow the use of a particular version
@@ -193,6 +197,7 @@ struct target_data {
 	char gdb_version[MAXSTRLEN];
 	char release[MAXSTRLEN];
 	struct stat statbuf;
+	const char *target_as_param;
 } target_data = { 0 }; 
 
 int
@@ -203,7 +208,7 @@ main(int argc, char **argv)
 
 	sp = setup_gdb_defaults();
 
-	while ((c = getopt(argc, argv, "gsqnWwubdr:p:P:")) > 0) {
+	while ((c = getopt(argc, argv, "gsqnWwubdr:p:P:t:")) > 0) {
 		switch (c) {
 		case 'q':
 			target_data.flags |= QUIET;
@@ -236,6 +241,9 @@ main(int argc, char **argv)
 		case 'g':
 			gdb_configure(sp);
 			break;
+		case 't':
+			target_data.target_as_param = optarg;
+			break;
 		}
 	}
 
@@ -274,6 +282,21 @@ get_current_configuration(void)
 #ifdef __x86_64__
         target_data.target = X86_64;
 #endif
+#ifdef __arm__
+        target_data.target = ARM;
+#endif
+        /* override target if specified on command line */
+	if (target_data.target_as_param != 0) {
+		if (target_data.target == X86 &&
+		    strcmp(target_data.target_as_param, "ARM") == 0) {
+			/* debugging of ARM core files only supported on X86 */
+			target_data.target = ARM;
+		} else {
+			fprintf(stderr,
+				"target \"%s\" is not supported on this architecture\n",
+				target_data.target_as_param);
+		}
+        }
 
         if ((fp = fopen("Makefile", "r")) == NULL) {
 		perror("Makefile");
@@ -374,6 +397,9 @@ show_configuration(void)
 	case X86_64:
 		printf("TARGET: X86_64\n");
 		break;
+	case ARM:
+		printf("TARGET: ARM\n");
+		break;
 	}
 
 	if (strlen(target_data.program)) {
@@ -437,6 +463,10 @@ build_configure(struct supported_gdb_version *sp)
                 target = TARGET_X86_64;
                 target_CFLAGS = TARGET_CFLAGS_X86_64;
                 break;
+	case ARM:
+                target = TARGET_ARM;
+                target_CFLAGS = TARGET_CFLAGS_ARM;
+                break;
 	}
 
 	makefile_setup(&fp1, &fp2);
-- 
1.5.6.5
