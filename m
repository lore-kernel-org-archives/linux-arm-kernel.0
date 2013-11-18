From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 18 Nov 2013 18:38:13 +0000
Subject: [RFC PATCH V2 0/2] Add 'make dtbs_install'
In-Reply-To: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
Message-ID: <cover.1384798508.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Detailed changelog can be found in each patch.

The kernel community never created a 'dtbs_install' make target for properly
handling the build output of the kernel's devicetree files.  Currently, the dtb
files are simply their source file, s/dts/dtb/.  Users have recently begun
retrieving these files from inside the kernel tree.  Any change to the dts
filenames breaks the scripts of those users.

Before this gets too far along, we'd like to create a standardized method of
installing the dtb files for users to find and use.  In addition, some vendors
have done a diligent job naming their devicetree source files appropriately and
we don't want to break their setups.

This patch series solves both problems by creating a dtbs_install make target
which calls arch/arm/boot/installdtbs.sh.  If /sbin/installdtbs or
~/bin/installdtbs is present, they will be run instead of the default behavior.

The default action is to install a given dtb to

  /lib/modules/${kernel_version}/devicetree/${board_compatible}.dtb

Ideally, the devicetree file should be independent of the kernel version,
however, we aren't there yet.  So, while the devicetree files live in the
kernel source tree, we'll install them as above.  Once they are in their own
repository, this install target can be removed, and users can adjust their
workflow to getting the dtbs from a new location.

Jason Cooper (2):
  dtc: add 'compat' output option, prints board string
  kbuild: dtbs_install: new make target

 Makefile                     |  3 ++-
 arch/arm/Makefile            |  4 ++++
 arch/arm/boot/installdtbs.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 scripts/dtc/dtc.c            |  3 +++
 scripts/dtc/dtc.h            |  1 +
 scripts/dtc/flattree.c       |  9 +++++++++
 6 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/installdtbs.sh

-- 
1.8.4.3
