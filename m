From: lina.iyer@linaro.org (Lina Iyer)
Date: Mon, 24 Oct 2016 15:21:04 -0700
Subject: [PATCH v4 5/9] dt-bindings: Update binding for PM domain idle states
In-Reply-To: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
References: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1477347668-41901-6-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update DT bindings to describe idle states of PM domains.

This patch is based on the original patch by Marc Titinger.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 .../devicetree/bindings/power/power_domain.txt     | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 025b5e7..3c926b5 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -29,6 +29,16 @@ Optional properties:
    specified by this binding. More details about power domain specifier are
    available in the next section.
 
+- domain-idle-states : A phandle of an idle-state that shall be soaked into a
+                generic domain power state. The idle state definitions must be
+                compatible with "domain-idle-state" as well as
+                "arm,idle-state" as defined in [1].
+  The domain-idle-state property reflects the idle state of this PM domain and
+  not the idle states of the devices or sub-domains in the PM domain. Devices
+  and sub-domains have their own idle-states independent of the parent
+  domain's idle states. In the absence of this property, the domain would be
+  considered as capable of being powered-on or powered-off.
+
 Example:
 
 	power: power-controller at 12340000 {
@@ -59,6 +69,38 @@ The nodes above define two power controllers: 'parent' and 'child'.
 Domains created by the 'child' power controller are subdomains of '0' power
 domain provided by the 'parent' power controller.
 
+Example 3:
+	parent: power-controller at 12340000 {
+		compatible = "foo,power-controller";
+		reg = <0x12340000 0x1000>;
+		#power-domain-cells = <0>;
+		domain-idle-states = <&DOMAIN_RET>, <&DOMAIN_PWR_DN>;
+	};
+
+	child: power-controller at 12341000 {
+		compatible = "foo,power-controller";
+		reg = <0x12341000 0x1000>;
+		power-domains = <&parent 0>;
+		#power-domain-cells = <0>;
+		domain-idle-states = <&DOMAIN_PWR_DN>;
+	};
+
+	DOMAIN_RET: state at 0 {
+		compatible =  "domain-idle-state", "arm,idle-state";
+		reg = <0x0>;
+		entry-latency-us = <1000>;
+		exit-latency-us = <2000>;
+		min-residency-us = <10000>;
+	};
+
+	DOMAIN_PWR_DN: state at 1 {
+		compatible =  "domain-idle-state", "arm,idle-state";
+		reg = <0x1>;
+		entry-latency-us = <5000>;
+		exit-latency-us = <8000>;
+		min-residency-us = <7000>;
+	};
+
 ==PM domain consumers==
 
 Required properties:
@@ -76,3 +118,5 @@ Example:
 The node above defines a typical PM domain consumer device, which is located
 inside a PM domain with index 0 of a power controller represented by a node
 with the label "power".
+
+[1]. Documentation/devicetree/bindings/arm/idle-states.txt
-- 
2.7.4
