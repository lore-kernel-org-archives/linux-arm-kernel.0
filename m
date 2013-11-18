From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 18 Nov 2013 18:38:15 +0000
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <cover.1384798508.git.jason@lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <cover.1384798508.git.jason@lakedaemon.net>
Message-ID: <eaf050fbd62803784856a4f37d4b332f7778e22c.1384798508.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike other build products in the Linux kernel, the devicetree blobs
are simply the name of their source file, s/dts/dtb/.  There is also no
'make *install' mechanism to put them in a standard place with a
standard naming structure.

Unfortunately, users have begun scripting pulling the needed dtbs from
within the kernel tree, thus hardcoding the dtbs names.  In turn, this
means any changes to the dts filenames breaks these scripts.

This patch is an attempt to fix this problem.  Akin to 'make install',
this creates a new make target, dtbs_install.  The script that gets
called defers to a vendor or distribution supplied installdtbs binary,
if found in the system.  Otherwise, the default action is to install a
given dtb into

  /lib/modules/${kernel_version}/devicetree/${board_compat}.dtb

This solves several problems for us.  The board compatible string should
be unique, this enforces/highlights that.  While devicetrees are
stablilizing, the fact is, devicetrees aren't (yet) independent of
kernel version.  This install target facilitates keeping track of that.

Once the devicetree files are moved to their own repository, this
install target can be removed as users will be modifying their scripts
anyway.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
changes since v1:
 - added this patch

 Makefile                     |  3 ++-
 arch/arm/Makefile            |  4 ++++
 arch/arm/boot/installdtbs.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/installdtbs.sh

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
index c99b1086d83d..c16ebb1e74b0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -314,6 +314,10 @@ PHONY += dtbs
 dtbs: scripts
 	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) dtbs
 
+dtbs_install: dtbs
+	$(CONFIG_SHELL) $(srctree)/$(boot)/installdtbs.sh $(KERNELRELEASE) \
+	"$(MODLIB)/devicetree" "$(srctree)/$(boot)/dts"
+
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
diff --git a/arch/arm/boot/installdtbs.sh b/arch/arm/boot/installdtbs.sh
new file mode 100644
index 000000000000..c46c109363d2
--- /dev/null
+++ b/arch/arm/boot/installdtbs.sh
@@ -0,0 +1,44 @@
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
+DTC=./scripts/dtc/dtc
+
+# Default install
+[ -d "$2" ] && rm -rf "$2"
+
+mkdir -p "$2"
+
+for dtb in `find "$3" -name "*.dtb"`; do
+	# we use dtc to parse the dtb, get the board compatible string,
+	# and then copy the dtb to $2/${board_compatible}.dtb
+	compat="`$DTC -I dtb -O compat "$dtb"`"
+
+	if [ -e "$2/${compat}.dtb" ]; then
+		echo "Install $dtb: $2/${compat}.dtb already exists!" 1>&2
+		exit 1
+	else
+		cp "$dtb" "$2/${compat}.dtb"
+	fi
+done
-- 
1.8.4.3
