From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Jan 2015 11:35:54 +0000
Subject: [PATCH RFC 1/2] Documentation: arm: define DT bindings for system
 suspend
In-Reply-To: <1421840155-18990-1-git-send-email-sudeep.holla@arm.com>
References: <1421840155-18990-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1421840155-18990-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM based platforms implement unique ways to enter system suspend
(i.e. Suspend to RAM). The mechanism and the parameters defining the
system state vary on a per-platform basis forcing the OS to handle it
in very platform specific way.

Since ARM 32-bit systems had machine specific code, no attempts to
standardize are being made as it provides easy way to implement suspend
operations in a platform specific manner. However, this approach not
only makes maintainance more difficult as the number of platforms
supported increases but also not feasible for ARM64.

This DT binding aims at standardizing the system suspend for ARM
platforms. ARM64 platforms mandates entry-method property in DT for
this system suspend node.

On system implementing PSCI as an enable-method to enter system suspend,
the PSCI CPU suspend method is used on versions upto v0.2 and requires
the power_state parameter to be passed to the PSCI CPU suspend function.

This parameter is platform specific, therefore must be provided by
firmware to the OS in order to enable proper call sequence.

This ARM system suspend DT bindings rely on a property
(i.e. arm,psci-suspend-param) in the PSCI DT bindings that describes
how the PSCI CPU suspend power_state parameter should be defined in DT.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 Documentation/devicetree/bindings/arm/psci.txt     | 11 +++
 .../devicetree/bindings/arm/system-suspend.txt     | 93 ++++++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/system-suspend.txt

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index 5aa40ede0e99..bd3977a2a333 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -61,6 +61,14 @@ Device tree nodes that require usage of PSCI CPU_SUSPEND function (ie idle
 		Definition: power_state parameter to pass to the PSCI
 			    suspend call.
 
+PSCI v0.2 and earlier versions don't have explicit operation for system
+suspend. However, one can implement system suspend using CPU_SUSPEND by
+ensuring every other core except the one executing the CPU_SUSPEND call
+has called into PSCI through a CPU_OFF call.
+
+In such cases, device tree nodes representing system suspend as per the
+bindings in [2] must specify the above "arm,psci-suspend-param" property.
+
 Example:
 
 Case 1: PSCI v0.1 only.
@@ -100,3 +108,6 @@ Case 3: PSCI v0.2 and PSCI v0.1.
 
 [1] Kernel documentation - ARM idle states bindings
     Documentation/devicetree/bindings/arm/idle-states.txt
+
+[2] Kernel documentation - ARM system suspend bindings
+    Documentation/devicetree/bindings/arm/system-suspend.txt
diff --git a/Documentation/devicetree/bindings/arm/system-suspend.txt b/Documentation/devicetree/bindings/arm/system-suspend.txt
new file mode 100644
index 000000000000..15cac4c7fe92
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/system-suspend.txt
@@ -0,0 +1,93 @@
+==========================================
+ARM system suspend binding description
+==========================================
+
+==========================================
+1 - Introduction
+==========================================
+
+System Suspend(commonly known as Suspend to RAM) is a method to remove
+power from most parts of the machine aside from the RAM, which is required
+to restore the machine's state. Because of the large power savings, it is
+widely used in mobile systems like laptops, tablets and smartphones.
+
+Usually most mobile systems enter system suspend state aggressively when
+they are idle even for short time(in seconds) while others systems like
+laptops automatically enter this mode when they running on batteries and
+the lid is closed (and/or the user is inactive for some time(in minutes)).
+
+Most of the devices in the system are deactivated. Non-volatile memory
+(like disk drives, flash, memory card), graphics chips and even the CPU
+are usually deactivated. Only the RAM is powered to keep its contents. On
+resume, only those individual devices/CPUs need to be reinitialized and
+work continues relatively fast.
+
+It is highly hardware specific especially on ARM platforms. Hence we need
+device tree binding definition for ARM system suspend state which is the
+subject of this document in order to provide generic solution.
+
+===========================================
+2 - system suspend node
+===========================================
+
+The system suspend node represents the description of the mechanism to
+enter system suspend state and must be defined as follows:
+
+	- compatible
+		Usage: Required
+		Value type: <stringlist>
+		Definition: Must be "arm,system-suspend";
+
+	- entry-method
+		Value type: <stringlist>
+		Usage and definition depend on ARM architecture version.
+			# On ARM v8 64-bit this property is required and must
+			  be one of:
+			   - "arm,psci" (see bindings in [1])
+
+	- status:
+		Usage: Optional
+		Value type: <string>
+		Definition: A standard device tree property [2] that indicates
+			    the operational status of system suspend.
+			    If present, it shall be:
+			    "okay": to indicate it is operational.
+			    "disabled": to indicate that it has been disabled
+			                in firmware so it is not operational.
+			    By default, it's always enabled if not explicitly
+			    disabled.
+
+	In addition to the properties listed above, it may require additional
+	properties specifics to the entry-method defined, please refer to the
+	corresponding entry-method bindings documentation for details.
+	In the below example using "arm,psci" entry method,
+	"arm,psci-suspend-param" is a PSCI specific property.
+
+	The system suspend node's parent node must be the 'cpus' node.
+
+===========================================
+3 - Examples
+===========================================
+
+Example:
+cpus {
+	/* cpu-map, cpu and idle-states nodes */
+	....
+
+	system-suspend {
+		compatible = "arm,system-suspend";
+		entry-method = "arm,psci";
+		arm,psci-suspend-param = <0x1010000>;
+	};
+
+	....
+};
+===========================================
+4 - References
+===========================================
+
+[1] ARM Linux Kernel documentation - PSCI bindings
+    Documentation/devicetree/bindings/arm/psci.txt
+
+[2] ePAPR standard
+    https://www.power.org/documentation/epapr-version-1-1/
-- 
1.9.1
