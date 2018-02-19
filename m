From: d-gerlach@ti.com (Dave Gerlach)
Date: Sun, 18 Feb 2018 21:34:58 -0600
Subject: [PATCH 2/9] ARM: dts: am4372: Reserve pm code and data regions in
 ocmcram sram node
In-Reply-To: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
References: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1519011305-17822-3-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a 'pm_sram_code' reserved region to the ocmcram node to be exposed
by the mmio-sram driver as a pool but also mark it protect-exec so that
it can run code copied to it using sram_exec_copy.

Add another 'pm_sram_data' reserved region to the ocmcram node to act as
the data space for any code running from the 'pm_sram_code' region that
is exposed as a regular pool.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 964f3ef79728..81a03c1ad770 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -1141,6 +1141,21 @@
 		ocmcram: ocmcram at 40300000 {
 			compatible = "mmio-sram";
 			reg = <0x40300000 0x40000>; /* 256k */
+			ranges = <0x0 0x40300000 0x40000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pm_sram_code: pm-sram-code at 0 {
+				compatible = "ti,sram";
+				reg = <0x0 0x1000>;
+				protect-exec;
+			};
+
+			pm_sram_data: pm-sram-data at 1000 {
+				compatible = "ti,sram";
+				reg = <0x1000 0x1000>;
+				pool;
+			};
 		};
 
 		dcan0: can at 481cc000 {
-- 
2.16.1
