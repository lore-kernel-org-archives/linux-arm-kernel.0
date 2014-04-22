From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:26:11 +0200
Subject: [PATCH v2 07/38] memory: mvebu-devbus: split functions
In-Reply-To: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1398202002-28530-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu-devbus driver currently only supports the Armada 370/XP
family, but it can also cover the Orion5x family. However, the Orion5x
family has a different organization of the registers.

Therefore, in preparation to the introduction of Orion5x support, we
separate into two functions the code that 1/ retrieves the timing
parameters from the Device Tree and 2/ applies those timings
parameters into the hardware registers.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/memory/mvebu-devbus.c | 90 ++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
index 0f196b3..5dc9c63 100644
--- a/drivers/memory/mvebu-devbus.c
+++ b/drivers/memory/mvebu-devbus.c
@@ -89,19 +89,15 @@ static int get_timing_param_ps(struct devbus *devbus,
 	return 0;
 }
 
-static int devbus_set_timing_params(struct devbus *devbus,
-				    struct device_node *node)
+static int devbus_get_timing_params(struct devbus *devbus,
+				    struct device_node *node,
+				    struct devbus_read_params *r,
+				    struct devbus_write_params *w)
 {
-	struct devbus_read_params r;
-	struct devbus_write_params w;
-	u32 value;
 	int err;
 
-	dev_dbg(devbus->dev, "Setting timing parameter, tick is %lu ps\n",
-		devbus->tick_ps);
-
 	/* Get read timings */
-	err = of_property_read_u32(node, "devbus,bus-width", &r.bus_width);
+	err = of_property_read_u32(node, "devbus,bus-width", &r->bus_width);
 	if (err < 0) {
 		dev_err(devbus->dev,
 			"%s has no 'devbus,bus-width' property\n",
@@ -113,48 +109,48 @@ static int devbus_set_timing_params(struct devbus *devbus,
 	 * The bus width is encoded into the register as 0 for 8 bits,
 	 * and 1 for 16 bits, so we do the necessary conversion here.
 	 */
-	if (r.bus_width == 8)
-		r.bus_width = 0;
-	else if (r.bus_width == 16)
-		r.bus_width = 1;
+	if (r->bus_width == 8)
+		r->bus_width = 0;
+	else if (r->bus_width == 16)
+		r->bus_width = 1;
 	else {
-		dev_err(devbus->dev, "invalid bus width %d\n", r.bus_width);
+		dev_err(devbus->dev, "invalid bus width %d\n", r->bus_width);
 		return -EINVAL;
 	}
 
 	err = get_timing_param_ps(devbus, node, "devbus,badr-skew-ps",
-				 &r.badr_skew);
+				 &r->badr_skew);
 	if (err < 0)
 		return err;
 
 	err = get_timing_param_ps(devbus, node, "devbus,turn-off-ps",
-				 &r.turn_off);
+				 &r->turn_off);
 	if (err < 0)
 		return err;
 
 	err = get_timing_param_ps(devbus, node, "devbus,acc-first-ps",
-				 &r.acc_first);
+				 &r->acc_first);
 	if (err < 0)
 		return err;
 
 	err = get_timing_param_ps(devbus, node, "devbus,acc-next-ps",
-				 &r.acc_next);
+				 &r->acc_next);
 	if (err < 0)
 		return err;
 
 	err = get_timing_param_ps(devbus, node, "devbus,rd-setup-ps",
-				 &r.rd_setup);
+				 &r->rd_setup);
 	if (err < 0)
 		return err;
 
 	err = get_timing_param_ps(devbus, node, "devbus,rd-hold-ps",
-				 &r.rd_hold);
+				 &r->rd_hold);
 	if (err < 0)
 		return err;
 
 	/* Get write timings */
 	err = of_property_read_u32(node, "devbus,sync-enable",
-				  &w.sync_enable);
+				  &w->sync_enable);
 	if (err < 0) {
 		dev_err(devbus->dev,
 			"%s has no 'devbus,sync-enable' property\n",
@@ -163,28 +159,38 @@ static int devbus_set_timing_params(struct devbus *devbus,
 	}
 
 	err = get_timing_param_ps(devbus, node, "devbus,ale-wr-ps",
-				 &w.ale_wr);
+				 &w->ale_wr);
 	if (err < 0)
 		return err;
 
 	err = get_timing_param_ps(devbus, node, "devbus,wr-low-ps",
-				 &w.wr_low);
+				 &w->wr_low);
 	if (err < 0)
 		return err;
 
 	err = get_timing_param_ps(devbus, node, "devbus,wr-high-ps",
-				 &w.wr_high);
+				 &w->wr_high);
 	if (err < 0)
 		return err;
 
+	return 0;
+}
+
+static void devbus_armada_set_timing_params(struct devbus *devbus,
+					   struct device_node *node,
+					   struct devbus_read_params *r,
+					   struct devbus_write_params *w)
+{
+	u32 value;
+
 	/* Set read timings */
-	value = r.bus_width << ARMADA_DEV_WIDTH_SHIFT |
-		r.badr_skew << ARMADA_BADR_SKEW_SHIFT |
-		r.rd_hold   << ARMADA_RD_HOLD_SHIFT   |
-		r.acc_next  << ARMADA_ACC_NEXT_SHIFT  |
-		r.rd_setup  << ARMADA_RD_SETUP_SHIFT  |
-		r.acc_first << ARMADA_ACC_FIRST_SHIFT |
-		r.turn_off;
+	value = r->bus_width << ARMADA_DEV_WIDTH_SHIFT |
+		r->badr_skew << ARMADA_BADR_SKEW_SHIFT |
+		r->rd_hold   << ARMADA_RD_HOLD_SHIFT   |
+		r->acc_next  << ARMADA_ACC_NEXT_SHIFT  |
+		r->rd_setup  << ARMADA_RD_SETUP_SHIFT  |
+		r->acc_first << ARMADA_ACC_FIRST_SHIFT |
+		r->turn_off;
 
 	dev_dbg(devbus->dev, "read parameters register 0x%p = 0x%x\n",
 		devbus->base + ARMADA_READ_PARAM_OFFSET,
@@ -193,24 +199,24 @@ static int devbus_set_timing_params(struct devbus *devbus,
 	writel(value, devbus->base + ARMADA_READ_PARAM_OFFSET);
 
 	/* Set write timings */
-	value = w.sync_enable  << ARMADA_SYNC_ENABLE_SHIFT |
-		w.wr_low       << ARMADA_WR_LOW_SHIFT      |
-		w.wr_high      << ARMADA_WR_HIGH_SHIFT     |
-		w.ale_wr;
+	value = w->sync_enable  << ARMADA_SYNC_ENABLE_SHIFT |
+		w->wr_low       << ARMADA_WR_LOW_SHIFT      |
+		w->wr_high      << ARMADA_WR_HIGH_SHIFT     |
+		w->ale_wr;
 
 	dev_dbg(devbus->dev, "write parameters register: 0x%p = 0x%x\n",
 		devbus->base + ARMADA_WRITE_PARAM_OFFSET,
 		value);
 
 	writel(value, devbus->base + ARMADA_WRITE_PARAM_OFFSET);
-
-	return 0;
 }
 
 static int mvebu_devbus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
+	struct devbus_read_params r;
+	struct devbus_write_params w;
 	struct devbus *devbus;
 	struct resource *res;
 	struct clk *clk;
@@ -240,11 +246,17 @@ static int mvebu_devbus_probe(struct platform_device *pdev)
 	rate = clk_get_rate(clk) / 1000;
 	devbus->tick_ps = 1000000000 / rate;
 
-	/* Read the device tree node and set the new timing parameters */
-	err = devbus_set_timing_params(devbus, node);
+	dev_dbg(devbus->dev, "Setting timing parameter, tick is %lu ps\n",
+		devbus->tick_ps);
+
+	/* Read the Device Tree node */
+	err = devbus_get_timing_params(devbus, node, &r, &w);
 	if (err < 0)
 		return err;
 
+	/* Set the new timing parameters */
+	devbus_armada_set_timing_params(devbus, node, &r, &w);
+
 	/*
 	 * We need to create a child device explicitly from here to
 	 * guarantee that the child will be probed after the timing
-- 
1.9.2
