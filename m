From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:38 -0500
Subject: [PATCH 26/36] dt-bindings: arm: Convert QCom board/soc bindings to
 json-schema
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-27-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert QCom SoC bindings to DT schema format using json-schema.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/qcom.txt          |  57 --------
 .../devicetree/bindings/arm/qcom.yaml         | 125 ++++++++++++++++++
 2 files changed, 125 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/qcom.txt
 create mode 100644 Documentation/devicetree/bindings/arm/qcom.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
deleted file mode 100644
index ee532e705d6c..000000000000
--- a/Documentation/devicetree/bindings/arm/qcom.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-QCOM device tree bindings
--------------------------
-
-Some qcom based bootloaders identify the dtb blob based on a set of
-device properties like SoC and platform and revisions of those components.
-To support this scheme, we encode this information into the board compatible
-string.
-
-Each board must specify a top-level board compatible string with the following
-format:
-
-	compatible = "qcom,<SoC>[-<soc_version>][-<foundry_id>]-<board>[/<subtype>][-<board_version>]"
-
-The 'SoC' and 'board' elements are required. All other elements are optional.
-
-The 'SoC' element must be one of the following strings:
-
-	apq8016
-	apq8074
-	apq8084
-	apq8096
-	msm8916
-	msm8974
-	msm8992
-	msm8994
-	msm8996
-	mdm9615
-	ipq8074
-	sdm845
-
-The 'board' element must be one of the following strings:
-
-	cdp
-	liquid
-	dragonboard
-	mtp
-	sbc
-	hk01
-
-The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
-where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
-as v1. If all versions of the 'board_version' elements match, then a
-wildcard '*' should be used, e.g. 'v*'.
-
-The 'foundry_id' and 'subtype' elements are one or more digits from 0 to 9.
-
-Examples:
-
-	"qcom,msm8916-v1-cdp-pm8916-v2.1"
-
-A CDP board with an msm8916 SoC, version 1 paired with a pm8916 PMIC of version
-2.1.
-
-	"qcom,apq8074-v2.0-2-dragonboard/1-v0.1"
-
-A dragonboard board v0.1 of subtype 1 with an apq8074 SoC version 2, made in
-foundry 2.
diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
new file mode 100644
index 000000000000..d8fcd8deed5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/qcom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM device tree bindings
+
+maintainers:
+  - Stephen Boyd <sboyd@codeaurora.org>
+
+description: |
+  Some qcom based bootloaders identify the dtb blob based on a set of
+  device properties like SoC and platform and revisions of those components.
+  To support this scheme, we encode this information into the board compatible
+  string.
+
+  Each board must specify a top-level board compatible string with the following
+  format:
+
+  	compatible = "qcom,<SoC>[-<soc_version>][-<foundry_id>]-<board>[/<subtype>][-<board_version>]"
+
+  The 'SoC' and 'board' elements are required. All other elements are optional.
+
+  The 'SoC' element must be one of the following strings:
+
+  	apq8016
+  	apq8074
+  	apq8084
+  	apq8096
+  	msm8916
+  	msm8974
+  	msm8992
+  	msm8994
+  	msm8996
+  	mdm9615
+  	ipq8074
+  	sdm845
+
+  The 'board' element must be one of the following strings:
+
+  	cdp
+  	liquid
+  	dragonboard
+  	mtp
+  	sbc
+  	hk01
+
+  The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
+  where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
+  as v1. If all versions of the 'board_version' elements match, then a
+  wildcard '*' should be used, e.g. 'v*'.
+
+  The 'foundry_id' and 'subtype' elements are one or more digits from 0 to 9.
+
+  Examples:
+
+  	"qcom,msm8916-v1-cdp-pm8916-v2.1"
+
+  A CDP board with an msm8916 SoC, version 1 paired with a pm8916 PMIC of version
+  2.1.
+
+  	"qcom,apq8074-v2.0-2-dragonboard/1-v0.1"
+
+  A dragonboard board v0.1 of subtype 1 with an apq8074 SoC version 2, made in
+  foundry 2.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,apq8016-sbc
+          - const: qcom,apq8016
+
+      - items:
+          - enum:
+              - qcom,apq8064-cm-qs600
+              - qcom,apq8064-ifc6410
+          - const: qcom,apq8064
+
+      - items:
+          - enum:
+              - qcom,apq8074-dragonboard
+          - const: qcom,apq8074
+
+      - items:
+          - enum:
+              - qcom,apq8060-dragonboard
+              - qcom,msm8660-surf
+          - const: qcom,msm8660
+
+      - items:
+          - enum:
+              - qcom,apq8084-mtp
+              - qcom,apq8084-sbc
+          - const: qcom,apq8084
+
+      - items:
+          - enum:
+              - qcom,msm8960-cdp
+          - const: qcom,msm8960
+
+      - items:
+          - const: qcom,msm8916-mtp/1
+          - const: qcom,msm8916-mtp
+          - const: qcom,msm8916
+
+      - items:
+          - const: qcom,msm8996-mtp
+
+      - items:
+          - const: qcom,ipq4019
+
+      - items:
+          - enum:
+              - qcom,ipq8064-ap148
+          - const: qcom,ipq8064
+
+      - items:
+          - enum:
+              - qcom,ipq8074-hk01
+          - const: qcom,ipq8074
+
+...
-- 
2.17.1
