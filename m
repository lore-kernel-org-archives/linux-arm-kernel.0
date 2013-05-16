From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 16 May 2013 17:55:16 +0200
Subject: [PATCHv10 1/9] arm: mvebu: fix the 'ranges' property to handle PCIe
In-Reply-To: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1368719725-21265-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 82a682676 ('ARM: dts: mvebu: Convert all the mvebu files to use
the range property') all the device nodes of Armada 370/XP are under a
common 'ranges' property that translates the device register addresses
into their absolute address, thanks to the base address of the
internal register space.

However, beyond just the register areas, there are also PCIe I/O and
memory regions, whose addresses should be properly translated. This
patch fixes the Armada 370 and XP ranges property to take PCIe into
account properly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Since the PCIe Device Tree description has been merged in 3.10-rc1,
this commit should go in 3.10-rc as well.
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    3 ++-
 arch/arm/boot/dts/armada-370.dtsi    |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 272bbc6..550eb77 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -33,7 +33,8 @@
 		#size-cells = <1>;
 		compatible = "simple-bus";
 		interrupt-parent = <&mpic>;
-		ranges = <0 0 0xd0000000 0x100000>;
+		ranges = <0          0 0xd0000000 0x0100000 /* internal registers */
+			  0xe0000000 0 0xe0000000 0x8100000 /* PCIe */>;
 
 		internal-regs {
 			compatible = "simple-bus";
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index b2c1b5a..834c9be 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -29,7 +29,8 @@
 	};
 
 	soc {
-		ranges = <0 0xd0000000 0x100000>;
+		ranges = <0          0xd0000000 0x0100000 /* internal registers */
+			  0xe0000000 0xe0000000 0x8100000 /* PCIe */>;
 		internal-regs {
 			system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
-- 
1.7.9.5
