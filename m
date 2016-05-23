From: carlo@caione.org (Carlo Caione)
Date: Mon, 23 May 2016 18:30:24 +0200
Subject: [PATCH v3 4/4] documentation: Add secure monitor binding documentation
In-Reply-To: <1464021024-29380-1-git-send-email-carlo@caione.org>
References: <1464021024-29380-1-git-send-email-carlo@caione.org>
Message-ID: <1464021024-29380-5-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the binding documentation for the Amlogic secure monitor driver.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 .../bindings/firmware/meson/meson_sm.txt           | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/meson/meson_sm.txt

diff --git a/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt b/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
new file mode 100644
index 0000000..2b71716
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
@@ -0,0 +1,51 @@
+* Amlogic Secure Monitor
+
+In the Amlogic SoCs the Secure Monitor code is used to provide access to the
+NVMEM, enable JTAG, set USB boot, etc...
+
+Required properties for the secure monitor node:
+- compatible: Should be "amlogic,meson-sm"
+- amlogic,sm-cmd-input-base: SMC32 function identifier to read the physical
+                             address of the input buffer
+- amlogic,sm-cmd-output-base: SMC32 function identifier to read the physical
+                              address of the output buffer
+
+Example:
+
+	#include <dt-bindings/firmware/meson-gxbb-sm.h>
+
+	...
+
+	firmware {
+		compatible = "simple-bus";
+
+		sm: secure-monitor {
+			compatible = "amlogic,meson-sm";
+			amlogic,sm-cmd-input-base = <SM_GET_SHARE_MEM_INPUT_BASE>;
+			amlogic,sm-cmd-output-base = <SM_GET_SHARE_MEM_OUTPUT_BASE>;
+		};
+	};
+
+Node of a device using the secure monitor must have a custom property to
+specify the SMC32 function the driver is going to use. The values of all the
+SMC function identifiers are listed in a SoC-specific header file:
+
+"include/dt-bindings/firmware/meson-gxbb-sm.h" - for the Meson GXBB secure monitor.
+
+Example of the node using the secure monitor:
+
+	#include <dt-bindings/firmware/meson-gxbb-sm.h>
+
+	...
+
+	efuse: efuse {
+		compatible = "amlogic,meson-gxbb-efuse";
+		secure-monitor = <&sm>;
+		amlogic,sm-cmd-read-efuse = <SM_EFUSE_READ>;
+		amlogic,sm-cmd-max-efuse = <SM_EFUSE_USER_MAX>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		...
+	};
+
-- 
2.7.4
