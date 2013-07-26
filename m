From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Fri, 26 Jul 2013 21:22:18 +0800
Subject: [PATCH v4 2/2] i2c: designware: add two optional property
 tx/rx-fifo-size
In-Reply-To: <1374844938-25505-1-git-send-email-zhangfei.gao@linaro.org>
References: <1374844938-25505-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1374844938-25505-3-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platform can not get fifo-size info form register DW_IC_COMP_PARAM_1.
Give chance to update rx-fifo-size and tx-fifo-size if provided in dts.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Acked-by: Baruch Siach <baruch@tkos.co.il>
---
 .../devicetree/bindings/i2c/i2c-designware.txt     |    7 +++++++
 drivers/i2c/busses/i2c-designware-platdrv.c        |    3 +++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index 7fd7fa2..af0bf8f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -6,6 +6,11 @@ Required properties :
  - reg : Offset and length of the register set for the device
  - interrupts : <IRQ> where IRQ is the interrupt number.
 
+Optional properties:
+
+ - rx-fifo-size : 1 cell, Rx fifo size
+ - tx-fifo-size : 1 cell, Tx fifo size
+
 Recommended properties :
 
  - clock-frequency : desired I2C bus clock frequency in Hz.
@@ -22,6 +27,8 @@ Example :
 		compatible = "snps,designware-i2c";
 		reg = <0xf0000 0x1000>;
 		interrupts = <11>;
+		rx-fifo-size = <16>;
+		tx-fifo-size = <16>;
 		clock-frequency = <400000>;
 	};
 
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 36ceebc..f657e65 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -86,6 +86,7 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
 	struct resource *mem;
+	struct device_node *np = pdev->dev.of_node;
 	int irq, r;
 
 	irq = platform_get_irq(pdev, 0);
@@ -145,6 +146,8 @@ static int dw_i2c_probe(struct platform_device *pdev)
 		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
 		dev->adapter.nr = pdev->id;
 	}
+	of_property_read_u32(np, "rx-fifo-size", &dev->rx_fifo_depth);
+	of_property_read_u32(np, "tx-fifo-size", &dev->tx_fifo_depth);
 	r = i2c_dw_init(dev);
 	if (r)
 		return r;
-- 
1.7.9.5
