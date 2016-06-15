From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 17:45:47 +0200
Subject: [PATCH v2 05/11] Kbuild: don't add obj tree in additional includes
In-Reply-To: <20160615154553.3177021-1-arnd@arndb.de>
References: <20160615154553.3177021-1-arnd@arndb.de>
Message-ID: <20160615154553.3177021-6-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building with separate object directories and driver specific
Makefiles that add additional header include paths, Kbuild adjusts
the gcc flags so that we include both the directory in the source
tree and in the object tree.

However, due to another bug I fixed earlier, this did not actually
include the correct directory in the object tree, so we know that
we only really need the source tree here. Also, including the
object tree sometimes causes warnings about nonexisting directories
when the include path only exists in the source.

This changes the logic to only emit the -I argument for the srctree,
not for objects. We still need both $(srctree)/$(src) and $(obj)
though, so I'm adding them manually.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Kbuild.include | 2 +-
 scripts/Makefile.lib   | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index f8b45eb47ed3..15b196fc2f49 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -202,7 +202,7 @@ hdr-inst := -f $(srctree)/scripts/Makefile.headersinst obj
 # Prefix -I with $(srctree) if it is not an absolute path.
 # skip if -I has no parameter
 addtree = $(if $(patsubst -I%,%,$(1)), \
-$(if $(filter-out -I/% -I../%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1))) $(1))
+$(if $(filter-out -I/% -I./% -I../%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1)),$(1)))
 
 # Find all -I options and call addtree
 flags = $(foreach o,$($(1)),$(if $(filter -I%,$(o)),$(call addtree,$(o)),$(o)))
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 76494e15417b..0a07f9014944 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -155,9 +155,10 @@ else
 # $(call addtree,-I$(obj)) locates .h files in srctree, from generated .c files
 #   and locates generated .h files
 # FIXME: Replace both with specific CFLAGS* statements in the makefiles
-__c_flags	= $(call addtree,-I$(obj)) $(call flags,_c_flags)
-__a_flags	=                          $(call flags,_a_flags)
-__cpp_flags     =                          $(call flags,_cpp_flags)
+__c_flags	= $(if $(obj),-I$(srctree)/$(src) -I$(obj)) \
+		  $(call flags,_c_flags)
+__a_flags	= $(call flags,_a_flags)
+__cpp_flags     = $(call flags,_cpp_flags)
 endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
-- 
2.9.0
