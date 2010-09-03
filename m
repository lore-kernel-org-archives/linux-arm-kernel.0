From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 3 Sep 2010 21:33:09 +0800
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option for
	exceptions
In-Reply-To: <20100903074806.GX14214@pengutronix.de>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
	<20100902212145.GA15264@n2100.arm.linux.org.uk>
	<20100902212723.GC26319@n2100.arm.linux.org.uk>
	<20100903074806.GX14214@pengutronix.de>
Message-ID: <AANLkTimjpf8bU1uhdfBOAP3MgJeChgFd7GeroMRyUxoF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/3 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Thu, Sep 02, 2010 at 10:27:23PM +0100, Russell King - ARM Linux wrote:
>> On Thu, Sep 02, 2010 at 10:21:45PM +0100, Russell King - ARM Linux wrote:
>> > On Thu, Jun 03, 2010 at 03:36:52PM +0800, Eric Miao wrote:
>> > > From: Eric Miao <eric.y.miao@gmail.com>
>> > >
>> > > Original idea and prototype came from Nicolas Pitre.
>> > >
>> > > As long as the zImage is placed within the 256MB range from the
>> > > start of the memory, ZRELADDR (Address where the decompressed
>> > > kernel will be placed, usually ?== PHYS_OFFSET + TEXT_OFFSET)
>> > > can be determined at run-time by masking PC with 0xf000_0000.
>> > >
>> > > Running through all the Makefile.boot, all those zreladdr-y
>> > > address == 0x[0-f]000_0000 + TEXT_OFFSET can be determined at
>> > > run-time.
>> > >
>> > > Option CONFIG_AUTO_ZRELADDR and CONFIG_ZRELADDR are introduced,
>> > > CONFIG_ZRELADDR _must_ be explicitly specified if:
>> > >
>> > > ?- ((zreladdr-y - TEXT_OFFSET) & ~0xf0000000) != 0, which means
>> > > ? ?a maksing of PC with 0xf000_0000 will result an incorrect
>> > > ? ?address.
>> > >
>> > > ?- or the assumption of the zImage being loaded by the boot
>> > > ? ?loader within 256MB from the start address is simply
>> > > ? ?incorrect
>> > >
>> > > ?- or when ZBOOT_ROM is used, where the above assumption is
>> > > ? ?normally wrong
>> > >
>> > > List of all Makefile.boot:
>> >
>> > Not so. ?What happened to H720x platforms, which are now broken?
>> > Any chance of fixing the regression that this introduced?
>> >
>> > http://armlinux.simtec.co.uk/kautobuild/2.6.36-rc3/h7202_defconfig/zimage.log
>>
>> And while we're here, why hasn't anyone removed the zreladdr
>> definitions in Makefile.boot yet? ?Or do we still need them and
>> we now have the same information defined in two different places?
>>
>> This all looks like a half-done job at the moment. ?Please clean it up.
> The original series removed all the 'Makefile.boot's IIRC. ?Currently
> the params_phys-y value is needed though. ?So should I send a patch that
> just removes the zreladdr values?
>

That sounds like a plan. And for those platforms which requires only
zreladdr-y, the whole Makefile.boot can just be removed. e.g.
mach-pxa and mach-mmp.

> Eric, what are your plans regarding the runtime-physoffset stuff? ?(I
> currently have none.)
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
