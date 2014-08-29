From: jotihojr@gmail.com (John Holland)
Date: Fri, 29 Aug 2014 12:18:22 +0200
Subject: [BUG] ARM: imx6q fec watchdog timeout with TX ring dump, eth[01]
 balance-rr bonded
Message-ID: <5400536E.2080709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,


I've been playing around with a Utilite Pro recently. It features a 
Freescale imx6q with SoC FEC as eth0 and a second ether Intel I211 
interface on PCIE being mapped to eth1 amongst various other bits.

ATM, it's running debian jessie and kernel 3.16.1 with the recent three 
patch sets from Russell King 
athttp://ftp.arm.linux.org.uk/cgit/linux-arm.git/log/?h=fec-testing.

During normal operation, I have had the occasional FEC Watchdog Timeout 
(FWT). However, when eth0 und eth1 are bonded to balance-rr mode and two 
independent iperfs cliented by different machines with each 4 threads 
run free on the Utilite, it inevitably comes to FWTs. Raising 
packets_per_slave to four seems to help somewhat.

I've tried other bond types, but that doesn't help.

The bond is routed through two aggregated (trunk) ports on a Netgear 
JGS524E running to the iperf clients.

The resulting dtb being used contains
             ethernet at 02188000 {
                                 clock-names = "ipg", "ahb", "ptp";
                                 clocks = <0x2 0x75 0x2 0x75 0x2 0xbe>;
                                 compatible = "fsl,imx6q-fec";
                                 interrupts-extended = <0x1 0x0 0x76 0x4 
0x1 0x0 0x77 0x4>;
                                 phy-mode = "rgmii";
                                 pinctrl-0 = <0x24>;
                                 pinctrl-names = "default";
                                 reg = <0x2188000 0x4000>;
                                 status = "okay";
                         };

and the interrupts-extended node is being picked up from imx6qdl.dtsi
                         fec: ethernet at 02188000 {
                                 compatible = "fsl,imx6q-fec";
                                 reg = <0x02188000 0x4000>;
                                 interrupts-extended =
                                         <&intc 0 118 IRQ_TYPE_LEVEL_HIGH>,
                                         <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
                                 clocks = <&clks 117>, <&clks 117>, 
<&clks 190>;
                                 clock-names = "ipg", "ahb", "ptp";
                                 status = "disabled";
                         };


Drop me a line, if you need more information.


TIA,

John


[1] Patch set 
A:http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/270173.html 

[2] Patch set 
B:http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/270373.html 

[3] Patch set 
C:http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/270393.html 

[4] Linux bonding 
documentationhttps://www.kernel.org/doc/Documentation/networking/bonding.txt
[5] Utilite Pro product 
pagehttp://utilite-computer.com/web/utilite-pro-specifications
[6] Utilite Pro bonding configurationhttp://www.utilite-co 
mputer.com/forum/viewtopic.php?f=73&t=1980&sid=31eb3a1273da28916d665112f8af2350


-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.gz
Type: application/gzip
Size: 26690 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/df35d023/attachment-0003.gz>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fec-watchdog.log.gz
Type: application/gzip
Size: 7123 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/df35d023/attachment-0004.gz>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx6q-cm-fx6.dtb
Type: application/octet-stream
Size: 32093 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/df35d023/attachment-0001.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx6q-cm-fx6.dts.gz
Type: application/gzip
Size: 6872 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/df35d023/attachment-0005.gz>
