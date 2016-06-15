From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 17:45:43 +0200
Subject: [PATCH v2 01/11] Kbuild: don't add ../../ to include path
In-Reply-To: <20160615154553.3177021-1-arnd@arndb.de>
References: <20160615154553.3177021-1-arnd@arndb.de>
Message-ID: <20160615154553.3177021-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we build with O=objdir and objdir is directly below the source tree,
$(srctree) becomes '..'.

When a Makefile adds a CFLAGS option like -Ipath/to/headers and
we are building with a separate object directory, Kbuild tries to
add two -I options, one for the source tree and one for the object
tree. An absolute path is treated as a special case, and don't add
this one twice. This also normally catches -I$(srctree)/$(src)
as $(srctree) usually is an absolute directory like /home/arnd/linux/.

The combination of the two behaviors however results in an invalid
path name to be included: we get both ../$(src) and ../../$(src),
the latter one pointing outside of the source tree, usually to a
nonexisting directory. Building with 'make W=1' makes this obvious:

cc1: error: ../../arch/arm/mach-s3c24xx/include: No such file or directory [-Werror=missing-include-dirs]

This adds another special case, treating path names starting with ../
like those starting with / so we don't try to prefix that with
$(srctree).

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Kbuild.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 0f82314621f2..f8b45eb47ed3 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -202,7 +202,7 @@ hdr-inst := -f $(srctree)/scripts/Makefile.headersinst obj
 # Prefix -I with $(srctree) if it is not an absolute path.
 # skip if -I has no parameter
 addtree = $(if $(patsubst -I%,%,$(1)), \
-$(if $(filter-out -I/%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1))) $(1))
+$(if $(filter-out -I/% -I../%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1))) $(1))
 
 # Find all -I options and call addtree
 flags = $(foreach o,$($(1)),$(if $(filter -I%,$(o)),$(call addtree,$(o)),$(o)))
-- 
2.9.0
