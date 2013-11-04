From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 04 Nov 2013 19:00:11 +0100
Subject: [BUG?] ARM: mvebu: is second PCIe unit of Armada XP mv78230 x1 or x4?
Message-ID: <87ppqgyrmc.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am currently playing with a NETGEAR ReadyNAS 2120. It is powered by a
2-core Armada XP SoC, more precisely a 78230 (this is what NETGEAR
advertises about the product; see the u-boot and /proc/cpuinfo info at
the end of this message).

I spent some time this week-end trying to figure out why I was unable to
see the Fresco Logic FL1009 XHCI controller (PCIe Gen II x1) connected
to the PCIe bus on a 3.12-rc7 with a custom .dts: Even after enabling
all available ports referenced in armada-xp-mv78230.dtsi, I still only
see the 2 Marvell SATA controllers (on Lane 0 and 1 of port 0) but not
the FL1009.

At some point, because I suspected a PCIe definition issue, I decided to
modify my .dts and make it inherit from armada-xp-mv78460.dtsi with all
PCIe ports enabled. At that point, here is what I got: 

root at thin:~# lspci 
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:04.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:05.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:06.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:07.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:08.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:09.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:0a.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9170 (rev 12)
02:00.0 SATA controller: Marvell Technology Group Ltd. Device 9170 (rev 12)
03:00.0 Memory controller: Marvell Technology Group Ltd. Device 7846 (rev 02)
04:00.0 Memory controller: Marvell Technology Group Ltd. Device 7846 (rev 02)
05:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02)
06:00.0 Memory controller: Marvell Technology Group Ltd. Device 7846 (rev 02)
07:00.0 Memory controller: Marvell Technology Group Ltd. Device 7846 (rev 02)
08:00.0 Memory controller: Marvell Technology Group Ltd. Device 7846 (rev 02)
09:00.0 Memory controller: Marvell Technology Group Ltd. Device 7846 (rev 02)
0a:00.0 Memory controller: Marvell Technology Group Ltd. Device 7846 (rev 02)

Then, I took a look at the [laconic] public documentation on the various
flavours of the Armada XP (mv7823, mv78260 and mv78460) regarding PCIe
aspects. I noticed that [1] reports a x1 second PCIe unit for mv78230
when [2] reports one x4 second unit for mv78230. FWIW, armada-xp-mv78230.dtsi
currently states the second unit is x4/x1.

[1]: http://www.marvell.com/embedded-processors/armada-xp/
[2]: http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf

I started modifying the 3.12-rc7 armada-xp-mv78230.dtsi considering [1]
was right and [2] was wrong. With the attached patch, here is what I get
with a .dts based on the modified armada-xp-mv78230.dtsi. Simply put,
it works (can see FL1009 and use it):

root at thin:~# lspci
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:05.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9170 (rev 12)
02:00.0 SATA controller: Marvell Technology Group Ltd. Device 9170 (rev 12)
03:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02)

At that point, my .dts contains the following:

	pcie-controller {
		status = "okay";

		/* Connected to first Marvell 88SE9170 SATA controller */
		pcie at 1,0 {
			/* Port 0, Lane 0 */
			status = "okay";
		};

		/* Connected to second Marvell 88SE9170 SATA controller */
		pcie at 2,0 {
			/* Port 0, Lane 1 */
			status = "okay";
		};

		/* Connected to Fresco Logic FL1009 USB 3.0 controller */
		pcie at 5,0 {
			/* Port 1, Lane 0 */
			status = "okay";
		};
	};

As I am way out of my league on the topic and do not have access to any
proper documentation, can someone give me some hints (based on symptoms
and working patch) on what may be happening? If I am correct on the root
cause, can someone comment on the patch?

Cheers,

a+


For the records, here is what NETGEAR u-boot reports:

U-Boot 2011.12 (Apr 09 2013 - 10:24:15) Marvell version: 2012_Q4.0
Netgear version: 04/09/2013 ReadyNAS-2120 V1.7.8

Board: DB-78460-BP rev 2.0
SoC:   MV78230 B0
       running 2 CPUs
       Custom configuration
CPU:   Marvell PJ4B (584) v7 (Rev 2) LE
       CPU 0
       CPU    @ 1200 [MHz]
       L2     @ 600 [MHz]
       TClock @ 250 [MHz]
       DDR    @ 600 [MHz]
       DDR 32Bit Width, FastPath Memory Access
       DDR ECC Disabled
DRAM:  2 GiB

and what I get on current 3.12-rc7 kernel:

/ # cat /proc/cpuinfo
Processor	: Marvell PJ4Bv7 Processor rev 2 (v7l)
processor	: 0
BogoMIPS	: 1196.85

processor	: 1
BogoMIPS	: 1196.85

Features	: swp half thumb fastmult vfp edsp vfpv3 
CPU implementer	: 0x56
CPU architecture: 7
CPU variant	: 0x2
CPU part	: 0x584
CPU revision	: 2

Hardware	: Marvell Armada XP Development Board
Revision	: 0000
Serial		: 0000000000000000


diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 0358a33..9dc7381 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -47,7 +47,7 @@
 		/*
 		 * MV78230 has 2 PCIe units Gen2.0: One unit can be
 		 * configured as x4 or quad x1 lanes. One unit is
-		 * x4/x1.
+		 * x1 only.
 		 */
 		pcie-controller {
 			compatible = "marvell,armada-xp-pcie";
@@ -61,10 +61,10 @@
 
 			ranges =
 			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
-				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
 				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
 				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
 				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
+				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000   /* Port 1.0 registers */
 				0x82000000 0x1 0       MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
 				0x81000000 0x1 0       MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
 				0x82000000 0x2 0       MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
@@ -73,8 +73,8 @@
 				0x81000000 0x3 0       MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
 				0x82000000 0x4 0       MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
 				0x81000000 0x4 0       MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */
-				0x82000000 0x9 0       MBUS_ID(0x04, 0xf8) 0 1 0 /* Port 2.0 MEM */
-				0x81000000 0x9 0       MBUS_ID(0x04, 0xf0) 0 1 0 /* Port 2.0 IO  */>;
+				0x82000000 0x5 0       MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
+				0x81000000 0x5 0       MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */>;
 
 			pcie at 1,0 {
 				device_type = "pci";
@@ -144,20 +144,20 @@
 				status = "disabled";
 			};
 
-			pcie at 9,0 {
+			pcie at 5,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
-				reg = <0x4800 0 0 0 0>;
+				assigned-addresses = <0x82000800 0 0x80000 0 0x2000>;
+				reg = <0x2800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				#interrupt-cells = <1>;
-				ranges = <0x82000000 0 0 0x82000000 0x9 0 1 0
-					  0x81000000 0 0 0x81000000 0x9 0 1 0>;
+				ranges = <0x82000000 0 0 0x82000000 0x5 0 1 0
+					  0x81000000 0 0 0x81000000 0x5 0 1 0>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 99>;
-				marvell,pcie-port = <2>;
+				interrupt-map = <0 0 0 0 &mpic 62>;
+				marvell,pcie-port = <1>;
 				marvell,pcie-lane = <0>;
-				clocks = <&gateclk 26>;
+				clocks = <&gateclk 9>;
 				status = "disabled";
 			};
 		};
