From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed,  5 Oct 2016 14:31:56 -0600
Subject: [PATCH 5/8] dt/bindings: Update binding for PM domain idle states
In-Reply-To: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1475699519-109623-6-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update DT bindings to describe idle states of PM domains.

This patch is based on the original patch by Marc Titinger.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/power/power_domain.txt     | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 025b5e7..a043315 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -29,6 +29,10 @@ Optional properties:
    specified by this binding. More details about power domain specifier are
    available in the next section.
 
+- domain-idle-states : A phandle of an idle-state that shall be soaked into a
+                generic domain power state. The idle state definitions are
+                compatible with arm,idle-state specified in [1].
+
 Example:
 
 	power: power-controller at 12340000 {
@@ -59,6 +63,36 @@ The nodes above define two power controllers: 'parent' and 'child'.
 Domains created by the 'child' power controller are subdomains of '0' power
 domain provided by the 'parent' power controller.
 
+Example 3:
+	parent: power-controller at 12340000 {
+		compatible = "foo,power-controller";
+		reg = <0x12340000 0x1000>;
+		#power-domain-cells = <1>;
+		domain-idle-states = <&DOMAIN_RET, &DOMAIN_PWR_DN>;
+	};
+
+	child: power-controller at 12341000 {
+		compatible = "foo,power-controller";
+		reg = <0x12341000 0x1000>;
+		power-domains = <&parent 0>;
+		#power-domain-cells = <1>;
+		domain-idle-states = <&DOMAIN_PWR_DN>;
+	};
+
+	DOMAIN_RET: state at 0 {
+		compatible = "arm,idle-state";
+		entry-latency-us = <1000>;
+		exit-latency-us = <2000>;
+		min-residency-us = <10000>;
+	};
+
+	DOMAIN_PWR_DN: state at 1 {
+		compatible = "arm,idle-state";
+		entry-latency-us = <5000>;
+		exit-latency-us = <8000>;
+		min-residency-us = <7000>;
+	};
+
 ==PM domain consumers==
 
 Required properties:
@@ -76,3 +110,5 @@ Example:
 The node above defines a typical PM domain consumer device, which is located
 inside a PM domain with index 0 of a power controller represented by a node
 with the label "power".
+
+[1]. Documentation/devicetree/bindings/arm/idle-states.txt
-- 
2.7.4
