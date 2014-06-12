From: geoff@infradead.org (Geoff Levand)
Date: Thu, 12 Jun 2014 00:12:56 +0000
Subject: [PATCH 2/2] configure: Fixes for --enable-xxx
In-Reply-To: <cover.1402531738.git.geoff@infradead.org>
References: <cover.1402531738.git.geoff@infradead.org>
Message-ID: <8ad2293111bbd60ddecd071be34734c2b46415df.1402531738.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the --enable-psci=no or --enable-gicv3=no form of configure option
was passed our configure script was setting the option to yes.  This
changes the logic slightly to fix the problem.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 configure.ac | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/configure.ac b/configure.ac
index b60f869..c61564b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,12 +41,11 @@ AC_SUBST([KERNEL_IMAGE], [$KERN_IMAGE])
 AC_SUBST([KERNEL_DTB], [$KERN_DTB])
 
 # Allow a user to pass --enable-psci
-USE_PSCI=no
 AC_ARG_ENABLE([psci],
 	AS_HELP_STRING([--enable-psci], [enable the psci boot method]),
-	[USE_PSCI=yes],
-	[USE_PSCI=no])
-AM_CONDITIONAL([PSCI], [test "x$USE_PSCI" = "xyes"])
+	[enable_psci=$enableval])
+AM_CONDITIONAL([PSCI], [test "x$enable_psci" = "xyes"])
+AS_IF([test "x$enable_psci" = "xyes"], [], [enable_psci=no])
 
 # Allow a user to pass --with-cpu-ids
 C_CPU_IDS="0x0,0x1,0x2,0x3"
@@ -69,12 +68,11 @@ AC_ARG_WITH([cmdline],
 AC_SUBST([CMDLINE], [$C_CMDLINE])
 
 # Allow a user to pass --enable-gicv3
-USE_GICV3=no
 AC_ARG_ENABLE([gicv3],
 	AS_HELP_STRING([--enable-gicv3], [enable GICv3 instead of GICv2]),
-	[USE_GICV3=yes],
-	[USE_GICV3=no])
-AM_CONDITIONAL([GICV3], [test "x$USE_GICV3" = "xyes"])
+	[enable_gicv3=$enableval])
+AM_CONDITIONAL([GICV3], [test "x$enable_gicv3" = "xyes"])
+AS_IF([test "x$enable_gicv3" = "xyes"], [], [enable_gicv3=no])
 
 # Ensure that we have all the needed programs
 AC_PROG_CC
@@ -93,6 +91,7 @@ AC_CONFIG_FILES([Makefile])
 AC_OUTPUT
 
 # Print the final config to the user.
+
 echo ""
 echo "  Boot wrapper configuration"
 echo "  =========================="
@@ -101,7 +100,7 @@ echo "  Linux kernel build dir:            ${KERN_DIR}"
 echo "  Device tree blob:                  ${KERN_DTB}"
 echo "  Linux kernel command line:         ${CMDLINE}"
 echo "  Embedded initrd:                   ${FILESYSTEM:-NONE}"
-echo "  Use PSCI?                          ${USE_PSCI}"
+echo "  Use PSCI?                          $enable_psci"
 echo "  CPU IDs:                           ${CPU_IDS}"
-echo "  Use GICv3?                         ${USE_GICV3}"
+echo "  Use GICv3?                         $enable_gicv3"
 echo ""
-- 
1.9.1
