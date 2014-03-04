From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  4 Mar 2014 17:36:59 +0100
Subject: [PATCH 1/4] ARM: mvebu: change the default PCIe apertures for Armada
 370/XP
In-Reply-To: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1393951022-18114-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest Marvell bootloaders for various boards change the MBus
Window base address from 0xC0000000 to 0xF0000000, in order to make
more RAM in the first 4 GB actually usable by the kernel (RAM that is
covered by the MBus window is "shadowed" and therefore not usable).

However, our default PCIe memory and I/O apertures where sitting at
0xe0000000 (for memory) and 0xe8000000 (for I/O), which will now be
outside of the MBus Window range on those platforms. To make things
work, we have to ensure those apertures use addresses in the
0xF0000000 -> 0xFFFFFFFF range.

Of course this change of the MBus Window base address from 0xC0000000
to 0xF0000000 also comes with a change of the internal register base
address from 0xD0000000 to 0xF1000000.

We have therefore designed the following memory map:

 * 0xF0000000 -> 0xF1000000: 16 MB, used for NOR flashes on Armada XP
   GP and Armada XP DB.

 * 0xF1000000 -> 0xF1100000: 1 MB, used for internal registers.

 * 0xF8000000 -> 0xFFE00000: 126 MB, used for PCIe memory.

 * 0xFFE00000 -> 0xFFF00000: 1 MB, used for PCIe I/O.

 * 0xFFF00000 -> 0xFFFFFFFF: 1 MB, used for the BootROM mapping

There is one exception to this layout: the Armada XP OpenBlocks, which
has a 128 MB NOR flash, mapped from 0xF0000000 to 0xF8000000. This
does not conflict with the current change for the PCIe I/O and memory
apertures, and continues to work because on Armada XP OpenBlocks, the
bootloader is an old one, and continues to have internal registers
mapped at 0xD0000000.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 74b5964..2188ce6 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -44,8 +44,8 @@
 		#size-cells = <1>;
 		controller = <&mbusc>;
 		interrupt-parent = <&mpic>;
-		pcie-mem-aperture = <0xe0000000 0x8000000>;
-		pcie-io-aperture  = <0xe8000000 0x100000>;
+		pcie-mem-aperture = <0xf8000000 0x7e00000>;
+		pcie-io-aperture  = <0xffe00000 0x100000>;
 
 		devbus-bootcs {
 			compatible = "marvell,mvebu-devbus";
-- 
1.8.3.2
