From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 18:23:17 +0100
Subject: [PATCH 06/11] ARM: mvebu: add Armada 380/385 support to the
 system-controller driver
In-Reply-To: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392053002-19831-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds support for the Armada 380/385 SoCs in the
system-controller driver. Since this SoC has the same system
controller registers layout than the Armada 370/XP at least for the
few features currently supported by the driver, this commit simply
adds a new compatible string that provides the same behavior than the
one provided for Armada 370/XP.

Note that we intentionally do not use the same compatible string as
Armada 370/XP, as the current system-controller driver is far from
exploiting all the possibilities of the hardware, and we may in the
future discover differences between Armada 370/XP and Armada 380/385.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/mvebu-system-controller.txt | 3 ++-
 arch/arm/mach-mvebu/system-controller.c                           | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt b/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt
index d24ab2e..3559972 100644
--- a/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt
@@ -1,6 +1,6 @@
 MVEBU System Controller
 -----------------------
-MVEBU (Marvell SOCs: Armada 370/375/XP, Dove, mv78xx0, Kirkwood, Orion5x)
+MVEBU (Marvell SOCs: Armada 370/375/38x/XP, Dove, mv78xx0, Kirkwood, Orion5x)
 
 Required properties:
 
@@ -8,6 +8,7 @@ Required properties:
 	- "marvell,orion-system-controller"
 	- "marvell,armada-370-xp-system-controller"
 	- "marvell,armada-375-system-controller"
+	- "marvell,armada-380-system-controller"
 - reg: Should contain system controller registers location and length.
 
 Example:
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index 1806187..b4e8bb2 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -71,6 +71,14 @@ static struct of_device_id of_system_controller_table[] = {
 	}, {
 		.compatible = "marvell,armada-375-system-controller",
 		.data = (void *) &armada_375_system_controller,
+	}, {
+		/*
+		 * As far as RSTOUTn and System soft reset registers
+		 * are concerned, Armada 38x is similar to Armada
+		 * 370/XP
+		 */
+		.compatible = "marvell,armada-380-system-controller",
+		.data = (void *) &armada_370_xp_system_controller,
 	},
 	{ /* end of list */ },
 };
-- 
1.8.3.2
