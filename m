From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 14 Dec 2014 02:42:01 +0100
Subject: [PATCHv0 0/5] ISL12057 alarm support and isil vs isl fix
Message-ID: <cover.1418519430.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew, Uwe,

Andrew, the first patch of this series is a new version of the one you
have in your tree, providing the changes asked by Uwe (i.e. you can
just replace yours by that one). If you prefer an additional commit over
what you already have, do not hesitate to tell me. Below, you have a
diff between previous (the one you have) and  this first patch, w/ some
inline comments. Uwe, tell me if it is what you expected.

The three patches for RN102, RN104 and RN2120 .dts files just add a
boolean property to the ISL12057 node to mark it has a wakeup source,
as proposed by Uwe. If first patch is ok, I think those three can
either be merged by Jason or directly by you, Andrew.

The last patch tries and fix the isl vs isil issue which led to the
conflict between the previous version of this patch and two patches
merged upstream by Darshana, *by using isil everywhere and deprecating
isl*. Arnd is also in copy to provide some feedback. At the moment, this
last patch and the first one of this series can be applied in whatever
order but I think this is just luck (first and last patch both touch
rtc-isl12057.c file) so we'll have to be careful if it's merged by
different maintainers.

Cheers,

a+

Some comments on the changes in first patch:

-diff -puN drivers/rtc/rtc-isl12057.c~rtc-rtc-isl12057-add-alarm-support-to-intersil-isl12057-rtc-driver drivers/rtc/rtc-isl12057.c
---- a/drivers/rtc/rtc-isl12057.c~rtc-rtc-isl12057-add-alarm-support-to-intersil-isl12057-rtc-driver
-+++ a/drivers/rtc/rtc-isl12057.c
+Index: linux/drivers/rtc/rtc-isl12057.c
+===================================================================
+--- linux.orig/drivers/rtc/rtc-isl12057.c
++++ linux/drivers/rtc/rtc-isl12057.c
 @@ -1,5 +1,5 @@
  /*
 - * rtc-isl12057 - Driver for Intersil ISL12057 I2C Real Time Clock
@@ -335,10 +310,44 @@
  static int isl12057_rtc_set_time(struct device *dev, struct rtc_time *tm)
  {
  	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
-@@ -262,9 +457,48 @@ static int isl12057_check_rtc_status(str
+@@ -262,9 +457,82 @@ static int isl12057_check_rtc_status(str
  	return 0;
  }
  
> ++#ifdef CONFIG_OF
> ++/*
> ++ * One would expect the device to be marked as a wakeup source only
> ++ * when an IRQ pin of the RTC is routed to an interrupt line of the
> ++ * CPU. In practice, such an IRQ pin can be connected to a PMIC and
> ++ * this allows the device to be powered up when RTC alarm rings. This
> ++ * is for instance the case on ReadyNAS 102, 104 and 2120. On those
> ++ * devices with no IRQ driectly connected to the SoC, the RTC chip
> ++ * can be forced as a wakeup source by stating that explicitly in
> ++ * the device's .dts file using the "can-wakeup-machine" boolean
> ++ * property. This will guarantee 'wakealarm' sysfs entry is available
> ++ * on the device.
> ++ *
> ++ * The function below returns 1, i.e. the capability of the chip to
> ++ * wakeup the device, based on IRQ availability or if the boolean
> ++ * property has been set in the .dts file. Otherwise, it returns 0.
> ++ */
> ++
> ++static bool isl12057_can_wakeup_machine(struct device *dev)
> ++{
> ++	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
> ++
> ++	return (data->irq ||
> ++		of_property_read_bool(dev->of_node, "can-wakeup-machine"));
> ++}
> ++#else
> ++static bool isl12057_can_wakeup_machine(struct device *dev)
> ++{
> ++	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
> ++
> ++	return !!data->irq;
> ++}
> ++#endif
> ++

a small helper. Note: the only way to mark the device is a wakeup source
is via system .dts file. Uwe, now is the time to decide if we put a prefix
before the property and which ;-)

I have also added a Documentation/devicetree/bindings/rtc/isil,isl12057.txt
in first patch to describe the purpose of the property and give some
example. I decided to let the device in the list of trivial I2C device
though, as this property is not per see required by the device, nor
specific to ISL12057 but to the way the chip IRQ line is connected (or
not connected) to the SoC.
 

>  +static int isl12057_rtc_alarm_irq_enable(struct device *dev,
>  +					 unsigned int enable)
>  +{
> @@ -385,7 +394,7 @@
>   };
>   
>   static struct regmap_config isl12057_rtc_regmap_config = {
> -@@ -277,7 +511,6 @@ static int isl12057_probe(struct i2c_cli
> +@@ -277,7 +545,6 @@ static int isl12057_probe(struct i2c_cli
>   {
>   	struct device *dev = &client->dev;
>   	struct isl12057_rtc_data *data;
> @@ -393,7 +402,7 @@
>   	struct regmap *regmap;
>   	int ret;
>   
> -@@ -310,10 +543,79 @@ static int isl12057_probe(struct i2c_cli
> +@@ -310,9 +577,70 @@ static int isl12057_probe(struct i2c_cli
>   	data->regmap = regmap;
>   	dev_set_drvdata(dev, data);
>   
> @@ -411,14 +420,8 @@
>  +				client->irq, ret);
>  +	}
>  +
> -+	/*
> -+	 * This is needed to have 'wakealarm' sysfs entry available. One
> -+	 * would expect the device to be marked as a wakeup source only
> -+	 * when an IRQ pin of the RTC is routed to an interrupt line of the
> -+	 * CPU. In practice, such an IRQ pin can be connected to a PMIC and
> -+	 * this allows the device to be powered up when RTC alarm rings.
> -+	 */
> -+	device_init_wakeup(dev, true);
> ++	if (isl12057_can_wakeup_machine(dev))
> ++		device_init_wakeup(dev, true);

We mark the device as a wakeup source if irq is available or the .dts
file explicitly require it via our new boolean can-wakeup-machine
property.


> ++}
> ++
>  +static int isl12057_remove(struct i2c_client *client)
>  +{
> -+	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(&client->dev);
> -+
> -+	if (rtc_data->irq > 0)
> ++	if (isl12057_can_wakeup_machine(&client->dev))
>  +		device_init_wakeup(&client->dev, false);

Same reason is used to remove the device as from wakeup sources.


>  +
>  +	return 0;
> @@ -452,7 +453,7 @@
>  +{
>  +	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(dev);
>  +
> -+	if (device_may_wakeup(dev))
> ++	if (rtc_data->irq && device_may_wakeup(dev))
>  +		return enable_irq_wake(rtc_data->irq);
>  +
>  +	return 0;
> @@ -462,20 +463,19 @@
>  +{
>  +	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(dev);
>  +
> -+	if (device_may_wakeup(dev))
> ++	if (rtc_data->irq && device_may_wakeup(dev))
>  +		return disable_irq_wake(rtc_data->irq);

check we have a valid irq before passing it to enable/disable_irq_wake(). 


Arnaud Ebalard (5):
  rtc: rtc-isl12057: add alarm support to Intersil ISL12057 RTC driver
  ARM: mvebu: ISL12057 rtc chip can be used to wake up RN102
  ARM: mvebu: ISL12057 rtc chip can be used to wake up RN104
  ARM: mvebu: ISL12057 rtc chip can be used to wake up RN2120
  dt-bindings: fix isl vs isil prefix issue for Intersil

 .../devicetree/bindings/i2c/trivial-devices.txt    |   5 +-
 .../devicetree/bindings/regulator/isl9305.txt      |   4 +-
 .../devicetree/bindings/rtc/isil,isl12057.txt      |  71 +++++
 .../devicetree/bindings/vendor-prefixes.txt        |   3 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |   1 +
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |   1 +
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |   1 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   2 +-
 arch/arm/boot/dts/zynq-parallella.dts              |   2 +-
 drivers/regulator/isl9305.c                        |   6 +-
 drivers/rtc/rtc-isl12022.c                         |   3 +-
 drivers/rtc/rtc-isl12057.c                         | 353 ++++++++++++++++++++-
 drivers/staging/iio/light/isl29028.c               |   4 +-
 13 files changed, 431 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl12057.txt

-- 
2.1.1
