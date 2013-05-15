From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 15 May 2013 15:37:00 +0200
Subject: [PATCHv4 7/9] arm: kirkwood: convert QNAP TS219 to use DT for the
 PCIe interface
In-Reply-To: <1368625022-25243-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368625022-25243-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1368625022-25243-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the PCIe mvebu driver is usable on Kirkwood, use it instead
of the legacy PCIe code, since it allows to describe the PCIe
interfaces in the Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-ts219-6281.dts |    3 ++-
 arch/arm/boot/dts/kirkwood-ts219-6282.dts |    3 ++-
 arch/arm/boot/dts/kirkwood-ts219.dtsi     |    9 +++++++--
 arch/arm/mach-kirkwood/board-ts219.c      |   10 ----------
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ts219-6281.dts b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
index 8295c83..42648ab 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6281.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
@@ -1,7 +1,8 @@
 /dts-v1/;
 
-/include/ "kirkwood-ts219.dtsi"
+/include/ "kirkwood.dtsi"
 /include/ "kirkwood-6281.dtsi"
+/include/ "kirkwood-ts219.dtsi"
 
 / {
 	ocp at f1000000 {
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
index df3f95d..95ceeb9 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -1,7 +1,8 @@
 /dts-v1/;
 
-/include/ "kirkwood-ts219.dtsi"
+/include/ "kirkwood.dtsi"
 /include/ "kirkwood-6282.dtsi"
+/include/ "kirkwood-ts219.dtsi"
 
 / {
 	ocp at f1000000 {
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
index 64ea27c..7c022fd 100644
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -1,5 +1,3 @@
-/include/ "kirkwood.dtsi"
-
 / {
 	model = "QNAP TS219 family";
 	compatible = "qnap,ts219", "marvell,kirkwood";
@@ -74,5 +72,12 @@
 			status = "okay";
 			nr-ports = <2>;
 		};
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
 	};
 };
diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
index acb0187..4695d5f 100644
--- a/arch/arm/mach-kirkwood/board-ts219.c
+++ b/arch/arm/mach-kirkwood/board-ts219.c
@@ -41,13 +41,3 @@ void __init qnap_dt_ts219_init(void)
 
 	pm_power_off = qnap_tsx1x_power_off;
 }
-
-/* FIXME: Will not work with DT. Maybe use MPP40_GPIO? */
-static int __init ts219_pci_init(void)
-{
-	if (machine_is_ts219())
-		kirkwood_pcie_init(KW_PCIE0);
-
-	return 0;
-}
-subsys_initcall(ts219_pci_init);
-- 
1.7.9.5
