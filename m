From: asamson@codeaurora.org (Azriel Samson)
Date: Thu, 31 Mar 2016 11:31:18 -0600
Subject: [PATCH v1] builddeb: fix missing headers in linux-headers package
Message-ID: <1459445479-10948-1-git-send-email-asamson@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel headers package (linux-headers) doesn't include
header files from other architectures required to build
out-of-tree modules.

For e.g. on ARM64, opcodes.h includes the same file from ARM
which causes the following error:
./arch/arm64/include/asm/opcodes.h:1:43: fatal error:
../../arm/include/asm/opcodes.h: No such file or directory
compilation terminated.

Signed-off-by: Azriel Samson <asamson@codeaurora.org>
---
 scripts/package/builddeb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 6c3b038..06ba0d9 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -322,7 +322,7 @@ fi
 
 # Build kernel header package
 (cd $srctree; find . -name Makefile\* -o -name Kconfig\* -o -name \*.pl) > "$objtree/debian/hdrsrcfiles"
-(cd $srctree; find arch/$SRCARCH/include include scripts -type f) >> "$objtree/debian/hdrsrcfiles"
+(cd $srctree; find arch/*/include include scripts -type f) >> "$objtree/debian/hdrsrcfiles"
 (cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
 (cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> "$objtree/debian/hdrsrcfiles"
 (cd $objtree; find arch/$SRCARCH/include Module.symvers include scripts -type f) >> "$objtree/debian/hdrobjfiles"
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
