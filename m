From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Oct 2015 13:52:30 +0100
Subject: [PATCH 1/3] mtd: create a partition type device tree binding
Message-ID: <1446123152-22666-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Linux code in drivers/mtd/maps/physmap_of.c will optionally
look for the linux,part-probe binding for hints on a partition type to
look for in the MTD. It was added in commit 9d5da3a9b849
"mtd: extend physmap_of to let the device tree specify the parition probe"

This solution is too Linux-specific and depend on some
Linux kernel-internal naming conventions. We need a proper
way of describing partition types that follow the pattern set by
other device tree bindings.

Create a "partition-type" binding for this, and add "my" bindings
for "arm,arm-flash-structure" as a starter for others to follow.
A follow-on patch adds support to the Linux kernel to handle this
binding, with some infrastructure for others to use it too.

Cc: devicetree at vger.kernel.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Reported-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/mtd/mtd-physmap.txt        |  2 ++
 .../devicetree/bindings/mtd/partition.txt          | 35 +++++++++++++++++++---
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
index 4a0a48bf4ecb..863560bdbb19 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
@@ -23,6 +23,8 @@ file systems on embedded devices.
    unaligned accesses as implemented in the JFFS2 code via memcpy().
    By defining "no-unaligned-direct-access", the flash will not be
    exposed directly to the MTD users (e.g. JFFS2) any more.
+ - partition-type : a flash partition type to expect and probe for
+   on this device. See "partition.txt" for available partition types.
  - linux,mtd-name: allow to specify the mtd name for retro capability with
    physmap-flash drivers as boot loader pass the mtd partition via the old
    device name physmap-flash.
diff --git a/Documentation/devicetree/bindings/mtd/partition.txt b/Documentation/devicetree/bindings/mtd/partition.txt
index 8e5557da1955..85d45764a4b3 100644
--- a/Documentation/devicetree/bindings/mtd/partition.txt
+++ b/Documentation/devicetree/bindings/mtd/partition.txt
@@ -1,9 +1,36 @@
 Representing flash partitions in devicetree
 
-Partitions can be represented by sub-nodes of an mtd device. This can be used
-on platforms which have strong conventions about which portions of a flash are
-used for what purposes, but which don't use an on-flash partition table such
-as RedBoot.
+On-device partition types:
+
+It is possible for some drivers to indicate an on-device partition type, i.e.
+partition tables, footers or other binary pattern in the flash used to
+define how the flash is partitioned. This can be done in the device tree node
+of an MTD device by specifying partition-type = "foo"; This tells the operating
+system to look for the partition type indicated.
+
+Required properties:
+- partition-type : the type of partition. Only one type can be specified.
+  Valid types are:
+  "arm,arm-flash-structure" (also called AFS)
+
+Example:
+
+flash0 at 40000000 {
+	/* 2 * 32MiB NOR Flash memory */
+	compatible = "arm,vexpress-flash", "cfi-flash";
+	partition-type = "arm,arm-flash-structure";
+	reg = <0x40000000 0x04000000>;
+	bank-width = <4>;
+};
+
+
+Device Tree specified partitions:
+
+If there is no specified on-device binary format, partitions can be
+represented by sub-nodes of an mtd device. This can be used on platforms which
+have strong conventions about which portions of a flash are used for what
+purposes.
+
 NOTE: if the sub-node has a compatible string, then it is not a partition.
 
 #address-cells & #size-cells must both be present in the mtd device. There are
-- 
2.4.3
