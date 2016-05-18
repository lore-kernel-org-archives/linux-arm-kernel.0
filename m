From: carlo@caione.org (Carlo Caione)
Date: Wed, 18 May 2016 16:56:22 +0200
Subject: [PATCH v2 4/4] documentation: Add secure monitor binding documentation
In-Reply-To: <1463583382-15614-1-git-send-email-carlo@caione.org>
References: <1463583382-15614-1-git-send-email-carlo@caione.org>
Message-ID: <1463583382-15614-5-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the binding documentation for the Amlogic secure monitor driver.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 .../devicetree/bindings/soc/meson/meson_sm.txt     | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/meson/meson_sm.txt

diff --git a/Documentation/devicetree/bindings/soc/meson/meson_sm.txt b/Documentation/devicetree/bindings/soc/meson/meson_sm.txt
new file mode 100644
index 0000000..f59c732
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/meson/meson_sm.txt
@@ -0,0 +1,45 @@
+* Amlogic Secure Monitor
+
+In the Amlogic SoCs the Secure Monitor code is used to provide access to the
+NVMEM, enable JTAG, set USB boot, etc...
+
+Required properties for the secure monitor node:
+- compatible: Should be "amlogic,meson-sm"
+- amlogic,sm_cmd_input_base: SMC32 function identifier to read the physical
+                             address of the input buffer
+- amlogic,sm_cmd_output_base: SMC32 function identifier to read the physical
+                              address of the output buffer
+
+Example:
+
+	#include <dt-bindings/soc/meson-gxbb-sm.h>
+
+	...
+
+	sm {
+		compatible = "amlogic,meson-sm";
+		amlogic,sm_cmd_input_base = <SM_GET_SHARE_MEM_INPUT_BASE>;
+		amlogic,sm_cmd_output_base = <SM_GET_SHARE_MEM_OUTPUT_BASE>;
+	};
+
+Node of a device using the secure monitor must have a custom property to
+specify the SMC32 function the driver is going to use. The values of all the
+SMC function identifiers are listed in a SoC-specific header file:
+
+"include/dt-bindings/soc/meson-gxbb-sm.h" - for the Meson GXBB secure monitor.
+
+Example of the node using the secure monitor:
+
+	#include <dt-bindings/soc/meson-gxbb-sm.h>
+
+	...
+
+	efuse: efuse {
+		compatible = "amlogic,meson-gxbb-efuse";
+		amlogic,sm_cmd_read_efuse = <SM_EFUSE_READ>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		...
+	};
+
-- 
2.7.4
