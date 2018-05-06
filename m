From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 6 May 2018 09:31:18 +0200
Subject: Handling lm3559 flash on Motorola Droid 4 and others
In-Reply-To: <20180505213951.GA4530@amd>
References: <20180505213951.GA4530@amd>
Message-ID: <20180506073118.GA6811@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> It seems lm3559 flash driver is available on github (
> https://github.com/ZenfoneArea/android_kernel_asus_zenfone5/tree/master/linux/modules/camera/drivers/media/i2c
> ) but there'll be some fun getting it cleaned up and merged.
> 
> Did anyone start doing anything in that area? Is there possibly better
> source to start from?

It turned out to be easier than expected. Of course, using flash w/o
v4l will not be easy, but that's generic problem.

									Pavel

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index bdf73cb..45305e8 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -271,6 +271,34 @@
 	};
 };
 
+&i2c3 {
+      rearcam: camera at 36 {
+            compatible = "micron,ov8820";
+	    reg = <0x36>;
+	    clocks = <&auxclk1_ck>;
+	    clock-names = "xvclk";
+	    clock-frequency = <24000000>;
+	    power-gpios = <&gpio2 16 GPIO_ACTIVE_HIGH>, // gpio48
+	    		  <&gpio3 19 GPIO_ACTIVE_HIGH>, // gpio83
+			  <&gpio5 23 GPIO_ACTIVE_HIGH>; // gpio151
+      };
+      frontcam: camera at 48 {
+       		compatible = "ovti,mt9m114";
+		reg = <0x48>;
+		clocks = <&auxclk2_ck>;
+		clock-names = "extclk";
+		clock-frequency = <24000000>;
+		power-gpios = <&gpio6 11 GPIO_ACTIVE_HIGH>, // gpio171
+			      <&gpio2 5 GPIO_ACTIVE_HIGH>; // gpio37
+		};
+	flashlight: flash at 53 {
+ 	    compatible = "ti,lm3559";
+	    reg = <0x53>;
+	};
+};
+
+
+
 &keypad {
 	keypad,num-rows = <8>;
 	keypad,num-columns = <8>;
diff --git a/drivers/media/i2c/lm3560.c b/drivers/media/i2c/lm3560.c
index b600e03a..a9b2ba2 100644
--- a/drivers/media/i2c/lm3560.c
+++ b/drivers/media/i2c/lm3560.c
@@ -17,6 +17,8 @@
  * General Public License for more details.
  */
 
+// Probably compatible with lm3559, too.
+
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
@@ -395,6 +397,22 @@ static int lm3560_init_device(struct lm3560_flash *flash)
 		return rval;
 	/* reset faults */
 	rval = regmap_read(flash->regmap, REG_FLAG, &reg_val);
+
+	printk("lm3560: Device initialized\n");
+
+	flash->led_mode = V4L2_FLASH_LED_MODE_TORCH;
+	rval = lm3560_mode_ctrl(flash);
+	rval = lm3560_torch_brt_ctrl(flash, 0, LM3560_TORCH_BRT_MIN);
+	rval = lm3560_torch_brt_ctrl(flash, 1, LM3560_TORCH_BRT_MIN);		
+
+	mdelay(1000);
+
+	rval = lm3560_torch_brt_ctrl(flash, 0, 0);
+	rval = lm3560_torch_brt_ctrl(flash, 1, 0);		
+	
+	flash->led_mode = V4L2_FLASH_LED_MODE_NONE;
+	rval = lm3560_mode_ctrl(flash);
+	
 	return rval;
 }
 
@@ -405,6 +423,8 @@ static int lm3560_probe(struct i2c_client *client,
 	struct lm3560_platform_data *pdata = dev_get_platdata(&client->dev);
 	int rval;
 
+	printk("3560: probe\n");
+
 	flash = devm_kzalloc(&client->dev, sizeof(*flash), GFP_KERNEL);
 	if (flash == NULL)
 		return -ENOMEM;
@@ -417,17 +437,19 @@ static int lm3560_probe(struct i2c_client *client,
 
 	/* if there is no platform data, use chip default value */
 	if (pdata == NULL) {
+		printk("3560: no pdata\n");
+		
 		pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
 		if (pdata == NULL)
 			return -ENODEV;
-		pdata->peak = LM3560_PEAK_3600mA;
-		pdata->max_flash_timeout = LM3560_FLASH_TOUT_MAX;
+		pdata->peak = LM3560_PEAK_1600mA;
+		pdata->max_flash_timeout = LM3560_FLASH_TOUT_MIN;
 		/* led 1 */
-		pdata->max_flash_brt[LM3560_LED0] = LM3560_FLASH_BRT_MAX;
-		pdata->max_torch_brt[LM3560_LED0] = LM3560_TORCH_BRT_MAX;
+		pdata->max_flash_brt[LM3560_LED0] = LM3560_FLASH_BRT_MIN;
+		pdata->max_torch_brt[LM3560_LED0] = LM3560_TORCH_BRT_MIN;
 		/* led 2 */
-		pdata->max_flash_brt[LM3560_LED1] = LM3560_FLASH_BRT_MAX;
-		pdata->max_torch_brt[LM3560_LED1] = LM3560_TORCH_BRT_MAX;
+		pdata->max_flash_brt[LM3560_LED1] = LM3560_FLASH_BRT_MIN;
+		pdata->max_torch_brt[LM3560_LED1] = LM3560_TORCH_BRT_MIN;
 	}
 	flash->pdata = pdata;
 	flash->dev = &client->dev;
@@ -466,6 +488,8 @@ static int lm3560_remove(struct i2c_client *client)
 
 static const struct i2c_device_id lm3560_id_table[] = {
 	{LM3560_NAME, 0},
+	{"lm3559", 0},
+	{"ti,lm3559", 0},
 	{}
 };
 



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180506/96bdf4cf/attachment.sig>
