From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 13 Apr 2013 16:56:40 +0200
Subject: [PATCHv3 05/10] arm: kirkwood: convert Iomega Iconnect to use DT for
 the PCIe interface
In-Reply-To: <1365865005-26653-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365865005-26653-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1365865005-26653-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the PCIe mvebu driver is usable on Kirkwood, use it instead
of the legacy PCIe code, since it allows to describe the PCIe
interfaces in the Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-iconnect.dts |    8 ++++++++
 arch/arm/mach-kirkwood/board-iconnect.c |    8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index 504f16b..4c8f0df 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -110,6 +110,14 @@
 				reg = <0x980000 0x1f400000>;
 			};
 		};
+
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
 	};
 
 	gpio-leds {
diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-kirkwood/board-iconnect.c
index c8ebde4..98b5ad1 100644
--- a/arch/arm/mach-kirkwood/board-iconnect.c
+++ b/arch/arm/mach-kirkwood/board-iconnect.c
@@ -22,11 +22,3 @@ void __init iconnect_init(void)
 {
 	kirkwood_ge00_init(&iconnect_ge00_data);
 }
-
-static int __init iconnect_pci_init(void)
-{
-	if (of_machine_is_compatible("iom,iconnect"))
-		kirkwood_pcie_init(KW_PCIE0);
-	return 0;
-}
-subsys_initcall(iconnect_pci_init);
-- 
1.7.9.5
