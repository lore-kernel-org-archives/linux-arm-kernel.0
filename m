From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Feb 2017 12:32:51 +0000
Subject: [BOOTWRAPPER PATCH 3/3] Dynamically determine the set of CPUs
In-Reply-To: <1487334771-25789-1-git-send-email-mark.rutland@arm.com>
References: <1487334771-25789-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1487334771-25789-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we hard-code the set of CPUs we expect, and we have some
strong expectations on the formatting of nodes.

As we can configure models with differing sets of CPUs, we added the
with-cpu-ids configure option to override this assumption, though in
practice it turns out this is very fragile.

Instead, we can parse the DTB to discover the set of CPU nodes (and
hence the set of CPU IDs, and the number of CPUs). This is far more
robust.

This patch changes the bootwrapper to do this, removing the newly
redundant --with-cpu-ids configure option.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Makefile.am      | 14 ++++++--------
 addpsci.pl       | 29 +++++++++++++++++++++++++++++
 configure.ac     |  8 --------
 findcpuids.pl    | 32 ++++++++++++++++++++++++++++++++
 gen-cpu-nodes.sh | 24 ------------------------
 5 files changed, 67 insertions(+), 40 deletions(-)
 create mode 100755 addpsci.pl
 create mode 100755 findcpuids.pl
 delete mode 100755 gen-cpu-nodes.sh

diff --git a/Makefile.am b/Makefile.am
index 9910caf..49cfa84 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -13,7 +13,8 @@ UART_BASE	:= $(shell perl -I $(top_srcdir) $(top_srcdir)/findbase.pl $(KERNEL_DT
 SYSREGS_BASE	:= $(shell perl -I $(top_srcdir) $(top_srcdir)/findbase.pl $(KERNEL_DTB) 0 'arm,vexpress-sysreg')
 CNTFRQ		:= 0x01800000	# 24Mhz
 
-NR_CPUS		:= $(shell echo $(CPU_IDS) | tr ',' ' ' | wc -w)
+CPU_IDS		:= $(shell perl -I $(top_srcdir) $(top_srcdir)/findcpuids.pl $(KERNEL_DTB))
+NR_CPUS         := $(shell echo $(CPU_IDS) | tr ',' ' ' | wc -w)
 
 DEFINES		= -DCNTFRQ=$(CNTFRQ)
 DEFINES		+= -DCPU_IDS=$(CPU_IDS)
@@ -50,14 +51,11 @@ PSCI_NODE	:= psci {				\
 			cpu_on = <$(PSCI_CPU_ON)>;	\
 			cpu_off = <$(PSCI_CPU_OFF)>;	\
 		   };
-CPU_NODES	:= $(shell $(top_srcdir)/gen-cpu-nodes.sh $(CPU_IDS))
-CPUS_NODE	:= cpus {		\
-			$(CPU_NODES)	\
-		   };
+CPU_NODES	:= $(shell perl -I $(top_srcdir) $(top_srcdir)/addpsci.pl $(KERNEL_DTB))
 else
 BOOTMETHOD	:= spin.o
 PSCI_NODE	:=
-CPUS_NODE	:=
+CPU_NODES	:=
 endif
 
 if GICV3
@@ -144,8 +142,8 @@ $(IMAGE): $(OFILES) model.lds fdt.dtb $(KERNEL_IMAGE) $(FILESYSTEM) $(XEN_IMAGE)
 model.lds: $(LD_SCRIPT) Makefile
 	$(CPP) $(CPPFLAGS) -ansi -DPHYS_OFFSET=$(PHYS_OFFSET) -DMBOX_OFFSET=$(MBOX_OFFSET) -DKERNEL_OFFSET=$(KERNEL_OFFSET) -DFDT_OFFSET=$(FDT_OFFSET) -DFS_OFFSET=$(FS_OFFSET) $(XEN) -DXEN_OFFSET=$(XEN_OFFSET) -DKERNEL=$(KERNEL_IMAGE) -DFILESYSTEM=$(FILESYSTEM) -DTEXT_LIMIT=$(TEXT_LIMIT) -P -C -o $@ $<
 
-fdt.dtb: $(KERNEL_DTB) Makefile gen-cpu-nodes.sh
-	( $(DTC) -O dts -I dtb $(KERNEL_DTB) ; echo "/ { $(CHOSEN_NODE) $(PSCI_NODE) $(CPUS_NODE) };" ) | $(DTC) -O dtb -o $@ -
+fdt.dtb: $(KERNEL_DTB) Makefile
+	( $(DTC) -O dts -I dtb $(KERNEL_DTB) ; echo "/ { $(CHOSEN_NODE) $(PSCI_NODE) }; $(CPU_NODES)" ) | $(DTC) -O dtb -o $@ -
 
 # The filesystem archive might not exist if INITRD is not being used
 .PHONY: all clean $(FILESYSTEM)
diff --git a/addpsci.pl b/addpsci.pl
new file mode 100755
index 0000000..06270ca
--- /dev/null
+++ b/addpsci.pl
@@ -0,0 +1,29 @@
+#!/usr/bin/perl -w
+# Generate additions to add a PSCI enable-method to cpu nodes.
+#
+# Usage: ./$0 <DTB>
+#
+# Copyright (C) 2014 ARM Limited. All rights reserved.
+#
+# Use of this source code is governed by a BSD-style license that can be
+# found in the LICENSE.txt file.
+
+use warnings;
+use strict;
+
+use FDT;
+
+my $filename = shift;
+die("No filename provided") unless defined($filename);
+
+open (my $fh, "<:raw", $filename) or die("Unable to open file '$filename'");
+
+my $fdt = FDT->parse($fh) or die("Unable to parse DTB");
+
+my $root = $fdt->get_root();
+
+my @cpus = $root->find_by_device_type('cpu');
+
+foreach my $cpu (@cpus) {
+	printf("&{%s} { enable-method = \\\"psci\\\"; };\n", $cpu->get_full_path());
+}
diff --git a/configure.ac b/configure.ac
index bbf4308..6914eb4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -91,13 +91,6 @@ AS_IF([test "x$USE_PSCI" != "xyes" -a "x$KERNEL_ES" = "x32"],
 	[AC_MSG_ERROR([With an AArch32 kernel, boot method must be PSCI.])]
 )
 
-# Allow a user to pass --with-cpu-ids
-C_CPU_IDS="0x0,0x1,0x2,0x3"
-AC_ARG_WITH(cpu-ids,
-	AS_HELP_STRING([--with-cpu-ids], [Specify a comma seperated list of CPU IDs]),
-	[C_CPU_IDS="$withval"])
-AC_SUBST([CPU_IDS], [$C_CPU_IDS])
-
 # Allow a user to pass --with-initrd
 AC_ARG_WITH([initrd],
 	AS_HELP_STRING([--with-initrd], [embed an initrd in the kernel image]),
@@ -151,7 +144,6 @@ echo "  Device tree blob:                  ${KERN_DTB}"
 echo "  Linux kernel command line:         ${CMDLINE}"
 echo "  Embedded initrd:                   ${FILESYSTEM:-NONE}"
 echo "  Use PSCI?                          ${USE_PSCI}"
-echo "  CPU IDs:                           ${CPU_IDS}"
 echo "  Use GICv3?                         ${USE_GICV3}"
 echo "  Boot-wrapper execution state:      AArch${BOOTWRAPPER_ES}"
 echo "  Kernel execution state:            AArch${KERNEL_ES}"
diff --git a/findcpuids.pl b/findcpuids.pl
new file mode 100755
index 0000000..709db69
--- /dev/null
+++ b/findcpuids.pl
@@ -0,0 +1,32 @@
+#!/usr/bin/perl -w
+# Find CPU IDs
+#
+# Usage: ./$0 <DTB>
+#
+# Copyright (C) 2014 ARM Limited. All rights reserved.
+#
+# Use of this source code is governed by a BSD-style license that can be
+# found in the LICENSE.txt file.
+
+use warnings;
+use strict;
+
+use FDT;
+
+my $filename = shift;
+die("No filename provided") unless defined($filename);
+
+open (my $fh, "<:raw", $filename) or die("Unable to open file '$filename'");
+
+my $fdt = FDT->parse($fh) or die("Unable to parse DTB");
+
+my $root = $fdt->get_root();
+
+my @cpus = $root->find_by_device_type('cpu');
+
+my @ids = map {
+	my ($addr, $size) = $_->get_untranslated_reg(0);
+	sprintf("0x%x", $addr);
+} @cpus;
+
+printf("%s\n", join(',', @ids));
diff --git a/gen-cpu-nodes.sh b/gen-cpu-nodes.sh
deleted file mode 100755
index eaa2e7c..0000000
--- a/gen-cpu-nodes.sh
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/sh
-# Very dumb shell script to generate DTB nodes that changes the
-# boot-method to PSCI.
-#
-# Copyright (C) 2014 ARM Limited. All rights reserved.
-#
-# Use of this source code is governed by a BSD-style license that can be
-# found in the LICENSE.txt file.
-
-CPU_IDS=$1;
-CPU_IDS_NO_HEX=$(echo $CPU_IDS | sed s/0x//g);
-CPU_IDS_NO_HEX=$(echo $CPU_IDS_NO_HEX | sed s/\,/\ /g);
-
-echo '#address-cells = <0x1>;'
-echo '#size-cells = <0>;'
-
-for id in $CPU_IDS_NO_HEX;
-do
-	echo "cpu@$id {"
-	echo '	device_type = \"cpu\";'
-	echo '	enable-method = \"psci\";'
-	echo "	reg = <0x$id>;"
-	echo "};"
-done
-- 
1.9.1
