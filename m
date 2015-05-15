From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 11:28:39 +0200
Subject: [GIT PULL]Hisilicon hip04 soc and D01 board DT updates for v4.2
In-Reply-To: <5554E035.6020004@hisilicon.com>
References: <554CC781.9010705@hisilicon.com>
 <CANMBJr6bOu9-w_gODrJO_4-VczXOo024wnyhAtndFGTGrWUs6g@mail.gmail.com>
 <5554E035.6020004@hisilicon.com>
Message-ID: <2091000.vbEIJY2sm3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 May 2015 18:49:41 Wei Xu wrote:
> On 5/14/2015 2:55 PM, Tyler Baker wrote:
> > On 14 May 2015 at 06:36, Tyler Baker <tyler.baker@linaro.org> wrote:
> >> On 14 May 2015 at 01:49, Wei Xu <xuwei5@hisilicon.com> wrote:
> >>> On 5/13/2015 8:20 PM, Tyler Baker wrote:
> >>>> On 12 May 2015 at 08:09, Wei Xu <xuwei5@hisilicon.com> wrote:
> >>>> When this was pulled into arm-soc, the kernelci.org bot reported
> >>>> hip04-d01 boot failures[1]. Before bisecting, I decided to wait a day
> >>>> and double check the status of -next in case there were needed
> >>>> dependencies from other trees. However, now there are the same
> >>>> hip04-d01 boot failures in next-20150513[2]. My robot has bisected[3]
> >>>> these boot failures down to...
> >>>>
> >>>> 828fcfe3c84ade68ecc3f1ba78baebc1654977f3 is the first bad commit
> >>>> commit 828fcfe3c84ade68ecc3f1ba78baebc1654977f3
> >>>> Author: Zhou Wang <wangzhou.bry@gmail.com>
> >>>> Date:   Wed Mar 25 14:57:45 2015 +0800
> >>>>
> >>>>     ARM: dts: hip04: add GPIO pieces
> >>>>
> >>>>     Hisilicon Soc hip04 has four GPIO controllers, each one has 32
> >>>>     GPIOs and can be configured to be an interrupt controller.The GPIO
> >>>>     controllers are compatible with the snps,dw-apb-gpio driver.
> >>>>     This patch add the corresponding device tree nodes.
> >>>>
> >>>>     Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >>>>     Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> >>>>     Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
> >>>
> >>>
> >>> It is a little strange.
> >>> I checked to this commit "28837bc3e732610ebc7c88ce205dbe43245b1cb8"
> >>> at "git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git".
> >>> and compiled with "hisi_defconfig".
> >>>
> >>> It is booting OK and the log is as below.
> >>> And I have also uploaded the binary at "https://github.com/hisilicon/boards/tree/master/D01/for-tyler".
> >>> Could you please confirm it again?
> >>
> >> It appears we are using different image formats to boot. The link
> >> above shows .kernel, .monitor, .text...can I split the kernel//dtb out
> >> from .kernel?
> >>
> >> I am using zImage and hip04-d01.dtb directly[1] with UEFI to TFTP
> >> boot. Could you try this method?
> 
> > For good measure, I tried booting next-20150514 on the D01 hardware in
> > the Linaro lab to confirm the same failure I see locally. It fails to
> > boot as well[1].
> 
> Thanks!
> I have tried your binary files and found it is stuck in the UEFI.
> I will continue to investigate this issue.
> 
> Hi Arnd,
> 
> Could you please revert that branch?
> After I resolve this issue I will send another pull request.
> Sorry to bother you!
> Thanks!
> 

I have applied the patch below on the for-next branch now, to revert everything
from this pull request. I have not changed the contents of the next/dt branch
for now, and am still waiting for a bug fix. Once you know what caused the
problem, please send a fix that applies on top of the next/dt branch in arm-soc,
and I'll reactivate it.

	Arnd


>From 912c904574a460009901dddf9666c66c4832fa9b Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 May 2015 11:24:22 +0200
Subject: [PATCH] ARM: hisi: revert changes from hisi/hip04-dt branch

This temporarily backs out all changes that were added in the hip04-dt
branch. Let's see if we can find out what caused the boot break and
then fix that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/boot/dts/hip04-d01.dts b/arch/arm/boot/dts/hip04-d01.dts
index ba04dd5fba8b..40a9e33c2654 100644
--- a/arch/arm/boot/dts/hip04-d01.dts
+++ b/arch/arm/boot/dts/hip04-d01.dts
@@ -28,32 +28,5 @@
 		uart0: uart at 4007000 {
 			status = "ok";
 		};
-
-		nand: nand at 4020000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "hw";
-			nand-ecc-strength = <16>;
-			nand-ecc-step-size = <1024>;
-
-			partition at 0 {
-				label = "nand_text";
-				reg = <0x00000000 0x00400000>;
-			};
-
-			partition at 00400000 {
-				label = "nand_monitor";
-				reg = <0x00400000 0x00400000>;
-			};
-
-			partition at 00800000 {
-				label = "nand_kernel";
-				reg = <0x00800000 0x00800000>;
-			};
-
-			partition at 01000000 {
-				label = "nand_fs";
-				reg = <0x01000000 0x1f000000>;
-			};
-		};
 	};
 };
diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index 6434b7f91329..44044f275115 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -269,139 +269,6 @@
 			interrupts = <0 372 4>;
 		};
 
-		gpio at 4003000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,dw-apb-gpio";
-			reg = <0x4003000 0x1000>;
-
-			gpio3: gpio-controller at 0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				snps,nr-gpios = <32>;
-				reg = <0>;
-				interrupt-parent = <&gic>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <0 392 4>;
-			};
-		};
-
-		gpio at 4002000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,dw-apb-gpio";
-			reg = <0x4002000 0x1000>;
-
-			gpio2: gpio-controller at 0 {
-			compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				snps,nr-gpios = <32>;
-				reg = <0>;
-				interrupt-parent = <&gic>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <0 391 4>;
-			};
-		};
-
-		gpio at 4001000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,dw-apb-gpio";
-			reg = <0x4001000 0x1000>;
-
-			gpio1: gpio-controller at 0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				snps,nr-gpios = <32>;
-				reg = <0>;
-				interrupt-parent = <&gic>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <0 390 4>;
-			};
-		};
-
-		gpio at 4000000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,dw-apb-gpio";
-			reg = <0x4000000 0x1000>;
-
-			gpio0: gpio-controller at 0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				snps,nr-gpios = <32>;
-				reg = <0>;
-				interrupt-parent = <&gic>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <0 389 4>;
-			};
-		};
-
-		nand: nand at 4020000 {
-			compatible = "hisilicon,504-nfc";
-			reg = <0x4020000 0x10000>, <0x5000000 0x1000>;
-			interrupts = <0 379 4>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-		};
-
-		mdio {
-			compatible = "hisilicon,hip04-mdio";
-			reg = <0x28f1000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			phy0: ethernet-phy at 0 {
-				compatible = "ethernet-phy-ieee802.3-c22";
-				reg = <0>;
-				marvell,reg-init = <18 0x14 0 0x8001>;
-			};
-
-			phy1: ethernet-phy at 1 {
-				compatible = "ethernet-phy-ieee802.3-c22";
-				reg = <1>;
-				marvell,reg-init = <18 0x14 0 0x8001>;
-			};
-		};
-
-		ppe: ppe at 28c0000 {
-			compatible = "hisilicon,hip04-ppe", "syscon";
-			reg = <0x28c0000 0x10000>;
-		};
-
-		fe: ethernet at 28b0000 {
-			compatible = "hisilicon,hip04-mac";
-			reg = <0x28b0000 0x10000>;
-			interrupts = <0 413 4>;
-			phy-mode = "mii";
-			port-handle = <&ppe 31 0>;
-		};
-
-		ge0: ethernet at 2800000 {
-			compatible = "hisilicon,hip04-mac";
-			reg = <0x2800000 0x10000>;
-			interrupts = <0 402 4>;
-			phy-mode = "sgmii";
-			port-handle = <&ppe 0 1>;
-			phy-handle = <&phy0>;
-		};
-
-		ge8: ethernet at 2880000 {
-			compatible = "hisilicon,hip04-mac";
-			reg = <0x2880000 0x10000>;
-			interrupts = <0 410 4>;
-			phy-mode = "sgmii";
-			port-handle = <&ppe 8 2>;
-			phy-handle = <&phy1>;
-		};
 	};
 
 	etb at 0,e3c42000 {
