From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 17 Feb 2014 15:23:22 +0100
Subject: [PATCH v4 04/13] ARM: mvebu: add Armada 375 support to the
 system-controller driver
In-Reply-To: <1392647011-30117-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392647011-30117-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392647011-30117-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The system controller block in the Armada 375 has different register
offsets for the system reset and other related functions. Therefore,
this commit introduces the new "armada-375-system-controller"
compatible string to identify the Armada 375 variant of the system
controller.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/arm/mvebu-system-controller.txt    |  3 ++-
 arch/arm/mach-mvebu/system-controller.c                    | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt b/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt
index 081c6a7..d24ab2e 100644
--- a/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt
@@ -1,12 +1,13 @@
 MVEBU System Controller
 -----------------------
-MVEBU (Marvell SOCs: Armada 370/XP, Dove, mv78xx0, Kirkwood, Orion5x)
+MVEBU (Marvell SOCs: Armada 370/375/XP, Dove, mv78xx0, Kirkwood, Orion5x)
 
 Required properties:
 
 - compatible: one of:
 	- "marvell,orion-system-controller"
 	- "marvell,armada-370-xp-system-controller"
+	- "marvell,armada-375-system-controller"
 - reg: Should contain system controller registers location and length.
 
 Example:
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index a7fb89a..1806187 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -1,5 +1,5 @@
 /*
- * System controller support for Armada 370 and XP platforms.
+ * System controller support for Armada 370, 375 and XP platforms.
  *
  * Copyright (C) 2012 Marvell
  *
@@ -11,7 +11,7 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  *
- * The Armada 370 and Armada XP SoCs both have a range of
+ * The Armada 370, 375 and Armada XP SoCs have a range of
  * miscellaneous registers, that do not belong to a particular device,
  * but rather provide system-level features. This basic
  * system-controller driver provides a device tree binding for those
@@ -47,6 +47,13 @@ static const struct mvebu_system_controller armada_370_xp_system_controller = {
 	.system_soft_reset = 0x1,
 };
 
+static const struct mvebu_system_controller armada_375_system_controller = {
+	.rstoutn_mask_offset = 0x54,
+	.system_soft_reset_offset = 0x58,
+	.rstoutn_mask_reset_out_en = 0x1,
+	.system_soft_reset = 0x1,
+};
+
 static const struct mvebu_system_controller orion_system_controller = {
 	.rstoutn_mask_offset = 0x108,
 	.system_soft_reset_offset = 0x10c,
@@ -61,6 +68,9 @@ static struct of_device_id of_system_controller_table[] = {
 	}, {
 		.compatible = "marvell,armada-370-xp-system-controller",
 		.data = (void *) &armada_370_xp_system_controller,
+	}, {
+		.compatible = "marvell,armada-375-system-controller",
+		.data = (void *) &armada_375_system_controller,
 	},
 	{ /* end of list */ },
 };
-- 
1.8.3.2
