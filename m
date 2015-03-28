From: dobatog@gmail.com (Gabriel Dobato)
Date: Sat, 28 Mar 2015 21:47:20 +0100
Subject: Ask for help: ARM: mvebu: add NAND support for dove
Message-ID: <55171358.5070200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am trying to set the Nand in a CM-510 Compulab based board (4.0-rc5).

As pxa3xx-nand driver supports NFCv1 (PXA3xx) and NFCv2 (Armada 370/XP), 
  I think that it should work more or less with Dove SoC (NFCv1) that is 
similar enough.

Until now, I've only added the correspondent node in dove.dtsi and the 
partitions in dove-cm-a510.dts ( it should be updated in the patch 
series that Sebastian Hesselbarth submitted ) :

---
  arch/arm/boot/dts/dove-cm-a510.dts | 17 +++++++++++++++++
  arch/arm/boot/dts/dove.dtsi        | 16 ++++++++++++++++
  2 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/dove-cm-a510.dts 
b/arch/arm/boot/dts/dove-cm-a510.dts
index 50c0d69..36cf10d 100644
--- a/arch/arm/boot/dts/dove-cm-a510.dts
+++ b/arch/arm/boot/dts/dove-cm-a510.dts
@@ -36,3 +36,20 @@
  &i2c0 {
           status = "okay";
  };
+
+&nand  {
+          status = "okay";
+          num-cs = <1>;
+          partition at 0 {
+                 label = "uImage";
+                 reg = <0x000000000000 0x000000400000>;
+          };
+          partition at 400000 {
+                 label = "Rootfs";
+                 reg = <0x000000400000 0x00001FC00000>;
+          };
+};
+
+
+
+
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index a5441d5..7e71f45 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -380,6 +380,22 @@
                                 status = "disabled";
                         };

+                       nand: nand at c0000 {
+                                compatible = "marvell,armada370-nand";
+                                #address-cells = <1>;
+                                #size-cells = <1>;
+                                reg= <0xc0000 0x60>;
+                                interrupts = <3>;
+                                clocks = <&core_clk 0>;
+                                pinctrl-0 = <&pmx_nand>;
+                                pinctrl-names = "default";
+                                marvell,nand-keep-config;
+                                marvell,nand-enable-arbiter;
+                                nand-on-flash-bbt;
+                        };
+
+
+
                         thermal: thermal-diode at d001c {
                                 compatible = "marvell,dove-thermal";
                                 reg = <0xd001c 0x0c>, <0xd005c 0x08>;
-- 
1.9.1


Int the boot trace, the Nand is detected:

...
brd: module loaded
loop: module loaded
mtip32xx Version 1.3.1
pxa3xx-nand f10c0000.nand: This platform can't do DMA on this device
nand: device found, Manufacturer ID: 0xec, Chip ID: 0xdc
nand: Samsung NAND 512MiB 3,3V 8-bit
nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
pxa3xx-nand f10c0000.nand: ECC strength 16, ECC step size 2048
Scanning device for bad blocks
random: nonblocking pool is initialized
Bad eraseblock 1692 at 0x00000d380000
Bad eraseblock 2395 at 0x000012b60000
Bad eraseblock 3877 at 0x00001e4a0000
2 ofpart partitions found on MTD device pxa3xx_nand-0
Creating 2 MTD partitions on "pxa3xx_nand-0":
0x000000000000-0x000020000000 : "uImage"
0x000000400000-0x000020000000 : "rootfs"
jme: JMicron JMC2XX ethernet driver version 1.0.8
libphy: orion_mdio_bus: probed
mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
mv643xx_eth_port mv643xx_eth_port.0 eth0: port 0 with MAC address 
00:01:c0:15:83:8e
usbcore: registered new interface driver smsc95xx
...

root at debug:~# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 20000000 00020000 "uImage"
mtd1: 1fc00000 00020000 "rootfs"

....


However, if I try to read/write into the mtd partitions, I can not, 
there are errors:

root at debug:~# nandwrite -p /dev/mtd0 /uImage
Writing at 0x00000000
pxa3xx-nand f10c0000.nand: Wait time out!!!

root at debug:~# flash_erase /dev/mtd0 0 0
Erasing 128 Kibyte @ 0 --  0 % complete pxa3xx-nand f10c0000.nand: Wait 
time out!!!

root at debug:~# cat /dev/mtd0
pxa3xx-nand f10c0000.nand: Wait time out!!!



AFAIK, the clock frequency of Dove Nand controller is different, so 
maybe is necessary to adapt timings... and I suppose something else...

I really appreciate any kind of help or advise .

Thank you.

Gabriel Dobato
