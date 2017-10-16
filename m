From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Oct 2017 14:24:37 +0100
Subject: [PATCH 1/4] kbuild: allow global override of CC instrumentation
In-Reply-To: <20171016132440.38098-1-mark.rutland@arm.com>
References: <20171016132440.38098-1-mark.rutland@arm.com>
Message-ID: <20171016132440.38098-2-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we have a number of compiler instrumentation features, each
with its own overrides to disable instrumentation of a file or
directory.

In a few cases, there are files with special ABI requirements, for which
we need to avoid all instrumentation. Having to apply each override
manually is tedious, and error-prone as new instrumentation features are
introduced.

To make matters easier, this patch adds a new CC_INSTRUMENT override,
allowing instrumentation to be avoided for certain files or directories.
This can also be overridden on a per-file or per-directory basis, to
allow opting in to some instrumentation.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrey Konovalov <adech.fo@gmail.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <mmarek@suse.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-kbuild at vger.kernel.org
---
 scripts/Makefile.lib | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5e975fee0f5b..c7d71f482b57 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -109,6 +109,15 @@ orig_a_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(KBUILD_SUBDIR_ASFLAGS) \
 _a_flags       = $(filter-out $(AFLAGS_REMOVE_$(basetarget).o), $(orig_a_flags))
 _cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$(@F))
 
+# Each of the compiler instrumentation features below can be selectively
+# enabled or disable for files or directoies. In decreasing order of
+# predence, each option foo is controlled by:
+# FOO_obj.o := [yn]
+# CC_INSTRUMENT_obj.o := [yn]
+# FOO := [yn]
+# CC_INSTRUMENT := [yn]
+# FOO_all := [yn]
+
 #
 # Enable gcov profiling flags for a file, directory or for all files depending
 # on variables GCOV_PROFILE_obj.o, GCOV_PROFILE and CONFIG_GCOV_PROFILE_ALL
@@ -116,7 +125,7 @@ _cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$(@F))
 #
 ifeq ($(CONFIG_GCOV_KERNEL),y)
 _c_flags += $(if $(patsubst n%,, \
-		$(GCOV_PROFILE_$(basetarget).o)$(GCOV_PROFILE)$(CONFIG_GCOV_PROFILE_ALL)), \
+		$(GCOV_PROFILE_$(basetarget).o)$(CC_INSTRUMENT_$(basetarget).o)$(GCOV_PROFILE)$(CC_INSTRUMENT)$(CONFIG_GCOV_PROFILE_ALL)), \
 		$(CFLAGS_GCOV))
 endif
 
@@ -126,19 +135,19 @@ endif
 #
 ifeq ($(CONFIG_KASAN),y)
 _c_flags += $(if $(patsubst n%,, \
-		$(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)y), \
+		$(KASAN_SANITIZE_$(basetarget).o)$(CC_INSTRUMENT_$(basetarget).o)$(KASAN_SANITIZE)$(CC_INSTRUMENT)y), \
 		$(CFLAGS_KASAN))
 endif
 
 ifeq ($(CONFIG_UBSAN),y)
 _c_flags += $(if $(patsubst n%,, \
-		$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_SANITIZE)$(CONFIG_UBSAN_SANITIZE_ALL)), \
+		$(UBSAN_SANITIZE_$(basetarget).o)$(CC_INSTRUMENT_$(basetarget).o)$(UBSAN_SANITIZE)$(CC_INSTRUMENT)$(CONFIG_UBSAN_SANITIZE_ALL)), \
 		$(CFLAGS_UBSAN))
 endif
 
 ifeq ($(CONFIG_KCOV),y)
 _c_flags += $(if $(patsubst n%,, \
-	$(KCOV_INSTRUMENT_$(basetarget).o)$(KCOV_INSTRUMENT)$(CONFIG_KCOV_INSTRUMENT_ALL)), \
+	$(KCOV_INSTRUMENT_$(basetarget).o)$(CC_INSTRUMENT_$(basetarget).o)$(KCOV_INSTRUMENT)$(CC_INSTRUMENT)$(CONFIG_KCOV_INSTRUMENT_ALL)), \
 	$(CFLAGS_KCOV))
 endif
 
-- 
2.11.0
