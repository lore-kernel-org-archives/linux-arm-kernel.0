From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 20 Dec 2013 19:42:52 -0800
Subject: [PATCH 1/5] Documentation: APM X-Gene SoC Ethernet DTS binding
 documentation
In-Reply-To: <1387597376-29303-1-git-send-email-isubramanian@apm.com>
References: <1387597376-29303-1-git-send-email-isubramanian@apm.com>
Message-ID: <1387597376-29303-2-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation explaining dts nodes.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Ravi Patel <rapatel@apm.com>
Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
---
 .../devicetree/bindings/net/apm-xgene-enet.txt     |   67 ++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/apm-xgene-enet.txt

diff --git a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
new file mode 100644
index 0000000..8b88b74
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
@@ -0,0 +1,67 @@
+APM X-Gene SoC Ethernet nodes
+
+Ethernet nodes are defined to describe on-chip ethernet interfaces in
+APM X-Gene SoC. Ethernet subsystem communicates with a central Queue Manager
+(QMTM) using messages for transmit, receive and allocating data buffers.
+There are multiple ethernet interfaces in APM X-Gene SoC. Each ethernet
+interface has its own node. Its corresponding clock nodes are shown below.
+
+Required properties:
+- compatible		: Shall be "apm,xgene-enet"
+- reg			: First memory resource shall be the Ethernet CSR
+			  memory resource for indirect MAC access.
+			  Second memory resource shall be the Ethernet CSR
+			  memory resource.
+			  Third memory resource shall be the Ethernet CSR
+			  memory resource for indirect MII access.
+- slave-name		: Shall be QMTM slave name.
+- interrupts		: First interrupt resource shall be the Ethernet global
+			  Error interrupt.
+			: Second interrupt resource shall be the Ethernet MAC
+			  Error interrupt.
+			: Third interrupt resource shall be the Ethernet QM
+			  interface interrupt.
+- clocks		: Reference to the clock entry.
+- local-mac-address	: Shall be ethernet mac address.
+- max-frame-size	: Shall be maximum ethernet frame size.
+- devid			: Shall be ethernet interface number.
+- phyid			: Shall be ethernet MII phy address.
+- phy-mode		: Shall be ethernet MII mode.
+
+Optional properties:
+- status		: Shall be "ok" if enabled or "disabled" if disabled.
+			  Default is "ok".
+
+Example:
+	eth8clk: eth8clk {
+		compatible = "apm,xgene-device-clock";
+		clock-names = "eth8clk";
+		status = "ok";
+	};
+
+	menet: ethernet at 17020000 {
+		compatible = "apm,xgene-enet";
+		status = "disabled";
+		reg = <0x0 0x17020000 0x0 0x30>,
+		      <0x0 0x17020000 0x0 0x10000>,
+		      <0x0 0x17020000 0x0 0x20>;
+		slave-name = "RGMII";
+		interrupts = <0x0 0x38 0x4>,
+			     <0x0 0x39 0x4>,
+			     <0x0 0x3a 0x4>;
+		clocks = <&eth8clk 0>;
+		local-mac-address = <0x0 0x11 0x3a 0x8a 0x5a 0x78>;
+		max-frame-size = <0x233a>;
+		devid = <8>;
+		phyid = <3>;
+		phy-mode = "rgmii";
+	};
+
+/* Board-specific peripheral configurations */
+aliases {
+	ethernet0 = &menet;
+};
+
+&menet {
+        status = "ok";
+};
-- 
1.7.9.5
