From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 19 Nov 2013 21:27:55 +0000
Subject: [PATCH V4] kbuild: dtbs_install: new make target
In-Reply-To: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
Message-ID: <1384896475-8744-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike other build products in the Linux kernel, there is no 'make
*install' mechanism to put devicetree blobs in a standard place.

This patch is an attempt to fix this problem.  Akin to 'make install',
this creates a new make target, dtbs_install.  The script that gets
called defers to a distribution or user supplied installdtbs binary,
if found in the system.  Otherwise, the default action is to install a
given dtb into

  /lib/modules/${kernel_version}/devicetree/${dts_filename}.dtb

This is done to keep dtbs from different kernel versions separate until
things have settled down.  Once the dtbs are stable, and not so strongly
linked to the kernel version, the devicetree files will most likely move
to their own repo.  Users will need to upgrade install scripts at that
time.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Question: should I make a note about the filenames not being considered an ABI,
or just let it be?

changes since v3:
 - drop renaming files to ${compat}.dtb (rmk/swarren)
 - move installdtbs.sh to ./scripts/ (gcl)

changes since v2:
 - use fdtget instead of a modified dtc to get the board compat string

changes since v1:
 - added this patch

 Makefile               |  3 ++-
 arch/arm/Makefile      |  4 ++++
 scripts/installdtbs.sh | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 scripts/installdtbs.sh

diff --git a/Makefile b/Makefile
index 920ad07180c9..29d609e972d6 100644
--- a/Makefile
+++ b/Makefile
@@ -339,6 +339,7 @@ OBJDUMP		= $(CROSS_COMPILE)objdump
 AWK		= awk
 GENKSYMS	= scripts/genksyms/genksyms
 INSTALLKERNEL  := installkernel
+INSTALLDTBS    := installdtbs
 DEPMOD		= /sbin/depmod
 PERL		= perl
 CHECK		= sparse
@@ -391,7 +392,7 @@ KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(S
 export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
 export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP
-export MAKE AWK GENKSYMS INSTALLKERNEL PERL UTS_MACHINE
+export MAKE AWK GENKSYMS INSTALLKERNEL INSTALLDTBS PERL UTS_MACHINE
 export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c99b1086d83d..6c7abfc5eb5e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -314,6 +314,10 @@ PHONY += dtbs
 dtbs: scripts
 	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) dtbs
 
+dtbs_install: dtbs
+	$(CONFIG_SHELL) $(srctree)/scripts/installdtbs.sh $(KERNELRELEASE) \
+	"$(MODLIB)/devicetree" "$(srctree)/$(boot)/dts"
+
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
diff --git a/scripts/installdtbs.sh b/scripts/installdtbs.sh
new file mode 100644
index 000000000000..11027f00c3a4
--- /dev/null
+++ b/scripts/installdtbs.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 1995 by Linus Torvalds
+#
+# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
+#
+# Further adapted from arch/x86/boot/install.sh by Jason Cooper
+#
+# "make dtbs_install" script
+#
+# Arguments:
+#   $1 - kernel version
+#   $2 - default install path (blank if root directory)
+#   $3 - directory containing dtbs
+#
+
+# User may have a custom install script
+
+if [ -x ~/bin/${INSTALLDTBS} ]; then exec ~/bin/${INSTALLDTBS} "$@"; fi
+if [ -x /sbin/${INSTALLDTBS} ]; then exec /sbin/${INSTALLDTBS} "$@"; fi
+
+# Default install
+[ -d "$2" ] && rm -rf "$2"
+
+mkdir -p "$2"
+
+for dtb in `find "$3" -name "*.dtb"`; do
+	cp "$dtb" "$2/${dtb##*/}"
+done
-- 
1.8.4.3
