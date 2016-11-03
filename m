From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  2 Nov 2016 22:52:08 -0600
Subject: [PATCH v5 5/8] Documentation: bindings: decouple juno specific
 details from generic binding
In-Reply-To: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1478148731-11712-6-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since SCPI is a generic protocol and the bindings are intended to be
generic, we need to decouple all the platform specific binding details
out of the generic bindings.

This patch moves are the Juno platform specific details into a separate
binding document.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 Documentation/devicetree/bindings/arm/arm,scpi.txt | 20 ++++++-----------
 .../devicetree/bindings/arm/juno,scpi.txt          | 26 ++++++++++++++++++++++
 2 files changed, 33 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/juno,scpi.txt

diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
index faa4b44572e3..d1882c4540d0 100644
--- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
@@ -59,18 +59,14 @@ SRAM and Shared Memory for SCPI
 A small area of SRAM is reserved for SCPI communication between application
 processors and SCP.
 
-Required properties:
-- compatible : should be "arm,juno-sram-ns" for Non-secure SRAM on Juno
-
-The rest of the properties should follow the generic mmio-sram description
-found in ../../sram/sram.txt
+The properties should follow the generic mmio-sram description found in [3]
 
 Each sub-node represents the reserved area for SCPI.
 
 Required sub-node properties:
 - reg : The base offset and size of the reserved area with the SRAM
-- compatible : should be "arm,juno-scp-shmem" for Non-secure SRAM based
-	       shared memory on Juno platforms
+- compatible : should be "arm,scp-shmem" for Non-secure SRAM based
+	       shared memory
 
 Sensor bindings for the sensors based on SCPI Message Protocol
 --------------------------------------------------------------
@@ -81,11 +77,9 @@ SCPI provides an API to access the various sensors on the SoC.
 - #thermal-sensor-cells: should be set to 1. This property follows the
 			 thermal device tree bindings[2].
 
-			 Valid cell values are raw identifiers (Sensor
-			 ID) as used by the firmware. Refer to
-			 platform documentation for your
-			 implementation for the IDs to use. For Juno
-			 R0 and Juno R1 refer to [3].
+			 Valid cell values are raw identifiers (Sensor ID)
+			 as used by the firmware. Refer to  platform details
+			 for your implementation for the IDs to use.
 
 Power domain bindings for the power domains based on SCPI Message Protocol
 ------------------------------------------------------------
@@ -112,7 +106,7 @@ PM domain consumers
 [0] http://infocenter.arm.com/help/topic/com.arm.doc.dui0922b/index.html
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
 [2] Documentation/devicetree/bindings/thermal/thermal.txt
-[3] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0922b/apas03s22.html
+[3] Documentation/devicetree/bindings/sram/sram.txt
 [4] Documentation/devicetree/bindings/power/power_domain.txt
 
 Example:
diff --git a/Documentation/devicetree/bindings/arm/juno,scpi.txt b/Documentation/devicetree/bindings/arm/juno,scpi.txt
new file mode 100644
index 000000000000..2ace8696bbee
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/juno,scpi.txt
@@ -0,0 +1,26 @@
+System Control and Power Interface (SCPI) Message Protocol
+(in addition to the standard binding in [0])
+
+Juno SRAM and Shared Memory for SCPI
+------------------------------------
+
+Required properties:
+- compatible : should be "arm,juno-sram-ns" for Non-secure SRAM
+
+Each sub-node represents the reserved area for SCPI.
+
+Required sub-node properties:
+- reg : The base offset and size of the reserved area with the SRAM
+- compatible : should be "arm,juno-scp-shmem" for Non-secure SRAM based
+	       shared memory on Juno platforms
+
+Sensor bindings for the sensors based on SCPI Message Protocol
+--------------------------------------------------------------
+Required properties:
+- compatible : should be "arm,scpi-sensors".
+- #thermal-sensor-cells: should be set to 1.
+			 For Juno R0 and Juno R1 refer to [1] for the
+			 sensor identifiers
+
+[0] Documentation/devicetree/bindings/arm/arm,scpi.txt
+[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0922b/apas03s22.html
-- 
1.9.1
