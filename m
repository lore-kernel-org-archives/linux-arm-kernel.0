From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Mon,  1 Oct 2018 13:27:47 -0700
Subject: [PATCH i2c-next v4 2/3] i2c: aspeed: Add 'timeout' DT property
 reading code
In-Reply-To: <20181001202748.8030-1-jae.hyun.yoo@linux.intel.com>
References: <20181001202748.8030-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20181001202748.8030-3-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds reading code of the 'timeout' DT property to set
bus timeout value in adapter configuration. This value still
can be configured through an I2C_TIMEOUT ioctl on cdev too.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 8dc9161ced38..6d31f54a6653 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -885,6 +885,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	struct clk *parent_clk;
 	struct resource *res;
 	int irq, ret;
+	u32 timeout_ms;
 
 	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
 	if (!bus)
@@ -918,6 +919,11 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 		bus->bus_frequency = 100000;
 	}
 
+	ret = of_property_read_u32(pdev->dev.of_node, "timeout",
+				   &timeout_ms);
+	if (ret)
+		timeout_ms = 0; /* then adap.timeout will be set by i2c-core */
+
 	match = of_match_node(aspeed_i2c_bus_of_table, pdev->dev.of_node);
 	if (!match)
 		bus->get_clk_reg_val = aspeed_i2c_24xx_get_clk_reg_val;
@@ -930,7 +936,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	init_completion(&bus->cmd_complete);
 	bus->adap.owner = THIS_MODULE;
 	bus->adap.retries = 0;
-	bus->adap.timeout = 5 * HZ;
+	bus->adap.timeout = timeout_ms ? msecs_to_jiffies(timeout_ms) : 0;
 	bus->adap.algo = &aspeed_i2c_algo;
 	bus->adap.dev.parent = &pdev->dev;
 	bus->adap.dev.of_node = pdev->dev.of_node;
-- 
2.19.0
