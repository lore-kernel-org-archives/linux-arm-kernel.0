From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 15 May 2014 00:11:29 -0400
Subject: [PATCH v10 2/3] Documentation: devicetree: Add new binding for
 PSCIv0.2
In-Reply-To: <1400127090-1320-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1400127090-1320-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <1400127090-1320-3-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PSCI v0.2+ spec defines standard values for PSCI function IDs.
Add a new binding entry so that pre v0.2 implementations can
use DT entries for function IDs and v0.2+ implementations use
standard entries as defined by the PSCIv0.2 specification.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/psci.txt | 37 +++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index 433afe9..b4a58f3 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -21,7 +21,15 @@ to #0.
 
 Main node required properties:
 
- - compatible    : Must be "arm,psci"
+ - compatible    : should contain at least one of:
+
+				 * "arm,psci" : for implementations complying to PSCI versions prior to
+					0.2. For these cases function IDs must be provided.
+
+				 * "arm,psci-0.2" : for implementations complying to PSCI 0.2. Function
+					IDs are not required and should be ignored by an OS with PSCI 0.2
+					support, but are permitted to be present for compatibility with
+					existing software when "arm,psci" is later in the compatible list.
 
  - method        : The method of calling the PSCI firmware. Permitted
                    values are:
@@ -45,6 +53,8 @@ Main node optional properties:
 
 Example:
 
+Case 1: PSCI v0.1 only.
+
 	psci {
 		compatible	= "arm,psci";
 		method		= "smc";
@@ -53,3 +63,28 @@ Example:
 		cpu_on		= <0x95c10002>;
 		migrate		= <0x95c10003>;
 	};
+
+
+Case 2: PSCI v0.2 only
+
+	psci {
+		compatible	= "arm,psci-0.2";
+		method		= "smc";
+	};
+
+Case 3: PSCI v0.2 and PSCI v0.1.
+
+	A DTB may provide IDs for use by kernels without PSCI 0.2 support,
+	enabling firmware and hypervisors to support existing and new kernels.
+	These IDs will be ignored by kernels with PSCI 0.2 support, which will
+	use the standard PSCI 0.2 IDs exclusively.
+
+	psci {
+		compatible = "arm,psci-0.2", "arm,psci";
+		method = "hvc";
+
+		cpu_on = < arbitrary value >;
+		cpu_off = < arbitrary value >;
+
+		...
+	};
-- 
1.8.3.2
