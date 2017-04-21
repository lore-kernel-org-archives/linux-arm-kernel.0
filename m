From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 22 Apr 2017 04:03:26 +0900
Subject: [RFC PATCH 1/2] kbuild: add KBUILD_FILE to point relative file path
 from $(srctree)
In-Reply-To: <1492801407-26823-1-git-send-email-yamada.masahiro@socionext.com>
References: <1492801407-26823-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1492801407-26823-2-git-send-email-yamada.masahiro@socionext.com>
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

Here, the idea is to define a new macro, KBUILD_FILE, to point the
relative file path from $(srctree).

If we replace __FILE__ with KBUILD_FILE, we can rip off the path
to the build directory.

I am adding stringify helper because '"..."' wrapping is the same
pattern for KBUILD_BASENAME, KBUILD_MODNAME, and KBUILD_FILE.

Please note KBUILD_FILE is still an absolute path for external
modules.  We can strip KBUILD_EXTMOD from the path if we want,
but I am not doing that.  It would make it difficult to figure out
the module in question in case of WARN_ON().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Kbuild.include | 4 ++++
 scripts/Makefile.lib   | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

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
index 9e70196..f8dce56 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -96,10 +96,11 @@ obj-dirs	:= $(addprefix $(obj)/,$(obj-dirs))
 # Note: Files that end up in two or more modules are compiled without the
 #       KBUILD_MODNAME definition. The reason is that any made-up name would
 #       differ in different configs.
-name-fix = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
+name-fix = $(call stringify,$(subst $(comma),_,$(subst -,_,$1)))
 basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
 modname_flags  = $(if $(filter 1,$(words $(modname))),\
                  -DKBUILD_MODNAME=$(call name-fix,$(modname)))
+filepath_flags = -DKBUILD_FILE=$(call stringify,$(src)/$(notdir $<))
 
 orig_c_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(KBUILD_SUBDIR_CCFLAGS) \
                  $(ccflags-y) $(CFLAGS_$(basetarget).o)
@@ -163,7 +164,7 @@ endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 $(__c_flags) $(modkern_cflags)                           \
-		 $(basename_flags) $(modname_flags)
+		 $(basename_flags) $(modname_flags) $(filepath_flags)
 
 a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 $(__a_flags) $(modkern_aflags)
-- 
2.7.4
