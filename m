From: sbranden@broadcom.com (Scott Branden)
Date: Sat, 28 Feb 2015 08:03:02 -0800
Subject: [PATCH v3 1/2] Input: bcm-keypad: add device tree bindings
In-Reply-To: <1425139383-6994-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1425139383-6994-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1425139383-6994-2-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documents the Broadcom keypad controller device tree bindings.

Reviewed-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 .../devicetree/bindings/input/brcm,bcm-keypad.txt  | 108 +++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt

diff --git a/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt b/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt
new file mode 100644
index 0000000..b77f50b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt
@@ -0,0 +1,108 @@
+* Broadcom Keypad Controller device tree bindings
+
+Broadcom Keypad controller is used to interface a SoC with a matrix-type
+keypad device. The keypad controller supports multiple row and column lines.
+A key can be placed at each intersection of a unique row and a unique column.
+The keypad controller can sense a key-press and key-release and report the
+event using a interrupt to the cpu.
+
+This binding is based on the matrix-keymap binding with the following
+changes:
+
+keypad,num-rows and keypad,num-columns are required.
+
+Required SoC Specific Properties:
+- compatible: should be "brcm,bcm-keypad"
+
+- reg: physical base address of the controller and length of memory mapped
+  region.
+
+- interrupts: The interrupt number to the cpu.
+
+Board Specific Properties:
+- keypad,num-rows: Number of row lines connected to the keypad
+  controller.
+
+- keypad,num-columns: Number of column lines connected to the
+  keypad controller.
+
+- col-debounce-filter-period: The debounce period for the Column filter.
+
+	KEYPAD_DEBOUNCE_1_ms	=	0
+	KEYPAD_DEBOUNCE_2_ms	=	1
+	KEYPAD_DEBOUNCE_4_ms	=	2
+	KEYPAD_DEBOUNCE_8_ms	=	3
+	KEYPAD_DEBOUNCE_16_ms	=	4
+	KEYPAD_DEBOUNCE_32_ms	=	5
+	KEYPAD_DEBOUNCE_64_ms	=	6
+	KEYPAD_DEBOUNCE_128_ms	=	7
+
+- status-debounce-filter-period: The debounce period for the Status filter.
+
+	KEYPAD_DEBOUNCE_1_ms	=	0
+	KEYPAD_DEBOUNCE_2_ms	=	1
+	KEYPAD_DEBOUNCE_4_ms	=	2
+	KEYPAD_DEBOUNCE_8_ms	=	3
+	KEYPAD_DEBOUNCE_16_ms	=	4
+	KEYPAD_DEBOUNCE_32_ms	=	5
+	KEYPAD_DEBOUNCE_64_ms	=	6
+	KEYPAD_DEBOUNCE_128_ms	=	7
+
+- row-output-enabled: An optional property indicating whether the row or
+  column is being used as output. If specified the row is being used
+  as the output. Else defaults to column.
+
+- pull-up-enabled: An optional property indicating the Keypad scan mode.
+  If specified implies the keypad scan pull-up has been enabled.
+
+- autorepeat: Boolean, Enable auto repeat feature of Linux input
+	  subsystem (optional).
+
+- linux,keymap: The keymap for keys as described in the binding document
+  devicetree/bindings/input/matrix-keymap.txt.
+
+Example:
+#include "dt-bindings/input/input.h"
+
+/ {
+	keypad: keypad at 180ac000 {
+		/* Required SoC specific properties */
+		compatible = "brcm,bcm-keypad";
+
+		/* Required Board specific properties */
+		keypad,num-rows = <5>;
+		keypad,num-columns = <5>;
+		status = "okay";
+
+		linux,keymap = <MATRIX_KEY(0x00, 0x02, KEY_F) /* key_forward */
+		MATRIX_KEY(0x00, 0x03, KEY_HOME) /* key_home */
+		MATRIX_KEY(0x00, 0x04, KEY_M) /* key_message */
+		MATRIX_KEY(0x01, 0x00, KEY_A) /* key_contacts */
+		MATRIX_KEY(0x01, 0x01, KEY_1) /* key_1 */
+		MATRIX_KEY(0x01, 0x02, KEY_2) /* key_2 */
+		MATRIX_KEY(0x01, 0x03, KEY_3) /* key_3 */
+		MATRIX_KEY(0x01, 0x04, KEY_S) /* key_speaker */
+		MATRIX_KEY(0x02, 0x00, KEY_P) /* key_phone */
+		MATRIX_KEY(0x02, 0x01, KEY_4) /* key_4 */
+		MATRIX_KEY(0x02, 0x02, KEY_5) /* key_5 */
+		MATRIX_KEY(0x02, 0x03, KEY_6) /* key_6 */
+		MATRIX_KEY(0x02, 0x04, KEY_VOLUMEUP) /* key_vol_up */
+		MATRIX_KEY(0x03, 0x00, KEY_C) /* key_call_log */
+		MATRIX_KEY(0x03, 0x01, KEY_7) /* key_7 */
+		MATRIX_KEY(0x03, 0x02, KEY_8) /* key_8 */
+		MATRIX_KEY(0x03, 0x03, KEY_9) /* key_9 */
+		MATRIX_KEY(0x03, 0x04, KEY_VOLUMEDOWN) /* key_vol_down */
+		MATRIX_KEY(0x04, 0x00, KEY_H) /* key_headset */
+		MATRIX_KEY(0x04, 0x01, KEY_KPASTERISK) /* key_* */
+		MATRIX_KEY(0x04, 0x02, KEY_0) /* key_0 */
+		MATRIX_KEY(0x04, 0x03, KEY_GRAVE) /* key_# */
+		MATRIX_KEY(0x04, 0x04, KEY_MUTE) /* key_mute */
+		>;
+
+		/* Optional board specific properties */
+		col-debounce-filter-period = <5>;
+		row-output-enabled;
+		pull-up-enabled;
+
+	};
+};
-- 
2.3.0
