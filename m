From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 22 Nov 2016 15:49:17 +0800
Subject: [PATCH 2/6] dt-bindings: Document the hi3660 reset bindings
In-Reply-To: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
References: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1479800961-6249-3-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings documentation for hi3660 SoC reset controller.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../bindings/reset/hisilicon,hi3660-reset.txt      | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
new file mode 100644
index 0000000..20e03a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
@@ -0,0 +1,42 @@
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
+- compatible: should be one of the following:
+  - "hisilicon,hi3660-reset-crgctrl : reset control for peripherals in crgctrl.
+  - "hisilicon,hi3660-reset-iomcu : reset control for peripherals in iomcu.
+- hisi,rst-syscon: phandle of the reset's syscon.
+- #reset-cells: 1, see below
+
+Example:
+	crg_ctrl: crg_ctrl at fff35000 {
+		compatible = "hisilicon,hi3660-crgctrl", "syscon";
+		reg = <0x0 0xfff35000 0x0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	crg_rst: crg_rst_controller {
+		compatible = "hisilicon,hi3660-reset-crgctrl";
+		#reset-cells = <1>;
+		hisi,rst-syscon = <&crg_ctrl>;
+	};
+
+Specifying reset lines connected to IP modules
+==============================================
+example:
+
+        ufs: ufs at ..... {
+                ...
+		resets = <&crg_rst HI3660_RST_UFS>,
+			 <&crg_rst HI3660_RST_UFS_ASSERT>;
+		reset-names = "rst", "assert";
+                ...
+        };
+
+The index could be found in <dt-bindings/reset/hisi,hi3660-resets.h>.
-- 
2.7.4
