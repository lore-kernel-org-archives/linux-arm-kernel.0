From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Nov 2018 14:02:37 -0800
Subject: [PATCH 2/2] bus: ti-sysc: Add mcasp optional clocks flag
In-Reply-To: <20181115220237.32129-1-tony@atomide.com>
References: <20181115220237.32129-1-tony@atomide.com>
Message-ID: <20181115220237.32129-3-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have OPT_CLKS_NEEDED in legacy platform data, but it's missing
from the ti-sysc driver for device tree based configuration.

In order to pass OPT_CLKS_NEEDED quirk flag we need to update omap4 module
data and add a new compatible for dra7 as the module layout is different
from sysc_regbits_omap4_mcasp.

Fixes: 70a65240efb1 ("bus: ti-sysc: Add register bits for interconnect
target modules")
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/bus/ti-sysc.txt |  1 +
 drivers/bus/ti-sysc.c                             | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
--- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -35,6 +35,7 @@ Required standard properties:
 		"ti,sysc-omap3-sham"
 		"ti,sysc-omap-aes"
 		"ti,sysc-mcasp"
+		"ti,sysc-dra7-mcasp"
 		"ti,sysc-usb-host-fs"
 		"ti,sysc-dra7-mcan"
 
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1503,6 +1503,16 @@ static const struct sysc_regbits sysc_regbits_omap4_mcasp = {
 static const struct sysc_capabilities sysc_omap4_mcasp = {
 	.type = TI_SYSC_OMAP4_MCASP,
 	.regbits = &sysc_regbits_omap4_mcasp,
+	.mod_quirks = SYSC_QUIRK_OPT_CLKS_NEEDED,
+};
+
+/*
+ * McASP found on dra7 and later
+ */
+static const struct sysc_capabilities sysc_dra7_mcasp = {
+	.type = TI_SYSC_OMAP4_SIMPLE,
+	.regbits = &sysc_regbits_omap4_simple,
+	.mod_quirks = SYSC_QUIRK_OPT_CLKS_NEEDED,
 };
 
 /*
@@ -1731,6 +1741,7 @@ static const struct of_device_id sysc_match[] = {
 	{ .compatible = "ti,sysc-omap3-sham", .data = &sysc_omap3_sham, },
 	{ .compatible = "ti,sysc-omap-aes", .data = &sysc_omap3_aes, },
 	{ .compatible = "ti,sysc-mcasp", .data = &sysc_omap4_mcasp, },
+	{ .compatible = "ti,sysc-dra7-mcasp", .data = &sysc_dra7_mcasp, },
 	{ .compatible = "ti,sysc-usb-host-fs",
 	  .data = &sysc_omap4_usb_host_fs, },
 	{ .compatible = "ti,sysc-dra7-mcan", .data = &sysc_dra7_mcan, },
-- 
2.19.1
