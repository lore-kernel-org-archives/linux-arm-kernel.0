From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Wed, 03 Dec 2014 18:18:57 +0530
Subject: [PATCH] mfd: max77686: Fix parent of rtc device
In-Reply-To: <1417598734.23732.11.camel@AMDC1943>
References: <1417523620-4311-1-git-send-email-yadi.brar@samsung.com>
 <1417524339-4604-1-git-send-email-yadi.brar@samsung.com>
 <547DBFAD.30605@samsung.com>
 <000001d00ed7$db623bb0$9226b310$%brar@samsung.com>
 <1417598734.23732.11.camel@AMDC1943>
Message-ID: <001d01d00ef7$9dc2ba80$d9482f80$%brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 03, 2014 2:56 PM, Krzysztof Kozlowski wrote:
> 
> On ?ro, 2014-12-03 at 14:32 +0530, Yadwinder Singh Brar wrote:
> >
> > On Tuesday, December 02, 2014 7:04 PM, Krzysztof Koz?owski wrote:
> > > On 02.12.2014 13:45, Yadwinder Singh Brar wrote:
> > > > rtc have different i2c client than power(pmic) block. So rtc
> > > > device should sit under its own i2c client in device hierarchy,
> > > > which
> > > reflects in sysfs also.
> > > > This patch modifies code to register rtc cell with rtc->dev as
> > > parent.
> > > >
> > > > Without this patch :
> > > > # ls /sys/class/i2c-adapter/i2c-0/0-0009/
> > > > driver         max77686-pmic  modalias       power
> uevent
> > > > max77686-clk   max77686-rtc   name           subsystem
> > > >
> > > > After applying patch :
> > > > # ls /sys/class/i2c-adapter/i2c-0/0-0006/
> > > > driver/        modalias       power/         uevent
> > > > max77686-rtc/  name           subsystem/
> > > >
> > > > Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> > > > ---
> > > >
> > > > Or Can we follow another (exhaustive but more cleaner) approach,
> > > which
> > > > will be more like code refactoring and cleanup rather than only
> fix:
> > > > Since rtc uses i2c client, which gets created using
> > > > i2c_new_dummy() and is not shared by any other cell of max77686.
> > > > So we can covert rtc platform driver itself to i2c client driver.
> > > > It will also allow to expilicitly describe max77686-rtc in DT
> which we can't do now.
> > > > It can be applicable to some other existing and new mfd pmic
> drivers.
> > > > Any suggestion/comments ?
> > >
> > > Hi,
> > >
> > > What kind of problem is solved by this patch?
> > >
> >
> > Let me try to explain once again :)
> > After seeing a message "i2c i2c-0: .... , addr=0x06, .." in dmesg
> log,
> > I was not able to find any such device in sysfs as well as device
> tree.
> > There was no device under /sys/class/i2c-dev/i2c-0/device/0-0006/
> > Isn't something wrong or missing ?
> >
> > This patch fixes that missing parent child relation, which IMO should
> > be correct always, though it causes any major problem or not.
> 
> OK, I got your point. I'm fine with both solutions and the patch looks
> good, so:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

Thanks for reviewing :).

> > Still I am thinking, 0-0006 slave device(rtc) shouldn't also appear
> in DT?
> > As DT should describe the hardware that we are using.
> 
> Your patch properly describes the hardware. However from driver
> perspective, the RTC here is not an standalone driver and depends on
> parent (MFD) driver.
> 

Hmm ... I can't see any hard dependency. I think rtc can survive as independent i2c device.
And rtc(@06) is more like a sibling of existing MFD driver(max77686 at 09)

> Although max77686 RTC could have its own DeviceTree node, I think it
> should still be put under main MFD driver's node, because the parent
> manages stuff like interrupts.
> 

I think it will not sound good to have something like max77686-rtc at 06
node under max77686 at 09 node, since both are kind of siblings.
And interrupts should not be a restricting factor, In case of
max77686 interrupt source and mask registers for rtc also lie in rtc
i2c register bank so we can add an irq_chip from rtc driver itself.

Only thing I can see which can be little bit tricky, is providing
alarm->pending info(pending interrupt) in alarm_read() callback
in rtc as currently its based on MAX77686_REG_STATUS2 which is
only common register in power(pmic) register bank of max77686.
Though in practical scenarios it may not be non zero, since
reading once source register clears this status also, but we may
have to keep it for sake of functionality completeness.

I can?t see any way(something similar to syscon) for sharing
i2c regmap between independent drivers, other than getting
reference to regmap from i2c device found by of_find_i2c_device_by_node().
Anyone can suggest better idea?


Best Regards,
Yadwinder
