From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 15 Dec 2014 15:56:51 +0100
Subject: [PATCH v2 1/3] devfreq: dt-bindings: Document bindings for Exynos3250
 bus DVFS driver
In-Reply-To: <1418655413-25410-1-git-send-email-k.kozlowski@samsung.com>
References: <1418655413-25410-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1418655413-25410-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for bindings used by Exynos3250 Dynamic Voltage
and Frequency Scaling (DVFS) driver.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 .../bindings/arm/samsung/exynos3250-devfreq.txt    | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt b/Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt
new file mode 100644
index 000000000000..162498ec0da8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt
@@ -0,0 +1,62 @@
+Samsung Exynos3250 bus frequency scaling driver
+===============================================
+
+The Exynos3250 SoC allows Dynamic Voltage and Frequency Scaling (DVFS)
+for certain system buses:
+ - memory controller and bus,
+ - peripheral buses (leftbus, rightbus).
+
+DVFS for memory controller and bus
+==================================
+Required properties:
+ - compatible : should be "samsung,exynos3250-busfreq-mif"
+ - clock-names : one clock of name "dmc" to manage frequency
+ - clocks : phandle and specifier for clock listed in clock-names property
+ - vdd-mif-supply : phandle to MIF voltage regulator
+ - devfreq-events : two phandles to devfreq event devices providing
+	raw data for bus utilization
+
+DVFS for peripheral buses
+=========================
+Required properties:
+ - compatible : should be "samsung,exynos3250-busfreq-int"
+ - clock-names : names for bus clocks to manage frequencies;
+	All following clock names (and corresponding phandles) must be
+	provided: "aclk_400", "aclk_266", "aclk_200", "aclk_160", "aclk_gdl",
+	"aclk_gdr", "mfc";
+ - clocks : phandles and specifiers for clocks listed in clock-names property
+ - vdd-int-supply : phandle to INT voltage regulator
+ - devfreq-events : two phandles to devfreq event devices providing
+	raw data for bus utilization
+
+Example
+=======
+	busfreq_mif: busfreq at 106A0000 {
+		compatible = "samsung,exynos3250-busfreq-mif";
+		clocks = <&cmu_dmc CLK_DIV_DMC>;
+		clock-names = "dmc";
+		vdd-mif-supply = <&buck1_reg>;
+		devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+		status = "okay";
+	};
+
+	busfreq_int: busfreq at 116A0000 {
+		compatible = "samsung,exynos3250-busfreq-int";
+		clocks = <&cmu CLK_DIV_ACLK_400_MCUISP>,
+			<&cmu CLK_DIV_ACLK_266>,
+			<&cmu CLK_DIV_ACLK_200>,
+			<&cmu CLK_DIV_ACLK_160>,
+			<&cmu CLK_DIV_GDL>,
+			<&cmu CLK_DIV_GDR>,
+			<&cmu CLK_DIV_MFC>;
+		clock-names = "aclk_400",
+			"aclk_266",
+			"aclk_200",
+			"aclk_160",
+			"aclk_gdl",
+			"aclk_gdr",
+			"mfc";
+		vdd-int-supply = <&buck3_reg>;
+		devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+		status = "okay";
+	};
-- 
1.9.1
