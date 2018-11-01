From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu,  1 Nov 2018 10:46:21 -0700
Subject: [PATCH] i2c: aspeed: Fix an incorrect error log printing
Message-ID: <20181101174621.8266-1-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usually a SLAVE_MATCH and an RX_DONE intterupts come together at
the same time in most cases but rarely these come separately like
SLAVE_MATCH first and then RX_DONE right after that.

Current slave irq handler prints out an error message if the
latter case happens but this is not an actual error, so this commit
fixes the incorrect error log printing and makes the handler
initialize slave state if an incorrect state actually happens.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 8dc9161ced38..e9312d90ff7d 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -311,9 +311,13 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 	case ASPEED_I2C_SLAVE_STOP:
 		i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
 		break;
+	case ASPEED_I2C_SLAVE_START:
+		/* Slave was just started. Waiting for the next irq. */;
+		break;
 	default:
-		dev_err(bus->dev, "unhandled slave_state: %d\n",
+		dev_err(bus->dev, "unknown slave_state: %d\n",
 			bus->slave_state);
+		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
 		break;
 	}
 
-- 
2.19.1
