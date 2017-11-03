From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri,  3 Nov 2017 10:11:48 -0700
Subject: [PATCH 04/15] kbuild: fix dynamic ftrace with clang LTO
In-Reply-To: <20171103171203.107569-1-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
Message-ID: <20171103171203.107569-5-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_CLANG_LTO enabled, LLVM IR won't be compiled into object
files until modpost_link. This change postpones calls to recordmcount
until after this step.

In order to exclude ftrace_process_locs from inspection, we add a new
code section .text..ftrace, which we tell recordmcount to ignore, and
a __norecordmcount attribute for moving functions to this section.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/Kconfig                      |  2 +-
 include/asm-generic/vmlinux.lds.h |  2 +-
 include/linux/compiler-clang.h    |  7 +++++++
 include/linux/compiler.h          |  4 ++++
 kernel/trace/ftrace.c             |  6 +++---
 scripts/Makefile.build            | 14 +++++++++++++-
 scripts/Makefile.modpost          |  4 ++++
 scripts/link-vmlinux.sh           | 16 ++++++++++++++++
 scripts/recordmcount.c            |  3 ++-
 9 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6b0c9d4de369..b82276a64045 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -617,7 +617,7 @@ config ARCH_SUPPORTS_CLANG_LTO
 config CLANG_LTO
 	bool "Use clang Link Time Optimization (LTO)"
 	depends on ARCH_SUPPORTS_CLANG_LTO
-	depends on !FTRACE_MCOUNT_RECORD
+	depends on !FTRACE_MCOUNT_RECORD || HAVE_C_RECORDMCOUNT
 	select LD_DEAD_CODE_DATA_ELIMINATION
 	help
           This option enables clang's Link Time Optimization (LTO), which allows
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d0070985c191..99e794b8eec7 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -458,7 +458,7 @@
  */
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
-		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely)	\
+		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely .text..ftrace)	\
 		*(.ref.text)						\
 	MEM_KEEP(init.text)						\
 	MEM_KEEP(exit.text)						\
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 54dfef70a072..0f9fe03e5364 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -16,3 +16,10 @@
  * with any version that can compile the kernel
  */
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
+
+#ifdef CONFIG_CLANG_LTO
+#ifdef CONFIG_FTRACE_MCOUNT_RECORD
+#define __norecordmcount \
+	__attribute__((__section__(".text..ftrace")))
+#endif
+#endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index fd8697aa4f73..94fe175a06e9 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -502,6 +502,10 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 #define __visible
 #endif
 
+#ifndef __norecordmcount
+#define __norecordmcount
+#endif
+
 #ifndef __nostackprotector
 # define __nostackprotector
 #endif
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8319e09e15b9..e117b849f9dc 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5573,9 +5573,9 @@ static int ftrace_cmp_ips(const void *a, const void *b)
 	return 0;
 }
 
-static int ftrace_process_locs(struct module *mod,
-			       unsigned long *start,
-			       unsigned long *end)
+static int __norecordmcount ftrace_process_locs(struct module *mod,
+						unsigned long *start,
+						unsigned long *end)
 {
 	struct ftrace_page *start_pg;
 	struct ftrace_page *pg;
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0cff240454f8..e69a02dec7bb 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -246,6 +246,12 @@ ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
   RECORDMCOUNT_FLAGS = -w
 endif
+
+ifdef CONFIG_CLANG_LTO
+# With LTO, we postpone running recordmcount until after the LTO link step, so
+# let's export the parameters for the link script.
+export RECORDMCOUNT_FLAGS
+else
 # Due to recursion, we must skip empty.o.
 # The empty.o file is created in the make process in order to determine
 # the target endianness and word size. It is made before all other C
@@ -254,17 +260,22 @@ sub_cmd_record_mcount =					\
 	if [ $(@) != "scripts/mod/empty.o" ]; then	\
 		$(objtree)/scripts/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
 	fi;
+endif
+
 recordmcount_source := $(srctree)/scripts/recordmcount.c \
 		    $(srctree)/scripts/recordmcount.h
-else
+else # !BUILD_C_RECORDMCOUNT
 sub_cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
 	"$(LD)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
+
 recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
+
+ifndef CONFIG_CLANG_LTO
 cmd_record_mcount =						\
 	if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =	\
 	     "$(CC_FLAGS_FTRACE)" ]; then			\
@@ -287,6 +298,7 @@ objtool_args += --no-unreachable
 else
 objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
 endif
+endif # CONFIG_FTRACE_MCOUNT_RECORD
 
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 2f3b45cbbe6b..da0c975ac4ed 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -164,6 +164,10 @@ lto_ko_objects = $(foreach o,$(1:$(modpost-ext).o=.o),			\
 		 $(shell [ -s $(@:.ko=.modversions) ] &&		\
 			echo -T $(@:.ko=.modversions))  		\
 		 -o $@ $(call lto_ko_objects, $(filter-out FORCE,$^))
+
+ifdef CONFIG_FTRACE_MCOUNT_RECORD
+cmd_ld_ko_o += ; $(objtree)/scripts/recordmcount $(RECORDMCOUNT_FLAGS) $@
+endif
 else
       cmd_ld_ko_o =                                                     \
 	$(LD) -r $(LDFLAGS)                                             \
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index c5c004b209ce..76e1da946f08 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -143,6 +143,19 @@ modpost_link()
 	${LD} ${LDFLAGS} -r -o ${1} $(modversions) ${objects}
 }
 
+# If CONFIG_CLANG_LTO is selected, we postpone running recordmcount until
+# we have compiled LLVM IR to an object file.
+recordmcount()
+{
+	if [ -z "${CONFIG_CLANG_LTO}" ]; then
+		return
+	fi
+
+	if [ -n "${CONFIG_FTRACE_MCOUNT_RECORD}" ]; then
+		scripts/recordmcount ${RECORDMCOUNT_FLAGS} $*
+	fi
+}
+
 # Link of vmlinux
 # ${1} - optional extra .o files
 # ${2} - output file
@@ -327,6 +340,9 @@ if [ -n "${CONFIG_CLANG_LTO}" ]; then
 	KBUILD_VMLINUX_INIT=
 	KBUILD_VMLINUX_MAIN=vmlinux.o
 	KBUILD_VMLINUX_LIBS=
+
+	# Call recordmcount if needed
+	recordmcount vmlinux.o
 fi
 
 kallsymso=""
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 16e086dcc567..69a769904da7 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -420,7 +420,8 @@ is_mcounted_section_name(char const *const txtname)
 		strcmp(".softirqentry.text", txtname) == 0 ||
 		strcmp(".kprobes.text", txtname) == 0 ||
 		strcmp(".cpuidle.text", txtname) == 0 ||
-		strcmp(".text.unlikely", txtname) == 0;
+		(strncmp(".text.",       txtname, 6) == 0 &&
+		 strcmp(".text..ftrace", txtname) != 0);
 }
 
 /* 32 bit and 64 bit are very similar */
-- 
2.15.0.403.gc27cc4dac6-goog
