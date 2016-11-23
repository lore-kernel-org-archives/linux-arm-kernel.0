From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 23 Nov 2016 16:07:55 +0800
Subject: [RFC v2: PATCH 1/2] dt-bindings: Document the hi3660 reset bindings
In-Reply-To: <1479888476-13138-1-git-send-email-zhangfei.gao@linaro.org>
References: <Arnd Bergmann <arnd@arndb.de>,>
 <1479888476-13138-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1479888476-13138-2-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings documentation for hi3660 SoC reset controller.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../bindings/reset/hisilicon,hi3660-reset.txt      | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
new file mode 100644
index 0000000..250daf2
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
@@ -0,0 +1,51 @@
+Hisilicon System Reset Controller
+======================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+The reset controller registers are part of the system-ctl block on
+hi3660 SoC.
+
+Required properties:
+- compatible: should be
+		 "hisilicon,hi3660-reset"
+- #reset-cells: 1, see below
+- hisi,rst-syscon: phandle of the reset's syscon.
+- hisi,reset-bits: Contains the reset control register information
+		  Should contain 2 cells for each reset exposed to
+		  consumers, defined as:
+			Cell #1 : offset from the syscon register base
+			Cell #2 : bits position of the control register
+
+Example:
+	iomcu: iomcu at ffd7e000 {
+		compatible = "hisilicon,hi3660-iomcu", "syscon";
+		reg = <0x0 0xffd7e000 0x0 0x1000>;
+	};
+
+	iomcu_rst: iomcu_rst_controller {
+		compatible = "hisilicon,hi3660-reset";
+		#reset-cells = <1>;
+		hisi,rst-syscon = <&iomcu>;
+		hisi,reset-bits = <0x20 0x8		/* 0: i2c0 */
+				   0x20 0x10		/* 1: i2c1 */
+				   0x20 0x20		/* 2: i2c2 */
+				   0x20 0x8000000>;	/* 3: i2c6 */
+	};
+
+Specifying reset lines connected to IP modules
+==============================================
+example:
+
+        i2c0: i2c at ..... {
+                ...
+		resets = <&iomcu_rst 0>;
+                ...
+        };
+
+	i2c1: i2c at ..... {
+                ...
+		resets = <&iomcu_rst 1>;
+                ...
+        };
-- 
2.7.4
