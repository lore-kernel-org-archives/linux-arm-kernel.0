From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 16 Dec 2014 00:54:39 +0100
Subject: [PATCHv1 2/3] rtc: rtc-isl12057: add isil,irq2-can-wakeup-machine
 property for in-tree users
In-Reply-To: <cover.1418687005.git.arno@natisbad.org>
References: <cover.1418687005.git.arno@natisbad.org>
Message-ID: <2b523b085c5ef3e0f1d0cae8b2f94d33f2362377.1418687005.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Current in-tree users of ISL12057 RTC chip (NETGEAR ReadyNAS 102, 104
and 2120) do not have the IRQ#2 pin of the chip (associated w/ the
Alarm1 mechanism) connected to their SoC, but to a PMIC (TPS65251
FWIW). This specific hardware configuration allows the NAS to wake up
when the alarms rings.

Recently introduced alarm support for ISL12057 relies on the provision
of an "interrupts" property in system .dts file, which previous three
users will never get. For that reason, alarm support on those devices
is not function. To support this use case, this patch adds a new DT
property for ISL12057 (isil,irq2-can-wakeup-machine) to indicate that
the chip is capable of waking up the device using its IRQ#2 pin (even
though it does not have its IRQ#2 pin connected directly to the SoC).

This specific configuration was tested on a ReadyNAS 102 by setting
an alarm, powering off the device and see it reboot as expected
when the alarm rang w/:

  # echo `date '+%s' -d '+ 1 minutes'` > /sys/class/rtc/rtc0/wakealarm
  # shutdown -h now

As a side note, the ISL12057 remains in the list of trivial devices,
because the property is not per se required by the device to work
but can help handle system w/ specific requirements. In exchange, the
new feature is described in details in a specific documentation file.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 .../devicetree/bindings/rtc/isil,isl12057.txt      | 78 ++++++++++++++++++++++
 drivers/rtc/rtc-isl12057.c                         | 45 +++++++++++--
 2 files changed, 117 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl12057.txt

diff --git a/Documentation/devicetree/bindings/rtc/isil,isl12057.txt b/Documentation/devicetree/bindings/rtc/isil,isl12057.txt
new file mode 100644
index 000000000000..501c39ceae79
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/isil,isl12057.txt
@@ -0,0 +1,78 @@
+Intersil ISL12057 I2C RTC/Alarm chip
+
+ISL12057 is a trivial I2C device (it has simple device tree bindings,
+consisting of a compatible field, an address and possibly an interrupt
+line).
+
+Nonetheless, it also supports an option boolean property
+("isil,irq2-can-wakeup-machine") to handle the specific use-case found
+on at least three in-tree users of the chip (NETGEAR ReadyNAS 102, 104
+and 2120 ARM-based NAS); On those devices, the IRQ#2 pin of the chip
+(associated with the alarm supported by the driver) is not connected
+to the SoC but to a PMIC. It allows the device to be powered up when
+RTC alarm rings. In order to mark the device has a wakeup source and
+get access to the 'wakealarm' sysfs entry, this specific property can
+be set when the IRQ#2 pin of the chip is not connected to the SoC but
+can wake up the device.
+
+Required properties supported by the device:
+
+ - "compatible": must be "isil,isl12057"
+ - "reg": I2C bus address of the device
+
+Optional properties:
+
+ - "isil,irq2-can-wakeup-machine": mark the chip as a wakeup source,
+   independently of the availability of an IRQ line connected to the
+   SoC.
+
+ - "interrupt-parent", "interrupts": for passing the interrupt line
+   of the SoC connected to IRQ#2 of the RTC chip.
+
+
+Example isl12057 node without IRQ#2 pin connected (no alarm support):
+
+	isl12057: isl12057 at 68 {
+		compatible = "isil,isl12057";
+		reg = <0x68>;
+	};
+
+
+Example isl12057 node with IRQ#2 pin connected to main SoC via MPP6 (note
+that the pinctrl-related properties below are given for completeness and
+may not be required or may be different depending on your system or
+SoC, and the main function of the MPP used as IRQ line, i.e.
+"interrupt-parent" and "interrupts" are usually sufficient):
+
+		    pinctrl {
+				...
+
+				rtc_alarm_pin: rtc_alarm_pin {
+					marvell,pins = "mpp6";
+					marvell,function = "gpio";
+				};
+
+				...
+
+		    };
+
+	...
+
+	isl12057: isl12057 at 68 {
+		compatible = "isil,isl12057";
+		reg = <0x68>;
+		pinctrl-0 = <&rtc_alarm_pin>;
+		pinctrl-names = "default";
+		interrupt-parent = <&gpio0>;
+		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+
+Example isl12057 node without IRQ#2 pin connected to the SoC but to a
+PMIC, allowing the device to be started based on configured alarm:
+
+	isl12057: isl12057 at 68 {
+		compatible = "isil,isl12057";
+		reg = <0x68>;
+		isil,irq2-can-wakeup-machine;
+	};
diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
index 3ec73ad7f2d8..bd76c5e35fa5 100644
--- a/drivers/rtc/rtc-isl12057.c
+++ b/drivers/rtc/rtc-isl12057.c
@@ -457,6 +457,40 @@ static int isl12057_check_rtc_status(struct device *dev, struct regmap *regmap)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+/*
+ * One would expect the device to be marked as a wakeup source only
+ * when an IRQ pin of the RTC is routed to an interrupt line of the
+ * CPU. In practice, such an IRQ pin can be connected to a PMIC and
+ * this allows the device to be powered up when RTC alarm rings. This
+ * is for instance the case on ReadyNAS 102, 104 and 2120. On those
+ * devices with no IRQ driectly connected to the SoC, the RTC chip
+ * can be forced as a wakeup source by stating that explicitly in
+ * the device's .dts file using the "isil,irq2-can-wakeup-machine"
+ * boolean property. This will guarantee 'wakealarm' sysfs entry is
+ * available on the device.
+ *
+ * The function below returns 1, i.e. the capability of the chip to
+ * wakeup the device, based on IRQ availability or if the boolean
+ * property has been set in the .dts file. Otherwise, it returns 0.
+ */
+
+static bool isl12057_can_wakeup_machine(struct device *dev)
+{
+	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
+
+	return (data->irq || of_property_read_bool(dev->of_node,
+					      "isil,irq2-can-wakeup-machine"));
+}
+#else
+static bool isl12057_can_wakeup_machine(struct device *dev)
+{
+	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
+
+	return !!data->irq;
+}
+#endif
+
 static int isl12057_rtc_alarm_irq_enable(struct device *dev,
 					 unsigned int enable)
 {
@@ -555,7 +589,8 @@ static int isl12057_probe(struct i2c_client *client,
 				client->irq, ret);
 	}
 
-	device_init_wakeup(dev, !!data->irq);
+	if (isl12057_can_wakeup_machine(dev))
+		device_init_wakeup(dev, true);
 
 	data->rtc = devm_rtc_device_register(dev, DRV_NAME, &rtc_ops,
 					     THIS_MODULE);
@@ -576,9 +611,7 @@ err:
 
 static int isl12057_remove(struct i2c_client *client)
 {
-	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(&client->dev);
-
-	if (rtc_data->irq)
+	if (isl12057_can_wakeup_machine(&client->dev))
 		device_init_wakeup(&client->dev, false);
 
 	return 0;
@@ -589,7 +622,7 @@ static int isl12057_rtc_suspend(struct device *dev)
 {
 	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(dev);
 
-	if (device_may_wakeup(dev))
+	if (rtc_data->irq && device_may_wakeup(dev))
 		return enable_irq_wake(rtc_data->irq);
 
 	return 0;
@@ -599,7 +632,7 @@ static int isl12057_rtc_resume(struct device *dev)
 {
 	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(dev);
 
-	if (device_may_wakeup(dev))
+	if (rtc_data->irq && device_may_wakeup(dev))
 		return disable_irq_wake(rtc_data->irq);
 
 	return 0;
-- 
2.1.1
