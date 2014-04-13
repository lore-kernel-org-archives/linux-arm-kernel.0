From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 16:39:44 +0200
Subject: [PATCH 07/29] memory: mvebu-devbus: add Orion5x support
In-Reply-To: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397400006-4315-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds support for the Orion5x family of Marvell processors
into the mvebu-devbus driver. It differs from the already supported
Armada 370/XP by:

 * Having a single register (instead of two) for doing all the timing
   configuration.

 * Having a few less timing configuration parameters.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/memory-controllers/mvebu-devbus.txt   | 25 ++++--
 drivers/memory/mvebu-devbus.c                      | 95 +++++++++++++++++-----
 2 files changed, 94 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt b/Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
index 653c90c..aff8e9e 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
@@ -6,10 +6,11 @@ The actual devices are instantiated from the child nodes of a Device Bus node.
 
 Required properties:
 
- - compatible:          Currently only Armada 370/XP SoC are supported,
-                        with this compatible string:
+ - compatible:          Armada 370/XP SoC are supported using the
+                        "marvell,mvebu-devbus" compatible string.
 
-                        marvell,mvebu-devbus
+                        Orion5x SoC are supported using the
+                        "marvell,orion-devbus" compatible string.
 
  - reg:                 A resource specifier for the register space.
                         This is the base address of a chip select within
@@ -22,7 +23,7 @@ Required properties:
                         integer values for each chip-select line in use:
                         0 <physical address of mapping> <size>
 
-Mandatory timing properties for child nodes:
+Timing properties for child nodes:
 
 Read parameters:
 
@@ -30,21 +31,26 @@ Read parameters:
                         drive the AD bus after the completion of a device read.
                         This prevents contentions on the Device Bus after a read
                         cycle from a slow device.
+			Mandatory.
 
- - devbus,bus-width:    Defines the bus width (e.g. <16>)
+ - devbus,bus-width:    Defines the bus width, in bits (e.g. <16>).
+   			Mandatory.
 
  - devbus,badr-skew-ps: Defines the time delay from from A[2:0] toggle,
                         to read data sample. This parameter is useful for
                         synchronous pipelined devices, where the address
                         precedes the read data by one or two cycles.
+			Mandatory.
 
  - devbus,acc-first-ps: Defines the time delay from the negation of
                         ALE[0] to the cycle that the first read data is sampled
                         by the controller.
+			Mandatory.
 
  - devbus,acc-next-ps:  Defines the time delay between the cycle that
                         samples data N and the cycle that samples data N+1
                         (in burst accesses).
+			Mandaory.
 
  - devbus,rd-setup-ps:  Defines the time delay between DEV_CSn assertion to
 			DEV_OEn assertion. If set to 0 (default),
@@ -52,6 +58,8 @@ Read parameters:
                         This parameter has no affect on <acc-first-ps> parameter
                         (no affect on first data sample). Set <rd-setup-ps>
                         to a value smaller than <acc-first-ps>.
+			Mandatory with "mvebu-devbus" compatible string.
+			Ignored otherwise.
 
  - devbus,rd-hold-ps:   Defines the time between the last data sample to the
 			de-assertion of DEV_CSn. If set to 0 (default),
@@ -62,16 +70,20 @@ Read parameters:
                         last data sampled. Also this parameter has no
                         affect on <turn-off-ps> parameter.
                         Set <rd-hold-ps> to a value smaller than <turn-off-ps>.
+			Mandatory with "mvebu-devbus" compatible string.
+			Ignored otherwise.
 
 Write parameters:
 
  - devbus,ale-wr-ps:    Defines the time delay from the ALE[0] negation cycle
 			to the DEV_WEn assertion.
+			Mandatory.
 
  - devbus,wr-low-ps:    Defines the time during which DEV_WEn is active.
                         A[2:0] and Data are kept valid as long as DEV_WEn
                         is active. This parameter defines the setup time of
                         address and data to DEV_WEn rise.
+			Mandatory.
 
  - devbus,wr-high-ps:   Defines the time during which DEV_WEn is kept
                         inactive (high) between data beats of a burst write.
@@ -79,10 +91,13 @@ Write parameters:
                         <wr-high-ps> - <tick> ps.
 			This parameter defines the hold time of address and
 			data after DEV_WEn rise.
+			Mandatory.
 
  - devbus,sync-enable: Synchronous device enable.
                        1: True
                        0: False
+		       Mandatory with "mvebu-devbus" compatible string.
+		       Ignored otherwise.
 
 An example for an Armada XP GP board, with a 16 MiB NOR device as child
 is showed below. Note that the Device Bus driver is in charge of allocating
diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
index 8df5b2b..59d8151 100644
--- a/drivers/memory/mvebu-devbus.c
+++ b/drivers/memory/mvebu-devbus.c
@@ -2,7 +2,7 @@
  * Marvell EBU SoC Device Bus Controller
  * (memory controller for NOR/NAND/SRAM/FPGA devices)
  *
- * Copyright (C) 2013 Marvell
+ * Copyright (C) 2013-2014 Marvell
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -44,6 +44,22 @@
 #define ARMADA_READ_PARAM_OFFSET	0x0
 #define ARMADA_WRITE_PARAM_OFFSET	0x4
 
+#define ORION_RESERVED			(0x2 << 30)
+#define ORION_BADR_SKEW_BIT		28
+#define ORION_WR_HIGH_EXT_BIT		27
+#define ORION_WR_LOW_EXT_BIT		26
+#define ORION_ALE_WR_EXT_BIT		25
+#define ORION_ACC_NEXT_EXT_BIT		24
+#define ORION_ACC_FIRST_EXT_BIT		23
+#define ORION_TURN_OFF_EXT_BIT		22
+#define ORION_DEV_WIDTH_BIT		20
+#define ORION_WR_HIGH_BIT		17
+#define ORION_WR_LOW_BIT		14
+#define ORION_ALE_WR_BIT		11
+#define ORION_ACC_NEXT_BIT		7
+#define ORION_ACC_FIRST_BIT		3
+#define ORION_TURN_OFF_BIT		0
+
 struct devbus_read_params {
 	u32 bus_width;
 	u32 badr_skew;
@@ -96,7 +112,6 @@ static int devbus_get_timing_params(struct devbus *devbus,
 {
 	int err;
 
-	/* Get read timings */
 	err = of_property_read_u32(node, "devbus,bus-width", &r->bus_width);
 	if (err < 0) {
 		dev_err(devbus->dev,
@@ -131,24 +146,25 @@ static int devbus_get_timing_params(struct devbus *devbus,
 	if (err < 0)
 		return err;
 
-	err = get_timing_param_ps(devbus, node, "devbus,rd-setup-ps",
-				 &r->rd_setup);
-	if (err < 0)
-		return err;
-
-	err = get_timing_param_ps(devbus, node, "devbus,rd-hold-ps",
-				 &r->rd_hold);
-	if (err < 0)
-		return err;
-
-	/* Get write timings */
-	err = of_property_read_u32(node, "devbus,sync-enable",
-				  &w->sync_enable);
-	if (err < 0) {
-		dev_err(devbus->dev,
-			"%s has no 'devbus,sync-enable' property\n",
-			node->full_name);
-		return err;
+	if (of_device_is_compatible(devbus->dev->of_node, "marvell,mvebu-devbus")) {
+		err = get_timing_param_ps(devbus, node, "devbus,rd-setup-ps",
+					  &r->rd_setup);
+		if (err < 0)
+			return err;
+
+		err = get_timing_param_ps(devbus, node, "devbus,rd-hold-ps",
+					  &r->rd_hold);
+		if (err < 0)
+			return err;
+
+		err = of_property_read_u32(node, "devbus,sync-enable",
+					   &w->sync_enable);
+		if (err < 0) {
+			dev_err(devbus->dev,
+				"%s has no 'devbus,sync-enable' property\n",
+				node->full_name);
+			return err;
+		}
 	}
 
 	err = get_timing_param_ps(devbus, node, "devbus,ale-wr-ps",
@@ -169,6 +185,39 @@ static int devbus_get_timing_params(struct devbus *devbus,
 	return 0;
 }
 
+static void devbus_orion_set_timing_params(struct devbus *devbus,
+					  struct device_node *node,
+					  struct devbus_read_params *r,
+					  struct devbus_write_params *w)
+{
+	u32 value;
+
+	/*
+	 * The hardware designers found it would be a good idea to
+	 * split most of the values in the register into two fields:
+	 * one containing all the low-order bits, and another one
+	 * containing just the high-order bit. For all of those
+	 * fields, we have to split the value into these two parts.
+	 */
+	value = (r->turn_off   & 0x7) << ORION_TURN_OFF_BIT  |
+		(r->acc_first  & 0xF) << ORION_ACC_FIRST_BIT |
+		(r->acc_next   & 0xF) << ORION_ACC_NEXT_BIT  |
+		(w->ale_wr     & 0x7) << ORION_ALE_WR_BIT    |
+		(w->wr_low     & 0x7) << ORION_WR_LOW_BIT    |
+		(w->wr_high    & 0x7) << ORION_WR_HIGH_BIT   |
+		r->bus_width          << ORION_DEV_WIDTH_BIT |
+		((r->turn_off  & 0x8)  ? BIT(ORION_TURN_OFF_EXT_BIT)  : 0) |
+		((r->acc_first & 0x10) ? BIT(ORION_ACC_FIRST_EXT_BIT) : 0) |
+		((r->acc_next  & 0x10) ? BIT(ORION_ACC_NEXT_EXT_BIT)  : 0) |
+		((w->ale_wr    & 0x8)  ? BIT(ORION_ALE_WR_EXT_BIT)    : 0) |
+		((w->wr_low    & 0x8)  ? BIT(ORION_WR_LOW_EXT_BIT)    : 0) |
+		((w->wr_high   & 0x8)  ? BIT(ORION_WR_HIGH_EXT_BIT)   : 0) |
+		(r->badr_skew << ORION_BADR_SKEW_BIT) |
+		ORION_RESERVED;
+
+	writel(value, devbus->base);
+}
+
 static void devbus_armada_set_timing_params(struct devbus *devbus,
 					   struct device_node *node,
 					   struct devbus_read_params *r,
@@ -248,7 +297,10 @@ static int mvebu_devbus_probe(struct platform_device *pdev)
 		return err;
 
 	/* Set the new timing parameters */
-	devbus_armada_set_timing_params(devbus, node, &r, &w);
+	if (of_device_is_compatible(node, "marvell,orion-devbus"))
+		devbus_orion_set_timing_params(devbus, node, &r, &w);
+	else
+		devbus_armada_set_timing_params(devbus, node, &r, &w);
 
 	/*
 	 * We need to create a child device explicitly from here to
@@ -264,6 +316,7 @@ static int mvebu_devbus_probe(struct platform_device *pdev)
 
 static const struct of_device_id mvebu_devbus_of_match[] = {
 	{ .compatible = "marvell,mvebu-devbus" },
+	{ .compatible = "marvell,orion-devbus" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mvebu_devbus_of_match);
-- 
1.8.3.2
