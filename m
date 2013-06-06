From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  6 Jun 2013 11:21:23 +0200
Subject: [PATCH] arm: mvebu: ensure PCIe range is propagated in the .dts files
In-Reply-To: <1370510483-32419-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370510483-32419-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1370510483-32419-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ranges DT entry needed by the PCIe controller is defined at the
SoC .dtsi level. However, some boards have a NOR flash, and to support
it, they need to override the SoC-level ranges property to add an
additional range. Since PCIe and NOR support came separately, some
boards were not properly changed to include the PCIe range in their
ranges property at the .dts level.

This commit fixes those platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-db.dts               | 1 +
 arch/arm/boot/dts/armada-xp-gp.dts               | 5 +++--
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index f5fc1a3..e28e68f 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -31,6 +31,7 @@
 
 	soc {
 		ranges = <0          0 0xd0000000 0x100000	/* Internal registers 1MiB */
+			  0xe0000000 0 0xe0000000 0x8100000     /* PCIe */
 			  0xf0000000 0 0xf0000000 0x1000000>;	/* Device Bus, NOR 16MiB   */
 
 		internal-regs {
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 0a04070..c87b2de 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -39,8 +39,9 @@
 	};
 
 	soc {
-		ranges = <0          0 0xd0000000 0x100000
-			  0xf0000000 0 0xf0000000 0x1000000>;
+		ranges = <0          0 0xd0000000 0x100000  /* Internal registers 1MiB */
+			  0xe0000000 0 0xe0000000 0x8100000 /* PCIe */
+			  0xf0000000 0 0xf0000000 0x1000000 /* Device Bus, NOR 16MiB  */>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 685ee7a..8f51045 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -27,8 +27,9 @@
 	};
 
 	soc {
-		ranges = <0          0 0xd0000000 0x100000
-			  0xf0000000 0 0xf0000000 0x8000000>;
+		ranges = <0          0 0xd0000000 0x100000	/* Internal registers 1MiB */
+			  0xe0000000 0 0xe0000000 0x8100000     /* PCIe */
+			  0xf0000000 0 0xf0000000 0x8000000     /* Device Bus, NOR 128MiB   */>;
 
 		internal-regs {
 			serial at 12000 {
-- 
1.8.1.2
