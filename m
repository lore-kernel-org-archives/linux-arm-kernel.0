From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 03 Dec 2014 10:25:34 +0100
Subject: [PATCH] mfd: max77686: Fix parent of rtc device
In-Reply-To: <000001d00ed7$db623bb0$9226b310$%brar@samsung.com>
References: <1417523620-4311-1-git-send-email-yadi.brar@samsung.com>
 <1417524339-4604-1-git-send-email-yadi.brar@samsung.com>
 <547DBFAD.30605@samsung.com>
 <000001d00ed7$db623bb0$9226b310$%brar@samsung.com>
Message-ID: <1417598734.23732.11.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2014-12-03 at 14:32 +0530, Yadwinder Singh Brar wrote:
> 
> On Tuesday, December 02, 2014 7:04 PM, Krzysztof Koz?owski wrote: 
> > On 02.12.2014 13:45, Yadwinder Singh Brar wrote:
> > > rtc have different i2c client than power(pmic) block. So rtc device
> > > should sit under its own i2c client in device hierarchy, which
> > reflects in sysfs also.
> > > This patch modifies code to register rtc cell with rtc->dev as
> > parent.
> > >
> > > Without this patch :
> > > # ls /sys/class/i2c-adapter/i2c-0/0-0009/
> > > driver         max77686-pmic  modalias       power          uevent
> > > max77686-clk   max77686-rtc   name           subsystem
> > >
> > > After applying patch :
> > > # ls /sys/class/i2c-adapter/i2c-0/0-0006/
> > > driver/        modalias       power/         uevent
> > > max77686-rtc/  name           subsystem/
> > >
> > > Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> > > ---
> > >
> > > Or Can we follow another (exhaustive but more cleaner) approach,
> > which
> > > will be more like code refactoring and cleanup rather than only fix:
> > > Since rtc uses i2c client, which gets created using i2c_new_dummy()
> > > and is not shared by any other cell of max77686. So we can covert rtc
> > > platform driver itself to i2c client driver. It will also allow to
> > > expilicitly describe max77686-rtc in DT which we can't do now.
> > > It can be applicable to some other existing and new mfd pmic drivers.
> > > Any suggestion/comments ?
> > 
> > Hi,
> > 
> > What kind of problem is solved by this patch?
> >
> 
> Let me try to explain once again :)
> After seeing a message "i2c i2c-0: .... , addr=0x06, .." in dmesg log,
> I was not able to find any such device in sysfs as well as device tree.
> There was no device under /sys/class/i2c-dev/i2c-0/device/0-0006/
> Isn't something wrong or missing ?
> 
> This patch fixes that missing parent child relation, which IMO
> should be correct always, though it causes any major problem or not.

OK, I got your point. I'm fine with both solutions and the patch looks
good, so:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

> Still I am thinking, 0-0006 slave device(rtc) shouldn't also appear in DT?
> As DT should describe the hardware that we are using.

Your patch properly describes the hardware. However from driver
perspective, the RTC here is not an standalone driver and depends on
parent (MFD) driver.

Although max77686 RTC could have its own DeviceTree node, I think it
should still be put under main MFD driver's node, because the parent
manages stuff like interrupts.

Best regards,
Krzysztof
