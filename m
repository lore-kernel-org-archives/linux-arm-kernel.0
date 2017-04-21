From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 22 Apr 2017 04:36:44 +0900
Subject: [RFC-b PATCH] kbuild: redefine __FILE__ as relative path from
 $(srctree) if possible
Message-ID: <1492803404-17837-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Kbuild runs in the objtree, __FILE__ can be a very long path
depending of $(srctree).

Commit 9da0763bdd82 ("kbuild: Use relative path when building in a
subdir of the source tree") made the situation better for cases
where objtree is a child of srctree.  ($(srctree) is "..")

For other cases of out-of-tree build, filenames in WARN_ON() etc.
are still an absolute path.  It also means the kernel image depends
on where it was built.

Here, the idea is to redefine __FILE__ as the relative path from
$(srctree), but doing so causes a compiler warning:
  warning: "__FILE__" redefined [-Wbuiltin-macro-redefined]

We can suppress it with -Wno-builtin-macro-redefined.  However,
this option is not recognized by old compilers.  So, __FILE__
is re-defined only when the option is supported.

I am adding stringify helper because '"..."' wrapping is the same
pattern as in KBUILD_BASENAME, KBUILD_MODNAME.

Please note __FILE__ is always an absolute path for external
modules.  We can strip KBUILD_EXTMOD from the path if we want,
but I am not doing that.  It would make it difficult to figure out
the module in question in case of WARN_ON().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

This is another possible approach.

Please see these as well:
https://patchwork.kernel.org/patch/9693559/
https://patchwork.kernel.org/patch/9693563/

Pro:
this is only touching 3 makefiles.

Con:
this does not work for old compilers.


 Makefile               | 3 +++
 scripts/Kbuild.include | 4 ++++
 scripts/Makefile.lib   | 6 ++++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8804aae..293ef6d 100644
--- a/Makefile
+++ b/Makefile
@@ -798,6 +798,9 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=strict-prototypes)
 # Prohibit date/time macros, which would make the build non-deterministic
 KBUILD_CFLAGS   += $(call cc-option,-Werror=date-time)
 
+# Is is possible to redefine __FILE__?
+KBUILD_CFLAGS	+= $(call cc-disable-warning, builtin-macro-redefined)
+
 # enforce correct pointer usage
 KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
 
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 61f87a9..7fc3841 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -31,6 +31,10 @@ baseprereq = $(basename $(notdir $<))
 escsq = $(subst $(squote),'\$(squote)',$1)
 
 ###
+# Quote a string to pass it to C files. foo => '"foo"'
+stringify = $(squote)$(quote)$1$(quote)$(squote)
+
+###
 # Easy method for doing a status message
        kecho := :
  quiet_kecho := echo
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 9e70196..1d789df 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -96,10 +96,12 @@ obj-dirs	:= $(addprefix $(obj)/,$(obj-dirs))
 # Note: Files that end up in two or more modules are compiled without the
 #       KBUILD_MODNAME definition. The reason is that any made-up name would
 #       differ in different configs.
-name-fix = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
+name-fix = $(call stringify,$(subst $(comma),_,$(subst -,_,$1)))
 basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
 modname_flags  = $(if $(filter 1,$(words $(modname))),\
                  -DKBUILD_MODNAME=$(call name-fix,$(modname)))
+filepath_flags = $(if $(filter -Wno-builtin-macro-redefined, $(KBUILD_CFLAGS)), \
+                 -D__FILE__=$(call stringify,$(src)/$(notdir $<)))
 
 orig_c_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(KBUILD_SUBDIR_CCFLAGS) \
                  $(ccflags-y) $(CFLAGS_$(basetarget).o)
@@ -163,7 +165,7 @@ endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 $(__c_flags) $(modkern_cflags)                           \
-		 $(basename_flags) $(modname_flags)
+		 $(basename_flags) $(modname_flags) $(filepath_flags)
 
 a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 $(__a_flags) $(modkern_aflags)
-- 
2.7.4
