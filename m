From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Jul 2017 12:04:35 +0530
Subject: [RFC v2 5/6] drivers: boot_constraint: Add initial DT bindings
In-Reply-To: <cover.1499770771.git.viresh.kumar@linaro.org>
References: <cover.1499770771.git.viresh.kumar@linaro.org>
Message-ID: <0610277aef9830cff53b7b53cf41cc54886fdc7f.1499770771.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree bindings for boot constraints. Only power supply
constraint types are supported currently.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/boot-constraints.txt       | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/boot-constraints.txt

diff --git a/Documentation/devicetree/bindings/boot-constraints.txt b/Documentation/devicetree/bindings/boot-constraints.txt
new file mode 100644
index 000000000000..9a01ea1e6e72
--- /dev/null
+++ b/Documentation/devicetree/bindings/boot-constraints.txt
@@ -0,0 +1,68 @@
+BOOT CONSTRAINTS
+================
+
+Some devices are powered ON by the bootloader before the bootloader handovers
+control to the Operating System (OS). It maybe important for those devices to
+keep working until the time the OS takes over and starts configuring the devices
+again.
+
+A typical example of that can be the LCD controller, which is used by the
+bootloaders to show image(s) while the platform is booting into the Operating
+System. The LCD controller can be using some resources, like clk, supplies, etc,
+that are shared between several devices. These shared resources should be
+configured to satisfy need of all the users. If another device's (X) driver gets
+probed before the LCD controller driver in this case, then it may end up
+reconfiguring these resources to ranges satisfying the current users (only
+device X) and that can make the LCD screen unstable.
+
+This document describes the binding used to specify such boot constraints to the
+OS.
+
+Power Supply Constraints:
+-------------------------
+
+This describes the binding of constraints for the power supply resources. These
+must be present directly in the consumer device's node.
+
+Required properties:
+- boot-constraint-supplies:
+
+  This contains an array of (one or more) strings, each of which must match with
+  the <name> of a corresponding <name>-supply property in the same device node.
+  This is required for the OS to know about the power supplies that are
+  configured (and enabled) by the bootloader for the consumer device.
+
+  It is assumed that the power supply is already enabled by the bootloader.
+
+- boot-constraint-uV:
+
+  This contains an array of {min max} microvolt tuples for the power supplies in
+  the same order in which they are present in "boot-constraint-supplies"
+  property. Here, min is the smallest and max is the largest voltage that the
+  consumer (corresponding to the device node where this property is present) may
+  set.
+
+Example of a consumer device node (mmc) referencing two regulators and setting
+their boot constraints (twl_reg1 and twl_reg2):
+
+	twl_reg1: regulator at 0 {
+		...
+		...
+		...
+	};
+
+	twl_reg2: regulator at 1 {
+		...
+		...
+		...
+	};
+
+	mmc: mmc at 0x0 {
+		...
+		...
+		vmmc-supply = <&twl_reg1>;
+		vmmcaux-supply = <&twl_reg2>;
+		boot-constraint-supplies = "vmmc", "vmmcaux";
+		boot-constraint-uV = <1800000 2000000>, /* vmmc */
+				     <2000000 2000000>; /* vmmcaux */
+	};
-- 
2.13.0.71.gd7076ec9c9cb
