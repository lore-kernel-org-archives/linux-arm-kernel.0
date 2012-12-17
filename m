From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Dec 2012 16:35:38 +0000
Subject: [PATCH v2 3/6] ARM: psci: add devicetree binding for describing PSCI
 firmware
In-Reply-To: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
Message-ID: <1355762141-29616-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new devicetree binding for describing PSCI firmware
to Linux.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/devicetree/bindings/arm/psci.txt | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/psci.txt

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
new file mode 100644
index 0000000..904d0d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -0,0 +1,58 @@
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
+ - function-base : The base ID from which the functions are offset.
+
+Main node optional properties:
+
+ - cpu_suspend   : Offset of CPU_SUSPEND ID from function-base
+
+ - cpu_off       : Offset of CPU_OFF ID from function-base
+
+ - cpu_on        : Offset of CPU_ON ID from function-base
+
+ - migrate       : Offset of MIGRATE ID from function-base
+
+
+Example:
+
+	psci {
+		compatible	= "arm,psci";
+		method		= "smc";
+		function-base	= <0x95c1ba5e>;
+		cpu_suspend	= <0>;
+		cpu_off		= <1>;
+		cpu_on		= <2>;
+		migrate		= <3>;
+	};
-- 
1.8.0
