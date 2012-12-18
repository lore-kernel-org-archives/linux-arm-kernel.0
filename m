From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Dec 2012 17:53:13 +0000
Subject: [PATCH v3 3/6] ARM: psci: add devicetree binding for describing PSCI
 firmware
In-Reply-To: <1355853196-23676-1-git-send-email-will.deacon@arm.com>
References: <1355853196-23676-1-git-send-email-will.deacon@arm.com>
Message-ID: <1355853196-23676-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new devicetree binding for describing PSCI firmware
to Linux.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/devicetree/bindings/arm/psci.txt | 55 ++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/psci.txt

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
new file mode 100644
index 0000000..433afe9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -0,0 +1,55 @@
+* Power State Coordination Interface (PSCI)
+
+Firmware implementing the PSCI functions described in ARM document number
+ARM DEN 0022A ("Power State Coordination Interface System Software on ARM
+processors") can be used by Linux to initiate various CPU-centric power
+operations.
+
+Issue A of the specification describes functions for CPU suspend, hotplug
+and migration of secure software.
+
+Functions are invoked by trapping to the privilege level of the PSCI
+firmware (specified as part of the binding below) and passing arguments
+in a manner similar to that specified by AAPCS:
+
+	 r0		=> 32-bit Function ID / return value
+	{r1 - r3}	=> Parameters
+
+Note that the immediate field of the trapping instruction must be set
+to #0.
+
+
+Main node required properties:
+
+ - compatible    : Must be "arm,psci"
+
+ - method        : The method of calling the PSCI firmware. Permitted
+                   values are:
+
+                   "smc" : SMC #0, with the register assignments specified
+		           in this binding.
+
+                   "hvc" : HVC #0, with the register assignments specified
+		           in this binding.
+
+Main node optional properties:
+
+ - cpu_suspend   : Function ID for CPU_SUSPEND operation
+
+ - cpu_off       : Function ID for CPU_OFF operation
+
+ - cpu_on        : Function ID for CPU_ON operation
+
+ - migrate       : Function ID for MIGRATE operation
+
+
+Example:
+
+	psci {
+		compatible	= "arm,psci";
+		method		= "smc";
+		cpu_suspend	= <0x95c10000>;
+		cpu_off		= <0x95c10001>;
+		cpu_on		= <0x95c10002>;
+		migrate		= <0x95c10003>;
+	};
-- 
1.8.0
