From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 24 Feb 2018 21:57:04 +0100
Subject: [PATCHv3] tlv320dac33: Add device tree bindings
In-Reply-To: <20180206152722.GH5681@sirena.org.uk>
References: <20180129230539.GA18280@amd> <20180131190112.GA31608@amd>
 <20b9ff40-a869-a165-07a2-2a103830efb3@ti.com>
 <20180205082445.GA18274@amd> <20180206121122.GG5681@sirena.org.uk>
 <20180206134906.GA7842@amd> <20180206152722.GH5681@sirena.org.uk>
Message-ID: <20180224205704.GB5132@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-02-06 15:27:22, Mark Brown wrote:
> On Tue, Feb 06, 2018 at 02:49:06PM +0100, Pavel Machek wrote:
> > On Tue 2018-02-06 12:11:22, Mark Brown wrote:
> 
> > > Please submit patches using subject lines reflecting the style for the
> > > subsystem.  This makes it easier for people to identify relevant
> > > patches.  Look at what existing commits in the area you're changing are
> > > doing and make sure your subject lines visually resemble what they're
> > > doing.
> 
> > AFAICT this goes to Documentation, not sound.
> 
> Even if that were the case you're not following the commonly accepted
> practice there either.
> 
> > If you have any comments on V1 of this patch, that would be nice, I'd
> > like to get that merged once we are finished with the bindings.
> 
> It is the middle of the merge window, please be a bit more patient.

For the record, patch currently looks like this. If you have some
comments on the code, I'd like to hear them.

Best regards,
								Pavel

diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
new file mode 100644
index 0000000..aee0a87
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
@@ -0,0 +1,32 @@
+Texas Instruments - tlv320dac33 Codec module
+
+The tlv320dac33 serial control bus communicates through I2C protocols.
+
+Required properties:
+
+- compatible - "ti,tlv320dac33"
+- reg - I2C slave address
+- ti,burst-bclkdiv - BCLK divider value in burst mode. Valid range is 1..255.
+
+Optional properties:
+
+- reset-gpios      - gpio pin to power the device, active high.
+
+- interrupts       - The interrupt output from the device.
+- interrupt-parent - The parent interrupt controller.
+
+- ti,keep-bclk     - Keep the BCLK running in FIFO modes.
+
+Example:
+
+tlv320dac33: audio-codec at 19 {
+	compatible = "ti,tlv320dac33";
+	reg = <0x19>;
+
+	interrupt-parent = <&gpio2>;
+	interrupts = <21 1>; /* gpio_53, IRQF_TRIGGER_RISING */
+	reset-gpios = <&gpio2 28 0>; /* gpio_60 */
+
+	ti,keep-bclk;
+	ti,burst-bclkdiv = <3>;
+};
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 8c71d2f..7302789 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -30,6 +32,7 @@
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -105,7 +108,7 @@ struct tlv320dac33_priv {
 	unsigned int nsample;		/* burst read amount from host */
 	int mode1_latency;		/* latency caused by the i2c writes in
 					 * us */
-	u8 burst_bclkdiv;		/* BCLK divider value in burst mode */
+	u32 burst_bclkdiv;		/* BCLK divider value in burst mode */
 	u8 *reg_cache;
 	unsigned int burst_rate;	/* Interface speed in Burst modes */
 
@@ -1483,16 +1486,11 @@ static struct snd_soc_dai_driver dac33_dai = {
 static int dac33_i2c_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
-	struct tlv320dac33_platform_data *pdata;
+	struct tlv320dac33_platform_data *pdata = client->dev.platform_data;
 	struct tlv320dac33_priv *dac33;
+	struct device_node *np = client->dev.of_node;
 	int ret, i;
 
-	if (client->dev.platform_data == NULL) {
-		dev_err(&client->dev, "Platform data not set\n");
-		return -ENODEV;
-	}
-	pdata = client->dev.platform_data;
-
 	dac33 = devm_kzalloc(&client->dev, sizeof(struct tlv320dac33_priv),
 			     GFP_KERNEL);
 	if (dac33 == NULL)
@@ -1511,10 +1509,26 @@ static int dac33_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, dac33);
 
-	dac33->power_gpio = pdata->power_gpio;
-	dac33->burst_bclkdiv = pdata->burst_bclkdiv;
-	dac33->keep_bclk = pdata->keep_bclk;
-	dac33->mode1_latency = pdata->mode1_latency;
+	if (pdata) {
+		dac33->power_gpio = pdata->power_gpio;
+		dac33->burst_bclkdiv = pdata->burst_bclkdiv;
+		dac33->keep_bclk = pdata->keep_bclk;
+		dac33->mode1_latency = pdata->mode1_latency;
+	} else if (np) {
+		ret = of_get_named_gpio(np, "power-gpios", 0);
+		if (ret >= 0)
+			dac33->power_gpio = ret;
+		else
+			dac33->power_gpio = -1;
+
+		if (of_property_read_bool(np, "ti,keep-bclk"))
+			dac33->keep_bclk = true;
+
+		of_property_read_u32(np, "ti,burst-bclkdiv", &dac33->burst_bclkdiv);
+	} else {
+		dev_err(&client->dev, "Platform data not set\n");
+		return -ENODEV;
+	}
 	if (!dac33->mode1_latency)
 		dac33->mode1_latency = 10000; /* 10ms */
 	dac33->irq = client->irq;
@@ -1580,9 +1594,16 @@ static const struct i2c_device_id tlv320dac33_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tlv320dac33_i2c_id);
 
+static const struct of_device_id tlv320dac33_of_match[] = {
+	{ .compatible = "ti,tlv320dac33", },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, tlv320dac33_of_match);
+
 static struct i2c_driver tlv320dac33_i2c_driver = {
 	.driver = {
 		.name = "tlv320dac33-codec",
+		.of_match_table = of_match_ptr(tlv320dac33_of_match),
 	},
 	.probe		= dac33_i2c_probe,
 	.remove		= dac33_i2c_remove,


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180224/a867dbd2/attachment.sig>
