From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 24 Jan 2017 15:15:48 +0100
Subject: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
In-Reply-To: <b6d1670c-a83f-55aa-efd1-e52adb297ac6@roeck-us.net>
References: <20170123124058.GA17134@amd> <20170123141331.GA11402@amd>
 <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd> <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net>
 <20170124070639.GA5068@rzhang1-surface>
 <b6d1670c-a83f-55aa-efd1-e52adb297ac6@roeck-us.net>
Message-ID: <20170124141548.GA14489@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>>>/sys files related to battery no longer appear. I beieve this has
> >>>>something to do with it:
> >>>>
> >>>>[    2.374877] of_get_named_gpiod_flags: parsed 'reset-gpios' property
> >>>>of node '/ocp at 68000000/spi at 48098000/tsc2005 at 0[0]' - status (0)
> >>>>[    2.375946] input: TSC2005 touchscreen as
> >>>>/devices/platform/68000000.ocp/48098000.spi/spi_master/spi1/spi1.0/input/input5
> >>>>[    2.392120] rx51-battery: probe of n900-battery failed with error
> >>>>-22
> >>>
> >>>Mystery solved:
> >>>
> >>>diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> >>>index 3932f92..fe5ec82 100644
> >>>--- a/drivers/hwmon/hwmon.c
> >>>+++ b/drivers/hwmon/hwmon.c
> >>>@@ -545,8 +545,10 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
> >>> 	int i, j, err, id;
> >>>
> >>> 	/* Do not accept invalid characters in hwmon name attribute */
> >>>-	if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
> >>>+	if (name && (!strlen(name) || strpbrk(name, "-* \t\n"))) {
> >>>+		printk("hwmon: Invalid character detected: %s\n", name);
> >>> 		return ERR_PTR(-EINVAL);
> >>>+	}
> >>>
> >>> 	id = ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
> >>> 	if (id < 0)
> >>>
> >>>
> >>>pavel at n900:~$ dmesg | grep -5 Invalid
> >>>[    0.829650] of_get_named_gpiod_flags: parsed 'gpio-reset' property
> >>>of node '/ocp at 68000000/i2c at 48072000/tlv320aic3x at 19[0]' - status (0)
> >>>[    0.833831] tsl2563 2-0029: model 7, rev. 0
> >>>[    0.837768] of_get_named_gpiod_flags: parsed 'enable-gpio' property
> >>>of node '/ocp at 68000000/i2c at 48072000/lp5523 at 32[0]' - status (0)
> >>>[    1.921417] omap_i2c 48072000.i2c: controller timed out
> >>>[    2.056823] lp5523x 2-0032: lp5523 Programmable led chip found
> >>>[    2.064147] hwmon: Invalid character detected: bq27200-0
> >>
> >>So the problem is really that the thermal driver needs to create a valid name.
> >>
> >Right.
> >
> >Before reverting, can you please try if this patch works or not?

> >diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> >index c4a508a..0c6789f 100644
> >--- a/drivers/thermal/thermal_hwmon.c
> >+++ b/drivers/thermal/thermal_hwmon.c
> >@@ -157,8 +157,8 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
> >
> > 	INIT_LIST_HEAD(&hwmon->tz_list);
> > 	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
> >-	hwmon->device = hwmon_device_register_with_info(NULL, hwmon->type,
> >-							hwmon, NULL, NULL);
> >+	hwmon->device = hwmon_device_register_with_info(NULL, NULL, NULL,
> >+							NULL, NULL);
> 
> This is wrong. The name should be converted to a valid name. Otherwise you would
> still have to provide the name attribute yourself, and the resulting name would
> still be invalid. A simple fix would be to add
> 	strreplace(hwmon->type, '-', '_');
> after strlcpy().

Simple, yes. But that will change userland interface. Is it okay thing
to do?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170124/4006858c/attachment.sig>
