From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed,  9 Jan 2013 21:43:14 +0100
Subject: [PATCH 14/14] ARM: tegra: trimslice: Initialize PCIe from DT
In-Reply-To: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1357764194-12677-15-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the device tree support in place, probe the PCIe controller from
the device tree and remove the corresponding workaround in the board
file.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v3:
- update for new DT binding

Changes in v2:
- new patch
---
 arch/arm/boot/dts/tegra20-trimslice.dts | 12 ++++++++++++
 arch/arm/mach-tegra/board-dt-tegra20.c  |  8 --------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 4b6c486..ebb4c17 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -301,6 +301,18 @@
 		};
 	};
 
+	pcie-controller {
+		status = "okay";
+
+		pci at 0 {
+			status = "okay";
+		};
+
+		pci at 1 {
+			status = "okay";
+		};
+	};
+
 	usb at c5000000 {
 		status = "okay";
 		nvidia,vbus-gpio = <&gpio 170 0>; /* gpio PV2 */
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 9e8256ab..67090fe 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -145,13 +145,6 @@ static void __init tegra_dt_init(void)
 				tegra20_auxdata_lookup, NULL);
 }
 
-static void __init trimslice_init(void)
-{
-#ifdef CONFIG_TEGRA_PCI
-	platform_device_register(&tegra_pcie_device);
-#endif
-}
-
 static void __init paz00_init(void)
 {
 	tegra_paz00_wifikill_init();
@@ -161,7 +154,6 @@ static struct {
 	char *machine;
 	void (*init)(void);
 } board_init_funcs[] = {
-	{ "compulab,trimslice", trimslice_init },
 	{ "compal,paz00", paz00_init },
 };
 
-- 
1.8.1
