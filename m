From: will.newton@gmail.com (Will Newton)
Date: Sun, 12 Dec 2010 15:17:20 +0000
Subject: [PATCH] dw_mmc: Add Synopsys DesignWare mmc host driver.
In-Reply-To: <20101212144750.GH8665@n2100.arm.linux.org.uk>
References: <20101209064751.GA21128@void.printf.net>
	<AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com>
	<20101209160157.GA28586@void.printf.net>
	<AANLkTim3Rj2tTbqvT8nM4L=p=Wx8bdOnGq=EDv+cs02g@mail.gmail.com>
	<20101211192320.GA24430@void.printf.net>
	<AANLkTin5aVPz5Y=jS89V00XS=rje3gqeUb2VTYt2A_9=@mail.gmail.com>
	<20101212135224.GA31812@void.printf.net>
	<AANLkTinMYeWNLu8e7xyBTvjmeFMsJ5sDGtsCesu04d4K@mail.gmail.com>
	<20101212141112.GF8665@n2100.arm.linux.org.uk>
	<AANLkTin++a_juBQDssFDd881R449so7Um2AvHFLXqiT_@mail.gmail.com>
	<20101212144750.GH8665@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinr_D8GvUON5PqHSiZCAS8tQy-0YChnYD4N+zY2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 12, 2010 at 2:47 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Dec 12, 2010 at 02:31:40PM +0000, Will Newton wrote:
>> On Sun, Dec 12, 2010 at 2:11 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > Maybe invent CONFIG_HAVE_MMIO_64BIT which architectures can select as
>> > appropriate?
>>
>> Wouldn't it be simpler to have a fallback readq/writeq implementation
>> like the below?
>>
>> static inline u64 __raw_readq(const volatile void __iomem *addr)
>> {
>> ? ? ? ? return *(const volatile u64 __force *) addr;
>> }
>>
>> It won't break any existing hardware (if your SoC bus does not support
>> 64bit accesses you are unlikely to have peripherals that require it)
>> and would avoid a number of #ifdefs and/or Kconfig dependencies.
>
> Firstly, why, then, are we discussing fixing dw_mmc.c so it builds on ARM?

It's a configurable IP block, so one would assume that if it was
configured with a 64bit FIFO width on ARM then your SoC integration
engineers dropped the ball.

Even on architectures that can do 64bit MMIO, I would expect there to
be systems where that is not safe in practice (e.g. 32bit bus fabric
that will translate a 64bit access into 2 32bit accesses) so I don't
know if it's ideal to make this an architecture level config symbol.
