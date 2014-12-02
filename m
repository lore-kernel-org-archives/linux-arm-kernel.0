From: harinik@xilinx.com (Harini Katakam)
Date: Tue,  2 Dec 2014 15:35:47 +0530
Subject: [PATCH 2/4] i2c: cadence: Set the hardware time-out register to
 maximum value
In-Reply-To: <1417514749-24319-1-git-send-email-harinik@xilinx.com>
References: <1417514749-24319-1-git-send-email-harinik@xilinx.com>
Message-ID: <1417514749-24319-3-git-send-email-harinik@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vishnu Motghare <vishnum@xilinx.com>

Cadence I2C controller has bug wherein it generates invalid read transactions
after time-out in master receiver mode. This driver does not use the HW
timeout and this interrupt is disabled but the feature itself cannot be
disabled. Hence, this patch writes the maximum value (0xFF) to this register.
This is one of the workarounds to this bug and it will not avoid the issue
completely but reduce the chances of error.

Signed-off-by: Vishnu Motghare <vishnum@xilinx.com>
Signed-off-by: Harini Katakam <harinik@xilinx.com>
---
 drivers/i2c/busses/i2c-cadence.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index e54899e..8065205 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -111,6 +111,8 @@
 #define CDNS_I2C_DIVA_MAX	4
 #define CDNS_I2C_DIVB_MAX	64
 
+#define CDNS_I2C_TIMEOUT_MAX	0xFF
+
 #define cdns_i2c_readreg(offset)       readl_relaxed(id->membase + offset)
 #define cdns_i2c_writereg(val, offset) writel_relaxed(val, id->membase + offset)
 
@@ -858,6 +860,8 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 		goto err_clk_dis;
 	}
 
+	cdns_i2c_writereg(CDNS_I2C_TIMEOUT_MAX, CDNS_I2C_TIME_OUT_OFFSET);
+
 	dev_info(&pdev->dev, "%u kHz mmio %08lx irq %d\n",
 		 id->i2c_clk / 1000, (unsigned long)r_mem->start, id->irq);
 
-- 
1.7.9.5
