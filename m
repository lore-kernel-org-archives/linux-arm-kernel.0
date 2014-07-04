From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  4 Jul 2014 22:24:05 +0200
Subject: [PATCH v7 02/24] mfd: max77686: Add power management support
In-Reply-To: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1404505467-26526-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver doesn't have PM operations defined so add a suspend
and resume function handlers to allow the PMIC IRQ to wakeup
the system when it is put into a sleep state.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mfd/max77686.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 3cb41d0..a38e9ee 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -240,10 +240,50 @@ static const struct i2c_device_id max77686_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max77686_i2c_id);
 
+#ifdef CONFIG_PM_SLEEP
+static int max77686_suspend(struct device *dev)
+{
+	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
+	struct max77686_dev *max77686 = i2c_get_clientdata(i2c);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(max77686->irq);
+
+	/*
+	 * IRQ must be disabled during suspend because if it happens
+	 * while suspended it will be handled before resuming I2C.
+	 *
+	 * When device is woken up from suspend (e.g. by RTC wake alarm),
+	 * an interrupt occurs before resuming I2C bus controller.
+	 * Interrupt handler tries to read registers but this read
+	 * will fail because I2C is still suspended.
+	 */
+	disable_irq(max77686->irq);
+
+	return 0;
+}
+
+static int max77686_resume(struct device *dev)
+{
+	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
+	struct max77686_dev *max77686 = i2c_get_clientdata(i2c);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(max77686->irq);
+
+	enable_irq(max77686->irq);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(max77686_pm, max77686_suspend, max77686_resume);
+
 static struct i2c_driver max77686_i2c_driver = {
 	.driver = {
 		   .name = "max77686",
 		   .owner = THIS_MODULE,
+		   .pm = &max77686_pm,
 		   .of_match_table = of_match_ptr(max77686_pmic_dt_match),
 	},
 	.probe = max77686_i2c_probe,
-- 
2.0.0.rc2
