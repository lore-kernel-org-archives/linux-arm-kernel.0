From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Nov 2013 18:35:36 -0800
Subject: [PATCH 7/8] ARM: OMAP2+: Fix GPMC and simplify bootloader timings for
 8250 and smc91x
In-Reply-To: <1384396537-3486-1-git-send-email-tony@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
Message-ID: <1384396537-3486-8-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f2bf0e72d000 (ARM: OMAP2+: Add minimal 8250 support
for GPMC) added support for using bootloader timings for some
devices. Turns out we can do the same by looking at the compatible
flags of the child without adding a new function as smc91x has
a similar issue as 8250 with the bootloader timings.

And let's fix the 8250 naming, we should use the device type as
the name like uart instead of 8250 for zoom dts file.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap-zoom-common.dtsi |  2 +-
 arch/arm/mach-omap2/gpmc.c              | 58 +++++++++++----------------------
 2 files changed, 20 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/omap-zoom-common.dtsi b/arch/arm/boot/dts/omap-zoom-common.dtsi
index b0ee342..68221fa 100644
--- a/arch/arm/boot/dts/omap-zoom-common.dtsi
+++ b/arch/arm/boot/dts/omap-zoom-common.dtsi
@@ -13,7 +13,7 @@
 	 * they probably share the same GPIO IRQ
 	 * REVISIT: Add timing support from slls644g.pdf
 	 */
-	8250 at 3,0 {
+	uart at 3,0 {
 		compatible = "ns16550a";
 		reg = <3 0 0x100>;
 		bank-width = <2>;
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 51525fa..e09e5ba 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1482,6 +1482,22 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	}
 
 	/*
+	 * For some GPMC devices we still need to rely on the bootloader
+	 * timings because the devices can be connected via FPGA. So far
+	 * the list is smc91x on the omap2 SDP boards, and 8250 on zooms.
+	 * REVISIT: Add timing support from slls644g.pdf and from the
+	 * lan91c96 manual.
+	 */
+	if (of_device_is_compatible(child, "ns16550a") ||
+	    of_device_is_compatible(child, "smsc,lan91c94") ||
+	    of_device_is_compatible(child, "smsc,lan91c111")) {
+		dev_warn(&pdev->dev,
+			 "%s using bootloader timings on CS%d\n",
+			 child->name, cs);
+		goto no_timings;
+	}
+
+	/*
 	 * FIXME: gpmc_cs_request() will map the CS to an arbitary
 	 * location in the gpmc address space. When booting with
 	 * device-tree we want the NOR flash to be mapped to the
@@ -1509,6 +1525,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	gpmc_read_timings_dt(child, &gpmc_t);
 	gpmc_cs_set_timings(cs, &gpmc_t);
 
+no_timings:
 	if (of_platform_device_create(child, NULL, &pdev->dev))
 		return 0;
 
@@ -1521,42 +1538,6 @@ err:
 	return ret;
 }
 
-/*
- * REVISIT: Add timing support from slls644g.pdf
- */
-static int gpmc_probe_8250(struct platform_device *pdev,
-				struct device_node *child)
-{
-	struct resource res;
-	unsigned long base;
-	int ret, cs;
-
-	if (of_property_read_u32(child, "reg", &cs) < 0) {
-		dev_err(&pdev->dev, "%s has no 'reg' property\n",
-			child->full_name);
-		return -ENODEV;
-	}
-
-	if (of_address_to_resource(child, 0, &res) < 0) {
-		dev_err(&pdev->dev, "%s has malformed 'reg' property\n",
-			child->full_name);
-		return -ENODEV;
-	}
-
-	ret = gpmc_cs_request(cs, resource_size(&res), &base);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot request GPMC CS %d\n", cs);
-		return ret;
-	}
-
-	if (of_platform_device_create(child, NULL, &pdev->dev))
-		return 0;
-
-	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
-
-	return -ENODEV;
-}
-
 static int gpmc_probe_dt(struct platform_device *pdev)
 {
 	int ret;
@@ -1598,10 +1579,9 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 		else if (of_node_cmp(child->name, "onenand") == 0)
 			ret = gpmc_probe_onenand_child(pdev, child);
 		else if (of_node_cmp(child->name, "ethernet") == 0 ||
-			 of_node_cmp(child->name, "nor") == 0)
+			 of_node_cmp(child->name, "nor") == 0 ||
+			 of_node_cmp(child->name, "uart") == 0)
 			ret = gpmc_probe_generic_child(pdev, child);
-		else if (of_node_cmp(child->name, "8250") == 0)
-			ret = gpmc_probe_8250(pdev, child);
 
 		if (WARN(ret < 0, "%s: probing gpmc child %s failed\n",
 			 __func__, child->full_name))
-- 
1.8.1.1
