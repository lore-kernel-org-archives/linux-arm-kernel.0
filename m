From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 10 Nov 2009 17:26:22 -0500
Subject: [PATCH] led: enable led in 88pm860x
Message-ID: <mailman.85.1260364589.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable led sub device in Marvell 88PM860x. Two LED arrays can be supported.
Each LED array can be used for R,G,B leds.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/leds/Kconfig         |    7 +
 drivers/leds/Makefile        |    1 +
 drivers/leds/leds-88pm860x.c |  334 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 342 insertions(+), 0 deletions(-)
 create mode 100644 drivers/leds/leds-88pm860x.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index e4f599f..49ec714 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -236,6 +236,13 @@ config LEDS_BD2802
 	  This option enables support for BD2802GU RGB LED driver chips
 	  accessed via the I2C bus.

+config LEDS_88PM860X
+	tristate "LED Support for Marvell 88PM860x PMIC"
+	depends on LEDS_CLASS && MFD_88PM860X
+	help
+	  This option enables support for on-chip LED drivers found on Marvell
+	  Semiconductor 88PM8606 PMIC.
+
 comment "LED Triggers"

 config LEDS_TRIGGERS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 46d7270..361ae38 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_LEDS_DA903X)		+= leds-da903x.o
 obj-$(CONFIG_LEDS_WM831X_STATUS)	+= leds-wm831x-status.o
 obj-$(CONFIG_LEDS_WM8350)		+= leds-wm8350.o
 obj-$(CONFIG_LEDS_PWM)			+= leds-pwm.o
+obj-$(CONFIG_LEDS_88PM860X)		+= leds-88pm860x.o

 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-88pm860x.c b/drivers/leds/leds-88pm860x.c
new file mode 100644
index 0000000..5160559
--- /dev/null
+++ b/drivers/leds/leds-88pm860x.c
@@ -0,0 +1,334 @@
+/*
+ * LED driver for Marvell 88PM860x
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ *	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/mfd/88pm860x.h>
+
+#define LED_PWM_SHIFT		(3)
+#define LED_PWM_MASK		(0x1F)
+#define LED_CURRENT_MASK	(0x07 << 5)
+
+#define LED_BLINK_ON_MASK	(0x07)
+#define LED_BLINK_PERIOD_MASK	(0x0F << 3)
+#define LED_BLINK_MASK		(0x7F)
+
+#define LED_BLINK_ON(x)		((x & 0x7) * 66 + 66)
+#define LED_BLINK_PERIOD(x)	((x & 0xF) * 530 + 930)
+#define LED_BLINK_ON_MIN	LED_BLINK_ON(0)
+#define LED_BLINK_ON_MAX	LED_BLINK_ON(0x7)
+#define LED_BLINK_PERIOD_MIN	LED_BLINK_PERIOD(0)
+#define LED_BLINK_PERIOD_MAX	LED_BLINK_PERIOD(0xE)
+#define LED_TO_ON(x)		((x - 66) / 66)
+#define LED_TO_PERIOD(x)	((x - 930) / 530)
+
+#define LED1_BLINK_EN		(1 << 1)
+#define LED2_BLINK_EN		(1 << 2)
+
+struct pm860x_led {
+	struct led_classdev cdev;
+	struct i2c_client *i2c;
+	struct pm860x_chip *chip;
+	struct mutex lock;
+	char name[MFD_NAME_SIZE];
+	int port;
+	int iset;
+
+	int blink;
+	int blink_time;
+	int blink_on;
+	int blink_off;
+	int current_brightness;
+};
+
+/* return offset of color register */
+static inline int __led_off(int port)
+{
+	int ret = -EINVAL;
+
+	switch (port) {
+	case PM8606_LED1_RED:
+	case PM8606_LED1_GREEN:
+	case PM8606_LED1_BLUE:
+		ret = port - PM8606_LED1_RED + PM8606_RGB1B;
+		break;
+	case PM8606_LED2_RED:
+	case PM8606_LED2_GREEN:
+	case PM8606_LED2_BLUE:
+		ret = port - PM8606_LED2_RED + PM8606_RGB2B;
+		break;
+	}
+	return ret;
+}
+
+/* return offset of blink register */
+static inline int __blink_off(int port)
+{
+	int ret = -EINVAL;
+
+	switch (port) {
+	case PM8606_LED1_RED:
+	case PM8606_LED1_GREEN:
+	case PM8606_LED1_BLUE:
+		ret = PM8606_RGB1A;
+	case PM8606_LED2_RED:
+	case PM8606_LED2_GREEN:
+	case PM8606_LED2_BLUE:
+		ret = PM8606_RGB2A;
+	}
+	return ret;
+}
+
+static inline int __blink_ctl_mask(int port)
+{
+	int ret = -EINVAL;
+
+	switch (port) {
+	case PM8606_LED1_RED:
+	case PM8606_LED1_GREEN:
+	case PM8606_LED1_BLUE:
+		ret = LED1_BLINK_EN;
+		break;
+	case PM8606_LED2_RED:
+	case PM8606_LED2_GREEN:
+	case PM8606_LED2_BLUE:
+		ret = LED2_BLINK_EN;
+		break;
+	}
+	return ret;
+}
+
+static void pm860x_led_set(struct led_classdev *cdev,
+			   enum led_brightness value)
+{
+	struct pm860x_led *data = container_of(cdev, struct pm860x_led, cdev);
+	struct pm860x_chip *chip = data->chip;
+	unsigned char brightness;
+	int offset;
+	int ret = -EINVAL;
+
+	offset = __led_off(data->port);
+
+	mutex_lock(&data->lock);
+	brightness = value >> 3;
+
+	if ((data->current_brightness == 0) && brightness) {
+		if (data->iset) {
+			ret = pm860x_set_bits(data->i2c, offset,
+					      LED_CURRENT_MASK, data->iset);
+			if (ret < 0)
+				goto out;
+		}
+	}
+
+	ret = pm860x_set_bits(data->i2c, offset, LED_PWM_MASK, brightness);
+	if (ret < 0)
+		goto out;
+	mutex_unlock(&data->lock);
+
+	data->current_brightness = brightness;
+	dev_dbg(chip->dev, "Update LED. (reg:%d, brightness:%d)\n",
+		offset, brightness);
+	return;
+out:
+	mutex_unlock(&data->lock);
+	dev_err(chip->dev, "Fail on update LED. (reg:%d, brightness:%d)\n",
+		offset, brightness);
+	return;
+}
+
+static enum led_brightness pm860x_led_get(struct led_classdev *cdev)
+{
+	struct pm860x_led *data = container_of(cdev, struct pm860x_led, cdev);
+	struct pm860x_chip *chip = data->chip;
+	enum led_brightness brightness = LED_OFF;
+	int offset = 0, ret = -EINVAL;
+
+	offset = __led_off(data->port);
+
+	mutex_lock(&data->lock);
+	ret = pm860x_reg_read(data->i2c, offset);
+	if (ret < 0)
+		goto out;
+	ret &= LED_PWM_MASK;
+	if (ret >= (LED_FULL >> LED_PWM_SHIFT))
+		brightness = LED_FULL;
+	else if (ret < (LED_HALF >> LED_PWM_SHIFT))
+		brightness = LED_OFF;
+	else
+		brightness = LED_HALF;
+out:
+	mutex_unlock(&data->lock);
+	dev_dbg(chip->dev, "Read LED. (reg:%d, brightness:%d, ret:%d)\n",
+		offset, brightness, ret);
+	return brightness;
+}
+
+static int pm860x_led_blink(struct led_classdev *cdev,
+			    unsigned long *delay_on,
+			    unsigned long *delay_off)
+{
+	struct pm860x_led *data = container_of(cdev, struct pm860x_led, cdev);
+	struct pm860x_chip *chip = data->chip;
+	int period, on, offset, sum;
+	int ret = -EINVAL;
+
+	offset = __blink_off(data->port);
+
+	on = *delay_on;
+	if (on < LED_BLINK_ON_MIN)
+		on = LED_BLINK_ON_MIN;
+	if (on > LED_BLINK_ON_MAX)
+		on = LED_BLINK_ON_MAX;
+
+	on = LED_TO_ON(on);
+	on = LED_BLINK_ON(on);
+
+	period = on + *delay_off;
+	if (period < LED_BLINK_PERIOD_MIN)
+		period = LED_BLINK_PERIOD_MIN;
+	if (period > LED_BLINK_PERIOD_MAX)
+		period = LED_BLINK_PERIOD_MAX;
+	period = LED_TO_PERIOD(period);
+	period = LED_BLINK_PERIOD(period);
+
+	mutex_lock(&data->lock);
+	data->blink_on = on;
+	data->blink_off = period - data->blink_on;
+	sum = (period << 3) | data->blink_on;
+
+	ret = pm860x_set_bits(data->i2c, offset, LED_BLINK_MASK, sum);
+	if (ret < 0)
+		goto out;
+
+	offset = __blink_ctl_mask(data->port);
+	ret = pm860x_set_bits(data->i2c, PM8606_WLED3B, offset, offset);
+	if (ret < 0)
+		goto out;
+	mutex_unlock(&data->lock);
+
+	dev_dbg(chip->dev, "LED blink delay on:%dms, delay off:%dms\n",
+		data->blink_on, data->blink_off);
+	return 0;
+out:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int __check_device(struct pm860x_led_pdata *pdata, char *name)
+{
+	struct pm860x_led_pdata *p = pdata;
+	int ret = -EINVAL;
+
+	while (p && p->id) {
+		if ((p->id != PM8606_ID_LED) || (p->flags < 0))
+			break;
+
+		if (!strncmp(name, pm860x_led_name[p->flags],
+			MFD_NAME_SIZE)) {
+			ret = (int)p->flags;
+			break;
+		}
+		p++;
+	}
+	return ret;
+}
+
+static int pm860x_led_probe(struct platform_device *pdev)
+{
+	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct pm860x_platform_data *pm860x_pdata;
+	struct pm860x_led_pdata *pdata;
+	struct pm860x_led *data;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "No I/O resource!\n");
+		return -EINVAL;
+	}
+
+	if (pdev->dev.parent->platform_data) {
+		pm860x_pdata = pdev->dev.parent->platform_data;
+		pdata = pm860x_pdata->led;
+	} else
+		pdata = NULL;
+
+	data = kzalloc(sizeof(struct pm860x_led), GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+	strncpy(data->name, res->name, MFD_NAME_SIZE);
+	dev_set_drvdata(&pdev->dev, data);
+	data->chip = chip;
+	data->i2c = (chip->id == CHIP_PM8606) ? chip->client : chip->companion;
+	data->iset = pdata->iset;
+	data->port = __check_device(pdata, data->name);
+	if (data->port < 0)
+		return -EINVAL;
+
+	data->current_brightness = 0;
+	data->cdev.name = data->name;
+	data->cdev.brightness_set = pm860x_led_set;
+	data->cdev.brightness_get = pm860x_led_get;
+	data->cdev.blink_set = pm860x_led_blink;
+	mutex_init(&data->lock);
+
+	ret = led_classdev_register(chip->dev, &data->cdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register LED: %d\n", ret);
+		goto out;
+	}
+	return 0;
+out:
+	kfree(data);
+	return ret;
+}
+
+static int pm860x_led_remove(struct platform_device *pdev)
+{
+	struct pm860x_led *data = platform_get_drvdata(pdev);
+
+	led_classdev_unregister(&data->cdev);
+	kfree(data);
+
+	return 0;
+}
+
+static struct platform_driver pm860x_led_driver = {
+	.driver	= {
+		.name	= "88pm860x-led",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= pm860x_led_probe,
+	.remove	= pm860x_led_remove,
+};
+
+static int __devinit pm860x_led_init(void)
+{
+	return platform_driver_register(&pm860x_led_driver);
+}
+module_init(pm860x_led_init);
+
+static void __devexit pm860x_led_exit(void)
+{
+	platform_driver_unregister(&pm860x_led_driver);
+}
+module_exit(pm860x_led_exit);
+
+MODULE_DESCRIPTION("LED driver for Marvell PM860x");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:88pm860x-led");
-- 
1.5.6.5


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.112.1262377507.2170.linux-arm-kernel@lists.infradead.org>

mode which doesn't work, and the MMU mode does.

> However, in the (MM)I/O address
> mapping for the 21285 driver, the footbridge code completely ignores
> CONFIG_MMU and has all the I/O addresses #defined as if they were all
> virtual. This is obviously not going to work if the MMU is disabled and
> all the addresses will be wrong.

That's the situation with most platform support.  NOMMU support hasn't
had very much attention since it was merged, and certainly there is very
little in the way of interest in running NOMMU on the existing platforms.
I think you're the first to publically amit to contemplating this.

> I've attached a patch (-p0) that adds an #ifdef to select between
> physical and virtual addresses for the 21285 chip, depending on
> CONFIG_MMU. I do not have a real EBSA285 to test this on, but this board
> does have a real 21285 and it is working for me.

Most 21285-based systems are the same, so provided it works for one, it
should work for all.  However, I don't particularly like needlessly
doubling up the _SIZE macros.  Can we get around this by having another
macro:

#ifdef CONFIG_MMU
#define MMU_IO(a,b)	(a)
#else
#define MMU_IO(a,b)	(b)
#endif

and then using this to define each _BASE macro?



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.139.1263304858.2170.linux-arm-kernel@lists.infradead.org>

the memory which the page tables live in, so we had to make the two
match - and it's not possible to change the TTB flags and the page
tables simultaneously, certainly not without turning the MMU off, doing
the modification and turning it back on again.

> We still have things like the SMP/nAMP mode which is Cortex-A9 and
> ARM11MPCore specific. There is also the TLB ops broadcasting bit in
> ACTLR which is also specific to ARM Ltd cores and some of these bits
> may not be accessible directly if you run in non-secure mode.

If you're running in non-secure mode and the parts of the system you
don't have access to haven't already been setup, you're running in a
crippled environment - so this isn't really an argument.

> > It strikes me that things are just becoming excessively complicated with
> > these seemingly "catch-22" issues.  Maybe a totally different approach is
> > needed - such as requiring some of this low level setup to be done by the
> > platform's boot loader?
> 
> Ideally, yes, it would be nice if these were done by the boot loader. We
> would have to define some clear requirements or at least saying that
> Linux only touches the architectured registers and not the
> implementation defined ones. But I'm not sure how feasible this would
> be.

Unless we do something like this, we're going to end up with lots of
bits of additional platform specific non-conditional assembly in the
early kernel boot path.

That stands in the way of having the kernel bootable on different
platforms, supporting the device tree code, and makes debugging harder
(the "why doesn't my kernel boot" problem.)

> There is also the CPU hotplug case where CPUs come back via the setup
> function and may need to touch bits like SMP/nAMP. This should work
> together with a boot monitor.

How does the CPU get back to the setup function?  Is the hardware aware
of the address of our setup function?  I don't think so, so I don't buy
this argument.

If the CPU is reset (eg, because power has been removed), it's going to
want to start executing from the reset vector - which means it will come
back to us via the boot loader.

The only case where it may not is when the power has not been removed and
we're doing something along the lines of the hotplug code in Realview,
where we just put the "unplugged" CPUs into a wait-loop, but maintaining
all of their context.  When the CPU is "re-plugged" we manually jump back
to the C entry point for secondary processors directly, resetting the
stack as we go.  We don't re-call the CPU specific initialization again.


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.140.1263314574.2170.linux-arm-kernel@lists.infradead.org>

v7.  The only problem areas I'd forsee are with Thumb-2 and DMA coherent
memory.


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.141.1263340236.2170.linux-arm-kernel@lists.infradead.org>

the bus clock, and use named clocks only for extra clocks it may need
such as a codec clock for an audio device. I belive this is what Russell's
initial complaint about the implementation is.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.150.1263460579.2170.linux-arm-kernel@lists.infradead.org>

function calls or static data being indirected through the GOT table,
which means it has to be relocated along side the data segment - which
makes the offset between the text and data segments fixed.

I would not believe that the "problems" have gone because the toolchain
is working how it's supposed to.

The -Dstatic= stays.


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.154.1263841498.2170.linux-arm-kernel@lists.infradead.org>

MC13783_REG_POWERMISC_PWGTSPI_M as I don't understand it's purpose
without going through mc13783_reg_rmw_powermisc (which I didn't do yet).

What is the base for your patch?  (Hm, it seems next could work.
mc13783-regulator seems to have gotten some more #defines ending in _M.
You seem to mean "mask".  IMHO it's a bit unfortunate, because the
nameing scheme doesn't match the already existing names :-()

Shouldn't mc13783_state_powermisc_pwgt be a per-device variable instead
of a static variable?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.155.1264005392.2170.linux-arm-kernel@lists.infradead.org>

about 10 32-bit registers giving detailed information about various
aspects of the CPU - including five 32-bit registers for details about
the instruction set.

We know that some of the meanings of these registers has changed their
meaning - and I don't think there's a way to identify which meaning
should be applied to the registers (it seems to require reading lots
of different documents to sort out what CPUs implement which method.)

Frankly, it's a mess, and when you look at implementations, it turns out
to be unreliable.

> On ARM, it would be great to have a simple set of features in
> /proc/cpuinfo indicating which instruction sets are available (and
> reliable).

I think you've living in a dream world there.


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.171.1264421114.2170.linux-arm-kernel@lists.infradead.org>

1. the VIC initialization
2. the sdhci drive strength
3. the presence of a second i2c port
4. the CLKDIV0_ARM_MASK

The rest of the non-board support code is identical in those two
directories.

> It does however mean that mach-s3c6400 and mach-s3c6410 are not heavily
> populated with machines, especially as the intended new Openmoko device
> never appeared.

Given the above, and the "mass population" hasn't happened, maybe part
of the solution to the duplicated header file problem is to start
combining some of these directories?


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.173.1264494735.2170.linux-arm-kernel@lists.infradead.org>

the arch/arm/mach-s5pc100/cpu.c file. The s5pc100-clock.c should be
moved into arch/arm/mach-s5pc100/ as well.

Not sure yet what to do with the rest.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.179.1264671273.2170.linux-arm-kernel@lists.infradead.org>

platforms would make more sense.

I suspect that IRQF_VALID is something left behind from the times
before CONFIG_GENERIC_HARDIRQS. My not-so-qualified guess is that
IRQF_VALID was used to disallow request_irq() on irqs that lacked chip
backing.

Today IRQ_NOREQUEST seems to be used for chained interrupt handlers.
The check in request_threaded_irq() returns -EINVAL if IRQ_NOREQUEST
is set. This covers request_irq(), but setup_irq() is lacking a check.
Maybe this is done intentionally, or perhaps it's something I should
fix?

If the purpose with IRQF_VALID is to guard against
request_irq()/setup_irq() on irqs lacking chip backing, then good news
is that the CONFIG_GENERIC_HARDIRQ already has code to handle this for
us. Basically, the default in irq_desc_init makes use of &no_irq_chip.
And the __setup_irq() code is already checking against irqs mapped to
&no_irq_chip, those are disallowed with a -ENOSYS.

Is there any point in keeping IRQF_VALID on ARM, or shall I submit a
patch to clean things up?

Thanks,

/ magnus


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.180.1264719611.2170.linux-arm-kernel@lists.infradead.org>

The mask and ID pattern for older ARM IDs in the kernel
decompressor matches the CPU ID for Scorpion, causing the
v7 caching routines not to be run and kernel decompression
to take significantly longer.

This new mask from Russell should match only ARM v2/v3 CPU's.

Cc: Steve Muckle <smuckle@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/boot/compressed/head.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 4fddc50..07e7bcc 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -628,8 +628,8 @@ proc_types:
 @		b	__arm6_mmu_cache_off
 @		b	__armv3_mmu_cache_flush
 
-		.word	0x00000000		@ old ARM ID
-		.word	0x0000f000
+		.word	0x41000000		@ old ARM ID
+		.word	0xff00f000
 		mov	pc, lr
  THUMB(		nop				)
 		mov	pc, lr
-- 
1.6.3.3



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.200.1265637102.2170.linux-arm-kernel@lists.infradead.org>

corner cases to be dealt with.  I don't remember what they were
off hand though.


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.214.1266451369.2170.linux-arm-kernel@lists.infradead.org>

Building without CONFIG_CPU_IDLE or CONFIG_PM causes build to fail if
cpu idle parameters are tried to pass using omap3_pm_init_cpuidle
function.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   20 +++++++
 arch/arm/mach-omap2/cpuidle34xx.c   |  105 ++++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/pm.h            |   15 +++++
 3 files changed, 119 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5adef51..99f295e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -46,6 +46,7 @@
 #include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
+#include "pm.h"
 
 #define CONFIG_DISABLE_HFCLK 1
 
@@ -57,6 +58,24 @@
 
 #define TWL4030_MSECURE_GPIO 22
 
+/* FIXME: These values need to be updated based on more profiling on 3430sdp*/
+static struct cpuidle_params omap3_cpuidle_params_table[] = {
+	/* C1 */
+	{2, 2, 5},
+	/* C2 */
+	{10, 10, 30},
+	/* C3 */
+	{50, 50, 300},
+	/* C4 */
+	{1500, 1800, 4000},
+	/* C5 */
+	{2500, 7500, 12000},
+	/* C6 */
+	{3000, 8500, 15000},
+	/* C7 */
+	{10000, 30000, 300000},
+};
+
 static int board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -307,6 +326,7 @@ static void __init omap_3430sdp_init_irq(void)
 {
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
+	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index ff1ad3d..597148e 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -62,6 +62,30 @@ struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
 struct omap3_processor_cx current_cx_state;
 struct powerdomain *mpu_pd, *core_pd;
 
+/*
+ * The latencies/thresholds for various C states have
+ * to be configured from the respective board files.
+ * These are some default values (which might not provide
+ * the best power savings) used on boards which do not
+ * pass these details from the board file.
+ */
+static struct cpuidle_params cpuidle_params_table[] = {
+	/* C1 */
+	{2, 2, 5},
+	/* C2 */
+	{10, 10, 30},
+	/* C3 */
+	{50, 50, 300},
+	/* C4 */
+	{1500, 1800, 4000},
+	/* C5 */
+	{2500, 7500, 12000},
+	/* C6 */
+	{3000, 8500, 15000},
+	/* C7 */
+	{10000, 30000, 300000},
+};
+
 static int omap3_idle_bm_check(void)
 {
 	if (!omap3_can_sleep())
@@ -245,6 +269,24 @@ void omap3_cpuidle_update_states(void)
 	}
 }
 
+void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
+{
+	int i;
+
+	if (!cpuidle_board_params)
+		return;
+
+	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
+		cpuidle_params_table[i].sleep_latency =
+			cpuidle_board_params[i].sleep_latency;
+		cpuidle_params_table[i].wake_latency =
+			cpuidle_board_params[i].wake_latency;
+		cpuidle_params_table[i].threshold =
+			cpuidle_board_params[i].threshold;
+	}
+	return;
+}
+
 /* omap3_init_power_states - Initialises the OMAP3 specific C states.
  *
  * Below is the desciption of each C state.
@@ -261,9 +303,12 @@ void omap_init_power_states(void)
 	/* C1 . MPU WFI + Core active */
 	omap3_power_states[OMAP3_STATE_C1].valid = 1;
 	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
-	omap3_power_states[OMAP3_STATE_C1].sleep_latency = 2;
-	omap3_power_states[OMAP3_STATE_C1].wakeup_latency = 2;
-	omap3_power_states[OMAP3_STATE_C1].threshold = 5;
+	omap3_power_states[OMAP3_STATE_C1].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C1].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C1].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C1].wake_latency;
+	omap3_power_states[OMAP3_STATE_C1].threshold =
+			cpuidle_params_table[OMAP3_STATE_C1].threshold;
 	omap3_power_states[OMAP3_STATE_C1].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C1].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID;
@@ -271,9 +316,12 @@ void omap_init_power_states(void)
 	/* C2 . MPU WFI + Core inactive */
 	omap3_power_states[OMAP3_STATE_C2].valid = 1;
 	omap3_power_states[OMAP3_STATE_C2].type = OMAP3_STATE_C2;
-	omap3_power_states[OMAP3_STATE_C2].sleep_latency = 10;
-	omap3_power_states[OMAP3_STATE_C2].wakeup_latency = 10;
-	omap3_power_states[OMAP3_STATE_C2].threshold = 30;
+	omap3_power_states[OMAP3_STATE_C2].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C2].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C2].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C2].wake_latency;
+	omap3_power_states[OMAP3_STATE_C2].threshold =
+			cpuidle_params_table[OMAP3_STATE_C2].threshold;
 	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
@@ -281,9 +329,12 @@ void omap_init_power_states(void)
 	/* C3 . MPU CSWR + Core inactive */
 	omap3_power_states[OMAP3_STATE_C3].valid = 1;
 	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
-	omap3_power_states[OMAP3_STATE_C3].sleep_latency = 50;
-	omap3_power_states[OMAP3_STATE_C3].wakeup_latency = 50;
-	omap3_power_states[OMAP3_STATE_C3].threshold = 300;
+	omap3_power_states[OMAP3_STATE_C3].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C3].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C3].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C3].wake_latency;
+	omap3_power_states[OMAP3_STATE_C3].threshold =
+			cpuidle_params_table[OMAP3_STATE_C3].threshold;
 	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -292,9 +343,12 @@ void omap_init_power_states(void)
 	/* C4 . MPU OFF + Core inactive */
 	omap3_power_states[OMAP3_STATE_C4].valid = 1;
 	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
-	omap3_power_states[OMAP3_STATE_C4].sleep_latency = 1500;
-	omap3_power_states[OMAP3_STATE_C4].wakeup_latency = 1800;
-	omap3_power_states[OMAP3_STATE_C4].threshold = 4000;
+	omap3_power_states[OMAP3_STATE_C4].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C4].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C4].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C4].wake_latency;
+	omap3_power_states[OMAP3_STATE_C4].threshold =
+			cpuidle_params_table[OMAP3_STATE_C4].threshold;
 	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C4].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -303,9 +357,12 @@ void omap_init_power_states(void)
 	/* C5 . MPU CSWR + Core CSWR*/
 	omap3_power_states[OMAP3_STATE_C5].valid = 1;
 	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
-	omap3_power_states[OMAP3_STATE_C5].sleep_latency = 2500;
-	omap3_power_states[OMAP3_STATE_C5].wakeup_latency = 7500;
-	omap3_power_states[OMAP3_STATE_C5].threshold = 12000;
+	omap3_power_states[OMAP3_STATE_C5].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C5].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C5].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C5].wake_latency;
+	omap3_power_states[OMAP3_STATE_C5].threshold =
+			cpuidle_params_table[OMAP3_STATE_C5].threshold;
 	omap3_power_states[OMAP3_STATE_C5].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C5].core_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C5].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -314,9 +371,12 @@ void omap_init_power_states(void)
 	/* C6 . MPU OFF + Core CSWR */
 	omap3_power_states[OMAP3_STATE_C6].valid = 1;
 	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
-	omap3_power_states[OMAP3_STATE_C6].sleep_latency = 3000;
-	omap3_power_states[OMAP3_STATE_C6].wakeup_latency = 8500;
-	omap3_power_states[OMAP3_STATE_C6].threshold = 15000;
+	omap3_power_states[OMAP3_STATE_C6].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C6].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C6].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C6].wake_latency;
+	omap3_power_states[OMAP3_STATE_C6].threshold =
+			cpuidle_params_table[OMAP3_STATE_C6].threshold;
 	omap3_power_states[OMAP3_STATE_C6].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C6].core_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C6].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -325,9 +385,12 @@ void omap_init_power_states(void)
 	/* C7 . MPU OFF + Core OFF */
 	omap3_power_states[OMAP3_STATE_C7].valid = 1;
 	omap3_power_states[OMAP3_STATE_C7].type = OMAP3_STATE_C7;
-	omap3_power_states[OMAP3_STATE_C7].sleep_latency = 10000;
-	omap3_power_states[OMAP3_STATE_C7].wakeup_latency = 30000;
-	omap3_power_states[OMAP3_STATE_C7].threshold = 300000;
+	omap3_power_states[OMAP3_STATE_C7].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C7].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C7].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C7].wake_latency;
+	omap3_power_states[OMAP3_STATE_C7].threshold =
+			cpuidle_params_table[OMAP3_STATE_C7].threshold;
 	omap3_power_states[OMAP3_STATE_C7].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C7].flags = CPUIDLE_FLAG_TIME_VALID |
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 09c0144..58a2671 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -23,6 +23,21 @@ extern int omap3_can_sleep(void);
 extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
 
+struct cpuidle_params {
+	u32 sleep_latency;
+	u32 wake_latency;
+	u32 threshold;
+};
+
+#if defined(CONFIG_PM) && defined(CONFIG_CPU_IDLE)
+extern void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params);
+#else
+static
+inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
+{
+}
+#endif
+
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
-- 
1.6.6



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.221.1266483193.2170.linux-arm-kernel@lists.infradead.org>

because of few dependencies. The auto-generated dma and irq headers are
included as per comments.

The series is boot tested on omap4430 and omap4430 sdp's with multi-omap
and regular defconfig builds.


The following changes since commit 80c20d543d142ee54ec85259b77aaf0b83c32db5=
:
  Tony Lindgren (1):
        Merge branch 'omap-fixes-for-linus' into omap-for-linus

Santosh Shilimkar (9):
      omap3/4: uart: fix full-fifo write abort
      omap2/3/4: ioremap omap_globals module
      omap4: sdma: Enable the idle modes on omap4
      omap: sdma: Limit the secure reserve channel fix for omap3
      omap4: Fix omap_type() for omap4
      omap3/4: Remove overlapping mapping of L4_WKUP io space
      omap4: Add auto-generated irq and dma headers
      omap4: Use dma line defines from dma-44xx.h
      omap4: Use irq line defines from irq-44xx.h

 arch/arm/mach-omap2/control.c                |    6 +-
 arch/arm/mach-omap2/devices.c                |    8 +-
 arch/arm/mach-omap2/id.c                     |    2 +
 arch/arm/mach-omap2/include/mach/irqs-44xx.h |  144 ++++++++++++++++++++++=
+++
 arch/arm/mach-omap2/include/mach/irqs.h      |    1 +
 arch/arm/mach-omap2/io.c                     |   12 --
 arch/arm/mach-omap2/prcm.c                   |   16 +++-
 arch/arm/mach-omap2/sdrc.c                   |   11 ++-
 arch/arm/mach-omap2/serial.c                 |   31 +++++-
 arch/arm/mach-omap2/timer-mpu.c              |    2 +-
 arch/arm/plat-omap/common.c                  |   38 ++++----
 arch/arm/plat-omap/devices.c                 |    4 +-
 arch/arm/plat-omap/dma.c                     |    7 +-
 arch/arm/plat-omap/dmtimer.c                 |   24 ++--
 arch/arm/plat-omap/gpio.c                    |   12 +-
 arch/arm/plat-omap/include/plat/common.h     |   17 ++--
 arch/arm/plat-omap/include/plat/control.h    |    3 +
 arch/arm/plat-omap/include/plat/dma-44xx.h   |  145 ++++++++++++++++++++++=
++++
 arch/arm/plat-omap/include/plat/dma.h        |   86 +---------------
 arch/arm/plat-omap/include/plat/io.h         |    9 --
 arch/arm/plat-omap/include/plat/irqs.h       |   89 ----------------
 arch/arm/plat-omap/io.c                      |    4 -
 22 files changed, 411 insertions(+), 260 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/irqs-44xx.h
 create mode 100644 arch/arm/plat-omap/include/plat/dma-44xx.h

Regards,
Santosh



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.224.1267711647.2170.linux-arm-kernel@lists.infradead.org>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D4 face=3D"Times New Roman"><span lang=3DEN-US =
style=3D'font-size:15.0pt'>Question:
How does hardware know which part of binary program in memory should =
loaded
into Icache/Dcache?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D4 face=3D"Times New Roman"><span lang=3DEN-US =
style=3D'font-size:15.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D4
face=3D"Times New Roman"><span lang=3DEN-US =
style=3D'font-size:15.0pt'>Rocky<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0004_01CAB6F5.3376D8F0--



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.225.1267786035.2170.linux-arm-kernel@lists.infradead.org>

this should rather be MACH_VEXPRESS_CA9X4. What is the reason
for having ARCH_ here?

Otherwise, Tested-By: Albin Tonnerre <albin.tonnerre@gmail.com>


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.232.1268242523.2170.linux-arm-kernel@lists.infradead.org>

on anything without V6K extensions.  I think that the byte and word
versions are supported on V6 and up though.

That'd make both __cmpxchg and __xchg slightly buggy, in different ways.

What it does mean is that atomic operations on unsigned shorts using
ldrex/strex will only be possible on V6K and up.


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.253.1269024023.2170.linux-arm-kernel@lists.infradead.org>

to continue with it.


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.258.1269191859.2170.linux-arm-kernel@lists.infradead.org>

    Sometimes you need to make an `asm' operand be a specific register,
    but there's no matching constraint letter for that register _by
    itself_.  To force the operand into that register, use a local variable
    for the operand and specify the register in the variable declaration.
    *Note Explicit Reg Vars::.  Then for the `asm' operand, use any
    register constraint letter that matches the register:

         register int *p1 asm ("r0") = ...;
         register int *p2 asm ("r1") = ...;
         register int *result asm ("r0");
         asm ("sysint" : "=r" (result) : "0" (p1), "r" (p2));

Fwiw, that note is present in GCC-4.0.1, but not GCC-3.3.6.  But we've
depended on that behaviour for a long time.

Note that we've depended on GCC not copying values with a dereferenced
memory location for a long time too: E.g. "+m" (*ptr) is used a lot in
spinlocks.

I'm sure I've read email confirmation (on these very lists) that GCC
will always work with a memory constraint used in that way, without
copying the value to/from a different location such as a stack slot.

But suprisingly, the GCC documentation says:

    Extended asm supports input-output or read-write operands.  Use
    the constraint character `+' to indicate such an operand and list
    it with the output operands.  You should only use read-write
    operands when the constraints for the operand (or the operand in
    which only some of the bits are to be changed) allow a register.
                                                   ^^^^^^^^^^^^^^^^

Maybe we're relying on undefined GCC behaviour for the "+m" constraint?

> See the __asmeq() macro in <asm/system.h> for a dirty hack which will
> check which registers are used and abort at compile time, although your
> compilation is going to fail anyway so I'm not sure it makes much of a
> difference in this particular case.
> 
> The real fix here is to add an asm constraint to GCC which allows you to
> specify "any even GPR" (or whatever's most suitable for the ldrd
> instruction). Being able to give specific registers, like you can on
> other architectures, would be useful too.

See above GCC documentation for using register variables to designate
specific registers.  Many supported architectures don't have asm
letter constraints for each register - hence so many of the old
_syscallN macros in <asm/unistd.h> having to use register variables.

I am surprised GCC doesn't have a constraint for "any even register
suitable for ldrd" on ARM, but I've just checked gcc-4.4.3 and it doesn't.

However, if I'm reading the source correctly, if not compiling for
Thumb-1, and GCC believes the target machine supports ldrd, then all
doubleword values are constrained to an even register pair anyway.
That's why GCC itself does not need an even-register constraint letter.

...Which is I guess why it throws up only with OABI, or with pre-arm5e
archs: GCC doesn't consider OABI targets to support ldrd.  (It's
actually some more obscure condition, let's not go there).

Something else from the lovely GCC source:

    mfix-cortex-m3-ldrd
    Target Report Var(fix_cm3_ldrd) Init(2)
    Avoid overlapping destination and address registers on LDRD instructions
    that may trigger Cortex-M3 errata.

In other words, the "=&" earlyclobber *is* needed on Cortex-M3.

Enjoy!
-- Jamie


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.272.1269522643.2170.linux-arm-kernel@lists.infradead.org>

second read was not ready. If this delay is adequate for the worst
case propagate time it takes for the bits to change, it is not
needed to read the register more than twice. I determined this
experimentally by reading the register 3 times right after write
and comparing the  2nd and 3rd read when doing different transfers
between PC and ARM. As I have tested it only on 9261, somebody should
either run the same kind of tests on other SoC's as well or figure
out the worst case timings on all of them.
The datasheet describes that some changes are performed in
3 USB clock + 3 master clock periods. If so, then one/some extra reads
could create the master-clock dependant small delay needed to
be sure that everything is ready.

Actually, this leads to a another problem. We are able to read the
rx fifo count when the bits are changing there. If some data is being
received at the very moment when we read the register, we're in
trouble. When some bits are old and some new, we can get values that
are larger or smaller than the actual value (ie 0111->1000 change).
This is a rare condition, but it might happen. Should this register
be read always twice to check that nothing was unstable during the
first read?

I would still leave in this extra read because it is known to be
unstable. If it is needed on some SoC's, we could read out the
register value until we get 2 same results to verify that it is
stable. But there is no point of reading the first (known bad) value.

-- 
Anti Sullin
Embedded Software Engineer
Artec Design LLC
Teaduspargi 6/2, 12618, Tallinn, Estonia
http://www.artecdesign.ee 



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.273.1269547685.2170.linux-arm-kernel@lists.infradead.org>

This patch introduces support for the tcc platform by creating an
arch/arm/plat-tcc and arch/arm/mach-tcc8k directories and adding
basic include files plus Kconfig and Makefile.

Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
---
 arch/arm/Kconfig                             |   11 +
 arch/arm/Makefile                            |    2 +
 arch/arm/mach-tcc8k/Kconfig                  |    5 +
 arch/arm/plat-tcc/Kconfig                    |   20 +
 arch/arm/plat-tcc/Makefile                   |    3 +
 arch/arm/plat-tcc/include/mach/debug-macro.S |   33 +
 arch/arm/plat-tcc/include/mach/entry-macro.S |   69 ++
 arch/arm/plat-tcc/include/mach/hardware.h    |   43 ++
 arch/arm/plat-tcc/include/mach/memory.h      |   29 +
 arch/arm/plat-tcc/include/mach/system.h      |   31 +
 arch/arm/plat-tcc/include/mach/tcc8k-regs.h  |  855 ++++++++++++++++++++++++++
 arch/arm/plat-tcc/include/mach/uncompress.h  |   32 +
 arch/arm/plat-tcc/include/mach/vmalloc.h     |   11 +
 arch/arm/plat-tcc/system.c                   |   24 +
 14 files changed, 1168 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tcc8k/Kconfig
 create mode 100644 arch/arm/plat-tcc/Kconfig
 create mode 100644 arch/arm/plat-tcc/Makefile
 create mode 100644 arch/arm/plat-tcc/include/mach/debug-macro.S
 create mode 100644 arch/arm/plat-tcc/include/mach/entry-macro.S
 create mode 100644 arch/arm/plat-tcc/include/mach/hardware.h
 create mode 100644 arch/arm/plat-tcc/include/mach/memory.h
 create mode 100644 arch/arm/plat-tcc/include/mach/system.h
 create mode 100644 arch/arm/plat-tcc/include/mach/tcc8k-regs.h
 create mode 100644 arch/arm/plat-tcc/include/mach/uncompress.h
 create mode 100644 arch/arm/plat-tcc/include/mach/vmalloc.h
 create mode 100644 arch/arm/plat-tcc/system.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c5408bf..8b9429c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -723,6 +723,15 @@ config ARCH_SHARK
 	  Support for the StrongARM based Digital DNARD machine, also known
 	  as "Shark" (<http://www.shark-linux.de/shark.html>).
 
+config ARCH_TCC_926
+	bool "Telechips TCC ARM926-based systems"
+	select CPU_ARM926T
+	select HAVE_CLK
+	select COMMON_CLKDEV
+	select GENERIC_CLOCKEVENTS
+	help
+	  Support for Telechips TCC ARM926-based systems.
+
 config ARCH_LH7A40X
 	bool "Sharp LH7A40X"
 	select CPU_ARM922T
@@ -887,6 +896,8 @@ source "arch/arm/plat-s3c24xx/Kconfig"
 source "arch/arm/plat-s5p/Kconfig"
 source "arch/arm/plat-s5pc1xx/Kconfig"
 
+source "arch/arm/plat-tcc/Kconfig"
+
 if ARCH_S3C2410
 source "arch/arm/mach-s3c2400/Kconfig"
 source "arch/arm/mach-s3c2410/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ed820e7..9656799 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -172,6 +172,7 @@ machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	:= shmobile
 machine-$(CONFIG_ARCH_STMP378X)		:= stmp378x
 machine-$(CONFIG_ARCH_STMP37XX)		:= stmp37xx
+machine-$(CONFIG_ARCH_TCC8K)		:= tcc8k
 machine-$(CONFIG_ARCH_U300)		:= u300
 machine-$(CONFIG_ARCH_U8500)		:= ux500
 machine-$(CONFIG_ARCH_VERSATILE)	:= versatile
@@ -192,6 +193,7 @@ plat-$(CONFIG_PLAT_PXA)		:= pxa
 plat-$(CONFIG_PLAT_S3C24XX)	:= s3c24xx samsung
 plat-$(CONFIG_PLAT_S5PC1XX)	:= s5pc1xx samsung
 plat-$(CONFIG_PLAT_S5P)		:= s5p samsung
+plat-$(CONFIG_ARCH_TCC_926)	:= tcc
 
 ifeq ($(CONFIG_ARCH_EBSA110),y)
 # This is what happens if you forget the IOCS16 line.
diff --git a/arch/arm/mach-tcc8k/Kconfig b/arch/arm/mach-tcc8k/Kconfig
new file mode 100644
index 0000000..ec7f71b
--- /dev/null
+++ b/arch/arm/mach-tcc8k/Kconfig
@@ -0,0 +1,5 @@
+if ARCH_TCC8K
+
+comment "TCC8000 systems:"
+
+endif
diff --git a/arch/arm/plat-tcc/Kconfig b/arch/arm/plat-tcc/Kconfig
new file mode 100644
index 0000000..1bf4995
--- /dev/null
+++ b/arch/arm/plat-tcc/Kconfig
@@ -0,0 +1,20 @@
+if ARCH_TCC_926
+
+menu "Telechips ARM926-based CPUs"
+
+choice
+	prompt "Telechips CPU type:"
+	default ARCH_TCC8K
+
+config ARCH_TCC8K
+	bool TCC8000
+	select USB_ARCH_HAS_OHCI
+	help
+	  Support for Telechips TCC8000 systems
+
+endchoice
+
+source "arch/arm/mach-tcc8k/Kconfig"
+
+endmenu
+endif
diff --git a/arch/arm/plat-tcc/Makefile b/arch/arm/plat-tcc/Makefile
new file mode 100644
index 0000000..3f2e4fe
--- /dev/null
+++ b/arch/arm/plat-tcc/Makefile
@@ -0,0 +1,3 @@
+# "Telechips Platform Common Modules"
+
+obj-y := system.o
diff --git a/arch/arm/plat-tcc/include/mach/debug-macro.S b/arch/arm/plat-tcc/include/mach/debug-macro.S
new file mode 100644
index 0000000..9753784
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/debug-macro.S
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 1994-1999 Russell King
+ * Copyright (C) 2008-2009 Telechips
+ * Copyright (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+		.macro	addruart,rx,tmp
+		mrc	p15, 0, \rx, c1, c0
+		tst	\rx, #1			@ MMU enabled?
+		moveq	\rx, #0x90000000	@ physical base address
+		movne	\rx, #0xF1000000	@ virtual base
+		orr	\rx, \rx, #0x00007000	@ UART0
+		.endm
+
+		.macro	senduart,rd,rx
+		strb	\rd, [\rx, #0x44]
+		.endm
+
+		.macro	waituart,rd,rx
+		.endm
+
+		.macro	busyuart,rd,rx
+1001:
+		ldr \rd, [\rx, #0x14]
+		tst \rd, #0x20
+
+		beq 1001b
+		.endm
diff --git a/arch/arm/plat-tcc/include/mach/entry-macro.S b/arch/arm/plat-tcc/include/mach/entry-macro.S
new file mode 100644
index 0000000..6099b6a
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/entry-macro.S
@@ -0,0 +1,69 @@
+/*
+ * include/asm-arm/arch-tcc83x/entry-macro.S
+ *
+ * Author : <linux@telechips.com>
+ * Created: June 10, 2008
+ * Description: Low-level IRQ helper macros for Telechips-based platforms
+ *
+ * Copyright (C) 2008-2009 Telechips
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+
+	.macro	disable_fiq
+	.endm
+
+	.macro  get_irqnr_preamble, base, tmp
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
+
+	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+
+		ldr	\base, =0xF2003000 @ base address of PIC registers
+
+		@@ read MREQ register of PIC0
+
+		mov	\irqnr, #0
+		ldr	\irqstat, [\base, #0x00000014 ]	@ lower 32 interrupts
+		cmp	\irqstat, #0
+		bne	1001f
+
+		@@ read MREQ register of PIC1
+
+		ldr	\irqstat, [\base, #0x00000094]	@ upper 32 interrupts
+		cmp	\irqstat, #0
+		beq	1002f
+		mov	\irqnr, #0x20
+
+1001:
+		movs	\tmp, \irqstat, lsl #16
+		movne	\irqstat, \tmp
+		addeq	\irqnr, \irqnr, #16
+
+		movs	\tmp, \irqstat, lsl #8
+		movne	\irqstat, \tmp
+		addeq	\irqnr, \irqnr, #8
+
+		movs	\tmp, \irqstat, lsl #4
+		movne	\irqstat, \tmp
+		addeq	\irqnr, \irqnr, #4
+
+		movs	\tmp, \irqstat, lsl #2
+		movne	\irqstat, \tmp
+		addeq	\irqnr, \irqnr, #2
+
+		movs	\tmp, \irqstat, lsl #1
+		addeq	\irqnr, \irqnr, #1
+		orrs	\base, \base, #1
+1002:
+		@@ exit here, Z flag unset if IRQ
+
+	.endm
+
diff --git a/arch/arm/plat-tcc/include/mach/hardware.h b/arch/arm/plat-tcc/include/mach/hardware.h
new file mode 100644
index 0000000..e70d126
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/hardware.h
@@ -0,0 +1,43 @@
+/*
+ * Author: RidgeRun, Inc. Greg Lonnon <glonnon@ridgerun.com>
+ * Reorganized for Linux-2.6 by Tony Lindgren <tony@atomide.com>
+ *                          and Dirk Behme <dirk.behme@de.bosch.com>
+ * Rewritten by:    <linux@telechips.com>
+ * Description: Hardware definitions for TCC8300 processors and boards
+ *
+ * Copyright (C) 2001 RidgeRun, Inc.
+ * Copyright (C) 2008-2009 Telechips
+ *
+ * Modifications for mainline (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GNU Pulic License version 2.
+ */
+
+#ifndef __ASM_ARCH_TCC_HARDWARE_H
+#define __ASM_ARCH_TCC_HARDWARE_H
+
+#include <asm/sizes.h>
+#ifndef __ASSEMBLER__
+#include <asm/types.h>
+#endif
+#include <mach/io.h>
+
+/*
+ * ----------------------------------------------------------------------------
+ * Clocks
+ * ----------------------------------------------------------------------------
+ */
+#define CLKGEN_REG_BASE		0xfffece00
+#define ARM_CKCTL		(CLKGEN_REG_BASE + 0x0)
+#define ARM_IDLECT1		(CLKGEN_REG_BASE + 0x4)
+#define ARM_IDLECT2		(CLKGEN_REG_BASE + 0x8)
+#define ARM_EWUPCT		(CLKGEN_REG_BASE + 0xC)
+#define ARM_RSTCT1		(CLKGEN_REG_BASE + 0x10)
+#define ARM_RSTCT2		(CLKGEN_REG_BASE + 0x14)
+#define ARM_SYSST		(CLKGEN_REG_BASE + 0x18)
+#define ARM_IDLECT3		(CLKGEN_REG_BASE + 0x24)
+
+/* DPLL control registers */
+#define DPLL_CTL		0xfffecf00
+
+#endif	/* __ASM_ARCH_TCC_HARDWARE_H */
diff --git a/arch/arm/plat-tcc/include/mach/memory.h b/arch/arm/plat-tcc/include/mach/memory.h
new file mode 100644
index 0000000..3acc680
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/memory.h
@@ -0,0 +1,29 @@
+/*
+ * Based on:    linux/include/asm-arm/arch-intergrator/memory.h
+ * Author:  Greg Lonnon <glonnon@ridgerun.com>
+ * Rewritten by: <linux@telechips.com>
+ * Modified: June 10, 2008
+ * Description: Memory map for TCC8300
+ *
+ * Copyright (C) 1999 ARM Limited
+ * Copyright (C) 2000 RidgeRun, Inc.
+ * Copyright (C) 2008-2009 Telechips
+ *
+ * Licensed under the terms of the GPL v2.
+ */
+
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+/*
+ * Physical DRAM offset.
+ */
+#define PHYS_OFFSET		UL(0x20000000)
+
+#define __virt_to_bus(x)	__virt_to_phys(x)
+#define __bus_to_virt(x)	__phys_to_virt(x)
+#define __pfn_to_bus(x)		__pfn_to_phys(x)
+#define __bus_to_pfn(x)		__phys_to_pfn(x)
+
+#endif
+
diff --git a/arch/arm/plat-tcc/include/mach/system.h b/arch/arm/plat-tcc/include/mach/system.h
new file mode 100644
index 0000000..909e603
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/system.h
@@ -0,0 +1,31 @@
+/*
+ * Author: <linux@telechips.com>
+ * Created: June 10, 2008
+ * Description: LINUX SYSTEM FUNCTIONS for TCC83x
+ *
+ * Copyright (C) 2008-2009 Telechips
+ *
+ * Licensed under the terms of the GPL v2.
+ *
+ */
+
+#ifndef __ASM_ARCH_SYSTEM_H
+#define __ASM_ARCH_SYSTEM_H
+#include <linux/clk.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+
+extern void plat_tcc_reboot(void);
+
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	plat_tcc_reboot();
+}
+
+#endif
diff --git a/arch/arm/plat-tcc/include/mach/tcc8k-regs.h b/arch/arm/plat-tcc/include/mach/tcc8k-regs.h
new file mode 100644
index 0000000..67f866c
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/tcc8k-regs.h
@@ -0,0 +1,855 @@
+/*
+ * Telechips TCC8000 register definitions
+ *
+ * (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GPLv2.
+ */
+
+#ifndef TCC8K_REGS_H
+#define TCC8K_REGS_H
+
+#include <linux/types.h>
+
+#define EXT_SDRAM_BASE		0x20000000
+#define INT_SRAM_BASE		0x30000000
+#define INT_SRAM_SIZE		SZ_32K
+#define CS0_BASE		0x40000000
+#define CS1_BASE		0x50000000
+#define CS1_SIZE		SZ_64K
+#define CS2_BASE		0x60000000
+#define CS3_BASE		0x70000000
+#define AHB_PERI_BASE		0x80000000
+#define AHB_PERI_SIZE		SZ_64K
+#define APB0_PERI_BASE		0x90000000
+#define APB0_PERI_SIZE		SZ_128K
+#define APB1_PERI_BASE		0x98000000
+#define APB1_PERI_SIZE		SZ_128K
+#define DATA_TCM_BASE		0xa0000000
+#define DATA_TCM_SIZE		SZ_8K
+#define EXT_MEM_CTRL_BASE	0xf0000000
+#define EXT_MEM_CTRL_SIZE	SZ_4K
+
+#define CS1_BASE_VIRT		0xf7000000
+#define AHB_PERI_BASE_VIRT	0xf4000000
+#define APB0_PERI_BASE_VIRT	0xf1000000
+#define APB1_PERI_BASE_VIRT	0xf2000000
+#define EXT_MEM_CTRL_BASE_VIRT	0xf3000000
+#define INT_SRAM_BASE_VIRT	0xf5000000
+#define DATA_TCM_BASE_VIRT	0xf6000000
+
+#define __REG(x)     (*((volatile u32 *)(x)))
+
+/* USB Device Controller Registers */
+#define UDC_BASE	(AHB_PERI_BASE_VIRT + 0x8000)
+#define UDC_BASE_PHYS	(AHB_PERI_BASE + 0x8000)
+
+#define UDC_IR_OFFS		0x00
+#define UDC_EIR_OFFS		0x04
+#define UDC_EIER_OFFS		0x08
+#define UDC_FAR_OFFS		0x0c
+#define UDC_FNR_OFFS		0x10
+#define UDC_EDR_OFFS		0x14
+#define UDC_RT_OFFS		0x18
+#define UDC_SSR_OFFS		0x1c
+#define UDC_SCR_OFFS		0x20
+#define UDC_EP0SR_OFFS		0x24
+#define UDC_EP0CR_OFFS		0x28
+
+#define UDC_ESR_OFFS		0x2c
+#define UDC_ECR_OFFS		0x30
+#define UDC_BRCR_OFFS		0x34
+#define UDC_BWCR_OFFS		0x38
+#define UDC_MPR_OFFS		0x3c
+#define UDC_DCR_OFFS		0x40
+#define UDC_DTCR_OFFS		0x44
+#define UDC_DFCR_OFFS		0x48
+#define UDC_DTTCR1_OFFS		0x4c
+#define UDC_DTTCR2_OFFS		0x50
+#define UDC_ESR2_OFFS		0x54
+
+#define UDC_SCR2_OFFS		0x58
+#define UDC_EP0BUF_OFFS		0x60
+#define UDC_EP1BUF_OFFS		0x64
+#define UDC_EP2BUF_OFFS		0x68
+#define UDC_EP3BUF_OFFS		0x6c
+#define UDC_PLICR_OFFS		0xa0
+#define UDC_PCR_OFFS		0xa4
+
+#define UDC_UPCR0_OFFS		0xc8
+#define UDC_UPCR1_OFFS		0xcc
+#define UDC_UPCR2_OFFS		0xd0
+#define UDC_UPCR3_OFFS		0xd4
+
+/* Bits in UDC_EIR */
+#define UDC_EIR_EP0I		(1 << 0)
+#define UDC_EIR_EP1I		(1 << 1)
+#define UDC_EIR_EP2I		(1 << 2)
+#define UDC_EIR_EP3I		(1 << 3)
+#define UDC_EIR_EPI_MASK	0x0f
+
+/* Bits in UDC_EIER */
+#define UDC_EIER_EP0IE		(1 << 0)
+#define UDC_EIER_EP1IE		(1 << 1)
+#define UDC_EIER_EP2IE		(1 << 2)
+#define UDC_EIER_EP3IE		(1 << 3)
+
+/* Bits in UDC_FNR */
+#define UDC_FNR_FN_MASK		0x7ff
+#define UDC_FNR_SM		(1 << 13)
+#define UDC_FNR_FTL		(1 << 14)
+
+/* Bits in UDC_SSR */
+#define UDC_SSR_HFRES		(1 << 0)
+#define UDC_SSR_HFSUSP		(1 << 1)
+#define UDC_SSR_HFRM		(1 << 2)
+#define UDC_SSR_SDE		(1 << 3)
+#define UDC_SSR_HSP		(1 << 4)
+#define UDC_SSR_DM		(1 << 5)
+#define UDC_SSR_DP		(1 << 6)
+#define UDC_SSR_TBM		(1 << 7)
+#define UDC_SSR_VBON		(1 << 8)
+#define UDC_SSR_VBOFF		(1 << 9)
+#define UDC_SSR_EOERR		(1 << 10)
+#define UDC_SSR_DCERR		(1 << 11)
+#define UDC_SSR_TCERR		(1 << 12)
+#define UDC_SSR_BSERR		(1 << 13)
+#define UDC_SSR_TMERR		(1 << 14)
+#define UDC_SSR_BAERR		(1 << 15)
+
+/* Bits in UDC_SCR */
+#define UDC_SCR_HRESE		(1 << 0)
+#define UDC_SCR_HSSPE		(1 << 1)
+#define UDC_SCR_RRDE		(1 << 5)
+#define UDC_SCR_SPDEN		(1 << 6)
+#define UDC_SCR_DIEN		(1 << 12)
+
+/* Bits in UDC_EP0SR */
+#define UDC_EP0SR_RSR		(1 << 0)
+#define UDC_EP0SR_TST		(1 << 1)
+#define UDC_EP0SR_SHT		(1 << 4)
+#define UDC_EP0SR_LWO		(1 << 6)
+
+/* Bits in UDC_EP0CR */
+#define UDC_EP0CR_ESS		(1 << 1)
+
+/* Bits in UDC_ESR */
+#define UDC_ESR_RPS		(1 << 0)
+#define UDC_ESR_TPS		(1 << 1)
+#define UDC_ESR_LWO		(1 << 4)
+#define UDC_ESR_FFS		(1 << 6)
+
+/* Bits in UDC_ECR */
+#define UDC_ECR_ESS		(1 << 1)
+#define UDC_ECR_CDP		(1 << 2)
+
+#define UDC_ECR_FLUSH		(1 << 6)
+#define UDC_ECR_DUEN		(1 << 7)
+
+/* Bits in UDC_UPCR0 */
+#define UDC_UPCR0_VBD		(1 << 1)
+#define UDC_UPCR0_VBDS		(1 << 6)
+#define UDC_UPCR0_RCD_12	(0x0 << 9)
+#define UDC_UPCR0_RCD_24	(0x1 << 9)
+#define UDC_UPCR0_RCD_48	(0x2 << 9)
+#define UDC_UPCR0_RCS_EXT	(0x1 << 11)
+#define UDC_UPCR0_RCS_XTAL	(0x0 << 11)
+
+/* Bits in UDC_UPCR1 */
+#define UDC_UPCR1_CDT(x)	((x) << 0)
+#define UDC_UPCR1_OTGT(x)	((x) << 3)
+#define UDC_UPCR1_SQRXT(x)	((x) << 8)
+#define UDC_UPCR1_TXFSLST(x)	((x) << 12)
+
+/* Bits in UDC_UPCR2 */
+#define UDC_UPCR2_TP		(1 << 0)
+#define UDC_UPCR2_TXRT(x)	((x) << 2)
+#define UDC_UPCR2_TXVRT(x)	((x) << 5)
+#define UDC_UPCR2_OPMODE(x)	((x) << 9)
+#define UDC_UPCR2_XCVRSEL(x)	((x) << 12)
+#define UDC_UPCR2_TM		(1 << 14)
+
+/* USB Host Controller registers */
+#define USBH0_BASE	(AHB_PERI_BASE_VIRT + 0xb000)
+#define USBH1_BASE	(AHB_PERI_BASE_VIRT + 0xb800)
+
+#define OHCI_INT_ENABLE_OFFS	0x10
+
+#define RH_DESCRIPTOR_A_OFFS	0x48
+#define RH_DESCRIPTOR_B_OFFS	0x4c
+
+#define USBHTCFG0_OFFS		0x100
+#define USBHHCFG0_OFFS		0x104
+#define USBHHCFG1_OFFS		0x104
+
+/* DMA controller registers */
+#define DMAC0_BASE	(AHB_PERI_BASE + 0x4000)
+#define DMAC1_BASE	(AHB_PERI_BASE + 0xa000)
+#define DMAC2_BASE	(AHB_PERI_BASE + 0x4800)
+#define DMAC3_BASE	(AHB_PERI_BASE + 0xa800)
+
+#define DMAC_CH_OFFSET(ch)	(ch * 0x30)
+
+#define ST_SADR_OFFS		0x00
+#define SPARAM_OFFS		0x04
+#define C_SADR_OFFS		0x0c
+#define ST_DADR_OFFS		0x10
+#define DPARAM_OFFS		0x14
+#define C_DADR_OFFS		0x1c
+#define HCOUNT_OFFS		0x20
+#define CHCTRL_OFFS		0x24
+#define RPTCTRL_OFFS		0x28
+#define EXTREQ_A_OFFS		0x2c
+
+/* Bits in CHCTRL register */
+#define CHCTRL_EN		(1 << 0)
+
+#define CHCTRL_IEN		(1 << 2)
+#define CHCTRL_FLAG		(1 << 3)
+#define CHCTRL_WSIZE8		(0 << 4)
+#define CHCTRL_WSIZE16		(1 << 4)
+#define CHCTRL_WSIZE32		(2 << 4)
+
+#define CHCTRL_BSIZE1		(0 << 6)
+#define CHCTRL_BSIZE2		(1 << 6)
+#define CHCTRL_BSIZE4		(2 << 6)
+#define CHCTRL_BSIZE8		(3 << 6)
+
+#define CHCTRL_TYPE_SINGLE_E	(0 << 8)
+#define CHCTRL_TYPE_HW		(1 << 8)
+#define CHCTRL_TYPE_SW		(2 << 8)
+#define CHCTRL_TYPE_SINGLE_L	(3 << 8)
+
+#define CHCTRL_BST		(1 << 10)
+
+/* Use DMA controller 0, channel 2 for USB */
+#define USB_DMA_BASE		(DMAC0_BASE + DMAC_CH_OFFSET(2))
+
+/* NAND flash controller registers */
+#define NFC_BASE	(AHB_PERI_BASE_VIRT + 0xd000)
+#define NFC_BASE_PHYS	(AHB_PERI_BASE + 0xd000)
+
+#define NFC_CMD_OFFS		0x00
+#define NFC_LADDR_OFFS		0x04
+#define NFC_BADDR_OFFS		0x08
+#define NFC_SADDR_OFFS		0x0c
+#define NFC_WDATA_OFFS		0x10
+#define NFC_LDATA_OFFS		0x20
+#define NFC_SDATA_OFFS		0x40
+#define NFC_CTRL_OFFS		0x50
+#define NFC_PSTART_OFFS		0x54
+#define NFC_RSTART_OFFS		0x58
+#define NFC_DSIZE_OFFS		0x5c
+#define NFC_IREQ_OFFS		0x60
+#define NFC_RST_OFFS		0x64
+#define NFC_CTRL1_OFFS		0x68
+#define NFC_MDATA_OFFS		0x70
+
+#define NFC_WDATA_PHYS_ADDR	(NFC_BASE_PHYS + NFC_WDATA_OFFS)
+
+/* Bits in NFC_CTRL */
+#define NFC_CTRL_BHLD_MASK	(0xf << 0)
+#define NFC_CTRL_BPW_MASK	(0xf << 4)
+#define NFC_CTRL_BSTP_MASK	(0xf << 8)
+#define NFC_CTRL_CADDR_MASK	(0x7 << 12)
+#define NFC_CTRL_CADDR_1	(0x0 << 12)
+#define NFC_CTRL_CADDR_2	(0x1 << 12)
+#define NFC_CTRL_CADDR_3	(0x2 << 12)
+#define NFC_CTRL_CADDR_4	(0x3 << 12)
+#define NFC_CTRL_CADDR_5	(0x4 << 12)
+#define NFC_CTRL_MSK		(1 << 15)
+#define NFC_CTRL_PSIZE256	(0 << 16)
+#define NFC_CTRL_PSIZE512	(1 << 16)
+#define NFC_CTRL_PSIZE1024	(2 << 16)
+#define NFC_CTRL_PSIZE2048	(3 << 16)
+#define NFC_CTRL_PSIZE4096	(4 << 16)
+#define NFC_CTRL_PSIZE_MASK	(7 << 16)
+#define NFC_CTRL_BSIZE1		(0 << 19)
+#define NFC_CTRL_BSIZE2		(1 << 19)
+#define NFC_CTRL_BSIZE4		(2 << 19)
+#define NFC_CTRL_BSIZE8		(3 << 19)
+#define NFC_CTRL_BSIZE_MASK	(3 << 19)
+#define NFC_CTRL_RDY		(1 << 21)
+#define NFC_CTRL_CS0SEL		(1 << 22)
+#define NFC_CTRL_CS1SEL		(1 << 23)
+#define NFC_CTRL_CS2SEL		(1 << 24)
+#define NFC_CTRL_CS3SEL		(1 << 25)
+#define NFC_CTRL_CSMASK		(0xf << 22)
+#define NFC_CTRL_BW		(1 << 26)
+#define NFC_CTRL_FS		(1 << 27)
+#define NFC_CTRL_DEN		(1 << 28)
+#define NFC_CTRL_READ_IEN	(1 << 29)
+#define NFC_CTRL_PROG_IEN	(1 << 30)
+#define NFC_CTRL_RDY_IEN	(1 << 31)
+
+/* Bits in NFC_IREQ */
+#define NFC_IREQ_IRQ0		(1 << 0)
+#define NFC_IREQ_IRQ1		(1 << 1)
+#define NFC_IREQ_IRQ2		(1 << 2)
+
+#define NFC_IREQ_FLAG0		(1 << 4)
+#define NFC_IREQ_FLAG1		(1 << 5)
+#define NFC_IREQ_FLAG2		(1 << 6)
+
+/* MMC controller registers */
+#define MMC0_BASE	(AHB_PERI_BASE_VIRT + 0xe000)
+#define MMC1_BASE	(AHB_PERI_BASE_VIRT + 0xe800)
+
+/* UART registers */
+
+#define UART0_BASE	(APB0_PERI_BASE_VIRT + 0x07000)
+#define UART0_BASE_PHYS	(APB0_PERI_BASE + 0x07000)
+#define UART1_BASE	(APB0_PERI_BASE_VIRT + 0x08000)
+#define UART1_BASE_PHYS	(APB0_PERI_BASE + 0x08000)
+#define UART2_BASE	(APB0_PERI_BASE_VIRT + 0x09000)
+#define UART2_BASE_PHYS	(APB0_PERI_BASE + 0x09000)
+#define UART3_BASE	(APB0_PERI_BASE_VIRT + 0x0a000)
+#define UART3_BASE_PHYS	(APB0_PERI_BASE + 0x0a000)
+#define UART4_BASE	(APB0_PERI_BASE_VIRT + 0x15000)
+#define UART4_BASE_PHYS	(APB0_PERI_BASE + 0x15000)
+
+#define UART_BASE	UART0_BASE
+#define UART_BASE_PHYS	UART0_BASE_PHYS
+
+#define UART_RBR_OFFS		0x00
+#define UART_THR_OFFS		0x00
+#define UART_DLL_OFFS		0x00
+#define UART_IER_OFFS		0x04
+#define UART_DLM_OFFS		0x04
+#define UART_IIR_OFFS		0x08
+#define UART_FCR_OFFS		0x08
+#define UART_LCR_OFFS		0x0c
+#define UART_MCR_OFFS		0x10
+#define UART_LSR_OFFS		0x14
+#define UART_MSR_OFFS		0x18
+#define UART_SCR_OFFS		0x1c
+#define UART_AFT_OFFS		0x20
+#define UART_UCR_OFFS		0x24
+#define UART_SRBR_OFFS		0x40
+#define UART_STHR_OFFS		0x44
+#define UART_SDLL_OFFS		0x48
+#define UART_SDLM_OFFS		0x4c
+#define UART_SIER_OFFS		0x50
+#define UART_SCCR_OFFS		0x60
+#define UART_STC_OFFS		0x64
+#define UART_IRCFG_OFFS		0x80
+
+/* Bits in UART_LCR */
+#define UART_LCR_DLAB	(1 << 7)
+#define UART_LCR_SB	(1 << 6)
+#define UART_LCR_SP	(1 << 5)
+#define UART_LCR_EPS	(1 << 4)
+#define UART_LCR_PEN	(1 << 3)
+#define UART_LCR_STB	(1 << 2)
+#define UART_LCR_WLS_5	(0 << 0)
+#define UART_LCR_WLS_6	(1 << 0)
+#define UART_LCR_WLS_7	(2 << 0)
+#define UART_LCR_WLS_8	(3 << 0)
+
+/* Bits in UART_FCR */
+#define UART_FCR_RXT_1	(0 << 6)
+#define UART_FCR_RXT_4	(1 << 6)
+#define UART_FCR_RXT_8	(2 << 6)
+#define UART_FCR_RXT_14	(3 << 6)
+#define UART_FCR_TXT_16 (0 << 4)
+#define UART_FCR_TXT_8	(1 << 4)
+#define UART_FCR_TXT_4	(2 << 4)
+#define UART_FCR_TXT_1	(3 << 4)
+#define UART_FCR_DRTE	(1 << 3)
+#define UART_FCR_TXFR	(1 << 2)
+#define UART_FCR_RXFR	(1 << 1)
+#define UART_FCR_FE	(1 << 0)
+
+/* Bits in UART_LSR */
+#define UART_LSR_ERF	(1 << 7)
+#define UART_LSR_TEMT	(1 << 6)
+#define UART_LSR_THRE	(1 << 5)
+#define UART_LSR_BI	(1 << 4)
+#define UART_LSR_FE	(1 << 3)
+#define UART_LSR_PE	(1 << 2)
+#define UART_LSR_OE	(1 << 1)
+#define UART_LSR_DR	(1 << 0)
+
+/* ECC controller */
+#define ECC_CTR_BASE	(APB0_PERI_BASE_VIRT + 0xd000)
+
+#define ECC_CTRL_OFFS		0x00
+#define ECC_BASE_OFFS		0x04
+#define ECC_MASK_OFFS		0x08
+#define ECC_CLEAR_OFFS		0x0c
+#define ECC4_0_OFFS		0x10
+#define ECC4_1_OFFS		0x14
+
+#define ECC_EADDR0_OFFS		0x50
+
+#define ECC_ERRNUM_OFFS		0x90
+#define ECC_IREQ_OFFS		0x94
+
+/* Bits in ECC_CTRL */
+#define ECC_CTRL_ECC4_DIEN	(1 << 28)
+#define ECC_CTRL_ECC8_DIEN	(1 << 29)
+#define ECC_CTRL_ECC12_DIEN	(1 << 30)
+#define ECC_CTRL_ECC_DISABLE	0x0
+#define ECC_CTRL_ECC_SLC_ENC	0x8
+#define ECC_CTRL_ECC_SLC_DEC	0x9
+#define ECC_CTRL_ECC4_ENC	0xa
+#define ECC_CTRL_ECC4_DEC	0xb
+#define ECC_CTRL_ECC8_ENC	0xc
+#define ECC_CTRL_ECC8_DEC	0xd
+#define ECC_CTRL_ECC12_ENC	0xe
+#define ECC_CTRL_ECC12_DEC	0xf
+
+/* Bits in ECC_IREQ */
+#define ECC_IREQ_E4DI		(1 << 4)
+
+#define ECC_IREQ_E4DF		(1 << 20)
+#define ECC_IREQ_E4EF		(1 << 21)
+
+/* Interrupt controller */
+
+#define PIC0_BASE	(APB1_PERI_BASE_VIRT + 0x3000)
+#define PIC0_BASE_PHYS	(APB1_PERI_BASE + 0x3000)
+
+#define PIC0_IEN_OFFS		0x00
+#define PIC0_CREQ_OFFS		0x04
+#define PIC0_IREQ_OFFS		0x08
+#define PIC0_IRQSEL_OFFS	0x0c
+#define PIC0_SRC_OFFS		0x10
+#define PIC0_MREQ_OFFS		0x14
+#define PIC0_TSTREQ_OFFS	0x18
+#define PIC0_POL_OFFS		0x1c
+#define PIC0_IRQ_OFFS		0x20
+#define PIC0_FIQ_OFFS		0x24
+#define PIC0_MIRQ_OFFS		0x28
+#define PIC0_MFIQ_OFFS		0x2c
+#define PIC0_TMODE_OFFS		0x30
+#define PIC0_SYNC_OFFS		0x34
+#define PIC0_WKUP_OFFS		0x38
+#define PIC0_TMODEA_OFFS	0x3c
+#define PIC0_INTOEN_OFFS	0x40
+#define PIC0_MEN0_OFFS		0x44
+#define PIC0_MEN_OFFS		0x48
+
+#define PIC0_IEN		__REG(PIC0_BASE + PIC0_IEN_OFFS)
+#define PIC0_IEN_PHYS		__REG(PIC0_BASE_PHYS + PIC0_IEN_OFFS)
+#define PIC0_CREQ		__REG(PIC0_BASE + PIC0_CREQ_OFFS)
+#define PIC0_CREQ_PHYS		__REG(PIC0_BASE_PHYS + PIC0_CREQ_OFFS)
+#define PIC0_IREQ		__REG(PIC0_BASE + PIC0_IREQ_OFFS)
+#define PIC0_IRQSEL		__REG(PIC0_BASE + PIC0_IRQSEL_OFFS)
+#define PIC0_IRQSEL_PHYS	__REG(PIC0_BASE_PHYS + PIC0_IRQSEL_OFFS)
+#define PIC0_SRC		__REG(PIC0_BASE + PIC0_SRC_OFFS)
+#define PIC0_MREQ		__REG(PIC0_BASE + PIC0_MREQ_OFFS)
+#define PIC0_TSTREQ		__REG(PIC0_BASE + PIC0_TSTREQ_OFFS)
+#define PIC0_POL		__REG(PIC0_BASE + PIC0_POL_OFFS)
+#define PIC0_IRQ		__REG(PIC0_BASE + PIC0_IRQ_OFFS)
+#define PIC0_FIQ		__REG(PIC0_BASE + PIC0_FIQ_OFFS)
+#define PIC0_MIRQ		__REG(PIC0_BASE + PIC0_MIRQ_OFFS)
+#define PIC0_MFIQ		__REG(PIC0_BASE + PIC0_MFIQ_OFFS)
+#define PIC0_TMODE		__REG(PIC0_BASE + PIC0_TMODE_OFFS)
+#define PIC0_TMODE_PHYS		__REG(PIC0_BASE_PHYS + PIC0_TMODE_OFFS)
+#define PIC0_SYNC		__REG(PIC0_BASE + PIC0_SYNC_OFFS)
+#define PIC0_WKUP		__REG(PIC0_BASE + PIC0_WKUP_OFFS)
+#define PIC0_TMODEA		__REG(PIC0_BASE + PIC0_TMODEA_OFFS)
+#define PIC0_INTOEN		__REG(PIC0_BASE + PIC0_INTOEN_OFFS)
+#define PIC0_MEN0		__REG(PIC0_BASE + PIC0_MEN0_OFFS)
+#define PIC0_MEN		__REG(PIC0_BASE + PIC0_MEN_OFFS)
+
+#define PIC1_BASE	(APB1_PERI_BASE_VIRT + 0x3080)
+
+#define PIC1_IEN_OFFS		0x00
+#define PIC1_CREQ_OFFS		0x04
+#define PIC1_IREQ_OFFS		0x08
+#define PIC1_IRQSEL_OFFS	0x0c
+#define PIC1_SRC_OFFS		0x10
+#define PIC1_MREQ_OFFS		0x14
+#define PIC1_TSTREQ_OFFS	0x18
+#define PIC1_POL_OFFS		0x1c
+#define PIC1_IRQ_OFFS		0x20
+#define PIC1_FIQ_OFFS		0x24
+#define PIC1_MIRQ_OFFS		0x28
+#define PIC1_MFIQ_OFFS		0x2c
+#define PIC1_TMODE_OFFS		0x30
+#define PIC1_SYNC_OFFS		0x34
+#define PIC1_WKUP_OFFS		0x38
+#define PIC1_TMODEA_OFFS	0x3c
+#define PIC1_INTOEN_OFFS	0x40
+#define PIC1_MEN1_OFFS		0x44
+#define PIC1_MEN_OFFS		0x48
+
+#define PIC1_IEN	__REG(PIC1_BASE + PIC1_IEN_OFFS)
+#define PIC1_CREQ	__REG(PIC1_BASE + PIC1_CREQ_OFFS)
+#define PIC1_IREQ	__REG(PIC1_BASE + PIC1_IREQ_OFFS)
+#define PIC1_IRQSEL	__REG(PIC1_BASE + PIC1_IRQSEL_OFFS)
+#define PIC1_SRC	__REG(PIC1_BASE + PIC1_SRC_OFFS)
+#define PIC1_MREQ	__REG(PIC1_BASE + PIC1_MREQ_OFFS)
+#define PIC1_TSTREQ	__REG(PIC1_BASE + PIC1_TSTREQ_OFFS)
+#define PIC1_POL	__REG(PIC1_BASE + PIC1_POL_OFFS)
+#define PIC1_IRQ	__REG(PIC1_BASE + PIC1_IRQ_OFFS)
+#define PIC1_FIQ	__REG(PIC1_BASE + PIC1_FIQ_OFFS)
+#define PIC1_MIRQ	__REG(PIC1_BASE + PIC1_MIRQ_OFFS)
+#define PIC1_MFIQ	__REG(PIC1_BASE + PIC1_MFIQ_OFFS)
+#define PIC1_TMODE	__REG(PIC1_BASE + PIC1_TMODE_OFFS)
+#define PIC1_SYNC	__REG(PIC1_BASE + PIC1_SYNC_OFFS)
+#define PIC1_WKUP	__REG(PIC1_BASE + PIC1_WKUP_OFFS)
+#define PIC1_TMODEA	__REG(PIC1_BASE + PIC1_TMODEA_OFFS)
+#define PIC1_INTOEN	__REG(PIC1_BASE + PIC1_INTOEN_OFFS)
+#define PIC1_MEN1	__REG(PIC1_BASE + PIC1_MEN1_OFFS)
+#define PIC1_MEN	__REG(PIC1_BASE + PIC1_MEN_OFFS)
+
+/* Timer registers */
+#define TIMER_BASE		(APB1_PERI_BASE_VIRT + 0x4000)
+#define TIMER_BASE_PHYS		(APB1_PERI_BASE + 0x4000)
+
+#define TWDCFG_OFFS		0x70
+
+#define TC32EN_OFFS		0x80
+#define TC32LDV_OFFS		0x84
+#define TC32CMP0_OFFS		0x88
+#define TC32CMP1_OFFS		0x8c
+#define TC32PCNT_OFFS		0x90
+#define TC32MCNT_OFFS		0x94
+#define TC32IRQ_OFFS		0x98
+
+/* Bits in TC32EN */
+#define TC32EN_PRESCALE_MASK	0x00ffffff
+#define TC32EN_ENABLE		(1 << 24)
+#define TC32EN_LOADZERO		(1 << 25)
+#define TC32EN_STOPMODE		(1 << 26)
+#define TC32EN_LDM0		(1 << 28)
+#define TC32EN_LDM1		(1 << 29)
+
+/* Bits in TC32IRQ */
+#define TC32IRQ_MSTAT_MASK	0x0000001f
+#define TC32IRQ_RSTAT_MASK	(0x1f << 8)
+#define TC32IRQ_IRQEN0		(1 << 16)
+#define TC32IRQ_IRQEN1		(1 << 17)
+#define TC32IRQ_IRQEN2		(1 << 18)
+#define TC32IRQ_IRQEN3		(1 << 19)
+#define TC32IRQ_IRQEN4		(1 << 20)
+#define TC32IRQ_RSYNC		(1 << 30)
+#define TC32IRQ_IRQCLR		(1 << 31)
+
+/* GPIO registers */
+#define GPIOPD_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOPD_DAT_OFFS		0x00
+#define GPIOPD_DOE_OFFS		0x04
+#define GPIOPD_FS0_OFFS		0x08
+#define GPIOPD_FS1_OFFS		0x0c
+#define GPIOPD_FS2_OFFS		0x10
+#define GPIOPD_RPU_OFFS		0x30
+#define GPIOPD_RPD_OFFS		0x34
+#define GPIOPD_DV0_OFFS		0x38
+#define GPIOPD_DV1_OFFS		0x3c
+
+#define GPIOPS_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOPS_DAT_OFFS		0x40
+#define GPIOPS_DOE_OFFS		0x44
+#define GPIOPS_FS0_OFFS		0x48
+#define GPIOPS_FS1_OFFS		0x4c
+#define GPIOPS_FS2_OFFS		0x50
+#define GPIOPS_FS3_OFFS		0x54
+#define GPIOPS_RPU_OFFS		0x70
+#define GPIOPS_RPD_OFFS		0x74
+#define GPIOPS_DV0_OFFS		0x78
+#define GPIOPS_DV1_OFFS		0x7c
+
+#define GPIOPS_FS1_SDH0_BITS	0x000000ff
+#define GPIOPS_FS1_SDH1_BITS	0x0000ff00
+
+#define GPIOPU_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOPU_DAT_OFFS		0x80
+#define GPIOPU_DOE_OFFS		0x84
+#define GPIOPU_FS0_OFFS		0x88
+#define GPIOPU_FS1_OFFS		0x8c
+#define GPIOPU_FS2_OFFS		0x90
+#define GPIOPU_RPU_OFFS		0xb0
+#define GPIOPU_RPD_OFFS		0xb4
+#define GPIOPU_DV0_OFFS		0xb8
+#define GPIOPU_DV1_OFFS		0xbc
+
+#define GPIOPU_FS0_TXD0		(1 << 0)
+#define GPIOPU_FS0_RXD0		(1 << 1)
+#define GPIOPU_FS0_CTS0		(1 << 2)
+#define GPIOPU_FS0_RTS0		(1 << 3)
+#define GPIOPU_FS0_TXD1		(1 << 4)
+#define GPIOPU_FS0_RXD1		(1 << 5)
+#define GPIOPU_FS0_CTS1		(1 << 6)
+#define GPIOPU_FS0_RTS1		(1 << 7)
+#define GPIOPU_FS0_TXD2		(1 << 8)
+#define GPIOPU_FS0_RXD2		(1 << 9)
+#define GPIOPU_FS0_CTS2		(1 << 10)
+#define GPIOPU_FS0_RTS2		(1 << 11)
+#define GPIOPU_FS0_TXD3		(1 << 12)
+#define GPIOPU_FS0_RXD3		(1 << 13)
+#define GPIOPU_FS0_CTS3		(1 << 14)
+#define GPIOPU_FS0_RTS3		(1 << 15)
+#define GPIOPU_FS0_TXD4		(1 << 16)
+#define GPIOPU_FS0_RXD4		(1 << 17)
+#define GPIOPU_FS0_CTS4		(1 << 18)
+#define GPIOPU_FS0_RTS4		(1 << 19)
+
+#define GPIOFC_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOFC_DAT_OFFS		0xc0
+#define GPIOFC_DOE_OFFS		0xc4
+#define GPIOFC_FS0_OFFS		0xc8
+#define GPIOFC_FS1_OFFS		0xcc
+#define GPIOFC_FS2_OFFS		0xd0
+#define GPIOFC_FS3_OFFS		0xd4
+#define GPIOFC_RPU_OFFS		0xf0
+#define GPIOFC_RPD_OFFS		0xf4
+#define GPIOFC_DV0_OFFS		0xf8
+#define GPIOFC_DV1_OFFS		0xfc
+
+#define GPIOFD_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOFD_DAT_OFFS		0x100
+#define GPIOFD_DOE_OFFS		0x104
+#define GPIOFD_FS0_OFFS		0x108
+#define GPIOFD_FS1_OFFS		0x10c
+#define GPIOFD_FS2_OFFS		0x110
+#define GPIOFD_RPU_OFFS		0x130
+#define GPIOFD_RPD_OFFS		0x134
+#define GPIOFD_DV0_OFFS		0x138
+#define GPIOFD_DV1_OFFS		0x13c
+
+#define GPIOLC_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOLC_DAT_OFFS		0x140
+#define GPIOLC_DOE_OFFS		0x144
+#define GPIOLC_FS0_OFFS		0x148
+#define GPIOLC_FS1_OFFS		0x14c
+#define GPIOLC_RPU_OFFS		0x170
+#define GPIOLC_RPD_OFFS		0x174
+#define GPIOLC_DV0_OFFS		0x178
+#define GPIOLC_DV1_OFFS		0x17c
+
+#define GPIOLD_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOLD_DAT_OFFS		0x180
+#define GPIOLD_DOE_OFFS		0x184
+#define GPIOLD_FS0_OFFS		0x188
+#define GPIOLD_FS1_OFFS		0x18c
+#define GPIOLD_FS2_OFFS		0x190
+#define GPIOLD_RPU_OFFS		0x1b0
+#define GPIOLD_RPD_OFFS		0x1b4
+#define GPIOLD_DV0_OFFS		0x1b8
+#define GPIOLD_DV1_OFFS		0x1bc
+
+#define GPIOAD_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOAD_DAT_OFFS		0x1c0
+#define GPIOAD_DOE_OFFS		0x1c4
+#define GPIOAD_FS0_OFFS		0x1c8
+#define GPIOAD_RPU_OFFS		0x1f0
+#define GPIOAD_RPD_OFFS		0x1f4
+#define GPIOAD_DV0_OFFS		0x1f8
+#define GPIOAD_DV1_OFFS		0x1fc
+
+#define GPIOXC_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOXC_DAT_OFFS		0x200
+#define GPIOXC_DOE_OFFS		0x204
+#define GPIOXC_FS0_OFFS		0x208
+#define GPIOXC_RPU_OFFS		0x230
+#define GPIOXC_RPD_OFFS		0x234
+#define GPIOXC_DV0_OFFS		0x238
+#define GPIOXC_DV1_OFFS		0x23c
+
+#define GPIOXC_FS0		__REG(GPIOXC_BASE + GPIOXC_FS0_OFFS)
+
+#define GPIOXC_FS0_CS0		(1 << 26)
+#define GPIOXC_FS0_CS1		(1 << 27)
+
+#define GPIOXD_BASE		(APB1_PERI_BASE_VIRT + 0x5000)
+
+#define GPIOXD_DAT_OFFS		0x240
+#define GPIOXD_FS0_OFFS		0x248
+#define GPIOXD_RPU_OFFS		0x270
+#define GPIOXD_RPD_OFFS		0x274
+#define GPIOXD_DV0_OFFS		0x278
+#define GPIOXD_DV1_OFFS		0x27c
+
+#define GPIOPK_BASE		(APB1_PERI_BASE_VIRT + 0x1c000)
+
+#define GPIOPK_RST_OFFS		0x008
+#define GPIOPK_DAT_OFFS		0x100
+#define GPIOPK_DOE_OFFS		0x104
+#define GPIOPK_FS0_OFFS		0x108
+#define GPIOPK_FS1_OFFS		0x10c
+#define GPIOPK_FS2_OFFS		0x110
+#define GPIOPK_IRQST_OFFS	0x210
+#define GPIOPK_IRQEN_OFFS	0x214
+#define GPIOPK_IRQPOL_OFFS	0x218
+#define GPIOPK_IRQTM0_OFFS	0x21c
+#define GPIOPK_IRQTM1_OFFS	0x220
+#define GPIOPK_CTL_OFFS		0x22c
+
+#define PMGPIO_BASE		(APB1_PERI_BASE_VIRT + 0x10000)
+#define BACKUP_RAM_BASE		PMGPIO_BASE
+
+#define PMGPIO_DAT_OFFS		0x800
+#define PMGPIO_DOE_OFFS		0x804
+#define PMGPIO_FS0_OFFS		0x808
+#define PMGPIO_RPU_OFFS		0x810
+#define PMGPIO_RPD_OFFS		0x814
+#define PMGPIO_DV0_OFFS		0x818
+#define PMGPIO_DV1_OFFS		0x81c
+#define PMGPIO_EE0_OFFS		0x820
+#define PMGPIO_EE1_OFFS		0x824
+#define PMGPIO_CTL_OFFS		0x828
+#define PMGPIO_DI_OFFS		0x82c
+#define PMGPIO_STR_OFFS		0x830
+#define PMGPIO_STF_OFFS		0x834
+#define PMGPIO_POL_OFFS		0x838
+#define PMGPIO_APB_OFFS		0x800
+
+/* Clock controller registers */
+#define CKC_BASE		(APB1_PERI_BASE_VIRT + 0x6000)
+#define CKC_BASE_PHYS		(APB1_PERI_BASE + 0x6000)
+
+#define CLKCTRL_OFFS		0x00
+#define PLL0CFG_OFFS		0x04
+#define PLL1CFG_OFFS		0x08
+#define CLKDIVC0_OFFS		0x0c
+
+#define BCLKCTR0_OFFS		0x14
+#define SWRESET0_OFFS		0x18
+
+#define BCLKCTR1_OFFS		0x60
+#define SWRESET1_OFFS		0x64
+#define PWDCTL_OFFS		0x68
+#define PLL2CFG_OFFS		0x6c
+#define CLKDIVC1_OFFS		0x70
+
+#define ACLKREF_OFFS		0x80
+#define ACLKI2C_OFFS		0x84
+#define ACLKSPI0_OFFS		0x88
+#define ACLKSPI1_OFFS		0x8c
+#define ACLKUART0_OFFS		0x90
+#define ACLKUART1_OFFS		0x94
+#define ACLKUART2_OFFS		0x98
+#define ACLKUART3_OFFS		0x9c
+#define ACLKUART4_OFFS		0xa0
+#define ACLKTCT_OFFS		0xa4
+#define ACLKTCX_OFFS		0xa8
+#define ACLKTCZ_OFFS		0xac
+#define ACLKADC_OFFS		0xb0
+#define ACLKDAI0_OFFS		0xb4
+#define ACLKDAI1_OFFS		0xb8
+#define ACLKLCD_OFFS		0xbc
+#define ACLKSPDIF_OFFS		0xc0
+#define ACLKUSBH_OFFS		0xc4
+#define ACLKSDH0_OFFS		0xc8
+#define ACLKSDH1_OFFS		0xcc
+#define ACLKC3DEC_OFFS		0xd0
+#define ACLKEXT_OFFS		0xd4
+#define ACLKCAN0_OFFS		0xd8
+#define ACLKCAN1_OFFS		0xdc
+#define ACLKGSB0_OFFS		0xe0
+#define ACLKGSB1_OFFS		0xe4
+#define ACLKGSB2_OFFS		0xe8
+#define ACLKGSB3_OFFS		0xec
+
+#define PLLxCFG_PD		(1 << 31)
+
+/* CLKCTRL bits */
+#define CLKCTRL_XE		(1 << 31)
+
+/* CLKDIVCx bits */
+#define CLKDIVC0_XTE		(1 << 7)
+#define CLKDIVC0_XE		(1 << 15)
+#define CLKDIVC0_P1E		(1 << 23)
+#define CLKDIVC0_P0E		(1 << 31)
+
+#define CLKDIVC1_P2E		(1 << 7)
+
+/* BCLKCTR0 clock bits */
+#define BCLKCTR0_USBD		(1 << 4)
+#define BCLKCTR0_ECC		(1 << 9)
+#define BCLKCTR0_USBH0		(1 << 11)
+#define BCLKCTR0_NFC		(1 << 16)
+
+/* BCLKCTR1 clock bits */
+#define BCLKCTR1_USBH1		(1 << 20)
+
+/* SWRESET0 bits */
+#define SWRESET0_USBD		(1 << 4)
+#define SWRESET0_USBH0		(1 << 11)
+
+/* SWRESET1 bits */
+#define SWRESET1_USBH1		(1 << 20)
+
+/* System clock sources */
+enum root_clks {
+	CLK_SRC_PLL0 = 0,
+	CLK_SRC_PLL1,
+	CLK_SRC_PLL0DIV,
+	CLK_SRC_PLL1DIV,
+	CLK_SRC_XI,
+	CLK_SRC_XIDIV,
+	CLK_SRC_XTI,
+	CLK_SRC_XTIDIV,
+	CLK_SRC_PLL2,
+	CLK_SRC_PLL2DIV,
+	CLK_SRC_PK0,
+	CLK_SRC_PK1,
+	CLK_SRC_PK2,
+	CLK_SRC_PK3,
+	CLK_SRC_PK4,
+	CLK_SRC_48MHZ
+};
+
+#define CLK_SRC_MASK		0xf
+
+/* Bits in ACLK* registers */
+#define ACLK_EN		(1 << 28)
+#define ACLK_SEL_SHIFT		24
+#define ACLK_SEL_MASK		0x0f000000
+#define ACLK_DIV_MASK		0x00000fff
+
+/* System configuration registers */
+
+#define SCFG_BASE		(APB1_PERI_BASE_VIRT + 0x13000)
+
+#define	BMI_OFFS		0x00
+#define AHBCON0_OFFS		0x04
+#define APBPWE_OFFS		0x08
+#define DTCMWAIT_OFFS		0x0c
+#define ECCSEL_OFFS		0x10
+#define AHBCON1_OFFS		0x14
+#define SDHCFG_OFFS		0x18
+#define REMAP_OFFS		0x20
+#define LCDSIAE_OFFS		0x24
+#define XMCCFG_OFFS		0xe0
+#define IMCCFG_OFFS		0xe4
+
+/* Values for ECCSEL */
+#define ECCSEL_EXTMEM		0x0
+#define ECCSEL_DTCM		0x1
+#define ECCSEL_INT_SRAM		0x2
+#define ECCSEL_AHB		0x3
+
+/* Bits in XMCCFG */
+#define XMCCFG_NFCE		(1 << 1)
+#define XMCCFG_FDXD		(1 << 2)
+
+/* External memory controller registers */
+
+#define EMC_BASE		EXT_MEM_CTRL_BASE
+
+#define SDCFG_OFFS		0x00
+#define SDFSM_OFFS		0x04
+#define MCFG_OFFS		0x08
+
+#define CSCFG0_OFFS		0x10
+#define CSCFG1_OFFS		0x14
+#define CSCFG2_OFFS		0x18
+#define CSCFG3_OFFS		0x1c
+
+#define MCFG_SDEN		(1 << 4)
+
+#endif /* TCC8K_REGS_H */
diff --git a/arch/arm/plat-tcc/include/mach/uncompress.h b/arch/arm/plat-tcc/include/mach/uncompress.h
new file mode 100644
index 0000000..8e0294d
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/uncompress.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * This file is licensed under the terms of the GPL version 2.
+ */
+
+#include <linux/types.h>
+#include <mach/tcc8k-regs.h>
+
+unsigned int system_rev;
+
+#define ID_MASK			0x7fff
+
+static void putc(int c)
+{
+	u32 *uart_lsr = (u32 *)(UART_BASE_PHYS + UART_LSR_OFFS);
+	u32 *uart_thr = (u32 *)(UART_BASE_PHYS + UART_THR_OFFS);
+
+	while (!(*uart_lsr & UART_LSR_THRE))
+		barrier();
+	*uart_thr = c;
+}
+
+static inline void flush(void)
+{
+}
+
+/*
+ * nothing to do
+ */
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
diff --git a/arch/arm/plat-tcc/include/mach/vmalloc.h b/arch/arm/plat-tcc/include/mach/vmalloc.h
new file mode 100644
index 0000000..9635303
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/vmalloc.h
@@ -0,0 +1,11 @@
+/*
+ * Author: <linux@telechips.com>
+ * Created: June 10, 2008
+ *
+ * Copyright (C) 2000 Russell King.
+ * Copyright (C) 2008-2009 Telechips
+ *
+ * Licensed under the terms of the GPL v2.
+ */
+#define VMALLOC_END	  (PAGE_OFFSET + 0x10000000)
+
diff --git a/arch/arm/plat-tcc/system.c b/arch/arm/plat-tcc/system.c
new file mode 100644
index 0000000..1a33ced
--- /dev/null
+++ b/arch/arm/plat-tcc/system.c
@@ -0,0 +1,24 @@
+/*
+ * System functions for Telechips TCCxxxx SoCs
+ *
+ * Copyright (C) Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GPL v2.
+ *
+ */
+
+#include <asm/io.h>
+#include <mach/tcc8k-regs.h>
+
+/* System reboot */
+void plat_tcc_reboot(void)
+{
+	/* Make sure clocks are on */
+	__raw_writel(0xffffffff, CKC_BASE + BCLKCTR0_OFFS);
+
+	/* Enable watchdog reset */
+	__raw_writel(0x49, TIMER_BASE + TWDCFG_OFFS);
+	/* Wait for reset */
+	unreachable();
+}
+
-- 
1.6.3.3



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.274.1269547769.2170.linux-arm-kernel@lists.infradead.org>

Add the clock framework for Telechips TCC8xxx processors.

Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
---
 arch/arm/mach-tcc8k/Makefile            |    6 +
 arch/arm/mach-tcc8k/clock.c             |  589 +++++++++++++++++++++++++++++++
 arch/arm/plat-tcc/Makefile              |    2 +-
 arch/arm/plat-tcc/clock.c               |  170 +++++++++
 arch/arm/plat-tcc/include/mach/clkdev.h |    7 +
 arch/arm/plat-tcc/include/mach/clock.h  |   48 +++
 6 files changed, 821 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tcc8k/Makefile
 create mode 100644 arch/arm/mach-tcc8k/clock.c
 create mode 100644 arch/arm/plat-tcc/clock.c
 create mode 100644 arch/arm/plat-tcc/include/mach/clkdev.h
 create mode 100644 arch/arm/plat-tcc/include/mach/clock.h

diff --git a/arch/arm/mach-tcc8k/Makefile b/arch/arm/mach-tcc8k/Makefile
new file mode 100644
index 0000000..805d850
--- /dev/null
+++ b/arch/arm/mach-tcc8k/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for TCC8K boards and common files.
+#
+
+# Common support
+obj-y += clock.o
diff --git a/arch/arm/mach-tcc8k/clock.c b/arch/arm/mach-tcc8k/clock.c
new file mode 100644
index 0000000..2910d9a
--- /dev/null
+++ b/arch/arm/mach-tcc8k/clock.c
@@ -0,0 +1,589 @@
+/*
+ * Lowlevel clock handling for Telechips TCC8xxx SoCs
+ *
+ * Copyright (C) 2010 by Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GPL v2
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+
+#include <asm/clkdev.h>
+
+#include <mach/clock.h>
+#include <mach/irqs.h>
+#include <mach/tcc8k-regs.h>
+
+extern int __init tcc8k_timer_init(struct clk *clock,
+					void __iomem *base, int irq);
+
+#define BCLKCTR0	(void __iomem *)(CKC_BASE + BCLKCTR0_OFFS)
+#define BCLKCTR1	(void __iomem *)(CKC_BASE + BCLKCTR1_OFFS)
+
+#define ACLKREF		(void __iomem *)(CKC_BASE + ACLKREF_OFFS)
+#define ACLKUART0	(void __iomem *)(CKC_BASE + ACLKUART0_OFFS)
+#define ACLKUART1	(void __iomem *)(CKC_BASE + ACLKUART1_OFFS)
+#define ACLKUART2	(void __iomem *)(CKC_BASE + ACLKUART2_OFFS)
+#define ACLKUART3	(void __iomem *)(CKC_BASE + ACLKUART3_OFFS)
+#define ACLKUART4	(void __iomem *)(CKC_BASE + ACLKUART4_OFFS)
+#define ACLKI2C		(void __iomem *)(CKC_BASE + ACLKI2C_OFFS)
+#define ACLKADC		(void __iomem *)(CKC_BASE + ACLKADC_OFFS)
+#define ACLKUSBH	(void __iomem *)(CKC_BASE + ACLKUSBH_OFFS)
+#define ACLKLCD		(void __iomem *)(CKC_BASE + ACLKLCD_OFFS)
+#define ACLKSDH0	(void __iomem *)(CKC_BASE + ACLKSDH0_OFFS)
+#define ACLKSDH1	(void __iomem *)(CKC_BASE + ACLKSDH1_OFFS)
+#define ACLKSPI0	(void __iomem *)(CKC_BASE + ACLKSPI0_OFFS)
+#define ACLKSPI1	(void __iomem *)(CKC_BASE + ACLKSPI1_OFFS)
+#define ACLKSPDIF	(void __iomem *)(CKC_BASE + ACLKSPDIF_OFFS)
+#define ACLKC3DEC	(void __iomem *)(CKC_BASE + ACLKC3DEC_OFFS)
+#define ACLKCAN0	(void __iomem *)(CKC_BASE + ACLKCAN0_OFFS)
+#define ACLKCAN1	(void __iomem *)(CKC_BASE + ACLKCAN1_OFFS)
+#define ACLKGSB0	(void __iomem *)(CKC_BASE + ACLKGSB0_OFFS)
+#define ACLKGSB1	(void __iomem *)(CKC_BASE + ACLKGSB1_OFFS)
+#define ACLKGSB2	(void __iomem *)(CKC_BASE + ACLKGSB2_OFFS)
+#define ACLKGSB3	(void __iomem *)(CKC_BASE + ACLKGSB3_OFFS)
+#define ACLKUSBH	(void __iomem *)(CKC_BASE + ACLKUSBH_OFFS)
+#define ACLKTCT		(void __iomem *)(CKC_BASE + ACLKTCT_OFFS)
+#define ACLKTCX		(void __iomem *)(CKC_BASE + ACLKTCX_OFFS)
+#define ACLKTCZ		(void __iomem *)(CKC_BASE + ACLKTCZ_OFFS)
+
+/* Crystal frequencies */
+static unsigned long xi_rate, xti_rate;
+
+static int index_of_root_clk(struct clk *clock);
+
+static void __iomem *pll_cfg_addr(int pll)
+{
+	switch (pll) {
+	case 0: return (void __iomem *)(CKC_BASE + PLL0CFG_OFFS);
+	case 1: return (void __iomem *)(CKC_BASE + PLL1CFG_OFFS);
+	case 2: return (void __iomem *)(CKC_BASE + PLL2CFG_OFFS);
+	default: BUG();
+	}
+}
+
+static int pll_enable(int pll, int enable)
+{
+	u32 reg;
+	void __iomem *addr = pll_cfg_addr(pll);
+
+	reg = __raw_readl(addr);
+	if (enable)
+		reg &= ~PLLxCFG_PD;
+	else
+		reg |= PLLxCFG_PD;
+
+	__raw_writel(reg, addr);
+	return 0;
+}
+
+static int xi_enable(int enable)
+{
+	u32 reg;
+
+	reg = __raw_readl(CKC_BASE + CLKCTRL_OFFS);
+	if (enable)
+		reg |= CLKCTRL_XE;
+	else
+		reg &= ~CLKCTRL_XE;
+
+	__raw_writel(reg, CKC_BASE + CLKCTRL_OFFS);
+	return 0;
+}
+
+static int root_clk_enable(enum root_clks src)
+{
+	switch (src) {
+	case CLK_SRC_PLL0: return pll_enable(0, 1);
+	case CLK_SRC_PLL1: return pll_enable(1, 1);
+	case CLK_SRC_PLL2: return pll_enable(2, 1);
+	case CLK_SRC_XI: return xi_enable(1);
+	default: BUG();
+	}
+	return 0;
+}
+
+static int root_clk_disable(enum root_clks root_src)
+{
+	switch (root_src) {
+	case CLK_SRC_PLL0: return pll_enable(0, 0);
+	case CLK_SRC_PLL1: return pll_enable(1, 0);
+	case CLK_SRC_PLL2: return pll_enable(2, 0);
+	case CLK_SRC_XI: return xi_enable(0);
+	default: BUG();
+	}
+	return 0;
+}
+
+static int enable_clk(struct clk *clk)
+{
+	u32 reg;
+
+	if (clk->root_id)
+		return root_clk_enable(clk->root_id - 1);
+
+	if (clk->aclkreg) {
+		reg = __raw_readl(clk->aclkreg);
+		reg |= ACLK_EN;
+		__raw_writel(reg, clk->aclkreg);
+	}
+	if (clk->bclkctr) {
+		reg = __raw_readl(clk->bclkctr);
+		reg |= 1 << clk->bclk_shift;
+		__raw_writel(reg, clk->bclkctr);
+	}
+	return 0;
+}
+
+static void disable_clk(struct clk *clk)
+{
+	u32 reg;
+
+	if (clk->root_id) {
+		root_clk_disable(clk->root_id - 1);
+		return;
+	}
+
+	if (clk->bclkctr) {
+		reg = __raw_readl(clk->bclkctr);
+		reg &= ~(1 << clk->bclk_shift);
+		__raw_writel(reg, clk->bclkctr);
+	}
+	if (clk->aclkreg) {
+		reg = __raw_readl(clk->aclkreg);
+		reg &= ~ACLK_EN;
+		__raw_writel(reg, clk->aclkreg);
+	}
+}
+
+static unsigned long get_rate_pll(int pll)
+{
+	u32 reg;
+	unsigned long s, m, p;
+	void __iomem *addr = pll_cfg_addr(pll);
+
+	reg = __raw_readl(addr);
+	s = (reg >> 16) & 0x07;
+	m = (reg >> 8) & 0xff;
+	p = reg & 0x3f;
+
+	return (m * xi_rate) / (p * (1 << s));
+}
+
+static unsigned long get_rate_pll_div(int pll)
+{
+	u32 reg;
+	unsigned long div = 0;
+	void __iomem *addr;
+
+	switch (pll) {
+	case 0:
+		addr = (void __iomem *)(CKC_BASE + CLKDIVC0_OFFS);
+		reg = __raw_readl(addr);
+		if (reg & CLKDIVC0_P0E)
+			div = (reg >> 24) & 0x3f;
+		break;
+	case 1:
+		addr = (void __iomem *)(CKC_BASE + CLKDIVC0_OFFS);
+		reg = __raw_readl(addr);
+		if (reg & CLKDIVC0_P1E)
+			div = (reg >> 16) & 0x3f;
+		break;
+	case 2:
+		addr = (void __iomem *)(CKC_BASE + CLKDIVC1_OFFS);
+		reg = __raw_readl(addr);
+		if (reg & CLKDIVC1_P2E)
+			div = __raw_readl(addr) & 0x3f;
+		break;
+	}
+	return get_rate_pll(pll) / (div + 1);
+}
+
+static unsigned long get_rate_xi_div(void)
+{
+	unsigned long div = 0;
+	u32 reg = __raw_readl(CKC_BASE + CLKDIVC0_OFFS);
+
+	if (reg & CLKDIVC0_XE)
+		div = (reg >> 8) & 0x3f;
+
+	return xi_rate / (div + 1);
+}
+
+static unsigned long get_rate_xti_div(void)
+{
+	unsigned long div = 0;
+	u32 reg = __raw_readl(CKC_BASE + CLKDIVC0_OFFS);
+
+	if (reg & CLKDIVC0_XTE)
+		div = reg & 0x3f;
+
+	return xti_rate / (div + 1);
+}
+
+static unsigned long root_clk_get_rate(enum root_clks src)
+{
+	switch (src) {
+	case CLK_SRC_PLL0: return get_rate_pll(0);
+	case CLK_SRC_PLL1: return get_rate_pll(1);
+	case CLK_SRC_PLL2: return get_rate_pll(2);
+	case CLK_SRC_PLL0DIV: return get_rate_pll_div(0);
+	case CLK_SRC_PLL1DIV: return get_rate_pll_div(1);
+	case CLK_SRC_PLL2DIV: return get_rate_pll_div(2);
+	case CLK_SRC_XI: return xi_rate;
+	case CLK_SRC_XTI: return xti_rate;
+	case CLK_SRC_XIDIV: return get_rate_xi_div();
+	case CLK_SRC_XTIDIV: return get_rate_xti_div();
+	default: return 0;
+	}
+}
+
+static unsigned long aclk_get_rate(struct clk *clk)
+{
+	u32 reg;
+	unsigned long div;
+	unsigned int src;
+
+	reg = __raw_readl(clk->aclkreg);
+	div = reg & 0x0fff;
+	src = (reg >> ACLK_SEL_SHIFT) & CLK_SRC_MASK;
+	return root_clk_get_rate(src) / (div + 1);
+}
+
+static unsigned long aclk_best_div(struct clk *clk, unsigned long rate)
+{
+	unsigned long div, src, freq, r1, r2;
+
+	src = __raw_readl(clk->aclkreg) >> ACLK_SEL_SHIFT;
+	src &= CLK_SRC_MASK;
+	freq = root_clk_get_rate(src);
+	div = freq / rate + 1;
+	r1 = freq / div;
+	r2 = freq / (div + 1);
+	if (r2 >= rate)
+		return div + 1;
+	if ((rate - r2) < (r1 - rate))
+		return div + 1;
+
+	return div;
+}
+
+static unsigned long aclk_round_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned int src;
+
+	src = __raw_readl(clk->aclkreg) >> ACLK_SEL_SHIFT;
+	src &= CLK_SRC_MASK;
+
+	return root_clk_get_rate(src) / aclk_best_div(clk, rate);
+}
+
+static int aclk_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 reg;
+
+	reg = __raw_readl(clk->aclkreg) & ~ACLK_DIV_MASK;
+	reg |= aclk_best_div(clk, rate);
+	return 0;
+}
+
+static unsigned long get_rate_sys(struct clk *clk)
+{
+	unsigned int src;
+
+	src = __raw_readl(CKC_BASE + CLKCTRL_OFFS) & CLK_SRC_MASK;
+		return root_clk_get_rate(src);
+}
+
+static unsigned long get_rate_bus(struct clk *clk)
+{
+	unsigned int div;
+
+	div = (__raw_readl(CKC_BASE + CLKCTRL_OFFS) >> 4) & 0xff;
+	return get_rate_sys(clk) / (div + 1);
+}
+
+static unsigned long get_rate_cpu(struct clk *clk)
+{
+	unsigned int reg, div, fsys, fbus;
+
+	fbus = get_rate_bus(clk);
+	reg = __raw_readl(CKC_BASE + CLKCTRL_OFFS);
+	if (reg & (1 << 29))
+		return fbus;
+	fsys = get_rate_sys(clk);
+	div = (reg >> 16) & 0x0f;
+	return fbus + ((fsys - fbus) * (div + 1)) / 16;
+}
+
+static unsigned long get_rate_root(struct clk *clk)
+{
+	return root_clk_get_rate(clk->root_id - 1);
+}
+
+static int __set_parent(struct clk *clock, struct clk *parent)
+{
+	if (clock->parent && (clock->parent != parent)) {
+		clock->parent->refcount--;
+		if ((clock->parent->refcount == 0) && clock->parent->disable)
+			clock->parent->disable(clock->parent);
+	}
+
+	clock->parent = parent;
+	if (clock->parent)
+		clock->parent->refcount++;
+	return 0;
+}
+
+static int aclk_set_parent(struct clk *clock, struct clk *parent)
+{
+	int new_src;
+	u32 reg;
+
+	if (clock->parent == parent)
+		return 0;
+
+	if (!parent)
+		return __set_parent(clock, parent);
+
+	new_src = index_of_root_clk(parent);
+	if (new_src < 0)
+		return __set_parent(clock, parent);
+	reg = __raw_readl(clock->aclkreg);
+	reg &= ~ACLK_SEL_MASK;
+	reg |= (new_src << ACLK_SEL_SHIFT) & ACLK_SEL_MASK;
+	__raw_writel(reg, clock->aclkreg);
+
+	return 0;
+}
+
+#define DEFINE_ROOT_CLOCK(name, ri, p)	\
+	static struct clk name = {		\
+		.root_id = ri,			\
+		.get_rate = get_rate_root,			\
+		.enable = enable_clk,		\
+		.disable = disable_clk,		\
+		.parent = p,			\
+	};
+
+#define DEFINE_SPECIAL_CLOCK(name, gr, p)	\
+	static struct clk name = {		\
+		.get_rate = gr,			\
+		.parent = p,			\
+	};
+
+#define DEFINE_ACLOCK(name, bc, bs, ar)		\
+	static struct clk name = {		\
+		.bclkctr = bc,			\
+		.bclk_shift = bs,		\
+		.aclkreg = ar,			\
+		.get_rate = aclk_get_rate,	\
+		.set_rate = aclk_set_rate,	\
+		.round_rate = aclk_round_rate,	\
+		.enable = enable_clk,		\
+		.disable = disable_clk,		\
+		.set_parent = aclk_set_parent,	\
+	};
+
+#define DEFINE_BCLOCK(name, bc, bs, gr, p)	\
+	static struct clk name = {		\
+		.bclkctr = bc,			\
+		.bclk_shift = bs,		\
+		.get_rate = gr,			\
+		.enable = enable_clk,		\
+		.disable = disable_clk,		\
+		.parent = p,			\
+	};
+
+DEFINE_ROOT_CLOCK(xi, CLK_SRC_XI + 1, NULL)
+DEFINE_ROOT_CLOCK(xti, CLK_SRC_XTI + 1, NULL)
+DEFINE_ROOT_CLOCK(xidiv, CLK_SRC_XIDIV + 1, &xi)
+DEFINE_ROOT_CLOCK(xtidiv, CLK_SRC_XTIDIV + 1, &xti)
+DEFINE_ROOT_CLOCK(pll0, CLK_SRC_PLL0 + 1, &xi)
+DEFINE_ROOT_CLOCK(pll1, CLK_SRC_PLL1 + 1, &xi)
+DEFINE_ROOT_CLOCK(pll2, CLK_SRC_PLL2 + 1, &xi)
+DEFINE_ROOT_CLOCK(pll0div, CLK_SRC_PLL0DIV + 1, &pll0)
+DEFINE_ROOT_CLOCK(pll1div, CLK_SRC_PLL1DIV + 1, &pll1)
+DEFINE_ROOT_CLOCK(pll2div, CLK_SRC_PLL2DIV + 1, &pll2)
+
+/* The following 3 clocks are special and are initialized explicitly later */
+DEFINE_SPECIAL_CLOCK(sys, get_rate_sys, NULL)
+DEFINE_SPECIAL_CLOCK(bus, get_rate_bus, &sys)
+DEFINE_SPECIAL_CLOCK(cpu, get_rate_cpu, &sys)
+
+DEFINE_ACLOCK(tct, NULL, 0, ACLKTCT)
+DEFINE_ACLOCK(tcx, NULL, 0, ACLKTCX)
+DEFINE_ACLOCK(tcz, NULL, 0, ACLKTCZ)
+DEFINE_ACLOCK(ref, NULL, 0, ACLKREF)
+DEFINE_ACLOCK(uart0, BCLKCTR0, 5, ACLKUART0)
+DEFINE_ACLOCK(uart1, BCLKCTR0, 23, ACLKUART1)
+DEFINE_ACLOCK(uart2, BCLKCTR0, 6, ACLKUART2)
+DEFINE_ACLOCK(uart3, BCLKCTR0, 8, ACLKUART3)
+DEFINE_ACLOCK(uart4, BCLKCTR1, 6, ACLKUART4)
+DEFINE_ACLOCK(i2c, BCLKCTR0, 7, ACLKI2C)
+DEFINE_ACLOCK(adc, BCLKCTR0, 10, ACLKADC)
+DEFINE_ACLOCK(usbh0, BCLKCTR0, 11, ACLKUSBH)
+DEFINE_ACLOCK(lcd, BCLKCTR0, 13, ACLKLCD)
+DEFINE_ACLOCK(sd0, BCLKCTR0, 17, ACLKSDH0)
+DEFINE_ACLOCK(sd1, BCLKCTR1, 5, ACLKSDH1)
+DEFINE_ACLOCK(spi0, BCLKCTR0, 24, ACLKSPI0)
+DEFINE_ACLOCK(spi1, BCLKCTR0, 30, ACLKSPI1)
+DEFINE_ACLOCK(spdif, BCLKCTR1, 2, ACLKSPDIF)
+DEFINE_ACLOCK(c3dec, BCLKCTR1, 9, ACLKC3DEC)
+DEFINE_ACLOCK(can0, BCLKCTR1, 10, ACLKCAN0)
+DEFINE_ACLOCK(can1, BCLKCTR1, 11, ACLKCAN1)
+DEFINE_ACLOCK(gsb0, BCLKCTR1, 13, ACLKGSB0)
+DEFINE_ACLOCK(gsb1, BCLKCTR1, 14, ACLKGSB1)
+DEFINE_ACLOCK(gsb2, BCLKCTR1, 15, ACLKGSB2)
+DEFINE_ACLOCK(gsb3, BCLKCTR1, 16, ACLKGSB3)
+DEFINE_ACLOCK(usbh1, BCLKCTR1, 20, ACLKUSBH)
+
+DEFINE_BCLOCK(dai0, BCLKCTR0, 0, NULL, NULL)
+DEFINE_BCLOCK(pic, BCLKCTR0, 1, NULL, NULL)
+DEFINE_BCLOCK(tc, BCLKCTR0, 2, NULL, NULL)
+DEFINE_BCLOCK(gpio, BCLKCTR0, 3, NULL, NULL)
+DEFINE_BCLOCK(usbd, BCLKCTR0, 4, NULL, NULL)
+DEFINE_BCLOCK(ecc, BCLKCTR0, 9, NULL, NULL)
+DEFINE_BCLOCK(gdma0, BCLKCTR0, 12, NULL, NULL)
+DEFINE_BCLOCK(rtc, BCLKCTR0, 15, NULL, NULL)
+DEFINE_BCLOCK(nfc, BCLKCTR0, 16, NULL, NULL)
+DEFINE_BCLOCK(g2d, BCLKCTR0, 18, NULL, NULL)
+DEFINE_BCLOCK(gdma1, BCLKCTR0, 22, NULL, NULL)
+DEFINE_BCLOCK(mscl, BCLKCTR0, 25, NULL, NULL)
+DEFINE_BCLOCK(bdma, BCLKCTR1, 0, NULL, NULL)
+DEFINE_BCLOCK(adma0, BCLKCTR1, 1, NULL, NULL)
+DEFINE_BCLOCK(scfg, BCLKCTR1, 3, NULL, NULL)
+DEFINE_BCLOCK(cid, BCLKCTR1, 4, NULL, NULL)
+DEFINE_BCLOCK(dai1, BCLKCTR1, 7, NULL, NULL)
+DEFINE_BCLOCK(adma1, BCLKCTR1, 8, NULL, NULL)
+DEFINE_BCLOCK(gps, BCLKCTR1, 12, NULL, NULL)
+DEFINE_BCLOCK(gdma2, BCLKCTR1, 17, NULL, NULL)
+DEFINE_BCLOCK(gdma3, BCLKCTR1, 18, NULL, NULL)
+DEFINE_BCLOCK(ddrc, BCLKCTR1, 19, NULL, NULL)
+
+#define _REGISTER_CLOCK(d, n, c) \
+	{ \
+		.dev_id = d, \
+		.con_id = n, \
+		.clk = &c, \
+	},
+
+static struct clk_lookup lookups[] = {
+	_REGISTER_CLOCK(NULL, "bus", bus)
+	_REGISTER_CLOCK(NULL, "cpu", cpu)
+	_REGISTER_CLOCK(NULL, "tct", tct)
+	_REGISTER_CLOCK(NULL, "tcx", tcx)
+	_REGISTER_CLOCK(NULL, "tcz", tcz)
+	_REGISTER_CLOCK(NULL, "ref", ref)
+	_REGISTER_CLOCK(NULL, "dai0", dai0)
+	_REGISTER_CLOCK(NULL, "pic", pic)
+	_REGISTER_CLOCK(NULL, "tc", tc)
+	_REGISTER_CLOCK(NULL, "gpio", gpio)
+	_REGISTER_CLOCK(NULL, "usbd", usbd)
+	_REGISTER_CLOCK("tcc-uart.0", NULL, uart0)
+	_REGISTER_CLOCK("tcc-uart.2", NULL, uart2)
+	_REGISTER_CLOCK("tcc-i2c", NULL, i2c)
+	_REGISTER_CLOCK("tcc-uart.3", NULL, uart3)
+	_REGISTER_CLOCK(NULL, "ecc", ecc)
+	_REGISTER_CLOCK(NULL, "adc", adc)
+	_REGISTER_CLOCK("tcc-usbh.0", "usb", usbh0)
+	_REGISTER_CLOCK(NULL, "gdma0", gdma0)
+	_REGISTER_CLOCK(NULL, "lcd", lcd)
+	_REGISTER_CLOCK(NULL, "rtc", rtc)
+	_REGISTER_CLOCK(NULL, "nfc", nfc)
+	_REGISTER_CLOCK("tcc-mmc.0", NULL, sd0)
+	_REGISTER_CLOCK(NULL, "g2d", g2d)
+	_REGISTER_CLOCK(NULL, "gdma1", gdma1)
+	_REGISTER_CLOCK("tcc-uart.1", NULL, uart1)
+	_REGISTER_CLOCK("tcc-spi.0", NULL, spi0)
+	_REGISTER_CLOCK(NULL, "mscl", mscl)
+	_REGISTER_CLOCK("tcc-spi.1", NULL, spi1)
+	_REGISTER_CLOCK(NULL, "bdma", bdma)
+	_REGISTER_CLOCK(NULL, "adma0", adma0)
+	_REGISTER_CLOCK(NULL, "spdif", spdif)
+	_REGISTER_CLOCK(NULL, "scfg", scfg)
+	_REGISTER_CLOCK(NULL, "cid", cid)
+	_REGISTER_CLOCK("tcc-mmc.1", NULL, sd1)
+	_REGISTER_CLOCK("tcc-uart.4", NULL, uart4)
+	_REGISTER_CLOCK(NULL, "dai1", dai1)
+	_REGISTER_CLOCK(NULL, "adma1", adma1)
+	_REGISTER_CLOCK(NULL, "c3dec", c3dec)
+	_REGISTER_CLOCK("tcc-can.0", NULL, can0)
+	_REGISTER_CLOCK("tcc-can.1", NULL, can1)
+	_REGISTER_CLOCK(NULL, "gps", gps)
+	_REGISTER_CLOCK("tcc-gsb.0", NULL, gsb0)
+	_REGISTER_CLOCK("tcc-gsb.1", NULL, gsb1)
+	_REGISTER_CLOCK("tcc-gsb.2", NULL, gsb2)
+	_REGISTER_CLOCK("tcc-gsb.3", NULL, gsb3)
+	_REGISTER_CLOCK(NULL, "gdma2", gdma2)
+	_REGISTER_CLOCK(NULL, "gdma3", gdma3)
+	_REGISTER_CLOCK(NULL, "ddrc", ddrc)
+	_REGISTER_CLOCK("tcc-usbh.1", "usb", usbh1)
+};
+
+static struct clk *root_clk_by_index(enum root_clks src)
+{
+	switch (src) {
+	case CLK_SRC_PLL0: return &pll0;
+	case CLK_SRC_PLL1: return &pll1;
+	case CLK_SRC_PLL2: return &pll2;
+	case CLK_SRC_PLL0DIV: return &pll0div;
+	case CLK_SRC_PLL1DIV: return &pll1div;
+	case CLK_SRC_PLL2DIV: return &pll2div;
+	case CLK_SRC_XI: return &xi;
+	case CLK_SRC_XTI: return &xti;
+	case CLK_SRC_XIDIV: return &xidiv;
+	case CLK_SRC_XTIDIV: return &xtidiv;
+	default: return NULL;
+	}
+}
+
+static int index_of_root_clk(struct clk *clock)
+{
+	if (clock->root_id)
+		return clock->root_id - 1;
+
+	return -1;
+}
+
+static void find_aclk_parent(struct clk *clk)
+{
+	unsigned int src;
+	struct clk *clock;
+
+	if (!clk->aclkreg)
+		return;
+
+	src = __raw_readl(clk->aclkreg) >> ACLK_SEL_SHIFT;
+	src &= CLK_SRC_MASK;
+
+	clock = root_clk_by_index(src);
+	if (!clock)
+		return;
+
+	clk->parent = clock;
+	clk->set_parent = aclk_set_parent;
+}
+
+int __init tcc_clocks_init(unsigned long xi_freq, unsigned long xti_freq)
+{
+	int i;
+
+	xi_rate = xi_freq;
+	xti_rate = xti_freq;
+
+	/* fixup parents and refcounts */
+	for (i = 0; i < ARRAY_SIZE(lookups); i++) {
+		find_aclk_parent(lookups[i].clk);
+		if (lookups[i].clk->parent)
+			__set_parent(lookups[i].clk, lookups[i].clk->parent);
+		clkdev_add(&lookups[i]);
+	}
+
+	return tcc8k_timer_init(&tcz, (void __iomem *)TIMER_BASE, INT_TC32);
+}
diff --git a/arch/arm/plat-tcc/Makefile b/arch/arm/plat-tcc/Makefile
index 3f2e4fe..eceabc8 100644
--- a/arch/arm/plat-tcc/Makefile
+++ b/arch/arm/plat-tcc/Makefile
@@ -1,3 +1,3 @@
 # "Telechips Platform Common Modules"
 
-obj-y := system.o
+obj-y := clock.o system.o
diff --git a/arch/arm/plat-tcc/clock.c b/arch/arm/plat-tcc/clock.c
new file mode 100644
index 0000000..2c08131
--- /dev/null
+++ b/arch/arm/plat-tcc/clock.c
@@ -0,0 +1,170 @@
+/*
+ * Clock framework for Telechips SoCs
+ * Based on arch/arm/plat-mxc/clock.c
+ *
+ * Copyright (C) 2004 - 2005 Nokia corporation
+ * Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ * Modified for omap shared clock framework by Tony Lindgren <tony@atomide.com>
+ * Copyright 2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
+ * Copyright 2010 Hans J. Koch, hjk at linutronix.de
+ *
+ * Licensed under the terms of the GPL v2.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+
+#include <mach/clock.h>
+#include <mach/hardware.h>
+
+static DEFINE_MUTEX(clocks_mutex);
+
+/*-------------------------------------------------------------------------
+ * Standard clock functions defined in include/linux/clk.h
+ *-------------------------------------------------------------------------*/
+
+static void __clk_disable(struct clk *clk)
+{
+	if (!clk)
+		return;
+
+	BUG_ON(clk->refcount == 0);
+
+	if (!(--clk->refcount) && clk->disable)
+		clk->disable(clk);
+	__clk_disable(clk->parent);
+}
+
+static int __clk_enable(struct clk *clk)
+{
+	if (!clk)
+		return -EINVAL;
+
+	__clk_enable(clk->parent);
+
+	if (clk->refcount++ == 0 && clk->enable)
+		clk->enable(clk);
+
+	return 0;
+}
+
+/* This function increments the reference count on the clock and enables the
+ * clock if not already enabled. The parent clock tree is recursively enabled
+ */
+int clk_enable(struct clk *clk)
+{
+	int ret = 0;
+
+	if (!clk)
+		return -EINVAL;
+
+	mutex_lock(&clocks_mutex);
+	ret = __clk_enable(clk);
+	mutex_unlock(&clocks_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_enable);
+
+/* This function decrements the reference count on the clock and disables
+ * the clock when reference count is 0. The parent clock tree is
+ * recursively disabled
+ */
+void clk_disable(struct clk *clk)
+{
+	if (!clk)
+		return;
+
+	mutex_lock(&clocks_mutex);
+	__clk_disable(clk);
+	mutex_unlock(&clocks_mutex);
+}
+EXPORT_SYMBOL_GPL(clk_disable);
+
+/* Retrieve the *current* clock rate. If the clock itself
+ * does not provide a special calculation routine, ask
+ * its parent and so on, until one is able to return
+ * a valid clock rate
+ */
+unsigned long clk_get_rate(struct clk *clk)
+{
+	if (!clk)
+		return 0UL;
+
+	if (clk->get_rate)
+		return clk->get_rate(clk);
+
+	return clk_get_rate(clk->parent);
+}
+EXPORT_SYMBOL_GPL(clk_get_rate);
+
+/* Round the requested clock rate to the nearest supported
+ * rate that is less than or equal to the requested rate.
+ * This is dependent on the clock's current parent.
+ */
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (!clk)
+		return 0;
+	if (!clk->round_rate)
+		return 0;
+
+	return clk->round_rate(clk, rate);
+}
+EXPORT_SYMBOL_GPL(clk_round_rate);
+
+/* Set the clock to the requested clock rate. The rate must
+ * match a supported rate exactly based on what clk_round_rate returns
+ */
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	int ret = -EINVAL;
+
+	if (!clk)
+		return ret;
+	if (!clk->set_rate || !rate)
+		return ret;
+
+	mutex_lock(&clocks_mutex);
+	ret = clk->set_rate(clk, rate);
+	mutex_unlock(&clocks_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_rate);
+
+/* Set the clock's parent to another clock source */
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	int ret = -EINVAL;
+
+	if (!clk)
+		return ret;
+	if (!clk->set_parent || !parent)
+		return ret;
+
+	mutex_lock(&clocks_mutex);
+	ret = clk->set_parent(clk, parent);
+	if (ret == 0)
+		clk->parent = parent;
+	mutex_unlock(&clocks_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_parent);
+
+/* Retrieve the clock's parent clock source */
+struct clk *clk_get_parent(struct clk *clk)
+{
+	if (!clk)
+		return NULL;
+
+	return clk->parent;
+}
+EXPORT_SYMBOL_GPL(clk_get_parent);
+
diff --git a/arch/arm/plat-tcc/include/mach/clkdev.h b/arch/arm/plat-tcc/include/mach/clkdev.h
new file mode 100644
index 0000000..04b37a8
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/clkdev.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_MACH_CLKDEV_H
+#define __ASM_MACH_CLKDEV_H
+
+#define __clk_get(clk) ({ 1; })
+#define __clk_put(clk) do { } while (0)
+
+#endif
diff --git a/arch/arm/plat-tcc/include/mach/clock.h b/arch/arm/plat-tcc/include/mach/clock.h
new file mode 100644
index 0000000..a12f58a
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/clock.h
@@ -0,0 +1,48 @@
+/*
+ * Low level clock header file for Telechips TCC architecture
+ * (C) 2010 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the GPL v2.
+ */
+
+#ifndef __ASM_ARCH_TCC_CLOCK_H__
+#define __ASM_ARCH_TCC_CLOCK_H__
+
+#ifndef __ASSEMBLY__
+
+struct clk {
+	struct clk *parent;
+	/* id number of a root clock, 0 for normal clocks */
+	int root_id;
+	/* Reference count of clock enable/disable */
+	int refcount;
+	/* Address of associated BCLKCTRx register. Must be set. */
+	void __iomem *bclkctr;
+	/* Bit position for BCLKCTRx. Must be set. */
+	int bclk_shift;
+	/* Address of ACLKxxx register, if any. */
+	void __iomem *aclkreg;
+	/* get the current clock rate (always a fresh value) */
+	unsigned long (*get_rate) (struct clk *);
+	/* Function ptr to set the clock to a new rate. The rate must match a
+	   supported rate returned from round_rate. Leave blank if clock is not
+	   programmable */
+	int (*set_rate) (struct clk *, unsigned long);
+	/* Function ptr to round the requested clock rate to the nearest
+	   supported rate that is less than or equal to the requested rate. */
+	unsigned long (*round_rate) (struct clk *, unsigned long);
+	/* Function ptr to enable the clock. Leave blank if clock can not
+	   be gated. */
+	int (*enable) (struct clk *);
+	/* Function ptr to disable the clock. Leave blank if clock can not
+	   be gated. */
+	void (*disable) (struct clk *);
+	/* Function ptr to set the parent clock of the clock. */
+	int (*set_parent) (struct clk *, struct clk *);
+};
+
+int clk_register(struct clk *clk);
+void clk_unregister(struct clk *clk);
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_ARCH_MXC_CLOCK_H__ */
-- 
1.6.3.3



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.275.1269547872.2170.linux-arm-kernel@lists.infradead.org>

Introduce lowlevel interrupt routines.

Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
---
 arch/arm/mach-tcc8k/Makefile          |    3 +-
 arch/arm/mach-tcc8k/irq.c             |  113 +++++++++++++++++++++++++++++++++
 arch/arm/plat-tcc/include/mach/irqs.h |   84 ++++++++++++++++++++++++
 3 files changed, 199 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tcc8k/irq.c
 create mode 100644 arch/arm/plat-tcc/include/mach/irqs.h

diff --git a/arch/arm/mach-tcc8k/Makefile b/arch/arm/mach-tcc8k/Makefile
index 805d850..24356e9 100644
--- a/arch/arm/mach-tcc8k/Makefile
+++ b/arch/arm/mach-tcc8k/Makefile
@@ -3,4 +3,5 @@
 #
 
 # Common support
-obj-y += clock.o
+obj-y += clock.o irq.o
+
diff --git a/arch/arm/mach-tcc8k/irq.c b/arch/arm/mach-tcc8k/irq.c
new file mode 100644
index 0000000..4d72859
--- /dev/null
+++ b/arch/arm/mach-tcc8k/irq.c
@@ -0,0 +1,113 @@
+/*
+ * Copyright (C) Telechips, Inc.
+ * Copyright (C) 2009-2010 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GNU GPL version 2.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/ptrace.h>
+
+#include <asm/irq.h>
+#include <asm/mach/irq.h>
+#include <asm/io.h>
+
+#include <mach/tcc8k-regs.h>
+#include <mach/irqs.h>
+
+/* Disable IRQ */
+static void tcc8000_mask_ack_irq0(unsigned int irq)
+{
+	PIC0_IEN &= ~(1 << irq);
+	PIC0_CREQ |=  (1 << irq);
+}
+
+static void tcc8000_mask_ack_irq1(unsigned int irq)
+{
+	PIC1_IEN &= ~(1 << (irq - 32));
+	PIC1_CREQ |= (1 << (irq - 32));
+}
+
+static void tcc8000_mask_irq0(unsigned int irq)
+{
+	PIC0_IEN &= ~(1 << irq);
+}
+
+static void tcc8000_mask_irq1(unsigned int irq)
+{
+	PIC1_IEN &= ~(1 << (irq - 32));
+}
+
+static void tcc8000_ack_irq0(unsigned int irq)
+{
+	PIC0_CREQ |=  (1 << irq);
+}
+
+static void tcc8000_ack_irq1(unsigned int irq)
+{
+	PIC1_CREQ |= (1 << (irq - 32));
+}
+
+/* Enable IRQ */
+static void tcc8000_unmask_irq0(unsigned int irq)
+{
+	PIC0_IEN |= (1 << irq);
+	PIC0_INTOEN |= (1 << irq);
+}
+
+static void tcc8000_unmask_irq1(unsigned int irq)
+{
+	PIC1_IEN |= (1 << (irq - 32));
+	PIC1_INTOEN |= (1 << (irq - 32));
+}
+
+static struct irq_chip tcc8000_irq_chip0 = {
+	.name		= "tcc_irq0",
+	.mask		= tcc8000_mask_irq0,
+	.ack		= tcc8000_ack_irq0,
+	.mask_ack	= tcc8000_mask_ack_irq0,
+	.unmask		= tcc8000_unmask_irq0,
+};
+
+static struct irq_chip tcc8000_irq_chip1 = {
+	.name		= "tcc_irq1",
+	.mask		= tcc8000_mask_irq1,
+	.ack		= tcc8000_ack_irq1,
+	.mask_ack	= tcc8000_mask_ack_irq1,
+	.unmask		= tcc8000_unmask_irq1,
+};
+
+void __init tcc8k_init_irq(void)
+{
+	int irqno;
+
+	/* Mask and clear all interrupts */
+	PIC0_IEN = 0x00000000;
+	PIC0_CREQ = 0xffffffff;
+	PIC1_IEN = 0x00000000;
+	PIC1_CREQ = 0xffffffff;
+
+	PIC0_MEN0 = 0x00000003;
+	PIC1_MEN1 = 0x00000003;
+	PIC1_MEN = 0x00000003;
+
+	/* let all IRQs be level triggered */
+	PIC0_TMODE = 0xffffffff;
+	PIC1_TMODE = 0xffffffff;
+	/* all IRQs are IRQs (not FIQs) */
+	PIC0_IRQSEL = 0xffffffff;
+	PIC1_IRQSEL = 0xffffffff;
+
+	for (irqno = 0; irqno < NR_IRQS; irqno++) {
+		if (irqno < 32)
+			set_irq_chip(irqno, &tcc8000_irq_chip0);
+		else
+			set_irq_chip(irqno, &tcc8000_irq_chip1);
+		set_irq_handler(irqno, handle_level_irq);
+		set_irq_flags(irqno, IRQF_VALID);
+	}
+}
+
diff --git a/arch/arm/plat-tcc/include/mach/irqs.h b/arch/arm/plat-tcc/include/mach/irqs.h
new file mode 100644
index 0000000..2e6bed8
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/irqs.h
@@ -0,0 +1,84 @@
+/*
+ * IRQ definitions for TCC8xxx
+ *
+ * Copyright (C) 2008-2009 Telechips
+ * Copyright (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GPL v2.
+ *
+ */
+
+#ifndef __ASM_ARCH_TCC_IRQS_H
+#define __ASM_ARCH_TCC_IRQS_H
+
+#define NR_IRQS 64
+
+/* PIC0 interrupts */
+#define INT_ADMA1	0
+#define INT_BDMA	1
+#define INT_ADMA0	2
+#define INT_GDMA1	3
+#define INT_I2S0RX	4
+#define INT_I2S0TX	5
+#define INT_TC		6
+#define INT_UART0	7
+#define INT_USBD	8
+#define INT_SPI0TX	9
+#define INT_UDMA	10
+#define INT_LIRQ	11
+#define INT_GDMA2	12
+#define INT_GDMA0	13
+#define INT_TC32	14
+#define INT_LCD		15
+#define INT_ADC		16
+#define INT_I2C		17
+#define INT_RTCP	18
+#define INT_RTCA	19
+#define INT_NFC		20
+#define INT_SD0		21
+#define INT_GSB0	22
+#define INT_PK		23
+#define INT_USBH0	24
+#define INT_USBH1	25
+#define INT_G2D		26
+#define INT_ECC		27
+#define INT_SPI0RX	28
+#define INT_UART1	29
+#define INT_MSCL	30
+#define INT_GSB1	31
+/* PIC1 interrupts */
+#define INT_E0		32
+#define INT_E1		33
+#define INT_E2		34
+#define INT_E3		35
+#define INT_E4		36
+#define INT_E5		37
+#define INT_E6		38
+#define INT_E7		39
+#define INT_UART2	40
+#define INT_UART3	41
+#define INT_SPI1TX	42
+#define INT_SPI1RX	43
+#define INT_GSB2	44
+#define INT_SPDIF	45
+#define INT_CDIF	46
+#define INT_VBON	47
+#define INT_VBOFF	48
+#define INT_SD1		49
+#define INT_UART4	50
+#define INT_GDMA3	51
+#define INT_I2S1RX	52
+#define INT_I2S1TX	53
+#define INT_CAN0	54
+#define INT_CAN1	55
+#define INT_GSB3	56
+#define INT_KRST	57
+#define INT_UNUSED	58
+#define INT_SD0D3	59
+#define INT_SD1D3	60
+#define INT_GPS0	61
+#define INT_GPS1	62
+#define INT_GPS2	63
+
+#endif  /* ASM_ARCH_TCC_IRQS_H */
+
-- 
1.6.3.3



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.276.1269547979.2170.linux-arm-kernel@lists.infradead.org>

Add the system timer using clockevents with the internal TC32 timer.
This also adds a clocksource using the same timer.

Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
---
 arch/arm/Kconfig                       |    1 +
 arch/arm/mach-tcc8k/Makefile           |    2 +-
 arch/arm/mach-tcc8k/time.c             |  150 ++++++++++++++++++++++++++++++++
 arch/arm/plat-tcc/include/mach/timex.h |    5 +
 4 files changed, 157 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tcc8k/time.c
 create mode 100644 arch/arm/plat-tcc/include/mach/timex.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8b9429c..7c6e731 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -728,6 +728,7 @@ config ARCH_TCC_926
 	select CPU_ARM926T
 	select HAVE_CLK
 	select COMMON_CLKDEV
+	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
 	  Support for Telechips TCC ARM926-based systems.
diff --git a/arch/arm/mach-tcc8k/Makefile b/arch/arm/mach-tcc8k/Makefile
index 24356e9..5673868 100644
--- a/arch/arm/mach-tcc8k/Makefile
+++ b/arch/arm/mach-tcc8k/Makefile
@@ -3,5 +3,5 @@
 #
 
 # Common support
-obj-y += clock.o irq.o
+obj-y += clock.o irq.o time.o
 
diff --git a/arch/arm/mach-tcc8k/time.c b/arch/arm/mach-tcc8k/time.c
new file mode 100644
index 0000000..db0a6da
--- /dev/null
+++ b/arch/arm/mach-tcc8k/time.c
@@ -0,0 +1,150 @@
+/*
+ * TCC8000 system timer setup
+ *
+ * (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GPL version 2.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+
+#include <asm/io.h>
+#include <asm/mach/time.h>
+
+#include <mach/tcc8k-regs.h>
+#include <mach/irqs.h>
+
+static void __iomem *timer_base;
+static struct clock_event_device clockevent_tcc;
+static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
+
+static cycle_t tcc_get_cycles(struct clocksource *cs)
+{
+	return __raw_readl(timer_base + TC32MCNT_OFFS);
+}
+
+static struct clocksource clocksource_tcc = {
+	.name		= "tcc_tc32",
+	.rating		= 200,
+	.read		= tcc_get_cycles,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 28,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static int tcc_set_next_event(unsigned long evt,
+			      struct clock_event_device *unused)
+{
+	unsigned long reg = __raw_readl(timer_base + TC32MCNT_OFFS);
+
+	__raw_writel(reg + evt, timer_base + TC32CMP0_OFFS);
+	return 0;
+}
+
+static void tcc_set_mode(enum clock_event_mode mode,
+				struct clock_event_device *evt)
+{
+	unsigned long tc32irq;
+
+	clockevent_mode = mode;
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_ONESHOT:
+		tc32irq = __raw_readl(timer_base + TC32IRQ_OFFS);
+		tc32irq |= TC32IRQ_IRQEN0;
+		__raw_writel(tc32irq, timer_base + TC32IRQ_OFFS);
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+		tc32irq = __raw_readl(timer_base + TC32IRQ_OFFS);
+		tc32irq &= ~TC32IRQ_IRQEN0;
+		__raw_writel(tc32irq, timer_base + TC32IRQ_OFFS);
+		break;
+	case CLOCK_EVT_MODE_PERIODIC:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static irqreturn_t tcc8k_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = &clockevent_tcc;
+
+	/* Acknowledge TC32 interrupt by reading TC32IRQ */
+	__raw_readl(timer_base + TC32IRQ_OFFS);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction tcc8k_timer_irq = {
+	.name		= "TC32_timer",
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.handler	= tcc8k_timer_interrupt,
+};
+
+static struct clock_event_device clockevent_tcc = {
+	.name		= "tcc_timer1",
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
+	.shift		= 32,
+	.set_mode	= tcc_set_mode,
+	.set_next_event	= tcc_set_next_event,
+	.rating		= 200,
+};
+
+static int __init tcc_clockevent_init(struct clk *clock)
+{
+	unsigned int c = clk_get_rate(clock);
+
+	clocksource_tcc.mult = clocksource_hz2mult(c,
+					clocksource_tcc.shift);
+	clocksource_register(&clocksource_tcc);
+
+	clockevent_tcc.mult = div_sc(c, NSEC_PER_SEC,
+					clockevent_tcc.shift);
+	clockevent_tcc.max_delta_ns =
+			clockevent_delta2ns(0xfffffffe, &clockevent_tcc);
+	clockevent_tcc.min_delta_ns =
+			clockevent_delta2ns(0xff, &clockevent_tcc);
+
+	clockevent_tcc.cpumask = cpumask_of(0);
+
+	clockevents_register_device(&clockevent_tcc);
+
+	return 0;
+}
+
+void __init tcc8k_timer_init(struct clk *clock, void __iomem *base, int irq)
+{
+	u32 reg;
+
+	timer_base = base;
+	tcc8k_timer_irq.irq = irq;
+
+	/* Enable clocks */
+	clk_enable(clock);
+
+	/* Initialize 32-bit timer */
+	reg = __raw_readl(timer_base + TC32EN_OFFS);
+	reg &= ~TC32EN_ENABLE; /* Disable timer */
+	__raw_writel(reg, timer_base + TC32EN_OFFS);
+	/* Free running timer, counting from 0 to 0xffffffff */
+	__raw_writel(0, timer_base + TC32EN_OFFS);
+	__raw_writel(0, timer_base + TC32LDV_OFFS);
+	reg = __raw_readl(timer_base + TC32IRQ_OFFS);
+	reg |= TC32IRQ_IRQEN0; /* irq at match with CMP0 */
+	__raw_writel(reg, timer_base + TC32IRQ_OFFS);
+
+	__raw_writel(TC32EN_ENABLE, timer_base + TC32EN_OFFS);
+
+	tcc_clockevent_init(clock);
+	setup_irq(irq, &tcc8k_timer_irq);
+}
diff --git a/arch/arm/plat-tcc/include/mach/timex.h b/arch/arm/plat-tcc/include/mach/timex.h
new file mode 100644
index 0000000..057acbe
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/timex.h
@@ -0,0 +1,5 @@
+/*
+ * A definition needed by arch core code.
+ *
+ */
+#define CLOCK_TICK_RATE		(HZ * 100000UL)
-- 
1.6.3.3



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.277.1269548122.2170.linux-arm-kernel@lists.infradead.org>

Map the IO ranges of TCC8xxx peripherals.

Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
---
 arch/arm/mach-tcc8k/Makefile        |    2 +-
 arch/arm/mach-tcc8k/io.c            |   68 +++++++++++++++++++++++++++++++++++
 arch/arm/plat-tcc/include/mach/io.h |   53 +++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tcc8k/io.c
 create mode 100644 arch/arm/plat-tcc/include/mach/io.h

diff --git a/arch/arm/mach-tcc8k/Makefile b/arch/arm/mach-tcc8k/Makefile
index 5673868..09552e2 100644
--- a/arch/arm/mach-tcc8k/Makefile
+++ b/arch/arm/mach-tcc8k/Makefile
@@ -3,5 +3,5 @@
 #
 
 # Common support
-obj-y += clock.o irq.o time.o
+obj-y += clock.o irq.o time.o io.o
 
diff --git a/arch/arm/mach-tcc8k/io.c b/arch/arm/mach-tcc8k/io.c
new file mode 100644
index 0000000..f499daf
--- /dev/null
+++ b/arch/arm/mach-tcc8k/io.c
@@ -0,0 +1,68 @@
+/*
+ * linux/arch/arm/mach-tcc8k/io.c
+ *
+ * (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * derived from TCC83xx io.c
+ * Copyright (C) Telechips, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <asm/tlb.h>
+#include <asm/mach/map.h>
+#include <asm/io.h>
+
+#include <mach/tcc8k-regs.h>
+
+/*
+ * The machine specific code may provide the extra mapping besides the
+ * default mapping provided here.
+ */
+static struct map_desc tcc8k_io_desc[] __initdata = {
+	{
+		.virtual	= CS1_BASE_VIRT,	/* CS1 (CS8900) */
+		.pfn		= __phys_to_pfn(CS1_BASE),
+		.length		= CS1_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= AHB_PERI_BASE_VIRT,	/* AHB peripherals */
+		.pfn		= __phys_to_pfn(AHB_PERI_BASE),
+		.length		= AHB_PERI_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= APB0_PERI_BASE_VIRT,	/* APB peripherals */
+		.pfn		= __phys_to_pfn(APB0_PERI_BASE),
+		.length		= APB0_PERI_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= APB1_PERI_BASE_VIRT,	/* APB peripherals */
+		.pfn		= __phys_to_pfn(APB1_PERI_BASE),
+		.length		= APB1_PERI_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= EXT_MEM_CTRL_BASE_VIRT, /* Ext. mem.contr. */
+		.pfn		= __phys_to_pfn(EXT_MEM_CTRL_BASE),
+		.length		= EXT_MEM_CTRL_SIZE,
+		.type		= MT_DEVICE
+	},
+};
+
+/*
+ * Maps common IO regions for tcc8k.
+ *
+ */
+void __init tcc8k_map_common_io(void)
+{
+	iotable_init(tcc8k_io_desc, ARRAY_SIZE(tcc8k_io_desc));
+}
+
diff --git a/arch/arm/plat-tcc/include/mach/io.h b/arch/arm/plat-tcc/include/mach/io.h
new file mode 100644
index 0000000..7d84370
--- /dev/null
+++ b/arch/arm/plat-tcc/include/mach/io.h
@@ -0,0 +1,53 @@
+/*
+ * Based on:    linux/include/asm-arm/arch-sa1100/io.h
+ * Author : <linux@telechips.com>
+ * Created: June 10, 2008
+ * Description: IO definitions for TCC8300 processors and boards
+ *
+ * Copyright (C) 1997-1999 Russell King
+ * Copyright (C) 2008-2009 Telechips
+ *
+ * Modifications for mainline (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of the GNU Public License version 2.
+ */
+
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+/*
+ * We don't actually have real ISA nor PCI buses, but there is so many
+ * drivers out there that might just work if we fake them...
+ */
+#define __io(a)			((void __iomem *)(PCIO_BASE + (a)))
+#define __mem_pci(a)		(a)
+
+/*
+ * ----------------------------------------------------------------------------
+ * I/O mapping
+ * ----------------------------------------------------------------------------
+ */
+
+#define PCIO_BASE	0
+
+/* Address Map of Internal Peripherials (Base 0x80000000) */
+#define IO_PHYS_A			0x80000000
+#define IO_OFFSET_A			0x70000000 /* Virtual IO = 0xF0000000 */
+#define IO_SIZE_A			0x100000
+#define IO_VIRT_A			(IO_PHYS + IO_OFFSET)
+#define IO_ADDRESS_A(pa)	((pa) + IO_OFFSET)
+#define IO_P2V_A(pa)		((pa) + IO_OFFSET)
+#define IO_V2P_A(va)		((va) - IO_OFFSET)
+
+/* Address Map of Internal Peripherials (Base 0x90000000) */
+#define IO_PHYS_B			0x90000000
+#define IO_OFFSET_B			0x61000000 /* Virtual IO = 0xF1000000 */
+#define IO_SIZE_B			0x100000
+#define IO_VIRT_B			(IO_PHYS + IO_OFFSET)
+#define IO_ADDRESS_B(pa)	((pa) + IO_OFFSET)
+#define IO_P2V_B(pa)		((pa) + IO_OFFSET)
+#define IO_V2P_B(va)		((va) - IO_OFFSET)
+
+#endif
-- 
1.6.3.3



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.278.1269548220.2170.linux-arm-kernel@lists.infradead.org>

This patch introduces a first set of platform devices for integrated
peripherals of TCC8xxx processors. Drivers for these devices are
available and will be posted in a second step.

Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
---
 arch/arm/mach-tcc8k/Makefile  |    2 +-
 arch/arm/mach-tcc8k/devices.c |  274 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 275 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tcc8k/devices.c

diff --git a/arch/arm/mach-tcc8k/Makefile b/arch/arm/mach-tcc8k/Makefile
index 09552e2..e8a1134 100644
--- a/arch/arm/mach-tcc8k/Makefile
+++ b/arch/arm/mach-tcc8k/Makefile
@@ -3,5 +3,5 @@
 #
 
 # Common support
-obj-y += clock.o irq.o time.o io.o
+obj-y += clock.o irq.o time.o io.o devices.o
 
diff --git a/arch/arm/mach-tcc8k/devices.c b/arch/arm/mach-tcc8k/devices.c
new file mode 100644
index 0000000..b6273af
--- /dev/null
+++ b/arch/arm/mach-tcc8k/devices.c
@@ -0,0 +1,274 @@
+/*
+ * linux/arch/arm/mach-tcc8k/devices.c
+ *
+ * Copyright (C) Telechips, Inc.
+ * Modifications for mainline (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * Licensed under the terms of GPL v2.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <asm/io.h>
+#include <asm/mach/map.h>
+
+#include <mach/tcc8k-regs.h>
+#include <mach/irqs.h>
+
+static u64 tcc8k_dmamask = DMA_BIT_MASK(32);
+
+#ifdef CONFIG_MTD_NAND_TCC
+/* NAND controller */
+static struct resource tcc_nand_resources[] = {
+	{
+		.start	= NFC_BASE,
+		.end	= NFC_BASE + 0x7f,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= INT_NFC,
+		.end	= INT_NFC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device tcc_nand_device = {
+	.name = "tcc_nand",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(tcc_nand_resources),
+	.resource = tcc_nand_resources,
+};
+#endif
+
+#ifdef CONFIG_MMC_TCC8K
+/* MMC controller */
+static struct resource tcc8k_mmc0_resource[] = {
+	{
+		.start = INT_SD0,
+		.end   = INT_SD0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct resource tcc8k_mmc1_resource[] = {
+	{
+		.start = INT_SD1,
+		.end   = INT_SD1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device tcc8k_mmc0_device = {
+	.name		= "tcc-mmc",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(tcc8k_mmc0_resource),
+	.resource	= tcc8k_mmc0_resource,
+	.dev		= {
+		.dma_mask		= &tcc8k_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+
+struct platform_device tcc8k_mmc1_device = {
+	.name		= "tcc-mmc",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(tcc8k_mmc1_resource),
+	.resource	= tcc8k_mmc1_resource,
+	.dev		= {
+		.dma_mask		= &tcc8k_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+
+static inline void tcc8k_init_mmc(void)
+{
+	u32 reg = __raw_readl(GPIOPS_BASE + GPIOPS_FS1_OFFS);
+
+	reg |= GPIOPS_FS1_SDH0_BITS | GPIOPS_FS1_SDH1_BITS;
+	__raw_writel(reg, GPIOPS_BASE + GPIOPS_FS1_OFFS);
+
+	platform_device_register(&tcc8k_mmc0_device);
+	platform_device_register(&tcc8k_mmc1_device);
+}
+#else
+static inline void tcc8k_init_mmc(void) { }
+#endif
+
+#ifdef CONFIG_SERIAL_TCC
+static struct resource uart0_resources[] = {
+	[0] = {
+		.start	= UART0_BASE,
+		.end	= UART0_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= INT_UART0,
+		.end	= INT_UART0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tcc8k_uart0_device = {
+	.name		= "tcc-uart",
+	.id		= 0,
+	.resource	= uart0_resources,
+	.num_resources	= ARRAY_SIZE(uart0_resources),
+};
+
+static inline void tcc8k_init_uart(void)
+{
+	u32 reg = __raw_readl(GPIOPU_BASE + GPIOPU_FS0_OFFS);
+
+	reg |= GPIOPU_FS0_TXD0 | GPIOPU_FS0_RXD0 |
+		GPIOPU_FS0_CTS0 | GPIOPU_FS0_RTS0;
+	__raw_writel(reg, GPIOPU_BASE + GPIOPU_FS0_OFFS);
+
+	platform_device_register(&tcc8k_uart0_device);
+}
+#else
+static inline void tcc8k_init_uart(void) { }
+#endif
+
+#ifdef CONFIG_USB_OHCI_HCD
+static int tcc8k_ohci_init(struct device *dev)
+{
+	u32 reg;
+
+	/* Use GPIO PK19 as VBUS control output */
+	reg = __raw_readl(GPIOPK_BASE + GPIOPK_FS0_OFFS);
+	reg &= ~(1 << 19);
+	__raw_writel(reg, GPIOPK_BASE + GPIOPK_FS0_OFFS);
+	reg = __raw_readl(GPIOPK_BASE + GPIOPK_FS1_OFFS);
+	reg &= ~(1 << 19);
+	__raw_writel(reg, GPIOPK_BASE + GPIOPK_FS1_OFFS);
+
+	reg = __raw_readl(GPIOPK_BASE + GPIOPK_DOE_OFFS);
+	reg |= (1 << 19);
+	__raw_writel(reg, GPIOPK_BASE + GPIOPK_DOE_OFFS);
+	/* Turn on VBUS */
+	reg = __raw_readl(GPIOPK_BASE + GPIOPK_DAT_OFFS);
+	reg |= (1 << 19);
+	__raw_writel(reg, GPIOPK_BASE + GPIOPK_DAT_OFFS);
+
+	return 0;
+}
+
+static struct resource tcc8k_ohci0_resources[] = {
+	[0] = {
+		.start = USBH0_BASE,
+		.end   = USBH0_BASE + 0x5c,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = INT_USBH0,
+		.end   = INT_USBH0,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static struct resource tcc8k_ohci1_resources[] = {
+	[0] = {
+		.start = USBH1_BASE,
+		.end   = USBH1_BASE + 0x5c,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = INT_USBH1,
+		.end   = INT_USBH1,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static struct tccohci_platform_data tcc8k_ohci0_platform_data = {
+	.controller	= 0,
+	.port_mode	= PMM_PERPORT_MODE,
+	.init		= tcc8k_ohci_init,
+};
+
+static struct tccohci_platform_data tcc8k_ohci1_platform_data = {
+	.controller	= 1,
+	.port_mode	= PMM_PERPORT_MODE,
+	.init		= tcc8k_ohci_init,
+};
+
+static struct platform_device ohci0_device = {
+	.name = "tcc-ohci",
+	.id = 0,
+	.dev = {
+		.dma_mask = &tcc8k_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &tcc8k_ohci0_platform_data,
+	},
+	.num_resources  = ARRAY_SIZE(tcc8k_ohci0_resources),
+	.resource       = tcc8k_ohci0_resources,
+};
+
+static struct platform_device ohci1_device = {
+	.name = "tcc-ohci",
+	.id = 1,
+	.dev = {
+		.dma_mask = &tcc8k_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &tcc8k_ohci1_platform_data,
+	},
+	.num_resources  = ARRAY_SIZE(tcc8k_ohci1_resources),
+	.resource       = tcc8k_ohci1_resources,
+};
+
+static void __init tcc8k_init_usbhost(void)
+{
+	platform_device_register(&ohci0_device);
+	platform_device_register(&ohci1_device);
+}
+#else
+static void __init tcc8k_init_usbhost(void) { }
+#endif
+
+/* USB device controller*/
+#ifdef CONFIG_USB_GADGET_TCC8K
+static struct resource udc_resources[] = {
+	[0] = {
+		.start = INT_USBD,
+		.end   = INT_USBD,
+		.flags = IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start = INT_UDMA,
+		.end   = INT_UDMA,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tcc8k_udc_device = {
+	.name = "tcc-udc",
+	.id = 0,
+	.resource = udc_resources,
+	.num_resources = ARRAY_SIZE(udc_resources),
+	.dev = {
+		 .dma_mask = &tcc8k_dmamask,
+		 .coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+};
+
+static void __init tcc8k_init_usb_gadget(void)
+{
+	platform_device_register(&tcc8k_udc_device);
+}
+#else
+static void __init tcc8k_init_usb_gadget(void) { }
+#endif	/* CONFIG_USB_GADGET_TCC83X */
+
+static int __init tcc8k_init_devices(void)
+{
+	tcc8k_init_uart();
+	tcc8k_init_mmc();
+	tcc8k_init_usbhost();
+	tcc8k_init_usb_gadget();
+	return 0;
+}
+
+arch_initcall(tcc8k_init_devices);
-- 
1.6.3.3



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.279.1269548308.2170.linux-arm-kernel@lists.infradead.org>

Add support for the Telechips TCC8000-SDK development board.

Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
---
 arch/arm/mach-tcc8k/Kconfig             |    6 +++
 arch/arm/mach-tcc8k/Makefile            |    3 ++
 arch/arm/mach-tcc8k/Makefile.boot       |    3 ++
 arch/arm/mach-tcc8k/board-tcc8000-sdk.c |   59 +++++++++++++++++++++++++++++++
 arch/arm/mach-tcc8k/board-tcc8000-sdk.h |   18 +++++++++
 5 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tcc8k/Makefile.boot
 create mode 100644 arch/arm/mach-tcc8k/board-tcc8000-sdk.c
 create mode 100644 arch/arm/mach-tcc8k/board-tcc8000-sdk.h

diff --git a/arch/arm/mach-tcc8k/Kconfig b/arch/arm/mach-tcc8k/Kconfig
index ec7f71b..ad86415 100644
--- a/arch/arm/mach-tcc8k/Kconfig
+++ b/arch/arm/mach-tcc8k/Kconfig
@@ -2,4 +2,10 @@ if ARCH_TCC8K
 
 comment "TCC8000 systems:"
 
+config MACH_TCC8000_SDK
+	bool "Telechips TCC8000-SDK development kit"
+	default y
+	help
+	  Support for the Telechips TCC8000-SDK board.
+
 endif
diff --git a/arch/arm/mach-tcc8k/Makefile b/arch/arm/mach-tcc8k/Makefile
index e8a1134..cd92cde 100644
--- a/arch/arm/mach-tcc8k/Makefile
+++ b/arch/arm/mach-tcc8k/Makefile
@@ -5,3 +5,6 @@
 # Common support
 obj-y += clock.o irq.o time.o io.o devices.o
 
+# Specific board support
+obj-$(CONFIG_MACH_TCC8000_SDK) += board-tcc8000-sdk.o
+
diff --git a/arch/arm/mach-tcc8k/Makefile.boot b/arch/arm/mach-tcc8k/Makefile.boot
new file mode 100644
index 0000000..f135c9d
--- /dev/null
+++ b/arch/arm/mach-tcc8k/Makefile.boot
@@ -0,0 +1,3 @@
+   zreladdr-y		:= 0x20008000
+params_phys-y		:= 0x20000100
+initrd_phys-y		:= 0x20800000
diff --git a/arch/arm/mach-tcc8k/board-tcc8000-sdk.c b/arch/arm/mach-tcc8k/board-tcc8000-sdk.c
new file mode 100644
index 0000000..545e586
--- /dev/null
+++ b/arch/arm/mach-tcc8k/board-tcc8000-sdk.c
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-types.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+
+#include "board-tcc8000-sdk.h"
+
+#ifdef CONFIG_MTD_NAND_TCC
+/* NAND */
+static struct tcc_nand_platform_data tcc8k_sdk_nand_data = {
+	.width = 1,
+	.hw_ecc = 0,
+};
+#endif
+
+static void __init tcc8k_init(void)
+{
+#ifdef CONFIG_MTD_NAND_TCC
+	tcc_nand_device.dev.platform_data = &tcc8k_sdk_nand_data;
+	platform_device_register(&tcc_nand_device);
+#endif
+}
+
+static void __init tcc8k_timer_init(void)
+{
+	tcc_clocks_init(XI_FREQUENCY, XTI_FREQUENCY);
+}
+
+static struct sys_timer tcc8k_timer = {
+	.init	= tcc8k_timer_init,
+};
+
+static void __init tcc8k_map_io(void)
+{
+	tcc8k_map_common_io();
+}
+
+MACHINE_START(TCC8000_SDK, "Telechips TCC8000-SDK Demo Board")
+	.phys_io	= 0x90000000,
+	.io_pg_offst	= ((0xf1000000) >> 18) & 0xfffc,
+	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.map_io		= tcc8k_map_io,
+	.init_irq	= tcc8k_init_irq,
+	.init_machine	= tcc8k_init,
+	.timer		= &tcc8k_timer,
+MACHINE_END
diff --git a/arch/arm/mach-tcc8k/board-tcc8000-sdk.h b/arch/arm/mach-tcc8k/board-tcc8000-sdk.h
new file mode 100644
index 0000000..1d4e791
--- /dev/null
+++ b/arch/arm/mach-tcc8k/board-tcc8000-sdk.h
@@ -0,0 +1,18 @@
+/*
+ * Some defines for arch/arm/mach-tcc8k/board-tcc8000-sdk.c
+ *
+ */
+
+#ifndef _BOARD_TCC_8000_SDK_H_
+#define _BOARD_TCC_8000_SDK_H_
+
+extern void __init tcc8k_init_irq(void);
+extern void __init tcc8k_map_common_io(void);
+extern int __init tcc_clocks_init(unsigned long xi_freq,
+					unsigned long xti_freq);
+extern struct platform_device tcc_nand_device;
+
+#define XI_FREQUENCY	12000000
+#define XTI_FREQUENCY	32768
+
+#endif
-- 
1.6.3.3



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.290.1270164227.2170.linux-arm-kernel@lists.infradead.org>

need something like this is the AMBA PL011 UART driver, RX part,
where data comes in from the outside and we have no control over
the data flow. I trigger one transfer to a buffer here, then wait for it
to complete or be interrupted. If it completes, I immediately trigger
another transfer to the second buffer before I start processing the just
recieved buffer (like front/back buffers).

I just hope that this will always be fast enough, queueing two transfers
after each other at the same time first would perhaps be better if the
hardware can handle it, now we have no hardware that can actually
queue that up so we can work it over the day we see something like
that...

(I don't know if I'm making myself clear, the PL011 patch may
speak for itself rather.)

> o =A0TODO: PAUSE/RESUME support. Currently the DMA API driver has to emul=
ate it.

The only PrimeCell that needs this is currently again the PL011.
It needs to PAUSE then get the number of pending bytes and then
terminate the transfer. This is done when we timeout transfers e.g.
for UART consoles. So being able to pause and retrieve the number
of bytes left and then cancel is the most advanced sequence that
will be used by a PrimeCell currently.

I've seen sample PCM/I2S drivers that wants PAUSE/RESUME though.

(...)
> Basic PL330 engine driver
>
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
> =A0arch/arm/common/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A0arch/arm/common/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/arm/common/pl330.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 1891 +++++++++++=
++++++++++++++++++++++
> =A0arch/arm/include/asm/hardware/pl330.h | =A0197 ++++
> =A04 files changed, 2092 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/common/pl330.c
> =A0create mode 100644 arch/arm/include/asm/hardware/pl330.h

Contemplate moving all but the header file to drivers/dma (not that I
have any strong feelings about it, just feels right).

(...)
> +/* Register and Bit field Definitions */
> +#define DS =A0 =A0 =A0 =A0 =A0 =A0 0x0
> +#define DS_ST_STOP =A0 =A0 0x0
> +#define DS_ST_EXEC =A0 =A0 0x1
> +#define DS_ST_CMISS =A0 =A00x2
> +#define DS_ST_UPDTPC =A0 0x3
> +#define DS_ST_WFE =A0 =A0 =A00x4
> +#define DS_ST_ATBRR =A0 =A00x5
> +#define DS_ST_QBUSY =A0 =A00x6
> +#define DS_ST_WFP =A0 =A0 =A00x7
> +#define DS_ST_KILL =A0 =A0 0x8
> +#define DS_ST_CMPLT =A0 =A00x9
> +#define DS_ST_FLTCMP =A0 0xe
> +#define DS_ST_FAULT =A0 =A00xf
> +
> +#define DPC =A0 =A0 =A0 =A0 =A0 =A00x4
> +#define INTEN =A0 =A0 =A0 =A0 =A00x20
> +#define ES =A0 =A0 =A0 =A0 =A0 =A0 0x24
> +#define INTSTATUS =A0 =A0 =A00x28
> +#define INTCLR =A0 =A0 =A0 =A0 0x2c
> +#define FSM =A0 =A0 =A0 =A0 =A0 =A00x30
> +#define FSC =A0 =A0 =A0 =A0 =A0 =A00x34
> +#define FTM =A0 =A0 =A0 =A0 =A0 =A00x38
> +
> +#define _FTC =A0 =A0 =A0 =A0 =A0 0x40
> +#define FTC(n) =A0 =A0 =A0 =A0 (_FTC + (n)*0x4)
> +
> +#define _CS =A0 =A0 =A0 =A0 =A0 =A00x100
> +#define CS(n) =A0 =A0 =A0 =A0 =A0(_CS + (n)*0x8)
> +#define CS_CNS =A0 =A0 =A0 =A0 (1 << 21)
> +
> +#define _CPC =A0 =A0 =A0 =A0 =A0 0x104
> +#define CPC(n) =A0 =A0 =A0 =A0 (_CPC + (n)*0x8)
> +
> +#define _SA =A0 =A0 =A0 =A0 =A0 =A00x400
> +#define SA(n) =A0 =A0 =A0 =A0 =A0(_SA + (n)*0x20)
> +
> +#define _DA =A0 =A0 =A0 =A0 =A0 =A00x404
> +#define DA(n) =A0 =A0 =A0 =A0 =A0(_DA + (n)*0x20)
> +
> +#define _CC =A0 =A0 =A0 =A0 =A0 =A00x408
> +#define CC(n) =A0 =A0 =A0 =A0 =A0(_CC + (n)*0x20)
> +
> +#define CC_SRCINC =A0 =A0 =A0(1 << 0)
> +#define CC_DSTINC =A0 =A0 =A0(1 << 14)
> +#define CC_SRCPRI =A0 =A0 =A0(1 << 8)
> +#define CC_DSTPRI =A0 =A0 =A0(1 << 22)
> +#define CC_SRCNS =A0 =A0 =A0 (1 << 9)
> +#define CC_DSTNS =A0 =A0 =A0 (1 << 23)
> +#define CC_SRCIA =A0 =A0 =A0 (1 << 10)
> +#define CC_DSTIA =A0 =A0 =A0 (1 << 24)
> +#define CC_SRCBRSTLEN_SHFT =A0 =A0 4
> +#define CC_DSTBRSTLEN_SHFT =A0 =A0 18
> +#define CC_SRCBRSTSIZE_SHFT =A0 =A01
> +#define CC_DSTBRSTSIZE_SHFT =A0 =A015
> +#define CC_SRCCCTRL_SHFT =A0 =A0 =A0 11
> +#define CC_SRCCCTRL_MASK =A0 =A0 =A0 0x7
> +#define CC_DSTCCTRL_SHFT =A0 =A0 =A0 25
> +#define CC_DRCCCTRL_MASK =A0 =A0 =A0 0x7
> +#define CC_SWAP_SHFT =A0 28
> +
> +#define _LC0 =A0 =A0 =A0 =A0 =A0 0x40c
> +#define LC0(n) =A0 =A0 =A0 =A0 (_LC0 + (n)*0x20)
> +
> +#define _LC1 =A0 =A0 =A0 =A0 =A0 0x410
> +#define LC1(n) =A0 =A0 =A0 =A0 (_LC1 + (n)*0x20)
> +
> +#define DBGSTATUS =A0 =A0 =A00xd00
> +#define DBG_BUSY =A0 =A0 =A0 (1 << 0)
> +
> +#define DBGCMD =A0 =A0 =A0 =A0 0xd04
> +#define DBGINST0 =A0 =A0 =A0 0xd08
> +#define DBGINST1 =A0 =A0 =A0 0xd0c
> +
> +#define CR0 =A0 =A0 =A0 =A0 =A0 =A00xe00
> +#define CR1 =A0 =A0 =A0 =A0 =A0 =A00xe04
> +#define CR2 =A0 =A0 =A0 =A0 =A0 =A00xe08
> +#define CR3 =A0 =A0 =A0 =A0 =A0 =A00xe0c
> +#define CR4 =A0 =A0 =A0 =A0 =A0 =A00xe10
> +#define CRD =A0 =A0 =A0 =A0 =A0 =A00xe14
> +
> +#define PERIPH_ID =A0 =A0 =A00xfe0
> +#define PCELL_ID =A0 =A0 =A0 0xff0
> +
> +#define CR0_PERIPH_REQ_SET =A0 =A0 (1 << 0)
> +#define CR0_BOOT_EN_SET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
> +#define CR0_BOOT_MAN_NS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
> +#define CR0_NUM_CHANS_SHIFT =A0 =A04
> +#define CR0_NUM_CHANS_MASK =A0 =A0 0x7
> +#define CR0_NUM_PERIPH_SHIFT =A0 12
> +#define CR0_NUM_PERIPH_MASK =A0 =A00x1f
> +#define CR0_NUM_EVENTS_SHIFT =A0 17
> +#define CR0_NUM_EVENTS_MASK =A0 =A00x1f
> +
> +#define CR1_ICACHE_LEN_SHIFT =A0 0
> +#define CR1_ICACHE_LEN_MASK =A0 =A00x7
> +#define CR1_NUM_ICACHELINES_SHIFT =A0 =A0 =A04
> +#define CR1_NUM_ICACHELINES_MASK =A0 =A0 =A0 0xf
> +
> +#define CRD_DATA_WIDTH_SHIFT =A0 0
> +#define CRD_DATA_WIDTH_MASK =A0 =A00x7
> +#define CRD_WR_CAP_SHIFT =A0 =A0 =A0 4
> +#define CRD_WR_CAP_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x7
> +#define CRD_WR_Q_DEP_SHIFT =A0 =A0 8
> +#define CRD_WR_Q_DEP_MASK =A0 =A0 =A00xf
> +#define CRD_RD_CAP_SHIFT =A0 =A0 =A0 12
> +#define CRD_RD_CAP_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x7
> +#define CRD_RD_Q_DEP_SHIFT =A0 =A0 16
> +#define CRD_RD_Q_DEP_MASK =A0 =A0 =A00xf
> +#define CRD_DATA_BUFF_SHIFT =A0 =A020
> +#define CRD_DATA_BUFF_MASK =A0 =A0 0x3ff
> +
> +#define =A0 =A0 =A0 =A0PART =A0 =A0 =A0 =A0 =A0 =A00x330
> +#define DESIGNER =A0 =A0 =A0 0x41
> +#define REVISION =A0 =A0 =A0 0x0
> +#define INTEG_CFG =A0 =A0 =A00x0
> +#define PERIPH_ID_VAL =A0((PART << 0) | (DESIGNER << 12) \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (REVISION << 20) | (I=
NTEG_CFG << 24))
> +
> +#define PCELL_ID_VAL =A0 0xb105f00d
> +
> +#define PL330_STATE_STOPPED =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
> +#define PL330_STATE_EXECUTING =A0 =A0 =A0 =A0 =A0(1 << 1)
> +#define PL330_STATE_WFE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
1 << 2)
> +#define PL330_STATE_FAULTING =A0 =A0 =A0 =A0 =A0 (1 << 3)
> +#define PL330_STATE_COMPLETING =A0 =A0 =A0 =A0 (1 << 4)
> +#define PL330_STATE_WFP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
1 << 5) /* TOUT for exit? */
> +#define PL330_STATE_KILLING =A0 =A0 =A0 =A0 =A0 =A0(1 << 6)
> +#define PL330_STATE_FAULT_COMPLETING =A0 (1 << 7)
> +#define PL330_STATE_CACHEMISS =A0 =A0 =A0 =A0 =A0(1 << 8)
> +#define PL330_STATE_UPDTPC =A0 =A0 =A0 =A0 =A0 =A0 (1 << 9)
> +#define PL330_STATE_ATBARRIER =A0 =A0 =A0 =A0 =A0(1 << 10) /* TOUT for e=
xit? */
> +#define PL330_STATE_QUEUEBUSY =A0 =A0 =A0 =A0 =A0(1 << 11) /* TOUT for e=
xit? */
> +#define PL330_STATE_INVALID =A0 =A0 =A0 =A0 =A0 =A0(1 << 15) /* To catch=
 error */
> +
> +#define PL330_STABLE_STATES (PL330_STATE_STOPPED | PL330_STATE_EXECUTING=
 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | PL330_STA=
TE_WFE | PL330_STATE_FAULTING)
> +
> +#define CMD_DMAADDH =A0 =A00x54
> +#define CMD_DMAEND =A0 =A0 0x00
> +#define CMD_DMAFLUSHP =A00x35
> +#define CMD_DMAGO =A0 =A0 =A00xa0
> +#define CMD_DMALD =A0 =A0 =A00x04
> +#define CMD_DMALDP =A0 =A0 0x25
> +#define CMD_DMALP =A0 =A0 =A00x20
> +#define CMD_DMALPEND =A0 0x28
> +#define CMD_DMAKILL =A0 =A00x01
> +#define CMD_DMAMOV =A0 =A0 0xbc
> +#define CMD_DMANOP =A0 =A0 0x18
> +#define CMD_DMARMB =A0 =A0 0x12
> +#define CMD_DMASEV =A0 =A0 0x34
> +#define CMD_DMAST =A0 =A0 =A00x08
> +#define CMD_DMASTP =A0 =A0 0x29
> +#define CMD_DMASTZ =A0 =A0 0x0c
> +#define CMD_DMAWFE =A0 =A0 0x36
> +#define CMD_DMAWFP =A0 =A0 0x30
> +#define CMD_DMAWMB =A0 =A0 0x13
> +
> +#define SZ_DMAADDH =A0 =A0 3
> +#define SZ_DMAEND =A0 =A0 =A01
> +#define SZ_DMAFLUSHP =A0 2
> +#define SZ_DMALD =A0 =A0 =A0 1
> +#define SZ_DMALDP =A0 =A0 =A02
> +#define SZ_DMALP =A0 =A0 =A0 2
> +#define SZ_DMALPEND =A0 =A02
> +#define SZ_DMAKILL =A0 =A0 1
> +#define SZ_DMAMOV =A0 =A0 =A06
> +#define SZ_DMANOP =A0 =A0 =A01
> +#define SZ_DMARMB =A0 =A0 =A01
> +#define SZ_DMASEV =A0 =A0 =A02
> +#define SZ_DMAST =A0 =A0 =A0 1
> +#define SZ_DMASTP =A0 =A0 =A02
> +#define SZ_DMASTZ =A0 =A0 =A01
> +#define SZ_DMAWFE =A0 =A0 =A02
> +#define SZ_DMAWFP =A0 =A0 =A02
> +#define SZ_DMAWMB =A0 =A0 =A01
> +#define SZ_DMAGO =A0 =A0 =A0 6
> +
> +#define BRST_LEN(ccr) =A0((((ccr) >> CC_SRCBRSTLEN_SHFT) & 0xf) + 1)
> +#define BRST_SIZE(ccr) (1 << (((ccr) >> CC_SRCBRSTSIZE_SHFT) & 0x7))
> +
> +#define BYTE_TO_BURST(b, ccr) =A0 =A0 =A0 =A0 =A0((b) / BRST_SIZE(ccr))
> +#define BURST_TO_BYTE(c, ccr) =A0 =A0 =A0 =A0 =A0((c) * BRST_SIZE(ccr))
> +
> +/* With 256 bytes, we can do more than 2.5MB and 5MB xfers per req
> + * at 1byte/burst for P<->M and M<->M respectively.
> + * For typical scenario, at 1word/burst, 10MB and 20MB xfers per req
> + * should be enough for P<->M and M<->M respectively.
> + */


I like multiline comments like this, notice blank first line:

/*
 * Foo
 */

(Yeah I know it's picky. Applies to entire file.)

> +#define MCODE_BUFF_PER_REQ =A0 =A0 256
> +
> +/* If program counter 'pc' is at req 'r' */
> +#define PC_AT_REQ(r, sz, pc) =A0 (((pc) >=3D (r)->mc_bus) && \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((pc) < ((r=
)->mc_bus + sz)))
> +
> +#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
> +
> +struct _xfer_spec {
> + =A0 =A0 =A0 u32 ccr;
> + =A0 =A0 =A0 struct pl330_req *r;
> + =A0 =A0 =A0 struct pl330_xfer *x;
> +};
> +
> +enum dmamov_dst {
> + =A0 =A0 =A0 SAR =3D 0,
> + =A0 =A0 =A0 CCR,
> + =A0 =A0 =A0 DAR,
> +};
> +
> +enum pl330_dst {
> + =A0 =A0 =A0 SRC =3D 0,
> + =A0 =A0 =A0 DST,
> +};
> +
> +enum pl330_cond {
> + =A0 =A0 =A0 SINGLE,
> + =A0 =A0 =A0 BURST,
> + =A0 =A0 =A0 ALWAYS,
> +};
> +
> +struct _pl330_req {
> + =A0 =A0 =A0 u32 mc_bus;
> + =A0 =A0 =A0 void *mc_cpu;
> + =A0 =A0 =A0 struct pl330_req *r;
> + =A0 =A0 =A0 /* hook to attach to DMAC's list of reqs with callbacks due=
 */
> + =A0 =A0 =A0 struct list_head rqd;
> +};
> +
> +struct _pl330_tbd {
> + =A0 =A0 =A0 /* DMAC needs to be reset */
> + =A0 =A0 =A0 unsigned reset_dmac:1;
> + =A0 =A0 =A0 /* manager needs to be reset */
> + =A0 =A0 =A0 unsigned reset_mngr:1;

Contemplate using bool for these two members.

> + =A0 =A0 =A0 /* which thread needs to be reset */
> + =A0 =A0 =A0 unsigned reset_chan:8;

Why not use:
u8 reset_chan;

> +};
> +
> +struct pl330_thread { /* Each DMA Channel */
> + =A0 =A0 =A0 u8 id;
> + =A0 =A0 =A0 int ev;
> + =A0 =A0 =A0 /* If the channel is not yet acquired by any client */
> + =A0 =A0 =A0 bool free;
> + =A0 =A0 =A0 /* 0 for inactive, index of active request + 1, otherwise *=
/
> + =A0 =A0 =A0 unsigned active;
> + =A0 =A0 =A0 struct mutex mtx;
> + =A0 =A0 =A0 /* Only two at a time */
> + =A0 =A0 =A0 struct _pl330_req req[2];
> + =A0 =A0 =A0 /* parent DMAC */
> + =A0 =A0 =A0 struct pl330_dmac *dmac;
> +};
> +
> +enum pl330_dmac_state {
> + =A0 =A0 =A0 UNINIT,
> + =A0 =A0 =A0 INIT,
> + =A0 =A0 =A0 DYING,
> +};
> +
> +/* Each DMA Controller */
> +struct pl330_dmac {
> + =A0 =A0 =A0 struct _pl330_tbd =A0 =A0 =A0 dmac_tbd;
> + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
> + =A0 =A0 =A0 /* hook to attach to global list of DMACs */
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0node;
> + =A0 =A0 =A0 /* Holds list of reqs with due callbacks */
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0req_done;
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev;
> + =A0 =A0 =A0 struct pl330_info =A0 =A0 =A0 pinfo;
> + =A0 =A0 =A0 /* Maximum possible events/irqs */
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 events[32];
> + =A0 =A0 =A0 /* BUS address of buffer allocated for MicroCode for all Ch=
annels */
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcode_bus;
> + =A0 =A0 =A0 /* CPU address of buffer allocated for MicroCode for all Ch=
annels*/
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*mcode_cpu;
> + =A0 =A0 =A0 struct pl330_thread =A0 =A0 *channels;
> + =A0 =A0 =A0 /* MANAGER thread is _always_ the last one */
> + =A0 =A0 =A0 struct pl330_thread =A0 =A0 *manager;
> + =A0 =A0 =A0 struct tasklet_struct =A0 tasks;
> + =A0 =A0 =A0 enum pl330_dmac_state =A0 state;
> +};
> +
> +/* All PL-330 DMACs are added to this list */
> +static LIST_HEAD(pl330_list);
> +/* Protection mutex while list manipulation */
> +static DEFINE_MUTEX(pl330_mutex);
> +
> +static inline void _callback(struct pl330_req *r, int err)
> +{
> + =A0 =A0 =A0 if (r && r->xfer_cb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->xfer_cb(r->token, err);
> +}
> +
> +static inline bool _queue_empty(struct pl330_thread *thrd)
> +{
> + =A0 =A0 =A0 return (thrd->req[0].r || thrd->req[1].r) ? false : true;
> +}
> +
> +static inline bool _queue_full(struct pl330_thread *thrd)
> +{
> + =A0 =A0 =A0 return (thrd->req[0].r && thrd->req[1].r) ? true : false;
> +}
> +
> +static inline bool is_manager(struct pl330_thread *thrd)
> +{
> + =A0 =A0 =A0 struct pl330_dmac *pl330 =3D thrd->dmac;
> +
> + =A0 =A0 =A0 /* MANAGER is indexed at the end */
> + =A0 =A0 =A0 if (thrd->id =3D=3D pl330->pinfo.pcfg.num_chan)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> +}
> +
> +/* If manager of the thread is in Non-Secure mode */
> +static inline bool _manager_ns(struct pl330_thread *thrd)
> +{
> + =A0 =A0 =A0 struct pl330_dmac *pl330 =3D thrd->dmac;
> +
> + =A0 =A0 =A0 return (pl330->pinfo.pcfg.mode & DMAC_MODE_NS) ? true : fal=
se;
> +}
> +
> +static inline u32 get_id(struct pl330_dmac *pl330, u32 off)
> +{
> + =A0 =A0 =A0 void __iomem *r =3D pl330->pinfo.base;
> + =A0 =A0 =A0 u32 id =3D 0;
> +
> + =A0 =A0 =A0 id |=3D (readb(r + off + 0x0) << 0);
> + =A0 =A0 =A0 id |=3D (readb(r + off + 0x4) << 8);
> + =A0 =A0 =A0 id |=3D (readb(r + off + 0x8) << 16);
> + =A0 =A0 =A0 id |=3D (readb(r + off + 0xc) << 24);
> +
> + =A0 =A0 =A0 return id;
> +}
> +
> +static inline u32 _emit_ADDH(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum pl330_dst da, u16 val)
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMAADDH;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMAADDH;
> + =A0 =A0 =A0 buf[0] |=3D (da << 1);
> + =A0 =A0 =A0 *((u16 *)&buf[1]) =3D val;
> +
> + =A0 =A0 =A0 return SZ_DMAADDH;
> +}
> +
> +static inline u32 _emit_END(unsigned dry_run, u8 buf[])
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMAEND;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMAEND;
> +
> + =A0 =A0 =A0 return SZ_DMAEND;
> +}
> +
> +static inline u32 _emit_FLUSHP(unsigned dry_run, u8 buf[], u8 peri)
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMAFLUSHP;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMAFLUSHP;
> +
> + =A0 =A0 =A0 peri &=3D 0x1f;
> + =A0 =A0 =A0 peri <<=3D 3;
> + =A0 =A0 =A0 buf[1] =3D peri;
> +
> + =A0 =A0 =A0 return SZ_DMAFLUSHP;
> +}
> +
> +static inline u32 _emit_LD(unsigned dry_run, u8 buf[], enum pl330_cond c=
ond)
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMALD;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMALD;
> +
> + =A0 =A0 =A0 if (cond =3D=3D SINGLE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (0 << 1) | (1 << 0);
> + =A0 =A0 =A0 else if (cond =3D=3D BURST)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (1 << 1) | (1 << 0);
> +
> + =A0 =A0 =A0 return SZ_DMALD;
> +}
> +
> +static inline u32 _emit_LDP(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum pl330_cond cond, u8 peri)
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMALDP;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMALDP;
> +
> + =A0 =A0 =A0 if (cond =3D=3D BURST)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (1 << 1);
> +
> + =A0 =A0 =A0 peri &=3D 0x1f;
> + =A0 =A0 =A0 peri <<=3D 3;
> + =A0 =A0 =A0 buf[1] =3D peri;
> +
> + =A0 =A0 =A0 return SZ_DMALDP;
> +}
> +
> +static inline u32 _emit_LP(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned loop, u8 cnt)
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMALP;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMALP;
> +
> + =A0 =A0 =A0 if (loop)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (1 << 1);
> +
> + =A0 =A0 =A0 buf[1] =3D cnt;
> +
> + =A0 =A0 =A0 return SZ_DMALP;
> +}
> +
> +struct _arg_LPEND {
> + =A0 =A0 =A0 enum pl330_cond cond;
> + =A0 =A0 =A0 bool forever;
> + =A0 =A0 =A0 unsigned loop;
> + =A0 =A0 =A0 u8 bjump;
> +};
> +
> +static inline u32 _emit_LPEND(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct _arg_LPEND *arg)
> +{
> + =A0 =A0 =A0 enum pl330_cond cond =3D arg->cond;
> + =A0 =A0 =A0 bool forever =3D arg->forever;
> + =A0 =A0 =A0 unsigned loop =3D arg->loop;
> + =A0 =A0 =A0 u8 bjump =3D arg->bjump;
> +
> +
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMALPEND;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMALPEND;
> +
> + =A0 =A0 =A0 if (loop)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (1 << 2);
> +
> + =A0 =A0 =A0 if (forever)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (1 << 4);
> +
> + =A0 =A0 =A0 if (cond =3D=3D SINGLE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (0 << 1) | (1 << 0);
> + =A0 =A0 =A0 else if (cond =3D=3D BURST)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (1 << 1) | (1 << 0);
> +
> + =A0 =A0 =A0 buf[1] =3D bjump;
> +
> + =A0 =A0 =A0 return SZ_DMALPEND;
> +}
> +
> +static inline u32 _emit_KILL(unsigned dry_run, u8 buf[])
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMAKILL;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMAKILL;
> +
> + =A0 =A0 =A0 return SZ_DMAKILL;
> +}
> +
> +static inline u32 _emit_MOV(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum dmamov_dst dst, u32 val)
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMAMOV;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMAMOV;
> + =A0 =A0 =A0 buf[1] =3D dst;
> + =A0 =A0 =A0 *((u32 *)&buf[2]) =3D val;
> +
> + =A0 =A0 =A0 return SZ_DMAMOV;
> +}
> +
> +static inline u32 _emit_NOP(unsigned dry_run, u8 buf[])
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMANOP;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMANOP;
> +
> + =A0 =A0 =A0 return SZ_DMANOP;
> +}
> +
> +static inline u32 _emit_RMB(unsigned dry_run, u8 buf[])
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMARMB;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMARMB;
> +
> + =A0 =A0 =A0 return SZ_DMARMB;
> +}
> +
> +static inline u32 _emit_SEV(unsigned dry_run, u8 buf[], u8 ev)
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMASEV;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMASEV;
> +
> + =A0 =A0 =A0 ev &=3D 0x1f;
> + =A0 =A0 =A0 ev <<=3D 3;
> + =A0 =A0 =A0 buf[1] =3D ev;
> +
> + =A0 =A0 =A0 return SZ_DMASEV;
> +}
> +
> +static inline u32 _emit_ST(unsigned dry_run, u8 buf[], enum pl330_cond c=
ond)
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMAST;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMAST;
> +
> + =A0 =A0 =A0 if (cond =3D=3D SINGLE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (0 << 1) | (1 << 0);
> + =A0 =A0 =A0 else if (cond =3D=3D BURST)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (1 << 1) | (1 << 0);
> +
> + =A0 =A0 =A0 return SZ_DMAST;
> +}
> +
> +static inline u32 _emit_STP(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum pl330_cond cond, u8 peri)
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMASTP;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMASTP;
> +
> + =A0 =A0 =A0 if (cond =3D=3D BURST)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (1 << 1);
> +
> + =A0 =A0 =A0 peri &=3D 0x1f;
> + =A0 =A0 =A0 peri <<=3D 3;
> + =A0 =A0 =A0 buf[1] =3D peri;
> +
> + =A0 =A0 =A0 return SZ_DMASTP;
> +}
> +
> +static inline u32 _emit_STZ(unsigned dry_run, u8 buf[])
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMASTZ;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMASTZ;
> +
> + =A0 =A0 =A0 return SZ_DMASTZ;
> +}
> +
> +static inline u32 _emit_WFE(unsigned dry_run, u8 buf[], u8 ev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned invalidate)
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMAWFE;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMAWFE;
> +
> + =A0 =A0 =A0 ev &=3D 0x1f;
> + =A0 =A0 =A0 ev <<=3D 3;
> + =A0 =A0 =A0 buf[1] =3D ev;
> +
> + =A0 =A0 =A0 if (invalidate)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[1] |=3D (1 << 1);
> +
> + =A0 =A0 =A0 return SZ_DMAWFE;
> +}
> +
> +static inline u32 _emit_WFP(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum pl330_cond cond, u8 peri)
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMAWFP;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMAWFP;
> +
> + =A0 =A0 =A0 if (cond =3D=3D SINGLE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (0 << 1) | (0 << 0);
> + =A0 =A0 =A0 else if (cond =3D=3D BURST)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (1 << 1) | (0 << 0);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (0 << 1) | (1 << 0);
> +
> + =A0 =A0 =A0 peri &=3D 0x1f;
> + =A0 =A0 =A0 peri <<=3D 3;
> + =A0 =A0 =A0 buf[1] =3D peri;
> +
> + =A0 =A0 =A0 return SZ_DMAWFP;
> +}
> +
> +static inline u32 _emit_WMB(unsigned dry_run, u8 buf[])
> +{
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMAWMB;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMAWMB;
> +
> + =A0 =A0 =A0 return SZ_DMAWMB;
> +}
> +
> +struct _arg_GO {
> + =A0 =A0 =A0 u8 chan;
> + =A0 =A0 =A0 u32 addr;
> + =A0 =A0 =A0 unsigned ns:1;
> +};
> +
> +static inline u32 _emit_GO(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct _arg_GO *arg)
> +{
> + =A0 =A0 =A0 u8 chan =3D arg->chan;
> + =A0 =A0 =A0 u32 addr =3D arg->addr;
> + =A0 =A0 =A0 unsigned ns =3D arg->ns;
> +
> + =A0 =A0 =A0 if (dry_run)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return SZ_DMAGO;
> +
> + =A0 =A0 =A0 buf[0] =3D CMD_DMAGO;
> + =A0 =A0 =A0 if (ns)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] |=3D (ns << 1);
> +
> + =A0 =A0 =A0 buf[1] =3D chan & 0x7;
> +
> + =A0 =A0 =A0 *((u32 *)&buf[2]) =3D addr;
> +
> + =A0 =A0 =A0 return SZ_DMAGO;
> +}

With all these emit_* functions you have half a microcode compiler in the
driver, but I really, really like it! It's the right foundation for
hackers that want
to have fun with the microcode generation later on.

> +static inline void _execute_DBGINSN(struct pl330_thread *thrd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 insn[], bool as_manager)
> +{
> + =A0 =A0 =A0 void __iomem *regs =3D thrd->dmac->pinfo.base;
> + =A0 =A0 =A0 u32 val;
> +
> + =A0 =A0 =A0 val =3D (insn[0] << 16) | (insn[1] << 24);
> + =A0 =A0 =A0 if (!as_manager) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D (1 << 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D (thrd->id << 8); /* Channel Number=
 */
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 writel(val, regs + DBGINST0);
> +
> + =A0 =A0 =A0 val =3D *((u32 *)&insn[2]);
> + =A0 =A0 =A0 writel(val, regs + DBGINST1);
> +}
> +
> +/* Returns Time-Out */
> +static bool _until_dmac_idle(struct pl330_thread *thrd)
> +{
> + =A0 =A0 =A0 void __iomem *regs =3D thrd->dmac->pinfo.base;
> + =A0 =A0 =A0 unsigned long loops =3D msecs_to_loops(5);
> +
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Until Manager is Idle */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(readl(regs + DBGSTATUS) & DBG_BUSY))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> + =A0 =A0 =A0 } while (--loops);
> +
> + =A0 =A0 =A0 if (!loops)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> +
> + =A0 =A0 =A0 return false;
> +}
> +
> +static inline u32 _state(struct pl330_thread *thrd)
> +{
> + =A0 =A0 =A0 void __iomem *regs =3D thrd->dmac->pinfo.base;
> + =A0 =A0 =A0 u32 val;
> +
> + =A0 =A0 =A0 if (is_manager(thrd))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D readl(regs + DS) & 0xf;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D readl(regs + CS(thrd->id)) & 0xf;
> +
> + =A0 =A0 =A0 switch (val) {
> + =A0 =A0 =A0 case DS_ST_STOP:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_STOPPED;
> + =A0 =A0 =A0 case DS_ST_EXEC:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_EXECUTING;
> + =A0 =A0 =A0 case DS_ST_CMISS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_CACHEMISS;
> + =A0 =A0 =A0 case DS_ST_UPDTPC:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_UPDTPC;
> + =A0 =A0 =A0 case DS_ST_WFE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_WFE;
> + =A0 =A0 =A0 case DS_ST_FAULT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_FAULTING;
> + =A0 =A0 =A0 case DS_ST_ATBRR:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_manager(thrd))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_INVALID;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_ATBARRIE=
R;
> + =A0 =A0 =A0 case DS_ST_QBUSY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_manager(thrd))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_INVALID;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_QUEUEBUS=
Y;
> + =A0 =A0 =A0 case DS_ST_WFP:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_manager(thrd))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_INVALID;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_WFP;
> + =A0 =A0 =A0 case DS_ST_KILL:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_manager(thrd))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_INVALID;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_KILLING;
> + =A0 =A0 =A0 case DS_ST_CMPLT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_manager(thrd))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_INVALID;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_COMPLETI=
NG;
> + =A0 =A0 =A0 case DS_ST_FLTCMP:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_manager(thrd))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_INVALID;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_FAULT_CO=
MPLETING;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PL330_STATE_INVALID;
> + =A0 =A0 =A0 }
> +}
> +
> +/* Use this _only_ to wait on transient states */
> +#define UNTIL(t, s) =A0 =A0while (!(_state(t) & (s))) cpu_relax();
> +
> +/* Start doing req 'idx' of thread 'thrd' */
> +static bool _trigger(struct pl330_thread *thrd, unsigned idx)
> +{
> + =A0 =A0 =A0 void __iomem *regs =3D thrd->dmac->pinfo.base;
> + =A0 =A0 =A0 struct _pl330_req *req =3D &thrd->req[idx];
> + =A0 =A0 =A0 struct pl330_req *r =3D req->r;
> + =A0 =A0 =A0 struct _arg_GO go;
> + =A0 =A0 =A0 unsigned ns;

bool

> + =A0 =A0 =A0 u8 insn[6] =3D {0, 0, 0, 0, 0, 0};
> +
> + =A0 =A0 =A0 /* Return if already ACTIVE */
> + =A0 =A0 =A0 if (_state(thrd) !=3D PL330_STATE_STOPPED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> +
> + =A0 =A0 =A0 /* Return if no request */
> + =A0 =A0 =A0 if (!r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> +
> + =A0 =A0 =A0 /* If timed out due to halted state-machine */
> + =A0 =A0 =A0 if (_until_dmac_idle(thrd))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> +
> + =A0 =A0 =A0 if (r->cfg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ns =3D r->cfg->nonsecure ? 1 : 0;

Since you defined nonsecure as :1 you could just assign it.
But please make both ns and cfg->nonsecure bool.

> + =A0 =A0 =A0 else if (readl(regs + CS(thrd->id)) & CS_CNS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ns =3D 1;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ns =3D 0;
> +
> + =A0 =A0 =A0 /* See 'Abort Sources' point-4 at Page 2-25 */
> + =A0 =A0 =A0 if (_manager_ns(thrd) && !ns)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s:%d Recipe for ABORT!\n=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, __LINE__);


dev_info(thrd->dmac->dev, "....");

> +
> + =A0 =A0 =A0 go.chan =3D thrd->id;
> + =A0 =A0 =A0 go.addr =3D req->mc_bus;
> + =A0 =A0 =A0 go.ns =3D ns;
> + =A0 =A0 =A0 _emit_GO(0, insn, &go);
> +
> + =A0 =A0 =A0 /* Set to generate interrupts for SEV */
> + =A0 =A0 =A0 writel(readl(regs + INTEN) | (1 << thrd->ev), regs + INTEN)=
;
> +
> + =A0 =A0 =A0 /* Only manager can execute GO */
> + =A0 =A0 =A0 _execute_DBGINSN(thrd, insn, true);
> +
> + =A0 =A0 =A0 return true;
> +}
> +
> +/* Makes sure the thread is in STOPPED state */
> +static void _stop(struct pl330_thread *thrd)
> +{
> + =A0 =A0 =A0 u8 insn[6] =3D {0, 0, 0, 0, 0, 0};
> +
> + =A0 =A0 =A0 /* Return if already STOPPED */
> + =A0 =A0 =A0 if (_state(thrd) =3D=3D PL330_STATE_STOPPED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (is_manager(thrd))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _emit_END(0, insn);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _emit_KILL(0, insn);
> +
> + =A0 =A0 =A0 _execute_DBGINSN(thrd, insn, is_manager(thrd));
> +}
> +
> +static bool _start(struct pl330_thread *thrd)
> +{
> + =A0 =A0 =A0 switch (_state(thrd)) {
> + =A0 =A0 =A0 case PL330_STATE_FAULT_COMPLETING:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 UNTIL(thrd, PL330_STATE_FAULTING | PL330_ST=
ATE_KILLING);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (_state(thrd) =3D=3D PL330_STATE_KILLING=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UNTIL(thrd, PL330_STATE_STO=
PPED)
> +
> + =A0 =A0 =A0 case PL330_STATE_FAULTING:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _stop(thrd);
> +
> + =A0 =A0 =A0 case PL330_STATE_KILLING:
> + =A0 =A0 =A0 case PL330_STATE_COMPLETING:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 UNTIL(thrd, PL330_STATE_STOPPED)
> +
> + =A0 =A0 =A0 case PL330_STATE_STOPPED:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return _trigger(thrd, thrd->req[0].r ? 0 : =
1);
> +
> + =A0 =A0 =A0 case PL330_STATE_WFP:
> + =A0 =A0 =A0 case PL330_STATE_QUEUEBUSY:
> + =A0 =A0 =A0 case PL330_STATE_ATBARRIER:
> + =A0 =A0 =A0 case PL330_STATE_UPDTPC:
> + =A0 =A0 =A0 case PL330_STATE_CACHEMISS:
> + =A0 =A0 =A0 case PL330_STATE_EXECUTING:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> +
> + =A0 =A0 =A0 case PL330_STATE_WFE: /* for PAUSE - nothing yet */
> + =A0 =A0 =A0 default: /* Shouldn't reach here with some transient state =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> + =A0 =A0 =A0 }
> +}
> +
> +static inline u32 _prepare_ccr(struct pl330_reqcfg *rqc)
> +{
> + =A0 =A0 =A0 u32 ccr =3D 0;
> +
> + =A0 =A0 =A0 if (rqc->src_inc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ccr |=3D CC_SRCINC;
> +
> + =A0 =A0 =A0 if (rqc->dst_inc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ccr |=3D CC_DSTINC;
> +
> + =A0 =A0 =A0 /* We set same protection levels for Src and DST for now */
> + =A0 =A0 =A0 if (rqc->privileged)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ccr |=3D CC_SRCPRI | CC_DSTPRI;
> + =A0 =A0 =A0 if (rqc->nonsecure)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ccr |=3D CC_SRCNS | CC_DSTNS;
> + =A0 =A0 =A0 if (rqc->insnaccess)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ccr |=3D CC_SRCIA | CC_DSTIA;
> +
> + =A0 =A0 =A0 ccr |=3D (((rqc->brst_len - 1) & 0xf) << CC_SRCBRSTLEN_SHFT=
);
> + =A0 =A0 =A0 ccr |=3D (((rqc->brst_len - 1) & 0xf) << CC_DSTBRSTLEN_SHFT=
);
> +
> + =A0 =A0 =A0 ccr |=3D (rqc->brst_size << CC_SRCBRSTSIZE_SHFT);
> + =A0 =A0 =A0 ccr |=3D (rqc->brst_size << CC_DSTBRSTSIZE_SHFT);
> +
> + =A0 =A0 =A0 ccr |=3D (rqc->dcctl << CC_SRCCCTRL_SHFT);
> + =A0 =A0 =A0 ccr |=3D (rqc->scctl << CC_DSTCCTRL_SHFT);
> +
> + =A0 =A0 =A0 ccr |=3D (rqc->swap << CC_SWAP_SHFT);
> +
> + =A0 =A0 =A0 return ccr;
> +}
> +
> +static inline bool _is_valid(u32 ccr)
> +{
> + =A0 =A0 =A0 enum pl330_dstcachectrl dcctl;
> + =A0 =A0 =A0 enum pl330_srccachectrl scctl;
> +
> + =A0 =A0 =A0 dcctl =3D (ccr >> CC_DSTCCTRL_SHFT) & CC_DRCCCTRL_MASK;
> + =A0 =A0 =A0 scctl =3D (ccr >> CC_SRCCCTRL_SHFT) & CC_SRCCCTRL_MASK;
> +
> + =A0 =A0 =A0 if (dcctl =3D=3D DINVALID1 || dcctl =3D=3D DINVALID2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || scctl =3D=3D SINVALID1 |=
| scctl =3D=3D SINVALID2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> +}
> +
> +static inline int _ldst_memtomem(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct _xfer_spec *pxs, int cyc)
> +{
> + =A0 =A0 =A0 int off =3D 0;
> +
> + =A0 =A0 =A0 while (cyc--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Do we need RMB/WMB for each load/store? =
REVISIT XXX */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_LD(dry_run, &buf[off], ALWAY=
S);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_RMB(dry_run, &buf[off]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_ST(dry_run, &buf[off], ALWAY=
S);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_WMB(dry_run, &buf[off]);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return off;
> +}
> +
> +static inline int _ldst_devtomem(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct _xfer_spec *pxs, int cyc)
> +{
> + =A0 =A0 =A0 int off =3D 0;
> +
> + =A0 =A0 =A0 while (cyc--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Do we need WFP for every cycle? REVISIT =
XXX */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_WFP(dry_run, &buf[off], SING=
LE, pxs->r->peri);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_LDP(dry_run, &buf[off], SING=
LE, pxs->r->peri);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_ST(dry_run, &buf[off], ALWAY=
S);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Do we need FLUSHP for every cycle? REVIS=
IT XXX */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_FLUSHP(dry_run, &buf[off], p=
xs->r->peri);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return off;
> +}
> +
> +static inline int _ldst_memtodev(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct _xfer_spec *pxs, int cyc)
> +{
> + =A0 =A0 =A0 int off =3D 0;
> +
> + =A0 =A0 =A0 while (cyc--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Do we need WFP for every cycle? REVISIT =
XXX */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_WFP(dry_run, &buf[off], SING=
LE, pxs->r->peri);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_LD(dry_run, &buf[off], ALWAY=
S);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_STP(dry_run, &buf[off], SING=
LE, pxs->r->peri);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Do we need FLUSHP for every cycle? REVIS=
IT XXX */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_FLUSHP(dry_run, &buf[off], p=
xs->r->peri);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return off;
> +}
> +
> +static int _bursts(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct _xfer_spec *pxs, int cyc)
> +{
> + =A0 =A0 =A0 int off =3D 0;
> +
> + =A0 =A0 =A0 switch (pxs->r->rqtype) {
> + =A0 =A0 =A0 case MEMTODEV:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _ldst_memtodev(dry_run, &buf[off],=
 pxs, cyc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case DEVTOMEM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _ldst_devtomem(dry_run, &buf[off],=
 pxs, cyc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case MEMTOMEM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _ldst_memtomem(dry_run, &buf[off],=
 pxs, cyc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D 0x40000000; /* Scare off the Clien=
t */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return off;
> +}
> +
> +/* Returns bytes consumed and updates bursts */
> +static inline int _loop(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long *bursts, const struct _xfer_s=
pec *pxs)
> +{
> + =A0 =A0 =A0 int cyc, cycmax, szlp, szlpend, szbrst, off;
> + =A0 =A0 =A0 unsigned lcnt0, lcnt1, ljmp0, ljmp1;
> + =A0 =A0 =A0 struct _arg_LPEND lpend;
> +
> + =A0 =A0 =A0 /* Max iterations possibile in DMALP is 256 */
> + =A0 =A0 =A0 if (*bursts >=3D 256*256) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcnt1 =3D 256;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcnt0 =3D 256;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cyc =3D *bursts / lcnt1 / lcnt0;
> + =A0 =A0 =A0 } else if (*bursts > 256) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcnt1 =3D 256;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcnt0 =3D *bursts / lcnt1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cyc =3D 1;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcnt1 =3D *bursts;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcnt0 =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cyc =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 szlp =3D _emit_LP(1, buf, 0, 0);
> + =A0 =A0 =A0 szbrst =3D _bursts(1, buf, pxs, 1);
> +
> + =A0 =A0 =A0 lpend.cond =3D ALWAYS;
> + =A0 =A0 =A0 lpend.forever =3D false;
> + =A0 =A0 =A0 lpend.loop =3D 0;
> + =A0 =A0 =A0 lpend.bjump =3D 0;
> + =A0 =A0 =A0 szlpend =3D _emit_LPEND(1, buf, &lpend);
> +
> + =A0 =A0 =A0 if (lcnt0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 szlp *=3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 szlpend *=3D 2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /** Do not mess with the construct **/

Which means? Hackers like to mess with stuff... Note to self?
Usually comments like that is a trace of questionable design
so if the design is solid, remove the comments because then it
will be obvious that you don't want to mess with the construct.

> +
> + =A0 =A0 =A0 /* Max bursts that we can unroll due to limit on the
> + =A0 =A0 =A0 =A0* size of backward jump that can be encoded in DMALPEND
> + =A0 =A0 =A0 =A0* which is 8-bits and hence 255
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 cycmax =3D (255 - (szlp + szlpend)) / szbrst;
> +
> + =A0 =A0 =A0 cyc =3D (cycmax < cyc) ? cycmax : cyc;
> +
> + =A0 =A0 =A0 off =3D 0;
> +
> + =A0 =A0 =A0 ljmp0 =3D off;
> + =A0 =A0 =A0 if (lcnt0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_LP(dry_run, &buf[off], 0, lc=
nt0);
> +
> + =A0 =A0 =A0 ljmp1 =3D off;
> + =A0 =A0 =A0 off +=3D _emit_LP(dry_run, &buf[off], 1, lcnt1);
> +
> + =A0 =A0 =A0 off +=3D _bursts(dry_run, &buf[off], pxs, cyc);
> +
> + =A0 =A0 =A0 lpend.cond =3D ALWAYS;
> + =A0 =A0 =A0 lpend.forever =3D false;
> + =A0 =A0 =A0 lpend.loop =3D 1;
> + =A0 =A0 =A0 lpend.bjump =3D off - ljmp1;
> + =A0 =A0 =A0 off +=3D _emit_LPEND(dry_run, &buf[off], &lpend);
> +
> + =A0 =A0 =A0 if (lcnt0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpend.cond =3D ALWAYS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpend.forever =3D false;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpend.loop =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpend.bjump =3D off - ljmp0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _emit_LPEND(dry_run, &buf[off], &l=
pend);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /***********************************/
> +
> + =A0 =A0 =A0 *bursts =3D lcnt1 * cyc;
> + =A0 =A0 =A0 if (lcnt0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *bursts *=3D lcnt0;
> +
> + =A0 =A0 =A0 return off;
> +}
> +
> +static inline int _setup_loops(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct _xfer_spec *pxs)
> +{
> + =A0 =A0 =A0 struct pl330_xfer *x =3D pxs->x;
> + =A0 =A0 =A0 u32 ccr =3D pxs->ccr;
> + =A0 =A0 =A0 unsigned long c, bursts =3D BYTE_TO_BURST(x->bytes, ccr);
> + =A0 =A0 =A0 int off =3D 0;
> +
> + =A0 =A0 =A0 while (bursts) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 c =3D bursts;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _loop(dry_run, &buf[off], &c, pxs)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bursts -=3D c;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return off;
> +}
> +
> +static inline int _setup_xfer(unsigned dry_run, u8 buf[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct _xfer_spec *pxs)
> +{
> + =A0 =A0 =A0 struct pl330_xfer *x =3D pxs->x;
> + =A0 =A0 =A0 int off =3D 0;
> +
> + =A0 =A0 =A0 /* DMAMOV SAR, x->src_addr */
> + =A0 =A0 =A0 off +=3D _emit_MOV(dry_run, &buf[off], SAR, x->src_addr);
> + =A0 =A0 =A0 /* DMAMOV DAR, x->dst_addr */
> + =A0 =A0 =A0 off +=3D _emit_MOV(dry_run, &buf[off], DAR, x->dst_addr);
> +
> + =A0 =A0 =A0 /* Setup Loop(s) */
> + =A0 =A0 =A0 off +=3D _setup_loops(dry_run, &buf[off], pxs);
> +
> + =A0 =A0 =A0 return off;
> +}
> +
> +/* A req is a sequence of one or more xfer units.
> + * Returns the number of bytes taken to setup the MC
> + * for the req.
> + */
> +static int _setup_req(unsigned dry_run, struct pl330_thread *thrd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned index, struct _xfer_spec *pxs)
> +{
> + =A0 =A0 =A0 struct _pl330_req *req =3D &thrd->req[index];
> + =A0 =A0 =A0 struct pl330_xfer *x;
> + =A0 =A0 =A0 u8 *buf =3D req->mc_cpu;
> + =A0 =A0 =A0 int off =3D 0;
> +
> + =A0 =A0 =A0 /* DMAMOV CCR, ccr */
> + =A0 =A0 =A0 off +=3D _emit_MOV(dry_run, &buf[off], CCR, pxs->ccr);
> +
> + =A0 =A0 =A0 x =3D pxs->r->x;
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Error if xfer length is not aligned at b=
urst size */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (x->bytes % BRST_SIZE(pxs->ccr))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxs->x =3D x;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 off +=3D _setup_xfer(dry_run, &buf[off], px=
s);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D x->next;
> + =A0 =A0 =A0 } while (x);
> +
> + =A0 =A0 =A0 /* DMAFLUSHP peripheral */
> + =A0 =A0 =A0 off +=3D _emit_FLUSHP(dry_run, &buf[off], pxs->r->peri);
> + =A0 =A0 =A0 /* DMASEV peripheral/event */
> + =A0 =A0 =A0 off +=3D _emit_SEV(dry_run, &buf[off], thrd->ev);
> + =A0 =A0 =A0 /* DMAEND */
> + =A0 =A0 =A0 off +=3D _emit_END(dry_run, &buf[off]);
> +
> + =A0 =A0 =A0 return off;
> +}
> +
> +/* Submit a list of xfers after which the client wants notification.
> + * Client is not notified after each xfer unit, just once after all
> + * xfer units are done or some error occurs.
> + * The actual xfer on bus starts automatically
> + */
> +int pl330_submit_req(void *ch_id, struct pl330_req *r)
> +{
> + =A0 =A0 =A0 struct pl330_thread *thrd =3D ch_id;
> + =A0 =A0 =A0 struct pl330_info *pi;
> + =A0 =A0 =A0 struct _xfer_spec xs;
> + =A0 =A0 =A0 void __iomem *regs;
> + =A0 =A0 =A0 u32 ccr;
> + =A0 =A0 =A0 unsigned idx;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 /* No Req or Unacquired Channel or DMAC stopping */
> + =A0 =A0 =A0 if (!r || !thrd || thrd->free || thrd->dmac->state =3D=3D D=
YING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 pi =3D &thrd->dmac->pinfo;
> + =A0 =A0 =A0 regs =3D pi->base;
> +
> + =A0 =A0 =A0 /* If request for non-existing peripheral */
> + =A0 =A0 =A0 if (r->peri >=3D pi->pcfg.num_peri)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 mutex_lock(&thrd->mtx);
> +
> + =A0 =A0 =A0 if (_queue_full(thrd)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto xfer_exit;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Use last settings, if not provided */
> + =A0 =A0 =A0 if (r->cfg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ccr =3D _prepare_ccr(r->cfg);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ccr =3D readl(regs + CC(thrd->id));
> +
> + =A0 =A0 =A0 /* If this req doesn't have valid xfer settings */
> + =A0 =A0 =A0 if (!_is_valid(ccr)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto xfer_exit;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 idx =3D thrd->req[0].r ? 1 : 0;
> +
> + =A0 =A0 =A0 xs.ccr =3D ccr;
> + =A0 =A0 =A0 xs.r =3D r;
> +
> + =A0 =A0 =A0 /* First dry run to check if req is acceptable */
> + =A0 =A0 =A0 ret =3D _setup_req(1, thrd, idx, &xs);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto xfer_exit;
> +
> + =A0 =A0 =A0 if (ret > pi->mcbufsz / 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto xfer_exit;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D 0;
> +
> + =A0 =A0 =A0 /* Hook the request */
> + =A0 =A0 =A0 _setup_req(0, thrd, idx, &xs);
> + =A0 =A0 =A0 thrd->req[idx].r =3D r;
> +
> + =A0 =A0 =A0 if (!_start(thrd)) { /* Could not start */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto xfer_exit;
> + =A0 =A0 =A0 }
> +
> +xfer_exit:
> + =A0 =A0 =A0 mutex_unlock(&thrd->mtx);
> + =A0 =A0 =A0 return ret;
> +}
> +EXPORT_SYMBOL(pl330_submit_req);

For all exported symbols: I have a hard time seeing anyone compiling the
DMA engine driver or anything else using this as a module and making use
of all these exports. But maybe for testing, what do I know...

> +static void pl330_dotask(unsigned long data)
> +{
> + =A0 =A0 =A0 struct pl330_dmac *pl330 =3D (struct pl330_dmac *) data;
> + =A0 =A0 =A0 struct pl330_info *pi =3D &pl330->pinfo;
> + =A0 =A0 =A0 struct pl330_thread *thrd;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 /* The DMAC itself gone nuts */
> + =A0 =A0 =A0 if (pl330->dmac_tbd.reset_dmac) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl330->state =3D DYING;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pi->pcfg.num_chan; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd =3D &pl330->channels[i=
];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Mark thread as infected =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl330->dmac_tbd.reset_chan =
|=3D (1 << thrd->id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl330->dmac_tbd.reset_mngr =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pl330->dmac_tbd.reset_mngr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _stop(pl330->manager);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < pi->pcfg.num_chan; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd =3D &pl330->channels[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pl330->dmac_tbd.reset_chan & (1 << thrd=
->id)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (thrd->active) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pl33=
0_req *r1, *r2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum pl330_=
op_err err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void __iome=
m *regs =3D pi->base;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned ac=
tive;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 active =3D =
thrd->active - 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r1 =3D thrd=
->req[active].r;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r2 =3D thrd=
->req[1 - active].r;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->req[a=
ctive].r =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->req[1=
 - active].r =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->activ=
e =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (readl(r=
egs + FSC) & (1 << thrd->id))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 err =3D PL330_ERR_FAIL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 err =3D PL330_ERR_ABORT;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _callback(r=
1, err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _callback(r=
2, err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _stop(thrd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Clear all errors */
> + =A0 =A0 =A0 pl330->dmac_tbd.reset_dmac =3D 0;
> + =A0 =A0 =A0 pl330->dmac_tbd.reset_mngr =3D 0;
> + =A0 =A0 =A0 pl330->dmac_tbd.reset_chan =3D 0;
> +
> + =A0 =A0 =A0 return;
> +}
> +
> +/* Returns 1 if state was updated, 0 otherwise */
> +int pl330_update(struct pl330_info *pi)
> +{
> + =A0 =A0 =A0 struct pl330_dmac *pl330;
> + =A0 =A0 =A0 void __iomem *regs;
> + =A0 =A0 =A0 u32 val;
> + =A0 =A0 =A0 int id, ev, ret =3D 0;
> +
> + =A0 =A0 =A0 if (!pi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 pl330 =3D container_of(pi, struct pl330_dmac, pinfo);
> +
> + =A0 =A0 =A0 if (pl330->state =3D=3D DYING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 regs =3D pi->base;
> +
> + =A0 =A0 =A0 val =3D readl(regs + FSM) & 0x1;
> + =A0 =A0 =A0 pl330->dmac_tbd.reset_mngr |=3D val;
> +
> + =A0 =A0 =A0 val =3D readl(regs + FSC) & ((1 << pi->pcfg.num_chan) - 1);
> + =A0 =A0 =A0 pl330->dmac_tbd.reset_chan |=3D val;
> +
> + =A0 =A0 =A0 /* Check which event happened i.e, thread notified */
> + =A0 =A0 =A0 val =3D readl(regs + ES);
> + =A0 =A0 =A0 if (pi->pcfg.num_events < 32
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && val & ~((1 << pi->pcfg.n=
um_events) - 1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl330->dmac_tbd.reset_dmac =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s:%d Unexpected!\n", __f=
unc__, __LINE__);

dev_info(pl330->dev, "...");

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto updt_exit;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 INIT_LIST_HEAD(&pl330->req_done);
> +
> + =A0 =A0 =A0 for (ev =3D 0; ev < pi->pcfg.num_events; ev++) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct _pl330_req *rqdone;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pl330_thread *thrd;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int active;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val & (1 << ev)) { /* Event occured */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D pl330->events[ev];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd =3D &pl330->channels[i=
d];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&thrd->mtx);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!thrd->active) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl330->dmac=
_tbd.reset_chan |=3D (1 << id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN=
_INFO "%s:%d Unexpected!\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 __func__, __LINE__);

dev_info(pl330->dev, "....");

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 active =3D thrd->active - 1=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rqdone =3D &thrd->req[activ=
e];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rqdone->r =3D NULL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (thrd->req[1 - active].r=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->activ=
e =3D 2 - active;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->activ=
e =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Get going again ASAP */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _start(thrd);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* For now, just make a lis=
t of callbacks to be done */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&rqdone->rqd,=
 &pl330->req_done);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&thrd->mtx);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Clear all event interrupts */
> + =A0 =A0 =A0 writel(val, regs + INTCLR);
> +
> + =A0 =A0 =A0 /* Now that we are in no hurry, do the callbacks */
> + =A0 =A0 =A0 while (!list_empty(&pl330->req_done)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct _pl330_req *rqdone =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_o=
f(pl330->req_done.next,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct _pl330_req, rqd);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init(&rqdone->rqd);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _callback(rqdone->r, PL330_ERR_NONE);
> + =A0 =A0 =A0 }
> +
> +updt_exit:
> +
> + =A0 =A0 =A0 if (pl330->dmac_tbd.reset_dmac
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || pl330->dmac_tbd.reset_mn=
gr
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || pl330->dmac_tbd.reset_ch=
an) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tasklet_schedule(&pl330->tasks);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +EXPORT_SYMBOL(pl330_update);
> +
> +/* This must be atomic. Since the DMA client calls this,
> + * there is no need to do callbacks. Otherwise, this may not be atomic.
> + */
> +int pl330_chan_ctrl(void *ch_id, enum pl330_chan_op op)
> +{
> + =A0 =A0 =A0 struct pl330_thread *thrd =3D ch_id;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!thrd || thrd->free || thrd->dmac->state =3D=3D DYING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 mutex_lock(&thrd->mtx);
> +
> + =A0 =A0 =A0 if (_queue_empty(thrd))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ctrl_exit;
> +
> + =A0 =A0 =A0 switch (op) {
> + =A0 =A0 =A0 case PL330_OP_FLUSH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _stop(thrd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->req[0].r =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->req[1].r =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->active =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case PL330_OP_ABORT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _stop(thrd);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* ABORT is only for the active req */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!thrd->active)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->req[thrd->active - 1].r =3D NULL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (_queue_empty(thrd)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->active =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 case PL330_OP_START: /* Should be un-necessary */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!_queue_empty(thrd) && !_start(thrd))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 }
> +
> +ctrl_exit:
> + =A0 =A0 =A0 mutex_unlock(&thrd->mtx);
> + =A0 =A0 =A0 return ret;
> +}
> +EXPORT_SYMBOL(pl330_chan_ctrl);
> +
> +int pl330_chan_status(void *ch_id, struct pl330_chanstatus *pstatus)
> +{
> + =A0 =A0 =A0 struct pl330_thread *thrd =3D ch_id;
> + =A0 =A0 =A0 struct pl330_dmac *pl330;
> + =A0 =A0 =A0 struct pl330_info *pi;
> + =A0 =A0 =A0 void __iomem *regs;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 u32 val;
> +
> + =A0 =A0 =A0 if (!pstatus || !thrd || thrd->free)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 mutex_lock(&thrd->mtx);
> +
> + =A0 =A0 =A0 pl330 =3D thrd->dmac;
> + =A0 =A0 =A0 pi =3D &pl330->pinfo;
> + =A0 =A0 =A0 regs =3D pi->base;
> +
> + =A0 =A0 =A0 /* The client should remove the DMAC and add again */
> + =A0 =A0 =A0 if (pl330->state =3D=3D DYING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pstatus->dmac_halted =3D true;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pstatus->dmac_halted =3D false;
> +
> + =A0 =A0 =A0 val =3D readl(regs + FSC);
> + =A0 =A0 =A0 if (val & (1 << thrd->id))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pstatus->faulting =3D true;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pstatus->faulting =3D false;
> +
> + =A0 =A0 =A0 val =3D readl(regs + CPC(thrd->id));
> + =A0 =A0 =A0 if (PC_AT_REQ(&thrd->req[0], pi->mcbufsz / 2, val))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D 1;
> + =A0 =A0 =A0 else if (PC_AT_REQ(&thrd->req[1], pi->mcbufsz / 2, val))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D 2;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D 0;
> +
> + =A0 =A0 =A0 /* If channel inactive while req in queue */
> + =A0 =A0 =A0 if ((thrd->active !=3D i) || (!_queue_empty(thrd) && !i))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s:%d DBG: Invalid state!=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, __LINE__);

dev_err(pl330->dev, "....");

Notice err! Not info.

> +
> + =A0 =A0 =A0 if (i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pstatus->act_req =3D thrd->req[i].r;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pstatus->enq_req =3D thrd->req[1-i].r;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pstatus->act_req =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pstatus->enq_req =3D NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pstatus->src_addr =3D readl(regs + SA(thrd->id));
> + =A0 =A0 =A0 pstatus->dst_addr =3D readl(regs + DA(thrd->id));
> +
> + =A0 =A0 =A0 mutex_unlock(&thrd->mtx);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(pl330_chan_status);
> +
> +static inline void _reset_thread(struct pl330_thread *thrd)
> +{
> + =A0 =A0 =A0 struct pl330_dmac *pl330 =3D thrd->dmac;
> + =A0 =A0 =A0 struct pl330_info *pi =3D &pl330->pinfo;
> +
> + =A0 =A0 =A0 thrd->req[0].r =3D NULL;
> + =A0 =A0 =A0 thrd->req[0].mc_cpu =3D pl330->mcode_cpu
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + (thrd->id=
 * pi->mcbufsz);
> + =A0 =A0 =A0 thrd->req[0].mc_bus =3D pl330->mcode_bus
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + (thrd->id=
 * pi->mcbufsz);
> +
> + =A0 =A0 =A0 thrd->req[1].r =3D NULL;
> + =A0 =A0 =A0 thrd->req[1].mc_cpu =3D thrd->req[0].mc_cpu
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + pi->mcbuf=
sz / 2;
> + =A0 =A0 =A0 thrd->req[1].mc_bus =3D thrd->req[0].mc_bus
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + pi->mcbuf=
sz / 2;
> +}
> +
> +/* Reserve an event */
> +static inline int _alloc_event(struct pl330_thread *thrd)
> +{
> + =A0 =A0 =A0 struct pl330_dmac *pl330 =3D thrd->dmac;
> + =A0 =A0 =A0 struct pl330_info *pi =3D &pl330->pinfo;
> + =A0 =A0 =A0 int ev;
> +
> + =A0 =A0 =A0 for (ev =3D 0; ev < pi->pcfg.num_events; ev++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pl330->events[ev] =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl330->events[ev] =3D thrd-=
>id;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return -1;
> +}
> +
> +/* Release an event */
> +static inline void _free_event(struct pl330_thread *thrd, int ev)
> +{
> + =A0 =A0 =A0 struct pl330_dmac *pl330 =3D thrd->dmac;
> + =A0 =A0 =A0 struct pl330_info *pi =3D &pl330->pinfo;
> +
> + =A0 =A0 =A0 if (ev >=3D 0 && ev < pi->pcfg.num_events
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && pl330->events[ev] =3D=3D=
 thrd->id)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl330->events[ev] =3D -1;
> +}
> +
> +void *pl330_request_channel(struct pl330_info *pi)
> +{
> + =A0 =A0 =A0 struct pl330_dmac *pl330;
> + =A0 =A0 =A0 struct pl330_thread *thrd;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int chans, i;
> +
> + =A0 =A0 =A0 if (!pi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 pl330 =3D container_of(pi, struct pl330_dmac, pinfo);
> +
> + =A0 =A0 =A0 if (pl330->state =3D=3D DYING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 chans =3D pi->pcfg.num_chan;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&pl330->lock, flags);
> +
> + =A0 =A0 =A0 thrd =3D NULL;
> + =A0 =A0 =A0 for (i =3D 0; i < chans; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pl330->channels[i].free) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd =3D &pl330->channels[i=
];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _reset_thread(thrd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->ev =3D _alloc_event(t=
hrd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (thrd->ev >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->free =
=3D false;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&pl330->lock, flags);
> +
> + =A0 =A0 =A0 return thrd;
> +}
> +EXPORT_SYMBOL(pl330_request_channel);
> +
> +void pl330_release_channel(void *ch_id)
> +{
> + =A0 =A0 =A0 struct pl330_thread *thrd =3D ch_id;
> + =A0 =A0 =A0 struct pl330_dmac *pl330;
> + =A0 =A0 =A0 struct pl330_req *r1, *r2;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (!thrd || thrd->free || thrd->dmac->state =3D=3D DYING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 pl330 =3D thrd->dmac;
> +
> + =A0 =A0 =A0 if (thrd->active =3D=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r1 =3D thrd->req[0].r;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r2 =3D thrd->req[1].r;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r1 =3D thrd->req[1].r;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r2 =3D thrd->req[0].r;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_lock(&thrd->mtx);
> +
> + =A0 =A0 =A0 _stop(thrd);
> +
> + =A0 =A0 =A0 mutex_unlock(&thrd->mtx);
> +
> + =A0 =A0 =A0 _callback(r1, PL330_ERR_ABORT);
> + =A0 =A0 =A0 _callback(r2, PL330_ERR_ABORT);
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&pl330->lock, flags);
> + =A0 =A0 =A0 _reset_thread(thrd);
> + =A0 =A0 =A0 _free_event(thrd, thrd->ev);
> + =A0 =A0 =A0 thrd->free =3D true;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&pl330->lock, flags);
> +}
> +EXPORT_SYMBOL(pl330_release_channel);
> +
> +static int dmac_alloc_threads(struct pl330_dmac *pl330)
> +{
> + =A0 =A0 =A0 struct pl330_info *pi =3D &pl330->pinfo;
> + =A0 =A0 =A0 int chans =3D pi->pcfg.num_chan;
> + =A0 =A0 =A0 struct pl330_thread *thrd;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 /* Allocate 1 Manager and 'chans' Channel threads */
> + =A0 =A0 =A0 pl330->channels =3D kzalloc((1 + chans) * sizeof(*thrd),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 GFP_KERNEL);
> + =A0 =A0 =A0 if (!pl330->channels)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 /* Init Channel threads */
> + =A0 =A0 =A0 for (i =3D 0; i < chans; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd =3D &pl330->channels[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->id =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->dmac =3D pl330;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_init(&thrd->mtx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _reset_thread(thrd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd->free =3D true;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* MANAGER is indexed at the end */
> + =A0 =A0 =A0 thrd =3D &pl330->channels[chans];
> + =A0 =A0 =A0 thrd->id =3D chans;
> + =A0 =A0 =A0 thrd->dmac =3D pl330;
> + =A0 =A0 =A0 thrd->free =3D false; /* Manager can't do xfer */
> + =A0 =A0 =A0 mutex_init(&thrd->mtx);
> + =A0 =A0 =A0 pl330->manager =3D thrd;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int dmac_free_threads(struct pl330_dmac *pl330)
> +{
> + =A0 =A0 =A0 struct pl330_info *pi =3D &pl330->pinfo;
> + =A0 =A0 =A0 int chans =3D pi->pcfg.num_chan;
> + =A0 =A0 =A0 struct pl330_thread *thrd;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 /* Release Channel threads */
> + =A0 =A0 =A0 for (i =3D 0; i < chans; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 thrd =3D &pl330->channels[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl330_release_channel((void *)thrd);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Free memory */
> + =A0 =A0 =A0 kfree(pl330->channels);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/* Must be called after pl330_info has been initialized */
> +static int dmac_alloc_resources(struct pl330_dmac *pl330)
> +{
> + =A0 =A0 =A0 struct pl330_info *pi =3D &pl330->pinfo;
> + =A0 =A0 =A0 int chans =3D pi->pcfg.num_chan;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 /* Alloc MicroCode buffer for 'chans' Channel threads.
> + =A0 =A0 =A0 =A0* A channel's buffer offset is (Channel_Id * MCODE_BUFF_=
PERCHAN)
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 pl330->mcode_cpu =3D dma_alloc_coherent(pl330->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chans * pi-=
>mcbufsz,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pl330->mco=
de_bus, GFP_KERNEL);
> + =A0 =A0 =A0 if (!pl330->mcode_cpu) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "Unable to allocate MCODE =
buffer\n");

dev_err(pl330->dev, "....");
ERR!

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D dmac_alloc_threads(pl330);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "Unable to create channels=
 for DMAC\n");


dev_err(pl330->dev, "....");
ERR!

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(pl330->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chans * pi-=
>mcbufsz,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl330->mcod=
e_cpu, pl330->mcode_bus);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void dmac_free_resources(struct pl330_dmac *pl330)
> +{
> + =A0 =A0 =A0 struct pl330_info *pi =3D &pl330->pinfo;
> + =A0 =A0 =A0 int chans =3D pi->pcfg.num_chan;
> +
> + =A0 =A0 =A0 dmac_free_threads(pl330);
> +
> + =A0 =A0 =A0 dma_free_coherent(pl330->dev, chans * pi->mcbufsz,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl330->mcod=
e_cpu, pl330->mcode_bus);
> +}
> +/* Initialize the structure for PL330 configuration, that can be used
> + * by the client driver the make best use of the DMAC
> + */
> +static void read_dmac_config(struct pl330_dmac *pl330)
> +{
> + =A0 =A0 =A0 struct pl330_info *pi =3D &pl330->pinfo;
> + =A0 =A0 =A0 void __iomem *regs =3D pi->base;
> + =A0 =A0 =A0 u32 val;
> +
> + =A0 =A0 =A0 val =3D readl(regs + CRD) >> CRD_DATA_WIDTH_SHIFT;
> + =A0 =A0 =A0 val &=3D CRD_DATA_WIDTH_MASK;
> + =A0 =A0 =A0 pi->pcfg.data_bus_width =3D 8 * (1 << val);
> +
> + =A0 =A0 =A0 val =3D readl(regs + CR0) >> CR0_NUM_CHANS_SHIFT;
> + =A0 =A0 =A0 val &=3D CR0_NUM_CHANS_MASK;
> + =A0 =A0 =A0 val +=3D 1;
> + =A0 =A0 =A0 pi->pcfg.num_chan =3D val;
> +
> + =A0 =A0 =A0 val =3D readl(regs + CR0);
> + =A0 =A0 =A0 if (val & CR0_PERIPH_REQ_SET) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D (val >> CR0_NUM_PERIPH_SHIFT) & CR0=
_NUM_PERIPH_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val +=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->pcfg.num_peri =3D val;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->pcfg.peri_ns =3D readl(regs + CR4);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->pcfg.num_peri =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 val =3D readl(regs + CR0);
> + =A0 =A0 =A0 if (val & CR0_BOOT_MAN_NS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->pcfg.mode |=3D DMAC_MODE_NS;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->pcfg.mode &=3D ~DMAC_MODE_NS;
> +
> + =A0 =A0 =A0 val =3D readl(regs + CR0) >> CR0_NUM_EVENTS_SHIFT;
> + =A0 =A0 =A0 val &=3D CR0_NUM_EVENTS_MASK;
> + =A0 =A0 =A0 val +=3D 1;
> + =A0 =A0 =A0 pi->pcfg.num_events =3D val;
> +
> + =A0 =A0 =A0 pi->pcfg.irq_ns =3D readl(regs + CR3);
> +
> + =A0 =A0 =A0 pi->pcfg.periph_id =3D get_id(pl330, PERIPH_ID);
> + =A0 =A0 =A0 pi->pcfg.pcell_id =3D get_id(pl330, PCELL_ID);
> +}
> +
> +/* After pl330_alloc, initialize pl330_info.base
> + * before calling pl330_add
> + */
> +int pl330_add(struct pl330_info *pi)
> +{
> + =A0 =A0 =A0 struct pl330_dmac *pl330, *pt;
> + =A0 =A0 =A0 void __iomem *regs;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (!pi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 pl330 =3D container_of(pi, struct pl330_dmac, pinfo);
> +
> + =A0 =A0 =A0 regs =3D pi->base;
> +
> + =A0 =A0 =A0 /* If the SoC can perform reset on the DMAC, then do it
> + =A0 =A0 =A0 =A0* before reading its configuration.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (pi->dmac_reset)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->dmac_reset(pi);
> +
> + =A0 =A0 =A0 /* Check if we can handle this DMAC */
> + =A0 =A0 =A0 if (get_id(pl330, PERIPH_ID) !=3D PERIPH_ID_VAL
> + =A0 =A0 =A0 =A0 =A0|| get_id(pl330, PCELL_ID) !=3D PCELL_ID_VAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "PERIPH_ID 0x%x, PCELL_ID =
0x%x !\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 readl(regs + PERIPH_ID), re=
adl(regs + PCELL_ID));

dev_info(pl330->dev, ...)

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }

If the parent device (IMO a DMAdevices/DMAengine) is an struct amba_device
I don't think this ID check is necessary, there is already PrimeCell
matching code in
<linux/amba/bus.h>

> +
> + =A0 =A0 =A0 /* Make sure it isn't already added */
> + =A0 =A0 =A0 list_for_each_entry(pt, &pl330_list, node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pt =3D=3D pl330)

Perhaps print some warning here. Doesn't seem sound that this
would happen.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 /* Read the configuration of the DMAC */
> + =A0 =A0 =A0 read_dmac_config(pl330);
> +
> + =A0 =A0 =A0 if (pi->pcfg.num_events =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s:%d Can't work without =
events!\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, __LINE__);

dev_info(pl330->dev, "....");

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Use default MC buffer size if not provided */
> + =A0 =A0 =A0 if (!pi->mcbufsz)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->mcbufsz =3D MCODE_BUFF_PER_REQ * 2;
> +
> + =A0 =A0 =A0 /* Mark all events as free */
> + =A0 =A0 =A0 for (i =3D 0; i < pi->pcfg.num_events; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl330->events[i] =3D -1;
> +
> + =A0 =A0 =A0 /* Allocate resources needed by the DMAC */
> + =A0 =A0 =A0 i =3D dmac_alloc_resources(pl330);
> + =A0 =A0 =A0 if (i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "Unable to create channels=
 for DMAC\n");

dev_info(pl330->dev, "....");

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_lock(&pl330_mutex);
> + =A0 =A0 =A0 list_add_tail(&pl330->node, &pl330_list);
> + =A0 =A0 =A0 mutex_unlock(&pl330_mutex);
> +
> + =A0 =A0 =A0 tasklet_init(&pl330->tasks, pl330_dotask,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned l=
ong) pl330);
> +
> + =A0 =A0 =A0 pl330->state =3D INIT;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(pl330_add);
> +
> +/* Drop DMAC from the list
> + */
> +void pl330_del(struct pl330_info *pi)
> +{
> + =A0 =A0 =A0 struct pl330_dmac *pl330, *pt;
> + =A0 =A0 =A0 int found;
> +
> + =A0 =A0 =A0 if (!pi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 pl330 =3D container_of(pi, struct pl330_dmac, pinfo);
> +
> + =A0 =A0 =A0 pl330->state =3D UNINIT;
> +
> + =A0 =A0 =A0 /* Make sure it is already added */
> + =A0 =A0 =A0 found =3D 0;
> + =A0 =A0 =A0 list_for_each_entry(pt, &pl330_list, node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pt =3D=3D pl330)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D 1;
> +
> + =A0 =A0 =A0 if (!found)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 tasklet_kill(&pl330->tasks);
> +
> + =A0 =A0 =A0 mutex_lock(&pl330_mutex);
> + =A0 =A0 =A0 list_del(&pl330->node);
> + =A0 =A0 =A0 mutex_unlock(&pl330_mutex);
> +
> + =A0 =A0 =A0 /* Free DMAC resources */
> + =A0 =A0 =A0 dmac_free_resources(pl330);
> +}
> +EXPORT_SYMBOL(pl330_del);
> +
> +struct pl330_info *pl330_alloc(struct device *dev)
> +{
> + =A0 =A0 =A0 struct pl330_dmac *pl330;
> +
> + =A0 =A0 =A0 pl330 =3D kzalloc(sizeof(*pl330), GFP_KERNEL);
> + =A0 =A0 =A0 if (!pl330)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 spin_lock_init(&pl330->lock);
> +
> + =A0 =A0 =A0 pl330->dev =3D dev;
> +
> + =A0 =A0 =A0 return &pl330->pinfo;
> +}
> +EXPORT_SYMBOL(pl330_alloc);
> +
> +void pl330_free(struct pl330_info *pi)
> +{
> + =A0 =A0 =A0 struct pl330_dmac *pl330;
> +
> + =A0 =A0 =A0 if (!pi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 pl330_del(pi);
> +
> + =A0 =A0 =A0 pl330 =3D container_of(pi, struct pl330_dmac, pinfo);
> +
> + =A0 =A0 =A0 kfree(pl330);
> +}
> +EXPORT_SYMBOL(pl330_free);
> diff --git a/arch/arm/include/asm/hardware/pl330.h
> b/arch/arm/include/asm/hardware/pl330.h
> new file mode 100644
> index 0000000..4e907ad
> --- /dev/null
> +++ b/arch/arm/include/asm/hardware/pl330.h
> @@ -0,0 +1,197 @@
> +/* linux/include/asm/hardware/pl330.h
> + *
> + * Copyright (C) 2010 Samsung Electronics Co Ltd.
> + * =A0 =A0 Jaswinder Singh <jassi.brar@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef __PL330_CORE_H
> +#define __PL330_CORE_H
> +
> +enum pl330_srccachectrl {
> + =A0 =A0 =A0 SCCTRL0 =3D 0, /* Noncacheable and nonbufferable */
> + =A0 =A0 =A0 SCCTRL1, /* Bufferable only */
> + =A0 =A0 =A0 SCCTRL2, /* Cacheable, but do not allocate */
> + =A0 =A0 =A0 SCCTRL3, /* Cacheable and bufferable, but do not allocate *=
/
> + =A0 =A0 =A0 SINVALID1,
> + =A0 =A0 =A0 SINVALID2,
> + =A0 =A0 =A0 SCCTRL6, /* Cacheable write-through, allocate on reads only=
 */
> + =A0 =A0 =A0 SCCTRL7, /* Cacheable write-back, allocate on reads only */
> +};
> +
> +enum pl330_dstcachectrl {
> + =A0 =A0 =A0 DCCTRL0 =3D 0, /* Noncacheable and nonbufferable */
> + =A0 =A0 =A0 DCCTRL1, /* Bufferable only */
> + =A0 =A0 =A0 DCCTRL2, /* Cacheable, but do not allocate */
> + =A0 =A0 =A0 DCCTRL3, /* Cacheable and bufferable, but do not allocate *=
/
> + =A0 =A0 =A0 DINVALID1 =3D 8,
> + =A0 =A0 =A0 DINVALID2,
> + =A0 =A0 =A0 DCCTRL6, /* Cacheable write-through, allocate on writes onl=
y */
> + =A0 =A0 =A0 DCCTRL7, /* Cacheable write-back, allocate on writes only *=
/
> +};
> +
> +/* Populated by the PL330 core driver for DMA API driver's info */
> +struct pl330_config {
> + =A0 =A0 =A0 u32 =A0 =A0 periph_id;
> + =A0 =A0 =A0 u32 =A0 =A0 pcell_id;
> +#define DMAC_MODE_NS =A0 (1 << 0)
> + =A0 =A0 =A0 unsigned int =A0 =A0mode;
> + =A0 =A0 =A0 unsigned int =A0 =A0data_bus_width:10; /* In number of bits=
 */
> + =A0 =A0 =A0 unsigned int =A0 =A0num_chan:4;
> + =A0 =A0 =A0 unsigned int =A0 =A0num_peri:6;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 peri_ns;
> + =A0 =A0 =A0 unsigned int =A0 =A0num_events:6;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 irq_ns;
> +};
> +
> +/* Handle to the DMAC provided by PL330 engine */
> +struct pl330_info {

Contemplate adding:
      /* Owning device */
      struct device *dev;

> + =A0 =A0 =A0 /* Size of MicroCode buffers for each channel */
> + =A0 =A0 =A0 unsigned mcbufsz;
> + =A0 =A0 =A0 /* ioremap'ed address of PL330 registers */
> + =A0 =A0 =A0 void __iomem =A0 =A0*base;
> + =A0 =A0 =A0 /* Client can freely use it */
> + =A0 =A0 =A0 void =A0 =A0*private_data;
> + =A0 =A0 =A0 /* Populated by the PL330 core driver during pl330_add */
> + =A0 =A0 =A0 struct pl330_config =A0 =A0 pcfg;
> + =A0 =A0 =A0 /* If the DMAC has some reset mechanism, then the client
> + =A0 =A0 =A0 =A0* may want to provide pointer to the relevent function.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 void (*dmac_reset)(struct pl330_info *pi);
> +};
> +
> +enum pl330_byteswap {
> + =A0 =A0 =A0 SWAP_NO =3D 0,
> + =A0 =A0 =A0 SWAP_2,
> + =A0 =A0 =A0 SWAP_4,
> + =A0 =A0 =A0 SWAP_8,
> + =A0 =A0 =A0 SWAP_16,
> +};
> +
> +enum pl330_reqtype {
> + =A0 =A0 =A0 MEMTOMEM,
> + =A0 =A0 =A0 MEMTODEV,
> + =A0 =A0 =A0 DEVTOMEM,
> + =A0 =A0 =A0 DEVTODEV,
> +};
> +
> +/* Request Configuration.
> + * The PL330 core uses the last working configuration if the
> + * request doesn't provide any.
> + *
> + * The Client may want to provide this info only for the
> + * first request and a request with new settings.
> + */
> +struct pl330_reqcfg {
> + =A0 =A0 =A0 /* Implies Incrementing address */
> + =A0 =A0 =A0 unsigned dst_inc:1;
> + =A0 =A0 =A0 unsigned src_inc:1;
> +
> + =A0 =A0 =A0 /* For now, the SRC & DST protection levels
> + =A0 =A0 =A0 =A0* and burst size/length are assumed same
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 unsigned nonsecure:1;
> + =A0 =A0 =A0 unsigned privileged:1;
> + =A0 =A0 =A0 unsigned insnaccess:1;

For all of these things using just one bit, contemplate
turning them into bool instead, because that's what they are.

> + =A0 =A0 =A0 unsigned brst_len:5;
> + =A0 =A0 =A0 unsigned brst_size:3; /* power of 2 */
> +
> + =A0 =A0 =A0 enum pl330_dstcachectrl dcctl;
> + =A0 =A0 =A0 enum pl330_srccachectrl scctl;
> + =A0 =A0 =A0 enum pl330_byteswap swap;
> +};
> +
> +/* One cycle of DMAC operation.
> + * There may be more than one xfer in a request.
> + */
> +struct pl330_xfer {
> + =A0 =A0 =A0 u32 src_addr;
> + =A0 =A0 =A0 u32 dst_addr;
> + =A0 =A0 =A0 /* Number of total _bytes_ to xfer */
> + =A0 =A0 =A0 u32 bytes;
> + =A0 =A0 =A0 /* Pointer to next xfer in the list.
> + =A0 =A0 =A0 =A0* The last xfer in the req must point to NULL
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 struct pl330_xfer *next;
> +};
> +
> +/* A request defining Scatter-Gather List ending with NULL xfer */
> +struct pl330_req {
> + =A0 =A0 =A0 enum pl330_reqtype rqtype;
> + =A0 =A0 =A0 /* Index of peripheral for the xfer */
> + =A0 =A0 =A0 unsigned peri:5;
> + =A0 =A0 =A0 /* Unique token for this xfer, set by the DMA engine */
> + =A0 =A0 =A0 void *token;
> + =A0 =A0 =A0 /* Callback to be called after xfer */
> + =A0 =A0 =A0 void (*xfer_cb)(void *token, int result);
> + =A0 =A0 =A0 /* If NULL, req will be done at last set parameters */
> + =A0 =A0 =A0 struct pl330_reqcfg *cfg;
> + =A0 =A0 =A0 /* Pointer to first xfer in the List */
> + =A0 =A0 =A0 struct pl330_xfer *x;
> +};
> +
> +/* To know the status of the channel and DMAC, the client
> + * provides a pointer to this structure. The PL330 core
> + * fills it with current information
> + */
> +struct pl330_chanstatus {
> + =A0 =A0 =A0 /* If the DMAC engine halted due to some error,
> + =A0 =A0 =A0 =A0* the client should remove-add DMAC */
> + =A0 =A0 =A0 bool dmac_halted;
> + =A0 =A0 =A0 /* If channel is halted due to some error,
> + =A0 =A0 =A0 =A0* the client may ABORT or FLUSH the channel */
> + =A0 =A0 =A0 bool faulting;
> + =A0 =A0 =A0 /* Location of last load */
> + =A0 =A0 =A0 u32 src_addr;
> + =A0 =A0 =A0 /* Location of last store */
> + =A0 =A0 =A0 u32 dst_addr;
> + =A0 =A0 =A0 /* Pointer to the active req */
> + =A0 =A0 =A0 struct pl330_req *act_req;
> + =A0 =A0 =A0 /* Pointer to req waiting in the queue */
> + =A0 =A0 =A0 struct pl330_req *enq_req;
> +};
> +
> +/* The callbacks are made with one of these arguments */
> +enum pl330_op_err {
> + =A0 =A0 =A0 /* The all xfers in the request were success */
> + =A0 =A0 =A0 PL330_ERR_NONE,
> + =A0 =A0 =A0 /* If req aborted due to global error */
> + =A0 =A0 =A0 PL330_ERR_ABORT,
> + =A0 =A0 =A0 /* If req failed due to problem with Channel */
> + =A0 =A0 =A0 PL330_ERR_FAIL,
> +};
> +
> +enum pl330_chan_op {
> + =A0 =A0 =A0 /* Start the channel */
> + =A0 =A0 =A0 PL330_OP_START,
> + =A0 =A0 =A0 /* Abort the active xfer */
> + =A0 =A0 =A0 PL330_OP_ABORT,
> + =A0 =A0 =A0 /* Stop xfer and flush queue */
> + =A0 =A0 =A0 PL330_OP_FLUSH,
> +};
> +
> +extern struct pl330_info *pl330_alloc(struct device *);
> +extern int pl330_add(struct pl330_info *);
> +extern void pl330_del(struct pl330_info *pi);
> +extern int pl330_update(struct pl330_info *pi);
> +extern void pl330_release_channel(void *ch_id);
> +extern void *pl330_request_channel(struct pl330_info *pi);
> +extern int pl330_chan_status(void *ch_id, struct pl330_chanstatus *pstat=
us);
> +extern int pl330_chan_ctrl(void *ch_id, enum pl330_chan_op op);
> +extern int pl330_submit_req(void *ch_id, struct pl330_req *r);
> +extern void pl330_free(struct pl330_info *pi);


Do you really need both pairs:

pl330_alloc() + pl330_add() and
pl330_del() + pl330_free()

to be public and exposed in the interface and exported? I would suggest mak=
ing
removing two of them unless there is something I don't get here.
IMO:

int pl330_add(struct device *, struct pl330_info *);
Should be enough, pl330_info will be filled in if the call returns sucessfu=
lly.
You could also

struct pl330_info *pl330_add(struct device *);

If you prefer to use macros like IS_ERR() etc on the returned pointer.

> +#endif /* __PL330_CORE_H */
> --
> 1.6.2.5
>

Yours,
Linus Walleij


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.295.1270532670.2170.linux-arm-kernel@lists.infradead.org>

support DMA as well (via two M2M channels). Maybe we can add support
for that in subsequent versions?

Thanks,
MW


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.298.1270593295.2170.linux-arm-kernel@lists.infradead.org>

Are you trying to 'git pull' his tree?

I tried that initially and it worked fine for the initial pull.  After that=
 I
always ran into issues with trying to update it.

I don't quite remember how I did the initial pull when I started a new bran=
ch
to follow Russell's tree but I think I did it like the FAQ says on how to
follow the -next tree.

Oh, this is using git version 1.7.0.3.254.g4503b

Regards,
Hartley=


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.299.1270764023.2170.linux-arm-kernel@lists.infradead.org>

/*
 * Table that determines the low power modes outputs, with actual settings
 * used in parentheses for don't-care values. Except for the float output,
 * the configured driven and pulled levels match, so if there is a need for
 * non-LPM pulled output, the same configuration could probably be used.
 *
 * Output value  sleep_oe_n  sleep_data  pullup_en  pulldown_en  pull_sel
 *                 (bit 7)    (bit 8)    (bit 14)     (bit 13)   (bit 15)
 *
 * Input            0          X(0)        X(0)        X(0)      0
 * Drive 0          0          0           0           X(1)      0
 * Drive 1          0          1           X(1)        0         0
 * Pull hi (1)      1          X(1)        1           0         0
 * Pull lo (0)      1          X(0)        0           1         0
 * Z (float)        1          X(0)        0           0         0
 */
#define MFPR_LPM_INPUT         (0)
#define MFPR_LPM_DRIVE_LOW     (MFPR_SLEEP_DATA(0) | MFPR_PULLDOWN_EN)
#define MFPR_LPM_DRIVE_HIGH    (MFPR_SLEEP_DATA(1) | MFPR_PULLUP_EN)
#define MFPR_LPM_PULL_LOW      (MFPR_LPM_DRIVE_LOW  | MFPR_SLEEP_OE_N)
#define MFPR_LPM_PULL_HIGH     (MFPR_LPM_DRIVE_HIGH | MFPR_SLEEP_OE_N)
#define MFPR_LPM_FLOAT         (MFPR_SLEEP_OE_N)
#define MFPR_LPM_MASK          (0xe080)


When a pin's LPM is configured as MFPR_LPM_INPUT, the MFPR will, upon
entry to any low power mode, contain all zeros in the bits listed
above. If my understanding is correct, this will cause such pins to
drive low in any low power mode.  That's not always a good thing for
an input pin to do. This definition is misleading and should probably be
removed.

The default MFP configuration includes MFP_LPM_DEFAULT, which (via 
mfpr_lpm[]) selects MFPR_LPM_INPUT. Is this really a desired "default"?
I think MFPR_LPM_DRIVE_LOW is a safer bet, in case the pin is externally
driven high.

-Dave



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.310.1271825771.2170.linux-arm-kernel@lists.infradead.org>

able
will increment in the same way at least in the current configuration.

If you have case where individual CPUs are running at different speed and d=
ifferent
Tick rate then only this can make difference.

Regards,
Santosh




>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.313.1271967581.2170.linux-arm-kernel@lists.infradead.org>

if (bits > 8) {
   this16
} else {
   that8
}
so no loss in splitting it. You need two copies of the read and write
loops in the read_write routine, though it's only 8 extra lines of
code for a 1% CPU increase.
I don't have strong feelings about this it way.

> Yes.  Too bad we can't also combine multiple messages that might be in
>  the queue...

I wonder if it might be easier, if there are several parts to a
message, to just cook up  one big new transfer, copy the data into it
and just do that. It would mean copying every data block of course
since in the MMC/SD case they are 512+2+1.

>  But, if this gets to complicated it might not be worth holding off
>  getting it merged
Possibly. It depends on the timing of the merge windows. The current
code works with some devices.

>  > It now occurs to me that another step in CPU efficiency could be had
>  > by abusing the receive-fifo-is-half-full interrupt to signal the
>  > completion of a transfer. This would only work for transfers of four
>  > or more words and would need some careful jiggery-pokery at end of
>  > transfer to turn the tx-fifo-is-half-empty interrupt enable off and
>  > ensure that exactly four words would end up in the RX FIFO.
>
> That might work but I think it could break horribly.  The "jiggery-pokery"
>  could end up being pretty messy.

Yes. It is looking nasty and it would make a mess of the place where
the continuity stuff needs to happen to achieve actual functionality
improvements.

To get some idea of the potential wins I've been instrumenting the
code today to see how many interrupts it takes to receive the last 4
words
At 3.7MHz I'm seeing up to 3 interrupts waiting for the final draining
to happen, with an average of 1.36 (1 would be the perfect figure)
At 400kHz it takes up to 26 with an average of 9.92

Me, I only really care about the SD card case, where a half dozen
useless interrupts per 512-byte block is not going to impact on the
CPU usage much. In fact, by making the interrupt routine more complex
it may even end up being more cpu hungry in the end.

On the other hand, slow clock-speed devices are using needless high
CPU, especially if the transfer sizes are small as is typical with
command-response devices.

>  But, the tx-fifo-is-half-empty might be what is needed to handle the
>  multiple transfer merging.  We know the driver is finished transfering
>  the data to the fifo when (espi->tx == t->len).  At this point we are
>  just wating for the last (fifo_level) bytes to come in on the rx fifo,
>  this could be anything from 1 to 8 bytes.

Another instrumentation show that yes, at 3.7MHz, the data read on
each interrupt is between 1 and 8 words. I'm surprised it gets to 8
full - maybe when the interrupt is requested while some other IRQ
(ether? clock tick?) is already in progress? I'm instrumenting in a
way that shouldn't change the timing characteristics of the transfer
(ie a tiny printk's only after end of transfer)

>  > It's a horrible thought, and I suspect that the DMA engine is the real answer.
>
> The DMA engine might help but it's not here yet....

Yes. What I mean is that the prospect of that happening somewhere in
the future reduces the importance of doing hairy jiggery pokery with
the interrupt version.

     M


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.323.1272395875.2170.linux-arm-kernel@lists.infradead.org>

be merged through Russells tree pending some changes to our
board structure in u8500/ux500.

Yours,
Linus Walleij


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.353.1272943117.2170.linux-arm-kernel@lists.infradead.org>

not, how about to remove it. It consumes the memory and increase code
itself. It's only function pin instead of GPIOs.

Thank you,
Kyungmin Park

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP07_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP07(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP07_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP07",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP10_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP10(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP10_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP10",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP11_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP11(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP11_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP11",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP12_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP12(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP12_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP12",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP13_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP13(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP13_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP13",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP14_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP14(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP14_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP14",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP15_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP15(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP15_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP15",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP16_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP16(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP16_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP16",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP17_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP17(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP17_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP17",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP18_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP18(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP18_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP18",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP20_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP20(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP20_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP20",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP21_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP21(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP21_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP21",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP22_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP22(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP22_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP22",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP23_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP23(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP23_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP23",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP24_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP24(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP24_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP24",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP25_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP25(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP25_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP25",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP26_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP26(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP26_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP26",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP27_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP27(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP27_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP27",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP28_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_MP28(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
MP28_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "MP28",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_ETC0_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_ETC0(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
ETC0_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "ETC0",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_ETC1_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_ETC1(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
ETC1_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "ETC1",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_ETC2_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_ETC2(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
ETC2_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "ETC2",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_ETC4_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .config =3D &gpio_cfg_noint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =A0 =3D S5PV210_ETC4(=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ngpio =A0=3D S5PV210_GPIO_=
ETC4_NR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .label =A0=3D "ETC4",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> +};
> +
> +static __init int s5pv210_gpiolib_init(void)
> +{
> + =A0 =A0 =A0 samsung_gpiolib_add_4bit_chips(s5pv210_gpio_4bit,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0ARRAY_SIZE(s5pv210_gpio_4bit));
> +
> + =A0 =A0 =A0 return 0;
> +}
> +core_initcall(s5pv210_gpiolib_init);
> diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-s5=
pv210/include/mach/gpio.h
> index 533b020..ddbbfc3 100644
> --- a/arch/arm/mach-s5pv210/include/mach/gpio.h
> +++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
> @@ -47,6 +47,39 @@
> =A0#define S5PV210_GPIO_J3_NR =A0 =A0 (8)
> =A0#define S5PV210_GPIO_J4_NR =A0 =A0 (5)
>
> +#define S5PV210_GPIO_MP01_NR =A0 (8)
> +#define S5PV210_GPIO_MP02_NR =A0 (4)
> +#define S5PV210_GPIO_MP03_NR =A0 (8)
> +#define S5PV210_GPIO_MP04_NR =A0 (8)
> +#define S5PV210_GPIO_MP05_NR =A0 (8)
> +#define S5PV210_GPIO_MP06_NR =A0 (8)
> +#define S5PV210_GPIO_MP07_NR =A0 (8)
> +
> +#define S5PV210_GPIO_MP10_NR =A0 (8)
> +#define S5PV210_GPIO_MP11_NR =A0 (8)
> +#define S5PV210_GPIO_MP12_NR =A0 (8)
> +#define S5PV210_GPIO_MP13_NR =A0 (8)
> +#define S5PV210_GPIO_MP14_NR =A0 (8)
> +#define S5PV210_GPIO_MP15_NR =A0 (8)
> +#define S5PV210_GPIO_MP16_NR =A0 (8)
> +#define S5PV210_GPIO_MP17_NR =A0 (8)
> +#define S5PV210_GPIO_MP18_NR =A0 (7)
> +
> +#define S5PV210_GPIO_MP20_NR =A0 (8)
> +#define S5PV210_GPIO_MP21_NR =A0 (8)
> +#define S5PV210_GPIO_MP22_NR =A0 (8)
> +#define S5PV210_GPIO_MP23_NR =A0 (8)
> +#define S5PV210_GPIO_MP24_NR =A0 (8)
> +#define S5PV210_GPIO_MP25_NR =A0 (8)
> +#define S5PV210_GPIO_MP26_NR =A0 (8)
> +#define S5PV210_GPIO_MP27_NR =A0 (8)
> +#define S5PV210_GPIO_MP28_NR =A0 (7)
> +
> +#define S5PV210_GPIO_ETC0_NR =A0 (6)
> +#define S5PV210_GPIO_ETC1_NR =A0 (8)
> +#define S5PV210_GPIO_ETC2_NR =A0 (8)
> +#define S5PV210_GPIO_ETC4_NR =A0 (6)
> +
> =A0/* GPIO bank numbers */
>
> =A0/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
> @@ -85,6 +118,35 @@ enum s5p_gpio_number {
> =A0 =A0 =A0 =A0S5PV210_GPIO_J2_START =A0 =3D S5PV210_GPIO_NEXT(S5PV210_GP=
IO_J1),
> =A0 =A0 =A0 =A0S5PV210_GPIO_J3_START =A0 =3D S5PV210_GPIO_NEXT(S5PV210_GP=
IO_J2),
> =A0 =A0 =A0 =A0S5PV210_GPIO_J4_START =A0 =3D S5PV210_GPIO_NEXT(S5PV210_GP=
IO_J3),
> + =A0 =A0 =A0 S5PV210_GPIO_MP01_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
J4),
> + =A0 =A0 =A0 S5PV210_GPIO_MP02_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP01),
> + =A0 =A0 =A0 S5PV210_GPIO_MP03_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP02),
> + =A0 =A0 =A0 S5PV210_GPIO_MP04_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP03),
> + =A0 =A0 =A0 S5PV210_GPIO_MP05_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP04),
> + =A0 =A0 =A0 S5PV210_GPIO_MP06_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP05),
> + =A0 =A0 =A0 S5PV210_GPIO_MP07_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP06),
> + =A0 =A0 =A0 S5PV210_GPIO_MP10_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP07),
> + =A0 =A0 =A0 S5PV210_GPIO_MP11_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP10),
> + =A0 =A0 =A0 S5PV210_GPIO_MP12_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP11),
> + =A0 =A0 =A0 S5PV210_GPIO_MP13_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP12),
> + =A0 =A0 =A0 S5PV210_GPIO_MP14_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP13),
> + =A0 =A0 =A0 S5PV210_GPIO_MP15_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP14),
> + =A0 =A0 =A0 S5PV210_GPIO_MP16_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP15),
> + =A0 =A0 =A0 S5PV210_GPIO_MP17_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP16),
> + =A0 =A0 =A0 S5PV210_GPIO_MP18_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP17),
> + =A0 =A0 =A0 S5PV210_GPIO_MP20_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP18),
> + =A0 =A0 =A0 S5PV210_GPIO_MP21_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP20),
> + =A0 =A0 =A0 S5PV210_GPIO_MP22_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP21),
> + =A0 =A0 =A0 S5PV210_GPIO_MP23_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP22),
> + =A0 =A0 =A0 S5PV210_GPIO_MP24_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP23),
> + =A0 =A0 =A0 S5PV210_GPIO_MP25_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP24),
> + =A0 =A0 =A0 S5PV210_GPIO_MP26_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP25),
> + =A0 =A0 =A0 S5PV210_GPIO_MP27_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP26),
> + =A0 =A0 =A0 S5PV210_GPIO_MP28_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP27),
> + =A0 =A0 =A0 S5PV210_GPIO_ETC0_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
MP28),
> + =A0 =A0 =A0 S5PV210_GPIO_ETC1_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
ETC0),
> + =A0 =A0 =A0 S5PV210_GPIO_ETC2_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
ETC1),
> + =A0 =A0 =A0 S5PV210_GPIO_ETC4_START =3D S5PV210_GPIO_NEXT(S5PV210_GPIO_=
ETC2),
> =A0};
>
> =A0/* S5PV210 GPIO number definitions */
> @@ -115,13 +177,42 @@ enum s5p_gpio_number {
> =A0#define S5PV210_GPJ2(_nr) =A0 =A0 =A0(S5PV210_GPIO_J2_START + (_nr))
> =A0#define S5PV210_GPJ3(_nr) =A0 =A0 =A0(S5PV210_GPIO_J3_START + (_nr))
> =A0#define S5PV210_GPJ4(_nr) =A0 =A0 =A0(S5PV210_GPIO_J4_START + (_nr))
> +#define S5PV210_MP01(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP01_START + (_nr))
> +#define S5PV210_MP02(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP02_START + (_nr))
> +#define S5PV210_MP03(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP03_START + (_nr))
> +#define S5PV210_MP04(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP04_START + (_nr))
> +#define S5PV210_MP05(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP05_START + (_nr))
> +#define S5PV210_MP06(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP06_START + (_nr))
> +#define S5PV210_MP07(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP07_START + (_nr))
> +#define S5PV210_MP10(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP10_START + (_nr))
> +#define S5PV210_MP11(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP11_START + (_nr))
> +#define S5PV210_MP12(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP12_START + (_nr))
> +#define S5PV210_MP13(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP13_START + (_nr))
> +#define S5PV210_MP14(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP14_START + (_nr))
> +#define S5PV210_MP15(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP15_START + (_nr))
> +#define S5PV210_MP16(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP16_START + (_nr))
> +#define S5PV210_MP17(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP17_START + (_nr))
> +#define S5PV210_MP18(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP18_START + (_nr))
> +#define S5PV210_MP20(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP20_START + (_nr))
> +#define S5PV210_MP21(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP21_START + (_nr))
> +#define S5PV210_MP22(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP22_START + (_nr))
> +#define S5PV210_MP23(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP23_START + (_nr))
> +#define S5PV210_MP24(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP24_START + (_nr))
> +#define S5PV210_MP25(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP25_START + (_nr))
> +#define S5PV210_MP26(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP26_START + (_nr))
> +#define S5PV210_MP27(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP27_START + (_nr))
> +#define S5PV210_MP28(_nr) =A0 =A0 =A0(S5PV210_GPIO_MP28_START + (_nr))
> +#define S5PV210_ETC0(_nr) =A0 =A0 =A0(S5PV210_GPIO_ETC0_START + (_nr))
> +#define S5PV210_ETC1(_nr) =A0 =A0 =A0(S5PV210_GPIO_ETC1_START + (_nr))
> +#define S5PV210_ETC2(_nr) =A0 =A0 =A0(S5PV210_GPIO_ETC2_START + (_nr))
> +#define S5PV210_ETC4(_nr) =A0 =A0 =A0(S5PV210_GPIO_ETC4_START + (_nr))
>
> =A0/* the end of the S5PV210 specific gpios */
> -#define S5PV210_GPIO_END =A0 =A0 =A0 (S5PV210_GPJ4(S5PV210_GPIO_J4_NR) +=
 1)
> +#define S5PV210_GPIO_END =A0 =A0 =A0 (S5PV210_ETC4(S5PV210_GPIO_ETC4_NR)=
 + 1)
> =A0#define S3C_GPIO_END =A0 =A0 =A0 =A0 =A0 S5PV210_GPIO_END
>
> -/* define the number of gpios we need to the one after the GPJ4() range =
*/
> -#define ARCH_NR_GPIOS =A0 =A0 =A0 =A0 =A0(S5PV210_GPJ4(S5PV210_GPIO_J4_N=
R) + =A0 =A0 \
> +/* define the number of gpios we need to the one after the ETC4() range =
*/
> +#define ARCH_NR_GPIOS =A0 =A0 =A0 =A0 =A0(S5PV210_ETC4(S5PV210_GPIO_ETC4=
_NR) + =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONFIG_SA=
MSUNG_GPIO_EXTRA + 1)
>
> =A0#include <asm-generic/gpio.h>
> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h b/arch/arm/ma=
ch-s5pv210/include/mach/regs-gpio.h
> new file mode 100644
> index 0000000..c78bbeb
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> @@ -0,0 +1,77 @@
> +/* linux/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + * =A0 =A0 =A0 =A0 =A0 =A0 http://www.samsung.com/
> + *
> + * S5PV210 - GPIO register definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_REGS_GPIO_H
> +#define __ASM_ARCH_REGS_GPIO_H __FILE__
> +
> +#include <mach/map.h>
> +
> +/* Base addresses for each of the banks */
> +
> +#define S5PV210_GPA0_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x000)
> +#define S5PV210_GPA1_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x020)
> +#define S5PV210_GPB_BASE =A0 =A0 =A0 (S5P_VA_GPIO + 0x040)
> +#define S5PV210_GPC0_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x060)
> +#define S5PV210_GPC1_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x080)
> +#define S5PV210_GPD0_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x0A0)
> +#define S5PV210_GPD1_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x0C0)
> +#define S5PV210_GPE0_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x0E0)
> +#define S5PV210_GPE1_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x100)
> +#define S5PV210_GPF0_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x120)
> +#define S5PV210_GPF1_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x140)
> +#define S5PV210_GPF2_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x160)
> +#define S5PV210_GPF3_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x180)
> +#define S5PV210_GPG0_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x1A0)
> +#define S5PV210_GPG1_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x1C0)
> +#define S5PV210_GPG2_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x1E0)
> +#define S5PV210_GPG3_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x200)
> +#define S5PV210_GPH0_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0xC00)
> +#define S5PV210_GPH1_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0xC20)
> +#define S5PV210_GPH2_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0xC40)
> +#define S5PV210_GPH3_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0xC60)
> +#define S5PV210_GPI_BASE =A0 =A0 =A0 (S5P_VA_GPIO + 0x220)
> +#define S5PV210_GPJ0_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x240)
> +#define S5PV210_GPJ1_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x260)
> +#define S5PV210_GPJ2_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x280)
> +#define S5PV210_GPJ3_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x2A0)
> +#define S5PV210_GPJ4_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x2C0)
> +#define S5PV210_MP01_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x2E0)
> +#define S5PV210_MP02_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x300)
> +#define S5PV210_MP03_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x320)
> +#define S5PV210_MP04_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x340)
> +#define S5PV210_MP05_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x360)
> +#define S5PV210_MP06_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x380)
> +#define S5PV210_MP07_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x3A0)
> +#define S5PV210_MP10_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x3C0)
> +#define S5PV210_MP11_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x3E0)
> +#define S5PV210_MP12_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x400)
> +#define S5PV210_MP13_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x420)
> +#define S5PV210_MP14_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x440)
> +#define S5PV210_MP15_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x460)
> +#define S5PV210_MP16_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x480)
> +#define S5PV210_MP17_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x4A0)
> +#define S5PV210_MP18_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x4C0)
> +#define S5PV210_MP20_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x4E0)
> +#define S5PV210_MP21_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x500)
> +#define S5PV210_MP22_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x520)
> +#define S5PV210_MP23_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x540)
> +#define S5PV210_MP24_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x560)
> +#define S5PV210_MP25_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x580)
> +#define S5PV210_MP26_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x5A0)
> +#define S5PV210_MP27_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x5C0)
> +#define S5PV210_MP28_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x5E0)
> +#define S5PV210_ETC0_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x600)
> +#define S5PV210_ETC1_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x620)
> +#define S5PV210_ETC2_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x640)
> +#define S5PV210_ETC4_BASE =A0 =A0 =A0(S5P_VA_GPIO + 0x660)
> +
> +#endif /* __ASM_ARCH_REGS_GPIO_H */
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-s=
oc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.359.1273060219.2170.linux-arm-kernel@lists.infradead.org>

not figured
out how to use type 2b and type 3b descriptors. It's not the fault of
DMA driver or
specification :-) It's actually upto the client to select the right type.

>> +
>> + =A0 =A0 lcfg->sghead =3D sgparams;
>> + =A0 =A0 lcfg->num_elem =3D nelem;
>> + =A0 =A0 lcfg->sgheadphy =3D padd;
>> + =A0 =A0 lcfg->pausenode =3D -1;
>> +
>> +
>> + =A0 =A0 if (NULL =3D=3D chparams)
> Minute point really. Better readability "ch_params"
OK

>> + =A0 =A0 dma_write(l, CDP(lch));
>> + =A0 =A0 dma_write((lcfg->sgheadphy), CNDP(lch));
>> + =A0 =A0 /**
>> + =A0 =A0 =A0* Barrier needed as writes to the
>> + =A0 =A0 =A0* descriptor memory needs to be flushed
>> + =A0 =A0 =A0* before it's used by DMA controller
>> + =A0 =A0 =A0*/
> Little bit of re-wording if you can.
> Also you don't wanted the double **
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Memory barrier is needed because data may still be
> =A0 =A0 =A0 =A0 * in the write buffer. The barrier drains write buffers a=
nd
> =A0 =A0 =A0 =A0 * ensures that DMA sees correct descriptors
> =A0 =A0 =A0 =A0 */
OK

>> + =A0 =A0 wmb();
>> + =A0 =A0 omap_start_dma(lch);
>> +
>> + =A0 =A0 /* Maintain the pause state in descriptor */
>> + =A0 =A0 omap_set_dma_sglist_pausebit(lcfg, lcfg->pausenode, 0);
>> + =A0 =A0 omap_set_dma_sglist_pausebit(lcfg, pauseafter, 1);
>> +
>> + =A0 =A0 /**
>> + =A0 =A0 =A0* Barrier needed as writes to the
>> + =A0 =A0 =A0* descriptor memory needs to be flushed
>> + =A0 =A0 =A0* before it's used by DMA controller
>> + =A0 =A0 =A0*/
> Description change if possible
OK

>> + =A0 =A0 wmb();
>> +
>> + =A0 =A0 /* Errata i557 - pausebit should be cleared in no standby mode=
 */
> This should have been

I couldn't understand this comment.

>> + =A0 =A0 sys_cf =3D dma_read(OCP_SYSCONFIG);
>> + =A0 =A0 l =3D sys_cf;
>> + =A0 =A0 /* Middle mode reg set no Standby */
>> + =A0 =A0 l &=3D ~(BIT(12) | BIT(13));
>> + =A0 =A0 dma_write(l, OCP_SYSCONFIG);


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.401.1273199835.2170.linux-arm-kernel@lists.infradead.org>

Origin 1.1"
> 
> The following commits are in:
> 
> Pinkava J (7):
>       ARM: n30: Enable Acer n35 if Acer n30 is selected
>       ARM: n30: fix: suspended wrong USB port on Acer n35
>       ARM: n30: Add RTC platform device for Acer n30 / Acer n35
>       ARM: n35: Add support for LEDs on Acer n35
>       ARM: n35: Enable wake-up by Power button on Acer n35
>       ARM: n30: Add support for MMC card reader on Acer n30 / Acer n35
>       ARM: n30: Add support for power on/off on Acer n30 / Acer n35 MMC card reader
> 
>  arch/arm/mach-s3c2410/Kconfig    |    7 ++++
>  arch/arm/mach-s3c2410/mach-n30.c |   65 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletions(-)
> 
> 



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.404.1273665228.2170.linux-arm-kernel@lists.infradead.org>

|   NOTE: This routine need only be called for page cache pages
|          which can potentially ever be mapped into the address
|          space of a user process.  So for example, VFS layer code
|          handling vfs symlinks in the page cache need not call
|          this interface at all.

A page from slab or stack is not going to see the sky of user land and
therefore it should not be fed into flush_dcache_page().

Sebastian


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.405.1273710668.2170.linux-arm-kernel@lists.infradead.org>

actually using the cfg_eint anywhere. For the S5PV210 it seems that the
gpio pin configuration is static for all gpio banks.

It is probably going to be easier to remove it from this code and look
at removing it altogether from the s3c_gpio_cfg configuration structure.

Also, but not a stopper to getting this merged, we should probably make
a standard config structure for this and then re-use it, as iirc this will
be the same as the 64xx case if we remove the cfg_eint.

> +static struct s3c_gpio_cfg gpio_cfg_noint = {
> +	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
> +	.set_pull	= s3c_gpio_setpull_updown,
> +	.get_pull	= s3c_gpio_getpull_updown,
> +};
> +
> +/* GPIO bank's base address given the index of the bank in the
> + * list of all gpio banks.
> + */
> +#define S5PV210_BANK_BASE(bank_nr)	(S5P_VA_GPIO + ((bank_nr) * 0x20))
> +
> +/*
> + * Following are the gpio banks in v210.
> + *
> + * The 'config' member when left to NULL, is initialized to the default
> + * structure gpio_cfg in the init function below.
> + *
> + * The 'base' member is also initialized in the init function below.
> + * Note: The initialization of 'base' member of s3c_gpio_chip structure
> + * uses the above macro and depends on the banks being listed in order here.
> + */
> +static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
> +	{
> +		.chip	= {
> +			.base	= S5PV210_GPA0(0),
> +			.ngpio	= S5PV210_GPIO_A0_NR,
> +			.label	= "GPA0",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPA1(0),
> +			.ngpio	= S5PV210_GPIO_A1_NR,
> +			.label	= "GPA1",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPB(0),
> +			.ngpio	= S5PV210_GPIO_B_NR,
> +			.label	= "GPB",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPC0(0),
> +			.ngpio	= S5PV210_GPIO_C0_NR,
> +			.label	= "GPC0",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPC1(0),
> +			.ngpio	= S5PV210_GPIO_C1_NR,
> +			.label	= "GPC1",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPD0(0),
> +			.ngpio	= S5PV210_GPIO_D0_NR,
> +			.label	= "GPD0",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPD1(0),
> +			.ngpio	= S5PV210_GPIO_D1_NR,
> +			.label	= "GPD1",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPE0(0),
> +			.ngpio	= S5PV210_GPIO_E0_NR,
> +			.label	= "GPE0",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPE1(0),
> +			.ngpio	= S5PV210_GPIO_E1_NR,
> +			.label	= "GPE1",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPF0(0),
> +			.ngpio	= S5PV210_GPIO_F0_NR,
> +			.label	= "GPF0",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPF1(0),
> +			.ngpio	= S5PV210_GPIO_F1_NR,
> +			.label	= "GPF1",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPF2(0),
> +			.ngpio	= S5PV210_GPIO_F2_NR,
> +			.label	= "GPF2",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPF3(0),
> +			.ngpio	= S5PV210_GPIO_F3_NR,
> +			.label	= "GPF3",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPG0(0),
> +			.ngpio	= S5PV210_GPIO_G0_NR,
> +			.label	= "GPG0",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPG1(0),
> +			.ngpio	= S5PV210_GPIO_G1_NR,
> +			.label	= "GPG1",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPG2(0),
> +			.ngpio	= S5PV210_GPIO_G2_NR,
> +			.label	= "GPG2",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPG3(0),
> +			.ngpio	= S5PV210_GPIO_G3_NR,
> +			.label	= "GPG3",
> +		},
> +	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_GPH0(0),
> +			.ngpio	= S5PV210_GPIO_H0_NR,
> +			.label	= "GPH0",
> +		},
> +	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_GPH1(0),
> +			.ngpio	= S5PV210_GPIO_H1_NR,
> +			.label	= "GPH1",
> +		},
> +	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_GPH2(0),
> +			.ngpio	= S5PV210_GPIO_H2_NR,
> +			.label	= "GPH2",
> +		},
> +	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_GPH3(0),
> +			.ngpio	= S5PV210_GPIO_H3_NR,
> +			.label	= "GPH3",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPI(0),
> +			.ngpio	= S5PV210_GPIO_I_NR,
> +			.label	= "GPI",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPJ0(0),
> +			.ngpio	= S5PV210_GPIO_J0_NR,
> +			.label	= "GPJ0",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPJ1(0),
> +			.ngpio	= S5PV210_GPIO_J1_NR,
> +			.label	= "GPJ1",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPJ2(0),
> +			.ngpio	= S5PV210_GPIO_J2_NR,
> +			.label	= "GPJ2",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPJ3(0),
> +			.ngpio	= S5PV210_GPIO_J3_NR,
> +			.label	= "GPJ3",
> +		},
> +	}, {
> +		.chip	= {
> +			.base	= S5PV210_GPJ4(0),
> +			.ngpio	= S5PV210_GPIO_J4_NR,
> +			.label	= "GPJ4",
> +		},
> +	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP01(0),
> +			.ngpio	= S5PV210_GPIO_MP01_NR,
> +			.label	= "MP01",
> +		},
> +	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP02(0),
> +			.ngpio	= S5PV210_GPIO_MP02_NR,
> +			.label	= "MP02",
> +		},
> +	}, {
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP03(0),
> +			.ngpio	= S5PV210_GPIO_MP03_NR,
> +			.label	= "MP03",
> +		},
> +	},
> +};
> +
> +static __init int s5pv210_gpiolib_init(void)
> +{
> +	struct s3c_gpio_chip *chip = s5pv210_gpio_4bit;
> +	int nr_chips = ARRAY_SIZE(s5pv210_gpio_4bit);
> +	int i = 0;
> +
> +	for (i = 0; i < nr_chips; i++, chip++) {
> +		if (chip->config == NULL)
> +			chip->config = &gpio_cfg;
> +		if (chip->base == NULL)
> +			chip->base = S5PV210_BANK_BASE(i);
> +	}
> +
> +	samsung_gpiolib_add_4bit_chips(s5pv210_gpio_4bit,
> +				       ARRAY_SIZE(s5pv210_gpio_4bit));
				       ^& replace with nr_chips.	

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.448.1274071698.2170.linux-arm-kernel@lists.infradead.org>

leave this comment for now.

> >> +#define eint_irq_to_bit(irq) ? ? ? ? (1 << (eint_offset(irq) & 0x7))
> >> +
> >> +#define eint_conf_reg(irq) ? ? ? ? ? ((eint_offset(irq)) >> 3)
> >> +#define eint_mask_reg(irq) ? ? ? ? ? ((eint_offset(irq)) >> 3)
> >> +#define eint_pend_reg(irq) ? ? ? ? ? ((eint_offset(irq)) >> 3)
> >> +
> >> +/* values for S5P_EXTINT0 */
> >> +#define S5P_EXTINT_LOWLEV ? ? ? ? ? ?(0x00)
> >> +#define S5P_EXTINT_HILEV ? ? ? ? ? ? (0x01)
> >> +#define S5P_EXTINT_FALLEDGE ? ? ? ? ?(0x02)
> >> +#define S5P_EXTINT_RISEEDGE ? ? ? ? ?(0x03)
> >> +#define S5P_EXTINT_BOTHEDGE ? ? ? ? ?(0x04)
> >> +
> >> +#endif /* __ASM_ARCH_REGS_GPIO_H */
> >> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> >> index d400a6a..7d1fc40 100644
> >> --- a/arch/arm/plat-s5p/Kconfig
> >> +++ b/arch/arm/plat-s5p/Kconfig
> >> @@ -23,3 +23,8 @@ config PLAT_S5P
> >> ? ? ? select SAMSUNG_IRQ_UART
> >> ? ? ? help
> >> ? ? ? ? Base platform code for Samsung's S5P series SoC.
> >> +
> >> +config S5P_EXT_INT
> >> + ? ? bool
> >> + ? ? help
> >> + ? ? ? Use the external interrupts (other than GPIO interrupts.)
> >> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> >> index a7c54b3..25941a5 100644
> >> --- a/arch/arm/plat-s5p/Makefile
> >> +++ b/arch/arm/plat-s5p/Makefile
> >> @@ -16,4 +16,5 @@ obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? += dev-uart.o
> >> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+= cpu.o
> >> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+= clock.o
> >> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+= irq.o
> >> +obj-$(CONFIG_S5P_EXT_INT) ? ?+= irq-eint.o
> >> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+= setup-i2c0.o
> >> diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
> >> new file mode 100644
> >> index 0000000..484a8fe
> >> --- /dev/null
> >> +++ b/arch/arm/plat-s5p/irq-eint.c
> >> @@ -0,0 +1,216 @@
> >> +/* linux/arch/arm/plat-s5p/irq-eint.c
> >> + *
> >> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> >> + * ? ? ? ? ? http://www.samsung.com
> >> + *
> >> + * S5P - IRQ EINT support
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> +*/
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/irq.h>
> >> +#include <linux/io.h>
> >> +#include <linux/sysdev.h>
> >> +#include <linux/gpio.h>
> >> +
> >> +#include <asm/bitops.h>
> >> +#include <asm/hardware/vic.h>
> >> +
> >> +#include <plat/regs-irqtype.h>
> >> +
> >> +#include <mach/map.h>
> >> +#include <plat/cpu.h>
> >> +#include <plat/pm.h>
> >> +
> >> +#include <plat/gpio-cfg.h>
> >> +#include <mach/regs-gpio.h>
> >> +
> >> +static inline void s5p_irq_eint_mask(unsigned int irq)
> >> +{
> >> + ? ? u32 mask;
> >> +
> >> + ? ? mask = __raw_readl(S5P_EINT_MASK(eint_mask_reg(irq)));
> >> + ? ? mask |= eint_irq_to_bit(irq);
> >> + ? ? __raw_writel(mask, S5P_EINT_MASK(eint_mask_reg(irq)));
> >> +}
> >> +
> >> +static void s5p_irq_eint_unmask(unsigned int irq)
> >> +{
> >> + ? ? u32 mask;
> >> +
> >> + ? ? mask = __raw_readl(S5P_EINT_MASK(eint_mask_reg(irq)));
> >> + ? ? mask &= ~(eint_irq_to_bit(irq));
> >> + ? ? __raw_writel(mask, S5P_EINT_MASK(eint_mask_reg(irq)));
> >> +}
> >> +
> >> +static inline void s5p_irq_eint_ack(unsigned int irq)
> >> +{
> >> + ? ? __raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(eint_pend_reg(irq)));
> >> +}
> >> +
> >> +static void s5p_irq_eint_maskack(unsigned int irq)
> >> +{
> >> + ? ? /* compiler should in-line these */
> >> + ? ? s5p_irq_eint_mask(irq);
> >> + ? ? s5p_irq_eint_ack(irq);
> >> +}
> >> +
> >> +static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
> >> +{
> >> + ? ? int offs = eint_offset(irq);
> >> + ? ? int shift;
> >> + ? ? u32 ctrl, mask;
> >> + ? ? u32 newvalue = 0;
> >> +
> >> + ? ? switch (type) {
> >> + ? ? case IRQ_TYPE_NONE:
> >> + ? ? ? ? ? ? printk(KERN_WARNING "No edge setting!\n");
> >> + ? ? ? ? ? ? break;
> >> +
> >> + ? ? case IRQ_TYPE_EDGE_RISING:
> >> + ? ? ? ? ? ? newvalue = S5P_EXTINT_RISEEDGE;
> >> + ? ? ? ? ? ? break;
> >> +
> >> + ? ? case IRQ_TYPE_EDGE_FALLING:
> >> + ? ? ? ? ? ? newvalue = S5P_EXTINT_RISEEDGE;
> >> + ? ? ? ? ? ? break;
> >> +
> >> + ? ? case IRQ_TYPE_EDGE_BOTH:
> >> + ? ? ? ? ? ? newvalue = S5P_EXTINT_BOTHEDGE;
> >> + ? ? ? ? ? ? break;
> >> +
> >> + ? ? case IRQ_TYPE_LEVEL_LOW:
> >> + ? ? ? ? ? ? newvalue = S5P_EXTINT_LOWLEV;
> >> + ? ? ? ? ? ? break;
> >> +
> >> + ? ? case IRQ_TYPE_LEVEL_HIGH:
> >> + ? ? ? ? ? ? newvalue = S5P_EXTINT_HILEV;
> >> + ? ? ? ? ? ? break;
> >> +
> >> + ? ? default:
> >> + ? ? ? ? ? ? printk(KERN_ERR "No such irq type %d", type);
> >> + ? ? ? ? ? ? return -EINVAL;
> >> + ? ? }
> >> +
> >> + ? ? shift = (offs & 0x7) * 4;
> >> + ? ? mask = 0x7 << shift;
> >> +
> >> + ? ? ctrl = __raw_readl(S5P_EINT_CON(eint_conf_reg(irq)));
> >> + ? ? ctrl &= ~mask;
> >> + ? ? ctrl |= newvalue << shift;
> >> + ? ? __raw_writel(ctrl, S5P_EINT_CON(eint_conf_reg(irq)));
> >> +
> >> + ? ? if ((0 <= offs) && (offs < 8))
> >> + ? ? ? ? ? ? s3c_gpio_cfgpin(EINT_GPIO_REG0(offs & 0x7), EINT_MODE);
> >> +
> >> + ? ? else if ((8 <= offs) && (offs < 16))
> >> + ? ? ? ? ? ? s3c_gpio_cfgpin(EINT_GPIO_REG1(offs & 0x7), EINT_MODE);
> >> +
> >> + ? ? else if ((16 <= offs) && (offs < 24))
> >> + ? ? ? ? ? ? s3c_gpio_cfgpin(EINT_GPIO_REG2(offs & 0x7), EINT_MODE);
> >> +
> >> + ? ? else if ((24 <= offs) && (offs < 32))
> >> + ? ? ? ? ? ? s3c_gpio_cfgpin(EINT_GPIO_REG3(offs & 0x7), EINT_MODE);
> >> +
> >> + ? ? else
> >> + ? ? ? ? ? ? printk(KERN_ERR "No such irq number %d", offs);
> >> +
> >> + ? ? return 0;
> >> +}
> >> +
> >> +static struct irq_chip s5p_irq_eint = {
> >> + ? ? .name ? ? ? ? ? = "s5p-eint",
> >> + ? ? .mask ? ? ? ? ? = s5p_irq_eint_mask,
> >> + ? ? .unmask ? ? ? ? = s5p_irq_eint_unmask,
> >> + ? ? .mask_ack ? ? ? = s5p_irq_eint_maskack,
> >> + ? ? .ack ? ? ? ? ? ?= s5p_irq_eint_ack,
> >> + ? ? .set_type ? ? ? = s5p_irq_eint_set_type,
> >> +#ifdef CONFIG_PM
> >> + ? ? .set_wake ? ? ? = s3c_irqext_wake,
> >> +#endif
> >> +};
> >> +
> >> +/* s5p_irq_demux_eint
> >> + *
> >> + * This function demuxes the IRQ from the group0 external interrupts,
> >> + * from IRQ_EINT(16) to IRQ_EINT(31). It is designed to be inlined into
> >> + * the specific handlers s5p_irq_demux_eintX_Y.
> >> + */
> >> +static inline void s5p_irq_demux_eint(unsigned int start, unsigned int end)
> >> +{
> >> + ? ? u32 status;
> >> + ? ? u32 mask = __raw_readl(S5P_EINT_MASK((start >> 3)));
> >> + ? ? unsigned int irq;
> >> +
> >> + ? ? status = __raw_readl(S5P_EINT_PEND((start >> 3)));
> >> + ? ? status &= ~mask;
> >> + ? ? status &= (1 << (end - start + 1)) - 1;
> >
> > We don't need to do any masking here as we'll always be processing all
> > interrupts from the controller. In fact, we probably don't need the end
> > argument here at-all.
> >
> >> + ? ? while (status) {
> >> + ? ? ? ? ? ? irq = fls(status);
> >> + ? ? ? ? ? ? generic_handle_irq(irq - 1 + IRQ_EINT(start));
> >> + ? ? ? ? ? ? status &= ~(1 << irq);
> >> + ? ? }
> >> +}
> >> +
> >> +static void s5p_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
> >> +{
> >> + ? ? s5p_irq_demux_eint(16, 23);
> >> + ? ? s5p_irq_demux_eint(24, 31);

We can remove the end parameters, both interrupt banks are 8 IRQs and
this we can also make the bit clearing post mask a constant if it is
even needed.

> >> +}
> >> +
> >> +static inline void s5p_irq_vic_eint_mask(unsigned int irq)
> >> +{
> >> + ? ? s5p_irq_eint_mask(irq);
> >> +}
> >> +
> >> +static void s5p_irq_vic_eint_unmask(unsigned int irq)
> >> +{
> >> + ? ? s5p_irq_eint_unmask(irq);
> >> +}
> >> +
> >> +static inline void s5p_irq_vic_eint_ack(unsigned int irq)
> >> +{
> >> + ? ? __raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(eint_pend_reg(irq)));
> >> +}
> >> +
> >> +static void s5p_irq_vic_eint_maskack(unsigned int irq)
> >> +{
> >> + ? ? s5p_irq_vic_eint_mask(irq);
> >> + ? ? s5p_irq_vic_eint_ack(irq);
> >> +}
> >> +
> >> +static struct irq_chip s5p_irq_vic_eint = {
> >> + ? ? .name ? ? ? ? ? = "s5p_vic_eint",
> >> + ? ? .mask ? ? ? ? ? = s5p_irq_vic_eint_mask,
> >> + ? ? .unmask ? ? ? ? = s5p_irq_vic_eint_unmask,
> >> + ? ? .mask_ack ? ? ? = s5p_irq_vic_eint_maskack,
> >> + ? ? .ack ? ? ? ? ? ?= s5p_irq_vic_eint_ack,
> >> + ? ? .set_type ? ? ? = s5p_irq_eint_set_type,
> >> +#ifdef CONFIG_PM
> >> + ? ? .set_wake ? ? ? = s3c_irqext_wake,
> >> +#endif
> >> +};
> >> +
> >> +int __init s5p_init_irq_eint(void)
> >> +{
> >> + ? ? int irq;
> >> +
> >> + ? ? for (irq = IRQ_EINT(0); irq <= IRQ_EINT(15); irq++)
> >> + ? ? ? ? ? ? set_irq_chip(irq, &s5p_irq_vic_eint);
> >> +
> >> + ? ? for (irq = IRQ_EINT_GRP(16); irq <= IRQ_EINT_GRP(31); irq++) {
> >> + ? ? ? ? ? ? set_irq_chip(irq, &s5p_irq_eint);
> >> + ? ? ? ? ? ? set_irq_handler(irq, handle_level_irq);
> >> + ? ? ? ? ? ? set_irq_flags(irq, IRQF_VALID);
> >> + ? ? }
> >> +
> >> + ? ? set_irq_chained_handler(IRQ_EINT16_31, s5p_irq_demux_eint16_31);
> >> + ? ? return 0;
> >> +}
> >> +
> >> +arch_initcall(s5p_init_irq_eint);

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.



>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.468.1274484897.2170.linux-arm-kernel@lists.infradead.org>

data at registering time, which is built-in, but I guess you object
because of the size of all the extra data and code that would come by
making mach-omapX/mailbox.c as built-in. Am I right?

If that's the case I agree, although I have the feeling that the
platform-specific data can be reduced a lot.

But again, only one of the patches makes the code built-in, the rest
of the patches are independent of that.

-- 
Felipe Contreras


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.474.1275728731.2170.linux-arm-kernel@lists.infradead.org>

/*
 * This is normally called from the decompressor code.  The requirements
 * are: MMU = off, D-cache = off, I-cache = dont care, r0 = 0,
 * r1 = machine nr, r2 = atags pointer.
 */

Since D-cache is off when entering kernel then what's the point of flushing
data cache here? In theory we only need make sure the whole cache is
invalidated right? So that when MMU is enabled the cache is in a clean
status with everything new loaded.

I'm asking this is I'm running a simulation and somehow the simulation can
not continue when data cache is cleaned but invalidate only works. My doubt
is since the cache content is garbage when chip is powered on, "xxx" data
may be flushed to memory if "clean and invalidate" is performed, which cause
my simulation problem.

Any one can help me understand this? Thanks in advance.

-Tim

--000e0cd70ad85790720488287990
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div>I have a question regarding the data cache flush routine called at =
the beginning of kernel start up. At the beginning of the start up code, af=
ter processor type and machine type look up and simple page table created, =
a __switch_data is called which goes to=A0__v7_setup in my case (since the =
CPU is A9). Then at the beginning of the function it calls v7_flush_dcache_=
all. This cache routine is in cache-v7.S and I see it actually does &quot;c=
lean and invalidate&quot; operation as opposed to invalidate only.</div>
<div><br></div><div>From Russell&#39;s comment I can see this is the kernel=
 start requirement:</div><div><div><br></div><div>/*</div><div>=A0* This is=
 normally called from the decompressor code. =A0The requirements</div><div>
=A0* are: MMU =3D off, D-cache =3D off, I-cache =3D dont care, r0 =3D 0,</d=
iv><div>=A0* r1 =3D machine nr, r2 =3D atags pointer.</div><div>=A0*/</div>=
<div><br></div><div>Since D-cache is off when entering kernel then what&#39=
;s the point of flushing data cache here? In theory we only need make sure =
the whole cache is invalidated right? So that when MMU is enabled the cache=
 is in a clean status with everything new loaded.</div>
<div><br></div><div>I&#39;m asking this is I&#39;m running a simulation and=
 somehow the simulation can not continue when data cache is cleaned but inv=
alidate only works. My doubt is since the cache content is garbage when chi=
p is powered on, &quot;xxx&quot; data may be flushed to memory if &quot;cle=
an and invalidate&quot; is performed, which cause my simulation problem.</d=
iv>
<div><br></div><div>Any one can help me understand this? Thanks in advance.=
</div><div><br></div><div>-Tim</div><div><br></div><div><br></div><div><br>=
</div><div><br></div></div><div><br></div>

--000e0cd70ad85790720488287990--
