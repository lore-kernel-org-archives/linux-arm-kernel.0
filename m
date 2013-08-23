From: robherring2@gmail.com (Rob Herring)
Date: Fri, 23 Aug 2013 10:10:13 -0500
Subject: [PATCH v2] dt: update PSCI binding documentation for v0.2
Message-ID: <1377270613-28435-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The PSCI spec from ARM has been updated to 0.2 version. Update the
binding document to reflect the spec changes. For the binding, the
major changes are addition of system reset and poweroff functions.
The recommended function id numbering has also changed.

This update also defines 32 and 64 bit calling conventions. The calling
convention is defined by the method property.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <Ian.Campbell@citrix.com>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>,
Cc: Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>
Cc: Matt Sealey <neko@bakuhatsu.net>
Cc: devicetree at vger.kernel.org
---
 Documentation/devicetree/bindings/arm/psci.txt | 85 +++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index 433afe9..2c03d0b 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -1,16 +1,17 @@
 * Power State Coordination Interface (PSCI)
 
 Firmware implementing the PSCI functions described in ARM document number
-ARM DEN 0022A ("Power State Coordination Interface System Software on ARM
+ARM DEN 0022B ("Power State Coordination Interface System Software on ARM
 processors") can be used by Linux to initiate various CPU-centric power
 operations.
 
-Issue A of the specification describes functions for CPU suspend, hotplug
-and migration of secure software.
+Issue B of the specification describes functions for CPU suspend, hotplug,
+migration of secure software, and system level reset and powerdown.
 
 Functions are invoked by trapping to the privilege level of the PSCI
 firmware (specified as part of the binding below) and passing arguments
-in a manner similar to that specified by AAPCS:
+as defined in ARM document "SMC Calling Convention" (ARM DEN 0028) in a manner
+similar to that specified by AAPCS:
 
 	 r0		=> 32-bit Function ID / return value
 	{r1 - r3}	=> Parameters
@@ -21,16 +22,37 @@ to #0.
 
 Main node required properties:
 
- - compatible    : Must be "arm,psci"
+ - compatible    : Must be "arm,psci-0.2" or "arm,psci"
 
- - method        : The method of calling the PSCI firmware. Permitted
-                   values are:
+ - method        : The method defines the calling convention for the PSCI
+                   firmware. If the firmware supports multiple calling
+                   conventions (i.e. 32 and 64 bit), then the DT shall have a
+                   node for each method. Permitted values are:
 
                    "smc" : SMC #0, with the register assignments specified
-		           in this binding.
+		           in this binding (deprecated, "arm,psci" only).
+
+                   "smc32" : SMC #0, using 32-bit SMC calling convention with
+                             32-bit register assignments specified in this
+                             binding.
+
+                   "smc64" : SMC #0, using 64-bit SMC calling convention with
+                             64-bit register assignments specified in this
+                             binding.
 
                    "hvc" : HVC #0, with the register assignments specified
-		           in this binding.
+		           in this binding (deprecated, "arm,psci" only).
+
+                   "hvc32" : HVC #0, using 32-bit HVC calling convention with
+                             32-bit register assignments specified in this
+                             binding.
+
+                   "hvc64" : HVC #0, using 64-bit HVCC calling convention with
+                             64-bit register assignments specified in this
+                             binding.
+
+ - psci_version  : Function ID for PSCI_VERSION operation. Required for
+                   "arm,psci-0.2" compatible version or later.
 
 Main node optional properties:
 
@@ -40,16 +62,47 @@ Main node optional properties:
 
  - cpu_on        : Function ID for CPU_ON operation
 
+ - affinity_info : Function ID for AFFINITY_INFO operation
+
  - migrate       : Function ID for MIGRATE operation
 
+ - migrate_info_type : Function ID for MIGRATE_INFO_TYPE operation
+
+ - migrate_info_up_cpu : Function ID for MIGRATE_INFO_UP_CPU operation
+
+ - system_reset  : Function ID for SYSTEM_RESET operation
+
+ - system_off    : Function ID for SYSTEM_OFF operation
+
 
 Example:
 
-	psci {
-		compatible	= "arm,psci";
-		method		= "smc";
-		cpu_suspend	= <0x95c10000>;
-		cpu_off		= <0x95c10001>;
-		cpu_on		= <0x95c10002>;
-		migrate		= <0x95c10003>;
+	psci32 {
+		compatible	= "arm,psci-0.2";
+		method		= "smc32";
+		psci_version	= <0x84000000>;
+		cpu_suspend	= <0x84000001>;
+		cpu_off		= <0x84000002>;
+		cpu_on		= <0x84000003>;
+		affinity_info	= <0x84000004>; 
+		migrate		= <0x84000005>;
+		migrate_info_type = <0x84000006>;
+		migrate_info_up_cpu = <0x84000007>;
+		system_off	= <0x84000008>; 
+		system_reset	= <0x84000009>; 
+	};
+
+	psci64 {
+		compatible	= "arm,psci-0.2";
+		method		= "smc64";
+		psci_version	= <0x84000000>;
+		cpu_suspend	= <0xc4000001>;
+		cpu_off		= <0x84000002>;
+		cpu_on		= <0xc4000003>;
+		affinity_info	= <0xc4000004>; 
+		migrate		= <0xc4000005>;
+		migrate_info_type = <0x84000006>;
+		migrate_info_up_cpu = <0xc4000007>;
+		system_off	= <0x84000008>; 
+		system_reset	= <0x84000009>; 
 	};
-- 
1.8.1.2
