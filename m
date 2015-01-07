From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 08 Jan 2015 08:51:12 +0900
Subject: [PATCHv7 05/10] devfreq: event: Add documentation for exynos-ppmu
 devfreq-event driver
In-Reply-To: <1420674677-3077-1-git-send-email-cw00.choi@samsung.com>
References: <1420674677-3077-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1420674677-3077-6-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the documentation for Exynos PPMU (Platform Performance
Monitoring Unit) devfreq-event driver.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../bindings/devfreq/event/exynos-ppmu.txt         | 110 +++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt

diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
new file mode 100644
index 0000000..e665d30
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
@@ -0,0 +1,110 @@
+
+* Samsung Exynos PPMU (Performance Profiling Monitoring Unit) device
+
+The Samsung Exynos SoC have PPMU (Performance Profiling Monitoring Unit) for
+each IPs. PPMU provides the primitive values to get performance data. These
+events provide useful information about the behavior of the SoC that you can
+use when analyzing system performance, and made visible and can be counted
+using login in each IP (DMC, CPU, RIGHTBUS, LEFTBUS, CAM interface, LCD, G3D,
+MFC). The Exynos PPMU driver use the devfreq-event class to provide event data
+to various devfreq device. The devfreq device would use the event data when
+derterming the current state of each IP.
+
+Required properties:
+- compatible: Should be "samsung,exynos-ppmu".
+- reg: physical base address of each PPMU and length of memory mapped region.
+
+Optional properties:
+- clock-names : the name of clock used by the PPMU, "ppmu"
+- clocks : phandles for clock specified in "clock-names" property
+- #clock-cells: should be 1.
+
+Example1 : PPMU nodes in exynos3250.dtsi are listed below.
+
+		ppmu_dmc0: ppmu_dmc0 at 106a0000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x106a0000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_dmc1: ppmu_dmc1 at 106b0000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x106b0000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_cpu: ppmu_cpu at 106c0000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x106c0000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_rightbus: ppmu_rightbus at 112a0000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x112a0000 0x2000>;
+			clocks = <&cmu CLK_PPMURIGHT>;
+			clock-names = "ppmu";
+			status = "disabled";
+		};
+
+		ppmu_leftbus: ppmu_leftbus0 at 116a0000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x116a0000 0x2000>;
+			clocks = <&cmu CLK_PPMULEFT>;
+			clock-names = "ppmu";
+			status = "disabled";
+		};
+
+Example2 : Events of each PPMU node in exynos3250-rinato.dts are listed below.
+
+	&ppmu_dmc0 {
+		status = "okay";
+
+		events {
+			ppmu_dmc0_3: ppmu-event3-dmc0 {
+				event-name = "ppmu-event3-dmc0";
+			};
+
+			ppmu_dmc0_2: ppmu-event2-dmc0 {
+				event-name = "ppmu-event2-dmc0";
+			};
+
+			ppmu_dmc0_1: ppmu-event1-dmc0 {
+				event-name = "ppmu-event1-dmc0";
+			};
+
+			ppmu_dmc0_0: ppmu-event0-dmc0 {
+				event-name = "ppmu-event0-dmc0";
+			};
+		};
+	};
+
+	&ppmu_dmc1 {
+		status = "okay";
+
+		events {
+			ppmu_dmc1_3: ppmu-event3-dmc1 {
+				event-name = "ppmu-event3-dmc1";
+			};
+		};
+	};
+
+	&ppmu_leftbus {
+		status = "okay";
+
+		events {
+			ppmu_leftbus_3: ppmu-event3-leftbus {
+				event-name = "ppmu-event3-leftbus";
+			};
+		};
+	};
+
+	&ppmu_rightbus {
+		status = "okay";
+
+		events {
+			ppmu_rightbus_3: ppmu-event3-rightbus {
+				event-name = "ppmu-event3-rightbus";
+			};
+		};
+	};
-- 
1.8.5.5
