From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Aug 2016 14:48:57 +0100
Subject: [PATCH] arm64: errata: Pass --fix-cortex-a53-843419 to ld if
 workaround enabled
Message-ID: <1471873737-7614-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cortex-A53 erratum 843419 is worked around by the linker, although it is
a configure-time option to GCC as to whether ld is actually asked to
apply the workaround or not.

This patch ensures that we pass --fix-cortex-a53-843419 to the linker
when both CONFIG_ARM64_ERRATUM_843419=y and the linker supports the
option.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig  | 15 +++++----------
 arch/arm64/Makefile |  9 +++++++++
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f586f1..e4b7d10e8e1c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -415,18 +415,13 @@ config ARM64_ERRATUM_845719
 
 config ARM64_ERRATUM_843419
 	bool "Cortex-A53: 843419: A load or store might access an incorrect address"
-	depends on MODULES
 	default y
-	select ARM64_MODULE_CMODEL_LARGE
+	select ARM64_MODULE_CMODEL_LARGE if MODULES
 	help
-	  This option builds kernel modules using the large memory model in
-	  order to avoid the use of the ADRP instruction, which can cause
-	  a subsequent memory access to use an incorrect address on Cortex-A53
-	  parts up to r0p4.
-
-	  Note that the kernel itself must be linked with a version of ld
-	  which fixes potentially affected ADRP instructions through the
-	  use of veneers.
+	  This option links the kernel with '--fix-cortex-a53-843419' and
+	  builds modules using the large memory model in order to avoid the use
+	  of the ADRP instruction, which can cause a subsequent memory access
+	  to use an incorrect address on Cortex-A53 parts up to r0p4.
 
 	  If unsure, say Y.
 
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 5b54f8c021d8..c5ad4957e7ee 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -18,6 +18,15 @@ ifneq ($(CONFIG_RELOCATABLE),)
 LDFLAGS_vmlinux		+= -pie -Bsymbolic
 endif
 
+ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
+ld-843419-workaround := $(call ld-option, --fix-cortex-a53-843419)
+  ifeq ($(ld-843419-workaround),)
+$(warning ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum)
+  else
+LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
+  endif
+endif
+
 KBUILD_DEFCONFIG := defconfig
 
 # Check for binutils support for specific extensions
-- 
2.1.4
