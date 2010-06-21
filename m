From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 21 Jun 2010 18:43:50 +0800
Subject: [PATCH v5 1/3] ARM: SAMSUNG: Add keypad device support
In-Reply-To: <003701cb1124$3e335f00$ba9a1d00$%szyprowski@samsung.com>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
	<AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
	<003701cb1124$3e335f00$ba9a1d00$%szyprowski@samsung.com>
Message-ID: <AANLkTiny_KNR0mZy9D52gZrGqJuYDPkK-P_zCFTfrAcm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 5:29 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> On Monday, June 21, 2010 11:06 AM Eric Miao wrote:
>
>> On Mon, Jun 21, 2010 at 2:26 PM, Joonyoung Shim <jy0922.shim@samsung.com>
>> wrote:
>> > This patch adds samsung keypad device definition for samsung cpus.
>> >
>> > Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> > ---
>> > ?arch/arm/plat-samsung/Kconfig ? ? ? ? ? ? ? ? ? ?| ? ?5 ++
>> > ?arch/arm/plat-samsung/Makefile ? ? ? ? ? ? ? ? ? | ? ?1 +
>> > ?arch/arm/plat-samsung/dev-keypad.c ? ? ? ? ? ? ? | ? 58
>> +++++++++++++++++++++
>>
>> Why need an individual file for a simple device? ?In the end, these files
>> will flood over the plat-samsung/ directory. And now think this - in your
>> new SoC design ,the keypad IP is replaced with a completely new one, does
>> that mean a new dev-keypad-new1.c, dev-keypad-new2.c?
>>
>> I personally prefer a single devices.c for all the devices, if you
>> orgnize well, shouldn't take up much code size in that single file.
>
> A separate dev-abc.c files has been chosen by a platform maintainer. This
> has some advantages as some unused data can be easily not compiled into
> the kernel which is configured specially for a particular board.

This also can be done by something like below:

#if defined(CONFIG_S5P_KEYPAD) || defined(CONFIG_S5P_KEYPAD_MODULE)
struct platform_device s5p_device_keypad {
        ........
};
#endif

And if you want run-time discardable platform_device, you have to mark
this structure as __initdata, and duplicate that device when registering.

That's why in arch/arm/mach-mmp/, a light weight and descriptive
'struct pxa_device_desc' is introduced, so only those platform_devices
registered will be generated and registered.
