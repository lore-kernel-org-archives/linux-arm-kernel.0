From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 29 Nov 2009 20:43:45 -0500
Subject: [PATCH 02/10] support 88pm8606 in 860x driver
In-Reply-To: <20091127145820.GA3640@sortiz.org>
References: <771cded00911130054p2ef293ebse84b1de3cf4fa9fd@mail.gmail.com>
	<20091120150215.GF3733@sortiz.org>
	<771cded00911211625g74601e5die59a680f36903cb3@mail.gmail.com>
	<20091127145820.GA3640@sortiz.org>
Message-ID: <771cded00911291743u76688d24ja40a30472ebd6af8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2009 at 9:58 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Haojian,
>
> On Sun, Nov 22, 2009 at 08:25:48AM +0800, Haojian Zhuang wrote:
>> On Fri, Nov 20, 2009 at 11:02 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
>> > Hi Haojian,
>> >
>> > On Fri, Nov 13, 2009 at 03:54:52AM -0500, Haojian Zhuang wrote:
>> >> From 52a43fa137c45e62ced134b240c387b600f4ac0e Mon Sep 17 00:00:00 2001
>> >> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> >> Date: Fri, 6 Nov 2009 09:22:52 -0500
>> >> Subject: [PATCH] mfd: support 88pm8606 in 860x driver
>> >>
>> >> 88PM8606 and 88PM8607 are always used together. Although they're two discrete
>> >> chips, the logic function is tightly linked. For example, USB charger driver
>> >> is based on these two devices.
>> >>
>> >> Now share one driver to these two devices. Create a logical chip structure
>> >> that contains both 8606 device and 8607 device.
>> > I think it's a really good idea to have one driver for those 2 devices.
>> > However, I dont see much point in having the mixed_88pm860x common structure.
>> > That forces you in having a static structure there for no real benefit. In
>> > fact, by having it you're restricting yourself to the current HW
>> > configuration, i.e. at most 1 8806 and 1 8807.
>> Yes, I just want to restrict at most 1 8806 and 1 8807 in system. Or
>> we should have 1 8806 or 1 8807 in system.
>> Although I defined mixed_88pm860x common structure, I didn't use it
>> directly. I used pm860x_reg_read() to make use of this structure. In
>> all I2C operations, there's a descriptor indicator. This indicator is
>> used call 8807 operation in 8806 client. Since USB charger is the
>> device of 8806, it also need to access 8807 register. Otherwise, I
>> have to assert two i2c clients in 8806 device driver.
> Ok, I dont have the HW specs for those 2 devices, but it seems to me that
> wanting to link those 2 is a platform design, not a driver one. In other
[Haojian]: The original purpose of designing 8806 and 8807 is for
phone. 8807 carries buck converter, LDOs, charging unit, RTC, audio
codec, touch, vibrator and GPIOs. 8806 carries boost converter (supply
WLED), RGB LED, charger, VBUS switcher and external vibrator. 8807
processes low level voltage and 8806 processes high level voltage.
They're different chips, but they work together.

> words, I dont see why it wouldnt be possible to have a platform with e.g only
> one 8806 or only one 8807. Is that correct ? If that's so, then you need to
[Haojian]: If customer likes, they can only enable 8807 or 8806. And
my driver supports this functionality. If we just want to enable 8807,
we shouldn't enable backlight, LED, charger, and so on. If we just
want to enable 8806, we shouldn't enable touch, RTC, LDO, audio codec,
and so on. Driver will check the platform data. If platform data isn't
specified, related driver won't be mounted. That mixed structure is
just a glue logic for linking these two drivers. If we want to have
the functionality of USB charger, we have to make use of both 8807 and
8806. Because 8807 and 8806 has different I2C address. I have to let
usb charger as the sub-device of 8806, and it needs to access 8807
registers since some charger control logic is placed in 8807. That's
the main reason of using mixed structure for glue logic.
> re-design this driver and forget about your static mixed structure.
> If your platform is designed so that you need to access one of the potentially
> available 8807 from one of the potentially available 8806, then you need to
> define an API to which you'd pass some platform data that would basically tell
> which of the 8807 you want to access.
>
> On the other hand if it is impossible from a HW point of view to have a
> platform design where you'd have either a single 8806 or a single 8807, then 2
> things:
> - Your driver design would be ok.
[Haojian]: Great Thanks :)
> - Those chip designs are really bad as it should be one and only one single
> (and in particular only use one single i2c address space and id)
[Haojian]: I agree this opinion that the same functionality logic
should be placed into one chip and using single i2c address. If same
functionality logic can be in one chip, the driver could be simpler
without glue logic.
>
> Cheers,
> Samuel.
>
>
Hi Samuel,

I tried to add some comments of the chip's background. Up to now, I
can't find a better idea to handle this driver without mixed structure
since usb charger linkes them tightly. If there's a better prototype
to handle this, I'll adopt it.

Thanks
Haojian
