From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Tue, 13 May 2014 15:30:15 +0530
Subject: [PATCH v9 1/3] Documentation: Document Exynos5 USB 3.0 DRD PHY
In-Reply-To: <1399975217-3231-1-git-send-email-gautam.vivek@samsung.com>
References: <1399975217-3231-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1399975217-3231-2-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add necessary binding documentation for USB 3.0 DRD PHY present on
Exynos5 SoC series.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 .../devicetree/bindings/phy/samsung-phy.txt        |   47 ++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
index b422e38..2049261 100644
--- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -114,3 +114,50 @@ Example:
 		compatible = "samsung,exynos-sataphy-i2c";
 		reg = <0x38>;
 	};
+
+Samsung Exynos5 SoC series USB DRD PHY controller
+--------------------------------------------------
+
+Required properties:
+- compatible : Should be set to one of the following supported values:
+	- "samsung,exynos5250-usbdrd-phy" - for exynos5250 SoC,
+	- "samsung,exynos5420-usbdrd-phy" - for exynos5420 SoC.
+- reg : Register offset and length of USB DRD PHY register set;
+- clocks: Clock IDs array as required by the controller
+- clock-names: names of clocks correseponding to IDs in the clock property;
+	       Required clocks:
+	- phy: main PHY clock (same as USB DRD controller i.e. DWC3 IP clock),
+	       used for register access.
+	- ref: PHY's reference clock (usually crystal clock), used for
+	       PHY operations, associated by phy name. It is used to
+	       determine bit values for clock settings register.
+	       For Exynos5420 this is given as 'sclk_usbphy30' in CMU.
+- samsung,pmu-syscon: phandle for PMU system controller interface, used to
+		      control pmu registers for power isolation.
+- #phy-cells : from the generic PHY bindings, must be 1;
+
+For "samsung,exynos5250-usbdrd-phy" and "samsung,exynos5420-usbdrd-phy"
+compatible PHYs, the second cell in the PHY specifier identifies the
+PHY id, which is interpreted as follows:
+  0 - UTMI+ type phy,
+  1 - PIPE3 type phy,
+
+Example:
+	usbdrd_phy: usbphy at 12100000 {
+		compatible = "samsung,exynos5250-usbdrd-phy";
+		reg = <0x12100000 0x100>;
+		clocks = <&clock 286>, <&clock 1>;
+		clock-names = "phy", "ref";
+		samsung,pmu-syscon = <&pmu_system_controller>;
+		#phy-cells = <1>;
+	};
+
+- aliases: For SoCs like Exynos5420 having multiple USB 3.0 DRD PHY controllers,
+	   'usbdrd_phy' nodes should have numbered alias in the aliases node,
+	   in the form of usbdrdphyN, N = 0, 1... (depending on number of
+	   controllers).
+Example:
+	aliases {
+		usbdrdphy0 = &usb3_phy0;
+		usbdrdphy1 = &usb3_phy1;
+	};
-- 
1.7.10.4
