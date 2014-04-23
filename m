From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 23 Apr 2014 17:51:15 +0200
Subject: [PATCH v2 6/7] Documentation: add the Marvell Berlin pinctrl
 documentation
In-Reply-To: <1398268276-9696-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1398268276-9696-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1398268276-9696-7-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation related to the Berlin pin-controller driver and
explain how to configure this group based controller.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 .../bindings/pinctrl/marvell,berlin-pinctrl.txt    | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,berlin-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,berlin-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,berlin-pinctrl.txt
new file mode 100644
index 000000000000..c59671ac6b54
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,berlin-pinctrl.txt
@@ -0,0 +1,44 @@
+* Pin-controller driver for the Marvell Berlin SoCs
+
+The pins controlled by the Marvell Berlin controller are organized in groups.
+Configuration is done by group, so no actual pin information is needed.
+
+Be aware the Marvell Berlin datasheets use the keyword 'mode' for what is called
+a 'function' in the pin-controller subsystem.
+
+Required properties:
+- compatible: should be one of: "marvell,berlin2-soc-pinctrl",
+				"marvell,berlin2-sysmgr-pinctrl",
+				"marvell,berlin2cd-soc-pinctrl",
+				"marvell,berlin2cd-sysmgr-pinctrl",
+				"marvell,berlin2q-soc-pinctrl"
+				"marvell,berlin2q-sysmgr-pinctrl"
+- reg: registers physical address and length of the pin controller.
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pin-controller bindings used by client devices.
+
+A pin-controller node should contain subnodes representing the pin group
+configurations, one per group. Each subnode has the group name and the muxing
+function used.
+
+Required subnode-properties:
+- marvell,groups: a list of strings describing the group names.
+- marvell,function: a string describing the function used to mux the groups.
+
+Example:
+
+sm_pinctrl: pin-controller at 0 {
+	compatible = "marvell,berlin2q-sysmgr-pinctrl";
+	reg = <0xfc0000 0x44>;
+
+	uart0_pmux: uart0-pmux {
+		marvell,groups = "GSM12", "GSM13";
+		marvell,function = "uart0";
+	};
+}
+
+&uart0 {
+	pinctrl-0 = <&uart0_pmux>;
+	pinctrl-names = "default";
+};
-- 
1.8.3.2
