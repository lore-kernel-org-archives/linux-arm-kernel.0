From: danindrey@mail.ru (Andrey Danin)
Date: Mon, 20 Jul 2015 23:35:44 +0300
Subject: [PATCH v3 2/4] staging/nvec: reimplement on top of tegra i2c driver
In-Reply-To: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
Message-ID: <1437424546-30405-3-git-send-email-danindrey@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove i2c controller related code and use tegra i2c driver in slave mode.
Update nvec documentation.

Signed-off-by: Andrey Danin <danindrey@mail.ru>
---
Changes for v3:
- resolve conflict: 'nvec != NULL' changed to '!nvec'

Changes for v2:
- remove extra new line
- keep old functions to simplify review
- move nvec_state enum to nvec.c
- use nvec-slave instead of nvec in dts to keep ABI compatibility
- rebased on top of new i2c slave framework
- delay workaround moved to tegra-i2c
- documentation patch is integrated in this commit
- reverted a log message to minimize changes

Signed-off-by: Andrey Danin <danindrey@mail.ru>
---
 .../devicetree/bindings/nvec/nvidia,nvec.txt       |  21 +-
 drivers/staging/nvec/nvec.c                        | 258 +++++++++++++--------
 drivers/staging/nvec/nvec.h                        |  10 -
 3 files changed, 169 insertions(+), 120 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt b/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
index 5ae601e..aba34095 100644
--- a/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
+++ b/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
@@ -1,21 +1,6 @@
 NVIDIA compliant embedded controller
 
 Required properties:
-- compatible : should be "nvidia,nvec".
-- reg : the iomem of the i2c slave controller
-- interrupts : the interrupt line of the i2c slave controller
-- clock-frequency : the frequency of the i2c bus
-- gpios : the gpio used for ec request
-- slave-addr: the i2c address of the slave controller
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries:
-  Tegra20/Tegra30:
-  - div-clk
-  - fast-clk
-  Tegra114:
-  - div-clk
-- resets : Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names : Must include the following entries:
-  - i2c
+- compatible : should be "nvidia,nvec-slave".
+- reg: the i2c address of the slave controller
+- request-gpios : the gpio used for ec request
diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 164634d..7da3dfe 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -25,8 +25,8 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
+#include <linux/i2c.h>
 #include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/list.h>
@@ -39,25 +39,19 @@
 
 #include "nvec.h"
 
-#define I2C_CNFG			0x00
-#define I2C_CNFG_PACKET_MODE_EN		(1<<10)
-#define I2C_CNFG_NEW_MASTER_SFM		(1<<11)
-#define I2C_CNFG_DEBOUNCE_CNT_SHIFT	12
-
-#define I2C_SL_CNFG		0x20
-#define I2C_SL_NEWSL		(1<<2)
-#define I2C_SL_NACK		(1<<1)
-#define I2C_SL_RESP		(1<<0)
-#define I2C_SL_IRQ		(1<<3)
-#define END_TRANS		(1<<4)
-#define RCVD			(1<<2)
-#define RNW			(1<<1)
-
-#define I2C_SL_RCVD		0x24
-#define I2C_SL_STATUS		0x28
-#define I2C_SL_ADDR1		0x2c
-#define I2C_SL_ADDR2		0x30
-#define I2C_SL_DELAY_COUNT	0x3c
+
+#define I2C_SL_ST_END_TRANS			(1<<4)
+#define I2C_SL_ST_IRQ				(1<<3)
+#define I2C_SL_ST_RCVD				(1<<2)
+#define I2C_SL_ST_RNW				(1<<1)
+
+
+enum nvec_state {
+	ST_NONE,
+	ST_RX,
+	ST_TX,
+	ST_TRANS_START,
+};
 
 /**
  * enum nvec_msg_category - Message categories for nvec_msg_alloc()
@@ -479,7 +473,7 @@ static void nvec_tx_completed(struct nvec_chip *nvec)
 		nvec->tx->pos = 0;
 		nvec_gpio_set_value(nvec, 0);
 	} else {
-		nvec->state = 0;
+		nvec->state = ST_NONE;
 	}
 }
 
@@ -497,7 +491,7 @@ static void nvec_rx_completed(struct nvec_chip *nvec)
 			   (uint) nvec->rx->pos);
 
 		nvec_msg_free(nvec, nvec->rx);
-		nvec->state = 0;
+		nvec->state = ST_NONE;
 
 		/* Battery quirk - Often incomplete, and likes to crash */
 		if (nvec->rx->data[0] == NVEC_BAT)
@@ -514,7 +508,7 @@ static void nvec_rx_completed(struct nvec_chip *nvec)
 
 	spin_unlock(&nvec->rx_lock);
 
-	nvec->state = 0;
+	nvec->state = ST_NONE;
 
 	if (!nvec_msg_is_event(nvec->rx))
 		complete(&nvec->ec_transfer);
@@ -522,6 +516,7 @@ static void nvec_rx_completed(struct nvec_chip *nvec)
 	schedule_work(&nvec->rx_work);
 }
 
+#if 0
 /**
  * nvec_invalid_flags - Send an error message about invalid flags and jump
  * @nvec: The nvec device
@@ -536,6 +531,7 @@ static void nvec_invalid_flags(struct nvec_chip *nvec, unsigned int status,
 	if (reset)
 		nvec->state = 0;
 }
+#endif /* FIXME: remove old code */
 
 /**
  * nvec_tx_set - Set the message to transfer (nvec->tx)
@@ -566,6 +562,8 @@ static void nvec_tx_set(struct nvec_chip *nvec)
 		(uint)nvec->tx->size, nvec->tx->data[1]);
 }
 
+
+#if 0
 /**
  * nvec_interrupt - Interrupt handler
  * @irq: The IRQ
@@ -755,6 +753,115 @@ static void nvec_disable_i2c_slave(struct nvec_chip *nvec)
 	clk_disable_unprepare(nvec->i2c_clk);
 }
 #endif
+#endif /* FIXME: remove old code. */
+
+
+/**
+ * nvec_slave_cb - I2C slave callback
+ *
+ * This callback fills our RX buffers and empties our TX
+ * buffers. This uses a finite state machine.
+ */
+static int nvec_slave_cb(struct i2c_client *client,
+		enum i2c_slave_event event, u8 *val)
+{
+	struct nvec_chip *nvec = i2c_get_clientdata(client);
+
+	switch (event) {
+	case I2C_SLAVE_WRITE_REQUESTED:
+		/* Alloc new msg only if prev transaction finished */
+		if (nvec->state == ST_NONE)
+			nvec->rx = nvec_msg_alloc(nvec, NVEC_MSG_RX);
+
+		/* Should not happen in a normal world */
+		if (unlikely(nvec->rx == NULL)) {
+			nvec->state = ST_NONE;
+			return -1;
+		}
+		nvec->rx->pos = 0;
+
+		if (client->addr != ((*val) >> 1)) {
+			dev_err(&client->dev,
+				"received address 0x%02x, expected 0x%02x\n",
+				((*val) >> 1), client->addr);
+			return -1;
+		}
+		nvec->state = ST_TRANS_START;
+		break;
+
+	case I2C_SLAVE_WRITE_RECEIVED:
+		if (nvec->state != ST_TRANS_START &&
+		    nvec->state != ST_RX) {
+			dev_err(&client->dev,
+				"unexpected write: state %d\n",
+				nvec->state);
+			return -1;
+		}
+		if (nvec->rx->pos >= NVEC_MSG_SIZE) {
+			dev_err(&client->dev,
+				"write buffer overflow: state %d\n",
+				nvec->state);
+			return -1;
+		}
+		nvec->rx->data[nvec->rx->pos++] = *val;
+		nvec->state = ST_RX;
+		break;
+
+	case I2C_SLAVE_READ_REQUESTED:
+		if (nvec->state != ST_RX) {
+			dev_err(&client->dev,
+				"unexpected read request: state %d\n",
+				nvec->state);
+			return -1;
+		}
+		nvec_msg_free(nvec, nvec->rx);
+		nvec_tx_set(nvec);
+		/* Should not happen in a normal world */
+		if (!nvec->tx) {
+			dev_err(&client->dev,
+				"can't alloc tx msg: state %d\n",
+				nvec->state);
+			return -1;
+		}
+		nvec_gpio_set_value(nvec, 1);
+		/* fallthrough */
+	case I2C_SLAVE_READ_PROCESSED:
+		if (nvec->state != ST_RX &&
+		    nvec->state != ST_TX) {
+			dev_err(&client->dev,
+				"unexpected read: state %d\n",
+				nvec->state);
+			return -1;
+		}
+
+		if (!nvec->tx || nvec->tx->pos >= nvec->tx->size) {
+			dev_err(nvec->dev,
+				"tx buffer underflow on %p (%u > %u)\n",
+				nvec->tx,
+				(uint) (nvec->tx ? nvec->tx->pos : 0),
+				(uint) (nvec->tx ? nvec->tx->size : 0));
+			nvec->state = ST_NONE;
+			break;
+		}
+
+		nvec->state = ST_TX;
+		*val = nvec->tx->data[nvec->tx->pos++];
+		break;
+
+	case I2C_SLAVE_STOP:
+		if (nvec->state == ST_TX)
+			nvec_tx_completed(nvec);
+		else if (nvec->state == ST_RX)
+			nvec_rx_completed(nvec);
+		nvec->state = ST_NONE;
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
 
 static void nvec_power_off(void)
 {
@@ -767,7 +874,7 @@ static void nvec_power_off(void)
 /*
  *  Parse common device tree data
  */
-static int nvec_i2c_parse_dt_pdata(struct nvec_chip *nvec)
+static int nvec_i2c_parse_dt(struct nvec_chip *nvec)
 {
 	nvec->gpio = of_get_named_gpio(nvec->dev->of_node, "request-gpios", 0);
 
@@ -776,68 +883,39 @@ static int nvec_i2c_parse_dt_pdata(struct nvec_chip *nvec)
 		return -ENODEV;
 	}
 
-	if (of_property_read_u32(nvec->dev->of_node, "slave-addr",
-				&nvec->i2c_addr)) {
-		dev_err(nvec->dev, "no i2c address specified");
-		return -ENODEV;
-	}
-
 	return 0;
 }
 
-static int tegra_nvec_probe(struct platform_device *pdev)
+static int nvec_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
-	int err, ret;
-	struct clk *i2c_clk;
+	int ret;
 	struct nvec_chip *nvec;
 	struct nvec_msg *msg;
-	struct resource *res;
-	void __iomem *base;
-	char	get_firmware_version[] = { NVEC_CNTL, GET_FIRMWARE_VERSION },
+	char    get_firmware_version[] = { NVEC_CNTL, GET_FIRMWARE_VERSION },
 		unmute_speakers[] = { NVEC_OEM0, 0x10, 0x59, 0x95 },
 		enable_event[7] = { NVEC_SYS, CNF_EVENT_REPORTING, true };
 
-	if (!pdev->dev.of_node) {
-		dev_err(&pdev->dev, "must be instantiated using device tree\n");
+
+	if (!client->dev.of_node) {
+		dev_err(&client->dev, "must be instantiated using device tree\n");
 		return -ENODEV;
 	}
 
-	nvec = devm_kzalloc(&pdev->dev, sizeof(struct nvec_chip), GFP_KERNEL);
+	nvec = devm_kzalloc(&client->dev, sizeof(struct nvec_chip), GFP_KERNEL);
 	if (!nvec)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, nvec);
-	nvec->dev = &pdev->dev;
+	nvec->dev = &client->dev;
+	ret = nvec_i2c_parse_dt(nvec);
+	if (ret < 0)
+		return ret;
 
-	err = nvec_i2c_parse_dt_pdata(nvec);
-	if (err < 0)
-		return err;
+	i2c_set_clientdata(client, nvec);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	ret = i2c_slave_register(client, nvec_slave_cb);
+	if (ret < 0)
+		return ret;
 
-	nvec->irq = platform_get_irq(pdev, 0);
-	if (nvec->irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
-		return -ENODEV;
-	}
-
-	i2c_clk = devm_clk_get(&pdev->dev, "div-clk");
-	if (IS_ERR(i2c_clk)) {
-		dev_err(nvec->dev, "failed to get controller clock\n");
-		return -ENODEV;
-	}
-
-	nvec->rst = devm_reset_control_get(&pdev->dev, "i2c");
-	if (IS_ERR(nvec->rst)) {
-		dev_err(nvec->dev, "failed to get controller reset\n");
-		return PTR_ERR(nvec->rst);
-	}
-
-	nvec->base = base;
-	nvec->i2c_clk = i2c_clk;
 	nvec->rx = &nvec->msg_pool[0];
 
 	ATOMIC_INIT_NOTIFIER_HEAD(&nvec->notifier_list);
@@ -852,23 +930,14 @@ static int tegra_nvec_probe(struct platform_device *pdev)
 	INIT_WORK(&nvec->rx_work, nvec_dispatch);
 	INIT_WORK(&nvec->tx_work, nvec_request_master);
 
-	err = devm_gpio_request_one(&pdev->dev, nvec->gpio, GPIOF_OUT_INIT_HIGH,
-					"nvec gpio");
-	if (err < 0) {
+	ret = devm_gpio_request_one(&client->dev, nvec->gpio,
+			GPIOF_OUT_INIT_HIGH,
+			"nvec gpio");
+	if (ret < 0) {
 		dev_err(nvec->dev, "couldn't request gpio\n");
 		return -ENODEV;
 	}
 
-	err = devm_request_irq(&pdev->dev, nvec->irq, nvec_interrupt, 0,
-				"nvec", nvec);
-	if (err) {
-		dev_err(nvec->dev, "couldn't request irq\n");
-		return -ENODEV;
-	}
-	disable_irq(nvec->irq);
-
-	tegra_init_i2c_slave(nvec);
-
 	/* enable event reporting */
 	nvec_toggle_global_events(nvec, true);
 
@@ -907,9 +976,10 @@ static int tegra_nvec_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_nvec_remove(struct platform_device *pdev)
+
+static int nvec_remove(struct i2c_client *client)
 {
-	struct nvec_chip *nvec = platform_get_drvdata(pdev);
+	struct nvec_chip *nvec = i2c_get_clientdata(client);
 
 	nvec_toggle_global_events(nvec, false);
 	mfd_remove_devices(nvec->dev);
@@ -938,8 +1008,6 @@ static int nvec_suspend(struct device *dev)
 	msg = nvec_write_sync(nvec, ap_suspend, sizeof(ap_suspend));
 	nvec_msg_free(nvec, msg);
 
-	nvec_disable_i2c_slave(nvec);
-
 	return 0;
 }
 
@@ -949,7 +1017,6 @@ static int nvec_resume(struct device *dev)
 	struct nvec_chip *nvec = platform_get_drvdata(pdev);
 
 	dev_dbg(nvec->dev, "resuming\n");
-	tegra_init_i2c_slave(nvec);
 	nvec_toggle_global_events(nvec, true);
 
 	return 0;
@@ -960,14 +1027,21 @@ static SIMPLE_DEV_PM_OPS(nvec_pm_ops, nvec_suspend, nvec_resume);
 
 /* Match table for of_platform binding */
 static const struct of_device_id nvidia_nvec_of_match[] = {
-	{ .compatible = "nvidia,nvec", },
+	{ .compatible = "nvidia,nvec-slave", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, nvidia_nvec_of_match);
 
-static struct platform_driver nvec_device_driver = {
-	.probe   = tegra_nvec_probe,
-	.remove  = tegra_nvec_remove,
+static const struct i2c_device_id nvidia_nvec_i2c_table[] = {
+	{ "nvec-slave", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, nvidia_nvec_i2c_table);
+
+static struct i2c_driver i2c_nvec_device_driver = {
+	.probe   = nvec_probe,
+	.remove  = nvec_remove,
+	.id_table = nvidia_nvec_i2c_table,
 	.driver  = {
 		.name = "nvec",
 		.pm = &nvec_pm_ops,
@@ -975,9 +1049,9 @@ static struct platform_driver nvec_device_driver = {
 	}
 };
 
-module_platform_driver(nvec_device_driver);
+module_i2c_driver(i2c_nvec_device_driver);
 
-MODULE_ALIAS("platform:nvec");
+MODULE_ALIAS("i2c:nvec");
 MODULE_DESCRIPTION("NVIDIA compliant embedded controller interface");
 MODULE_AUTHOR("Marc Dietrich <marvin24@gmx.de>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/nvec/nvec.h b/drivers/staging/nvec/nvec.h
index e271375..ad6a556 100644
--- a/drivers/staging/nvec/nvec.h
+++ b/drivers/staging/nvec/nvec.h
@@ -107,11 +107,6 @@ struct nvec_msg {
  * struct nvec_chip - A single connection to an NVIDIA Embedded controller
  * @dev: The device
  * @gpio: The same as for &struct nvec_platform_data
- * @irq: The IRQ of the I2C device
- * @i2c_addr: The address of the I2C slave
- * @base: The base of the memory mapped region of the I2C device
- * @i2c_clk: The clock of the I2C device
- * @rst: The reset of the I2C device
  * @notifier_list: Notifiers to be called on received messages, see
  *                 nvec_register_notifier()
  * @rx_data: Received messages that have to be processed
@@ -137,11 +132,6 @@ struct nvec_msg {
 struct nvec_chip {
 	struct device *dev;
 	int gpio;
-	int irq;
-	int i2c_addr;
-	void __iomem *base;
-	struct clk *i2c_clk;
-	struct reset_control *rst;
 	struct atomic_notifier_head notifier_list;
 	struct list_head rx_data, tx_data;
 	struct notifier_block nvec_status_notifier;
-- 
1.9.1
