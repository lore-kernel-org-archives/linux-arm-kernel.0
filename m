From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 22 Jun 2016 13:36:37 -0600
Subject: [PATCH 02/14] dt/bindings: update binding for PM domain idle states
In-Reply-To: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1466624209-27432-3-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Update DT bindings to describe idle states of PM domains.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
[Lina: Added state properties, removed state names, wakeup-latency,
added of_pm_genpd_init() API, pruned commit text]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[Ulf: Moved around code to make it compile properly, rebased on top of multiple state support]
---
 .../devicetree/bindings/power/power_domain.txt     | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 025b5e7..41e8dda 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -29,6 +29,43 @@ Optional properties:
    specified by this binding. More details about power domain specifier are
    available in the next section.
 
+- power-states : A phandle of an idle-state that shall be soaked into a
+                generic domain power state.
+
+==Power state==
+
+A PM domain power state describes an idle state of a domain and must be
+have the following properties -
+
+	- entry-latency-us
+		Usage: Not required if wakeup-latency-us is provided.
+		Value type: <prop-encoded-array>
+		Definition: u32 value representing worst case latency in
+		microseconds required to enter the idle state.
+		The exit-latency-us duration may be guaranteed
+		only after entry-latency-us has passed.
+
+	- exit-latency-us
+		Usage: Not required if wakeup-latency-us is provided.
+		Value type: <prop-encoded-array>
+		Definition: u32 value representing worst case latency
+		in microseconds required to exit the idle state.
+
+	- residency-us:
+		Usage: Optional
+		Value type: <prop-encoded-array>
+		Definition: A u32 value representing the time for which a
+		domain must be idle in the state to reap power saving benefits
+		of entering the state.
+
+	- state-param:
+		Usage: Optional
+		Value type: <prop-encoded-array>
+		Definition: A u32 value as defined by the state. May be used
+		by the driver to hold state related u32 data. In the case of
+		PSCI, an extended state-id for the domain may be encoded in
+		this value.
+
 Example:
 
 	power: power-controller at 12340000 {
@@ -55,6 +92,39 @@ Example 2:
 		#power-domain-cells = <1>;
 	};
 
+Example 3:
+
+	pm-domains {
+		a57_pd: a57_pd@ {
+			/* will have a57 platform ARM_PD_METHOD_OF_DECLARE*/
+			compatible = "arm,pd","arm,cortex-a57";
+			#power-domain-cells = <0>;
+			power-states = <&CLUSTER_SLEEP_0>;
+		};
+
+		a53_pd: a53_pd@ {
+			/* will have a a53 platform ARM_PD_METHOD_OF_DECLARE*/
+			compatible = "arm,pd","arm,cortex-a53";
+			#power-domain-cells = <0>;
+			power-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
+		};
+
+		CLUSTER_SLEEP_0: power-state at 0 {
+			entry-latency-us = <1000>;
+			exit-latency-us = <2000>;
+			residency-us = <10000>;
+			state-param = <0x1000010>;
+		};
+
+		CLUSTER_SLEEP_1: power-state at 1 {
+			entry-latency-us = <5000>;
+			exit-latency-us = <5000>;
+			residency-us = <100000>;
+			state-param = <0x1000020>;
+		};
+	};
+
+
 The nodes above define two power controllers: 'parent' and 'child'.
 Domains created by the 'child' power controller are subdomains of '0' power
 domain provided by the 'parent' power controller.
-- 
2.7.4
