From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 18 May 2018 12:31:26 +0200
Subject: [PATCH 5/9] PM / Domains: dt: Allow power-domain property to be a
 list of phandles
In-Reply-To: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1526639490-12167-6-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to describe topologies where devices are partitioned across
multiple power domains, let's extend the power-domain property to allow
being a list of phandles.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree at vger.kernel.org
Suggested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .../devicetree/bindings/power/power_domain.txt         | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 4733f76..b27ae7f 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -111,8 +111,9 @@ Example 3:
 ==PM domain consumers==
 
 Required properties:
- - power-domains : A phandle and PM domain specifier as defined by bindings of
-                   the power controller specified by phandle.
+ - power-domains : A phandle and PM domain specifier, or a list of phandles, as
+		   defined by bindings of the power controller specified by
+		   phandle.
 
 Example:
 
@@ -122,9 +123,16 @@ Example:
 		power-domains = <&power 0>;
 	};
 
-The node above defines a typical PM domain consumer device, which is located
-inside a PM domain with index 0 of a power controller represented by a node
-with the label "power".
+	leaky-device at 12350000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12350000 0x1000>;
+		power-domains = <&power0 0>, <&power1 0> ;
+	};
+
+The first example above defines a typical PM domain consumer device, which is
+located inside a PM domain with index 0 of a power controller represented by a
+node with the label "power". In the second example the consumer device are
+partitioned across two PM domains.
 
 Optional properties:
 - required-opps: This contains phandle to an OPP node in another device's OPP
-- 
2.7.4
