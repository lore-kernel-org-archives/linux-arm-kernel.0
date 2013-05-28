From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 29 May 2013 00:15:09 +0200
Subject: [PATCH] arm: kirkwood: convert NETGEAR ReadyNAS Duo v2 to use DT for
 the PCIe interface
Message-ID: <8738t6ycnm.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason and Thomas,

Thomas, I am following your work on PCIe support for a .dts file I am
working on for (Armada 370-based) Netgear ReadyNAS 102 and noticed your
set of patches to convert kirkwood-based boards to use it in order to
simplify/remove board specific code.

Jason, I gave your associated branch (jcooper/mvebu-next/pcie) a try
with following patch applied and can confirm USB 3.0 host controller
(connected to PCIe bus) is usable on Netgear ReadyNAS *Duo v2*
(88f6282-based brother of the 102).

Note that I had to s/of_pci_range_parser()/of_pci_range_parser_init()/
in drivers/pci/host/pci-mvebu.c to compile the kernel (this may already
have been fixed already):

CHK     kernel/config_data.h
drivers/pci/host/pci-mvebu.c: In function ?mvebu_pcie_probe?:
drivers/pci/host/pci-mvebu.c:742:2: error: implicit declaration of function ?of_pci_range_parser? [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[3]: *** [drivers/pci/host/pci-mvebu.o] Error 1
make[2]: *** [drivers/pci/host] Error 2
make[1]: *** [drivers/pci] Error 2
make[1]: *** Waiting for unfinished jobs....

Can one of you take the patch below into account? Or 

Cheers,

a+

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts |    8 ++++++++
 arch/arm/mach-kirkwood/board-readynas.c                |    1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index 1ca66ab..f9706da 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -111,6 +111,14 @@
 			status = "okay";
 			nr-ports = <2>;
 		};
+
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				 status = "okay";
+			};
+		};
 	};
 
 	gpio-leds {
diff --git a/arch/arm/mach-kirkwood/board-readynas.c b/arch/arm/mach-kirkwood/board-readynas.c
index fb42c20..341b82d 100644
--- a/arch/arm/mach-kirkwood/board-readynas.c
+++ b/arch/arm/mach-kirkwood/board-readynas.c
@@ -24,5 +24,4 @@ static struct mv643xx_eth_platform_data netgear_readynas_ge00_data = {
 void __init netgear_readynas_init(void)
 {
 	kirkwood_ge00_init(&netgear_readynas_ge00_data);
-	kirkwood_pcie_init(KW_PCIE0);
 }
-- 
1.7.10.4
