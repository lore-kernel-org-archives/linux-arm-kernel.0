From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Thu, 01 Mar 2012 16:14:39 +0100
Subject: [PATCH] ARM: at91: Add support for configurable main clock frequency.
Message-ID: <4F4F925F.2020405@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides main clock frequency configuration from device tree
definition.

If the "main-clock" attribute of pmc node is not specified it takes
12MHz as default value.

With this patch we can add board support using a different main clock
frequency (our custom board is using a 18,432MHz main clock).

---
 arch/arm/boot/dts/at91sam9g20.dtsi |    5 +++++
 arch/arm/mach-at91/board-dt.c      |   21 ++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi
b/arch/arm/boot/dts/at91sam9g20.dtsi
index 07603b8..da253b2 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -46,6 +46,11 @@
 			#size-cells = <1>;
 			ranges;

+			pmc {
+				compatible = "atmel,at91-pmc";
+				reg = <0xfffffc00 0x100>;
+			};
+
 			aic: interrupt-controller at fffff000 {
 				#interrupt-cells = <1>;
 				compatible = "atmel,at91rm9200-aic";
diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index bb6b434..c64a3b0 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -33,11 +33,30 @@
 #include "sam9_smc.h"
 #include "generic.h"

+static const struct of_device_id pmc_of_match[] __initconst = {
+	{ .compatible = "atmel,at91-pmc" },
+	{},
+};

 static void __init ek_init_early(void)
 {
+	struct device_node *node;
+	unsigned long main_clock = 12000000;
+
+	node = of_find_matching_node(NULL, pmc_of_match);
+
+	if (node) {
+		const __be32 *ip;
+		ip = of_get_property(node, "main-clock", NULL);
+		if (ip) {
+			main_clock = be32_to_cpup(ip);
+		}
+		of_node_put(node);
+	}
+
+
 	/* Initialize processor: 12.000 MHz crystal */
-	at91_initialize(12000000);
+	at91_initialize(main_clock);

 	/* DGBU on ttyS0. (Rx & Tx only) */
 	at91_register_uart(0, 0, 0);
-- 
1.7.0.4
