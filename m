From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Thu, 29 Sep 2016 07:32:23 -0700
Subject: [PATCH] arm64: make rpm failed due to incorrect path to Image.gz
Message-ID: <1475159543-2519-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "make rpm" and "make rpm-pkg" commands for arm64 platform are broken
due to rpmbuild couldn't find Image.gz file at default location (which
is kernel src root):
 cp: cannot stat 'Image.gz': No such file or directory
 error: Bad exit status from /var/tmp/rpm-tmp.ocFBmP (%install)

While the correct path to arm64 kernel image file
is "arch/arm64/boot/Image.gz".

The exact file name (Image.gz) is stored at KBUILD_IMAGE variable
and read by rpmbuild with "make image_name" command at
install phase after kernel build is complete.

Accordingly to  Michal's Marek comment it is necesary
that the KBUILD_IMAGE variable value has to be set
accordingly to point to actual file and thus fix that issue.

Since the KBUILD_IMAGE variable is used in general cases of
build we need to prevent other build types breakage by changing it.

The solution is to add to arch/arm64/Makefie extra target "image_name"
with dependency "KBUILD_IMAGE:=<proper path to Image.gz file>".
Thus it will allow to set proper path to Image.gz file only for
the "image_name" build target and this exact value will be picked up
while rpm build install phase.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
---
 arch/arm64/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index ab51aed..09926d3 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -101,6 +101,8 @@ all:	$(KBUILD_IMAGE) $(KBUILD_DTBS)
 
 boot := arch/arm64/boot
 
+image_name: KBUILD_IMAGE :=$(boot)/$(KBUILD_IMAGE)
+
 Image: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-- 
1.8.3.1
