From: post@twien.net (post at twien.net)
Date: Tue, 14 Oct 2014 13:14:50 +0200
Subject: ARMADA 370 - Distributed Switch Architecture (dsa) - device tree
In-Reply-To: <CAGVrzcZyRnizGHzCUZc=UD7E8vLJtqSXf=oxtHik27WXNMLU3w@mail.gmail.com>
References: <f1e8d1ba750bfb63f84471d0ec7de988@twien.net>
 <CAGVrzcZyRnizGHzCUZc=UD7E8vLJtqSXf=oxtHik27WXNMLU3w@mail.gmail.com>
Message-ID: <a35938e94d480b5a9c24720962ef46ff@twien.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Florian,
Thanks for the tip. If you wouldn't mind share your Device Tree source I 
would be pleased.
Best,
Tormod

On 2014-10-14 04:08, Florian Fainelli wrote:
> 2014-10-13 3:14 GMT-07:00  <post@twien.net>:
>> Dear all,
>> I have a custom board equipped with an ARMADA 370 SoC (88f6W11) and a
>> Marvell switch chip (88e6352) (I have written a device driver for the
>> latter).
>> My question is how to set up a proper device tree specification for 
>> the
>> board. The device tree specification is listed below. This is based on 
>> a
>> similar .dts-file for the kirkwood SoC.
>> Further down is a excerpt of the start up sequence. I would imagine 
>> the
>> switch would be installed as the "PHY" for eth0 (which seems not to be 
>> the
>> case). I added some additional printout messages, and from what I can 
>> see a
>> generic device driver is loaded, and eventually the mvneta_open/-probe
>> function states that the PHY can not be found. I have read the 
>> "examples" in
>> the ../boot/dts directory and also read the documentation. There are 
>> some
>> confusing things, for example the "dsa,mii-bus;" specification where I
>> eventually put in "dsa,mii-bus = <&mdio_bus>;". From both the examples 
>> and
>> the documentation it seemed I should specify a device on the mdio_bus, 
>> e.g.
>> "phy0", but when I did the whole thing crashed.
>> So specifying "mdio_bus" at least got me running a bit further, and 
>> the dsa
>> driver was detected and the proper switch device was identified.
>> What I would like to achieve is to get eth0 to connect to port 5 on 
>> the
>> switch using SGMII.
>> Any advice on how to proceed would  be appreciated.
> 
> At this point, what I would do is create a fixed-phy Device Tree node
> for mvneta to hardcode the link indication/speed/duplex, and specify
> the 'phy-mode' property to be "sgmii", and of course, remove the
> 'phy-handle' property such that the fixed PHY is used instead.
> 
> Right now, DSA drivers are not created as regular PHY drivers (which
> is something on my TODO list), such that they do not provide link
> indication towards the CPU Ethernet MAC. Except for the front-panel
> external ports, Ethernet switches does not report standardized link
> parameters through the standard MII registers for the CPU port, which
> is why we have to find another way to do that.
> 
> In case that helps, I could copy/paste a Device Tree source for a
> Broadcom SoC I use which has both of its DSA switch driver (bcm_sf2)
> and Ethernet MAC (bcmsysport) drivers mainline.
> 
> Please note that, in order to boot from the network with DSA-enabled
> devices, you need such a patch:
> http://patchwork.ozlabs.org/patch/354293/
> 
> which I should re-submit eventually
> 
> 
>> 
>> 
>> +---------+
>> |         |           +--------+
>> |         |   SGMII   |        |----- p0
>> |     eth0|-----------|p5      |  .    .
>> |         |           |        |----- p4
>> +---------+           +--------+
>> ARMADA 370             88e6352
>> 
>> 
>> Tormod
>> 
>> 
>> 
>> /*
>>  * Device Tree file for Marvell Armada 370 Ethernet Prototype board
>>  * ()
>>  *
>>  *  Copied from arch/arm/boot/dts/armada-370-rd.dts
>>  *
>>  *  Copyright (C) 2014 ...
>>  *
>>  * This file is licensed under the terms of the GNU General Public
>>  * License version 2.  This program is licensed "as is" without any
>>  * warranty of any kind, whether express or implied.
>>  */
>> 
>> /dts-v1/;
>> #include <dt-bindings/input/input.h>
>> #include <dt-bindings/gpio/gpio.h>
>> #include "armada-370.dtsi"
>> 
>> / {
>>         model = "Marvell Armada 370 Ethernet Prototype";
>>         compatible = "marvell,armada370", "marvell,armada-370-xp";
>> 
>>         chosen {
>>                 bootargs = "console=ttyS0,115200 earlyprintk";
>>         };
>> 
>>         memory {
>>                 device_type = "memory";
>>                 reg = <0x00000000 0x40000000>; /* 1 GB */
>>         };
>> 
>>         soc {
>>                 ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
>>                           MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
>> 
>> 
>>                 pcie-controller {
>>                         status = "okay";
>> 
>>                         /* Internal mini-PCIe connector */
>>                         pcie at 1,0 {
>>                                 /* Port 0, Lane 0 */
>>                                 status = "okay";
>>                         };
>> 
>>                         /* Internal mini-PCIe connector */
>>                         pcie at 2,0 {
>>                                 /* Port 1, Lane 0 */
>>                                 status = "okay";
>>                         };
>>                 };
>> 
>>                 internal-regs {
>>                         serial at 12000 {
>>                                 status = "okay";
>>                         };
>> 
>>                         mdio_bus: mdio {
>>                                 phy0: ethernet-phy at ff {
>> /*                                      compatible =
>> "ethernet-phy-id5043.0eb0", "ethernet-phy-ieee802.3-c22";
>> */
>>                                         reg = <0xff>;  /* no PHY 
>> connected
>> */
>>                                         speed = <1000>;
>>                                         duplex = <1>;
>>                                 };
>> 
>> /*                              phy1: ethernet-phy at 1 {
>>                                         reg = <0x1>;
>>                                 };
>> */
>>                         };
>> 
>>                         ethernet at 70000 {
>>                                 status = "okay";
>>                                 phy = <&phy0>;
>>                                 phy-mode = "sgmii";
>>                         };
>> 
>> /*                      ethernet at 74000 {
>>                                 status = "okay";
>>                                 phy = <&phy1>;
>>                                 phy-mode = "rgmii-id";
>>                         };
>> */
>>                         mvsdio at d4000 {
>>                                 pinctrl-0 = <&sdio_pins1>;
>>                                 pinctrl-names = "default";
>>                                 status = "okay";
>>                                 /* No CD or WP GPIOs */
>>                                 broken-cd;
>>                         };
>> 
>>                         usb at 50000 {
>>                                 status = "okay";
>>                         };
>> 
>> 
>> /*                      usb at 51000 {
>>                                 status = "okay";
>>                         };
>> */
>>                         spi0: spi at 10600 {
>>                                 status = "okay";
>>                                 };
>> 
>>                         i2c at 11000 {
>>                                 pinctrl-0 = <&i2c0_pins>;
>>                                 pinctrl-names = "default";
>>                                 clock-frequency = <100000>;
>>                                 status = "okay";
>>                         };
>> 
>>                         nand at d0000 {
>>                                 status = "okay";
>>                                 num-cs = <1>;
>>                                 marvell,nand-keep-config;
>>                                 marvell,nand-enable-arbiter;
>>                                 nand-on-flash-bbt;
>> 
>>                                 partition at 0 {
>>                                         label = "U-Boot";
>>                                         reg = <0 0x800000>;
>>                                 };
>>                                 partition at 800000 {
>>                                         label = "Linux";
>>                                         reg = <0x800000 0x800000>;
>>                                 };
>>                                 partition at 1000000 {
>>                                         label = "Filesystem";
>>                                         reg = <0x1000000 0x3f000000>;
>>                                 };
>>                         };
>>                 };
>>         };
>> 
>>         dsa at 0 {
>>                 compatible = "marvell,dsa";
>>                #address-cells = <2>;
>>                 #size-cells = <0>;
>>                 dsa,ethernet = <&eth0>;
>>                 dsa,mii-bus = <&mdio_bus>;
>> 
>>                 switch at 0 {
>>                         #address-cells = <1>;
>>                         #size-cells = <0>;
>> 
>>                         reg = <0 0>;
>> 
>>                         port at 0 {
>>                                 reg = <0>;
>>                                 label = "lan1";
>>                         };
>> 
>>                         port at 1 {
>>                                 reg = <1>;
>>                                 label = "lan2";
>>                         };
>> 
>>                         port at 2 {
>>                                 reg = <2>;
>>                                 label = "lan3";
>>                         };
>> 
>>                         port at 3 {
>>                                 reg = <3>;
>>                                 label = "lan4";
>>                         };
>> 
>>                         port at 5 {
>>                                 reg = <5>;
>>                                 label = "cpu";
>>                         };
>> 
>>                         port at 6 {
>>                                 reg = <6>;
>>                                 label = "lan6";
>>                         };
>>                 };
>>         };
>> 
>>  };
>> 
>> 
>> nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x38
>> nand: Micron MT29F8G08ABABAWP
>> nand: 1024MiB, SLC, page size: 4096, OOB size: 224
>> pxa3xx-nand f10d0000.nand: ECC strength 16, ECC step size 2048
>> Bad block table found at page 262016, version 0x01
>> Bad block table found at page 261888, version 0x01
>> 3 ofpart partitions found on MTD device pxa3xx_nand-0
>> Creating 3 MTD partitions on "pxa3xx_nand-0":
>> 0x000000000000-0x000000800000 : "U-Boot"
>> 0x000000800000-0x000001000000 : "Linux"
>> 0x000001000000-0x000040000000 : "Filesystem"
>> mdiobus register device_node: mdio
>> libphy: orion_mdio_bus: probed
>> mdio_bus f1072004.mdio-mi: /soc/internal-regs/mdio/ethernet-phy at ff PHY
>> address 255 is too large
>> mvneta_probe: ethernet device: eth%d
>> mvneta_probe: phy_node: ethernet-phy
>> mvneta f1070000.ethernet eth0: Using hardware mac address 
>> 00:50:43:02:02:00
>> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> ehci-pci: EHCI PCI platform driver
>> ehci-orion: EHCI orion driver
>> orion-ehci f1050000.usb: EHCI Host Controller
>> orion-ehci f1050000.usb: new USB bus registered, assigned bus number 1
>> orion-ehci f1050000.usb: irq 26, io mem 0xf1050000
>> orion-ehci f1050000.usb: USB 2.0 started, EHCI 1.00
>> hub 1-0:1.0: USB hub found
>> hub 1-0:1.0: 1 port detected
>> usbcore: registered new interface driver usb-storage
>> mousedev: PS/2 mouse device common for all mice
>> rtc-mv f1010300.rtc: internal RTC not ticking
>> orion_wdt: Initial timeout 229 sec
>> usbcore: registered new interface driver usbhid
>> usbhid: USB HID core driver
>> TCP: cubic registered
>> Distributed Switch Architecture driver version 0.1
>> eth0[0]: detected a Marvell 88E6352 switch
>> libphy: dsa slave smi: probed
>> ThumbEE CPU extension supported.
>> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
>> mvneta_mdio_probe: mvneta_probe: ethernet-phy
>> mvneta f1070000.ethernet eth0: could not find the PHY
>> mvneta f1070000.ethernet eth0: cannot probe MDIO bus
>> IP-Config: Failed to open eth0
>> IP-Config: Failed to open lan1
>> IP-Config: Failed to open lan2
>> IP-Config: Failed to open lan3
>> IP-Config: Failed to open lan4
>> IP-Config: Failed to open lan6
>> IP-Config: No network devices available
>> 
>> 
>> 
>> 
>> 
>> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
