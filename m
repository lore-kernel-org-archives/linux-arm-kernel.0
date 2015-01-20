From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 20 Jan 2015 13:16:51 +0100
Subject: [PATCH v4 1/9] PM / Domains: Add a note about power domain subdomains
In-Reply-To: <1421756219-21037-1-git-send-email-m.szyprowski@samsung.com>
References: <1421756219-21037-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1421756219-21037-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a note on defining subdomains to generic PM domain
binding documentation to let power domain providers use common approach
for defining power domain hierarchy.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .../devicetree/bindings/power/power_domain.txt     | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 98c16672ab5f..0f8ed3710c66 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -19,6 +19,16 @@ Required properties:
    providing multiple PM domains (e.g. power controllers), but can be any value
    as specified by device tree binding documentation of particular provider.
 
+Optional properties:
+ - power-domains : A phandle and PM domain specifier as defined by bindings of
+                   the power controller specified by phandle.
+   Some power domains might be powered from another power domain (or have
+   other hardware specific dependencies). For representing such dependency
+   a standard PM domain consumer binding is used. When provided, all domains
+   created by the given provider should be subdomains of the domain
+   specified by this binding. More details about power domain specifier are
+   available in the next section.
+
 Example:
 
 	power: power-controller at 12340000 {
@@ -30,6 +40,25 @@ Example:
 The node above defines a power controller that is a PM domain provider and
 expects one cell as its phandle argument.
 
+Example 2:
+
+	parent: power-controller at 12340000 {
+		compatible = "foo,power-controller";
+		reg = <0x12340000 0x1000>;
+		#power-domain-cells = <1>;
+	};
+
+	child: power-controller at 12340000 {
+		compatible = "foo,power-controller";
+		reg = <0x12341000 0x1000>;
+		power-domains = <&parent 0>;
+		#power-domain-cells = <1>;
+	};
+
+The nodes above define two power controllers: 'parent' and 'child'.
+Domains created by the 'child' power controller are subdomains of '0' power
+domain provided by the 'parent' power controller.
+
 ==PM domain consumers==
 
 Required properties:
-- 
1.9.2
