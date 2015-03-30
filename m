From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 30 Mar 2015 22:57:59 +0100
Subject: [PATCH v4 05/10] eeprom: Add bindings for simple eeprom framework
In-Reply-To: <1427752492-17039-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1427752492-17039-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1427752679-17261-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds bindings for simple eeprom framework which allows eeprom
consumers to talk to eeprom providers to get access to eeprom cell data.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
[Maxime Ripard: intial version of eeprom framework]
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/eeprom/eeprom.txt          | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/eeprom/eeprom.txt

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
new file mode 100644
index 0000000..fb71d46
--- /dev/null
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -0,0 +1,58 @@
+= EEPROM Data Device Tree Bindings =
+
+This binding is intended to represent the location of hardware
+configuration data stored in EEPROMs.
+
+On a significant proportion of boards, the manufacturer has stored
+some data on an EEPROM-like device, for the OS to be able to retrieve
+these information and act upon it. Obviously, the OS has to know
+about where to retrieve these data from, and where they are stored on
+the storage device.
+
+This document is here to document this.
+
+= Data providers =
+Contains bindings specific to provider drivers and data cells as children
+to this node.
+
+= Data cells =
+These are the child nodes of the provider which contain data cell
+information like offset and size in eeprom provider.
+
+Required properties:
+reg:	specifies the offset in byte within that storage device, and the length
+	in bytes of the data we care about.
+	There could be more then one offset-length pairs in this property.
+
+Optional properties:
+As required by specific data parsers/interpreters.
+
+For example:
+
+	/* Provider */
+	qfprom: qfprom at 00700000 {
+		compatible 	= "qcom,qfprom";
+		reg		= <0x00700000 0x8000>;
+		...
+
+		/* Data cells */
+		tsens_calibration: calib at 4404 {
+			reg = <0x4404 0x10>;
+		};
+
+		serial_number: sn {
+			reg = <0x104 0x4>, <0x204 0x4>, <0x30c 0x4>;
+
+		};
+		...
+	};
+
+= Data consumers =
+Are device nodes which consume eeprom data cells.
+
+For example:
+
+	tsens {
+		...
+		calibration = <&tsens_calibration>;
+	};
-- 
1.9.1
