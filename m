From: knut.wohlrab@de.bosch.com (Knut Wohlrab)
Date: Fri, 10 Aug 2012 14:30:59 +0200
Subject: How to define gpio irq with device tree
Message-ID: <5024FF03.1070805@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I try the touch screen of a iMX6 SabreLite evaluation board. The used 
eGalax touch controller worked fine with a 3.2.x kernel [1]. As 
mentioned there [2] I merge the basic device tree support to the actual 
driver (see patch [4]) and add the touch definition to 
arch/arm/boot/dts/imx6q-sabrelite.dts [3].

The driver seems to start but the interrupt never occurs.

The pinmux and I2C configuration seems correct. I did a simple test with 
polling the interrupt gpio (see "POLLTEST" in patch [4]) and got 
coordinates matching to the movements on the screen.

How to configure the gpio irq correctly?

Anybody solved to work with the eGalax touch and iMX6 SabreLite with 
kernel > 3.2?

Thanks a lot for any information.


[1]
http://git.linaro.org/gitweb?p=landing-teams/working/freescale/kernel.git;a=shortlog;h=refs/heads/lt-3.2-imx6 


[2]
http://git.linaro.org/gitweb?p=landing-teams/working/freescale/kernel.git;a=blob;f=drivers/input/touchscreen/egalax_ts.c;h=58184dad7a2e1b6a42711acddb184d68ffceeb4c;hb=refs/heads/lt-3.2-imx6 


[3]
...
             i2c at 021a8000 { /* I2C3 */
                 status = "okay";
                 clock-frequency = <400000>;

                 egalax at 04 {
                     compatible = "eeti,egalax";
                     reg = <0x04>;
                     interrupt-parent = <&gpio1>;
                     interrupts = <9 0x08>;
                     interrupt-gpio = <&gpio1 9 0>;
                 };
...

[4]

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 70524dd..653a97a 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -28,6 +28,9 @@
  #include <linux/slab.h>
  #include <linux/bitops.h>
  #include <linux/input/mt.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
  
  /*
   * Mouse Mode: some panel may configure the controller to mouse mode,
@@ -62,6 +65,7 @@
  struct egalax_ts {
  	struct i2c_client		*client;
  	struct input_dev		*input_dev;
+	int 					gpio_irq;
  };
  
  static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
@@ -122,7 +126,8 @@ static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
  /* wake up controller by an falling edge of interrupt gpio.  */
  static int egalax_wake_up_device(struct i2c_client *client)
  {
-	int gpio = irq_to_gpio(client->irq);
+	struct egalax_ts *ts = i2c_get_clientdata(client);
+	int gpio = ts->gpio_irq;
  	int ret;
  
  	ret = gpio_request(gpio, "egalax_irq");
@@ -159,6 +164,7 @@ static int __devinit egalax_firmware_version(struct i2c_client *client)
  static int __devinit egalax_ts_probe(struct i2c_client *client,
  				       const struct i2c_device_id *id)
  {
+	struct device_node *n = client->dev.of_node;
  	struct egalax_ts *ts;
  	struct input_dev *input_dev;
  	int ret;
@@ -179,6 +185,13 @@ static int __devinit egalax_ts_probe(struct i2c_client *client,
  
  	ts->client = client;
  	ts->input_dev = input_dev;
+	ts->gpio_irq = of_get_named_gpio(n, "interrupt-gpio", 0);
+	if (!gpio_is_valid(ts->gpio_irq))
+		dev_warn(&client->dev, "invalid interrupt GPIO\n");
+	else
+		dev_info(&client->dev, "valid interrupt GPIO:%d\n", ts->gpio_irq);
+
+	i2c_set_clientdata(client, ts);
  
  	/* controller may be in sleep, wake it up. */
  	egalax_wake_up_device(client);
@@ -214,13 +227,31 @@ static int __devinit egalax_ts_probe(struct i2c_client *client,
  	if (error < 0) {
  		dev_err(&client->dev, "Failed to register interrupt\n");
  		goto err_free_dev;
+	}else{
+		dev_info(&client->dev, "register interrupt: %d\n", client->irq);
  	}
  
  	error = input_register_device(ts->input_dev);
  	if (error)
  		goto err_free_irq;
  
-	i2c_set_clientdata(client, ts);
+//#define POLLTEST
+#ifdef POLLTEST
+	while(1){
+		if(!gpio_get_value(ts->gpio_irq)){
+			u8 buf[MAX_I2C_DATA_LEN];
+			int i, ret, tries = 0;
+			do {
+				ret = i2c_master_recv(client, buf, MAX_I2C_DATA_LEN);
+
+				for(i=0; i<ret; ++i)
+					printk("0x%02X ", buf[i]);
+
+				printk("\n");
+			} while (ret == -EAGAIN && tries++ < EGALAX_MAX_TRIES);
+		}
+	}
+#endif
  	return 0;
  
  err_free_irq:
@@ -251,6 +282,12 @@ static const struct i2c_device_id egalax_ts_id[] = {
  };
  MODULE_DEVICE_TABLE(i2c, egalax_ts_id);
  
+static struct of_device_id egalax_dt_ids[] = {
+	{ .compatible = "eeti,egalax" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_uart_dt_ids);
+
  #ifdef CONFIG_PM_SLEEP
  static int egalax_ts_suspend(struct device *dev)
  {
@@ -279,6 +316,7 @@ static struct i2c_driver egalax_ts_driver = {
  		.name	= "egalax_ts",
  		.owner	= THIS_MODULE,
  		.pm	= &egalax_ts_pm_ops,
+		.of_match_table	= egalax_dt_ids,
  	},
  	.id_table	= egalax_ts_id,
  	.probe		= egalax_ts_probe,
