From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 29 May 2018 15:52:57 +1000
Subject: linux-next: manual merge of the irqchip tree with the arm-soc tree
Message-ID: <20180529155257.5ae48830@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the irqchip tree got a conflict in:

  arch/arm/boot/dts/stm32mp157c.dtsi

between commit:

  3c00436fdb20 ("ARM: dts: stm32: add USBPHYC support to stm32mp157c")

from the arm-soc tree and commit:

  5f0e9d2557d7 ("ARM: dts: stm32: Add exti support for stm32mp157c")

from the irqchip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm/boot/dts/stm32mp157c.dtsi
index b66f673b5038,4fa0df853c8a..000000000000
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@@ -777,26 -183,13 +777,33 @@@
  			status = "disabled";
  		};
  
 +		usbphyc: usbphyc at 5a006000 {
 +			#address-cells = <1>;
 +			#size-cells = <0>;
 +			compatible = "st,stm32mp1-usbphyc";
 +			reg = <0x5a006000 0x1000>;
 +			clocks = <&rcc USBPHY_K>;
 +			resets = <&rcc USBPHY_R>;
 +			status = "disabled";
 +
 +			usbphyc_port0: usb-phy at 0 {
 +				#phy-cells = <0>;
 +				reg = <0>;
 +			};
 +
 +			usbphyc_port1: usb-phy at 1 {
 +				#phy-cells = <1>;
 +				reg = <1>;
 +			};
 +		};
 +
+ 		exti: interrupt-controller at 5000d000 {
+ 			compatible = "st,stm32mp1-exti", "syscon";
+ 			interrupt-controller;
+ 			#interrupt-cells = <2>;
+ 			reg = <0x5000d000 0x400>;
+ 		};
+ 
  		usart1: serial at 5c000000 {
  			compatible = "st,stm32h7-uart";
  			reg = <0x5c000000 0x400>;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180529/5a2ead38/attachment.sig>
