From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 31 May 2013 16:57:08 +0900
Subject: [PATCH 04/12] ARM: shmobile: r8a7740: Add DT name to clock list
 for CMT10
In-Reply-To: <20130528062246.GB20031@quad.lixom.net>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
 <1369645193-3595-5-git-send-email-horms+renesas@verge.net.au>
 <20130528032948.GF13532@quad.lixom.net>
 <20130528052944.GC25005@verge.net.au>
 <20130528062246.GB20031@quad.lixom.net>
Message-ID: <CANqRtoRwBHY1+Tgekg1CocZa4zWCAUWuZnW=5MXTA9SPcWYD0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, May 28, 2013 at 3:22 PM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, May 28, 2013 at 02:29:44PM +0900, Simon Horman wrote:
>> On Mon, May 27, 2013 at 08:29:48PM -0700, Olof Johansson wrote:
>> > Hi,
>> >
>> > On Mon, May 27, 2013 at 05:59:45PM +0900, Simon Horman wrote:
>> > > From: Bastian Hecht <hechtb@gmail.com>
>> > >
>> > > This adds temporarily the alternative device name to the clock list
>> > > that is used when booting via Device Tree setup.
>> >
>> > >
>> > > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> > > ---
>> > >  arch/arm/mach-shmobile/clock-r8a7740.c |    1 +
>> > >  1 file changed, 1 insertion(+)
>> > >
>> > > diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
>> > > index 5bd8da0..8fc396a 100644
>> > > --- a/arch/arm/mach-shmobile/clock-r8a7740.c
>> > > +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
>> > > @@ -582,6 +582,7 @@ static struct clk_lookup lookups[] = {
>> > >   CLKDEV_DEV_ID("e6cc0000.sci",           &mstp_clks[MSTP230]),
>> > >
>> > >   CLKDEV_DEV_ID("sh_cmt.10",              &mstp_clks[MSTP329]),
>> > > + CLKDEV_DEV_ID("e6138010.timer",         &mstp_clks[MSTP329]),
>> > >   CLKDEV_DEV_ID("sh_fsi2",                &mstp_clks[MSTP328]),
>> > >   CLKDEV_DEV_ID("i2c-sh_mobile.1",        &mstp_clks[MSTP323]),
>> > >   CLKDEV_DEV_ID("renesas_usbhs",          &mstp_clks[MSTP320]),
>> > > --
>> > > 1.7.10.4
>> > >
>> >
>> > Usually this is instead handled by adding entries to OF_DEV_AUXDATA() to
>> > rename the device in the board file. Would you mind doing that instead?
>>
>> Magnus has indicated in the past that he prefers this method over
>> using OF_DEV_AUXDATA() and the above is consistent with other
>> shmobile code.
>
> Ho hum. That's 180 degrees opposite to how we've been doing it on all
> other ARM platforms. :)

Correct! =) But that is not the only thing! The mach-shmobile
implementation style for DT is also different. I guess you've seen
other mach-shmobile-specific oddities like the DT -reference boards in
parallel with the C version, right?

With mach-shmobile we have deliberately chosen to avoid AUXDATA. The
reason for that is that we keep the DT version of a device clean from
the beginning so it is kept totally free of platform data while in
parallel we also have a regular platform device with platform data for
the old legacy C version of board support. Other ARM subarchitectures
seem to use DT together with platform data which is a step that we
prefer to skip by using a C version and a DT version of board support
in parallel. The idea is that we should be able to existing level of
support in the C version while incrementally doing development on the
DT -reference code. Then drop the C version when the DT version has
become good enough. Current blockers are GPIO/PFC DT and common clock
framework.

Regarding AUXDATA, I don't really mind using it that much, except that
I prefer to not use DT together with platform data. So that's what
we've been doing. As for device name conversion with AUXDATA, yes, we
could use that, but it turns out that if you're not using platform
data then it becomes more verbose line wise compared to just popping
in an additional line in the clock lookup like the patch above does.
It is already abstracted per-SoC but with AUXDATA i suspect we will
have to mix board specific bits with new SoC specific tables.

You can probably find other instances of similar mixed DT names with
regular platform device names in various clock lookup tables in
mach-shmobile. Of course we will convert them over if that makes your
life easier. Personally, due to limited time I'd rather work on other
non-cosmetic stuff like getting rid off CONFIG_MEMORY_START and others
and also fixing up 64-bit memory that seems broken in the generic ARM
kernel.

> Once you guys have clock bindings for device tree, the aliases should be
> possible to remove. That's where having them as auxdata is useful, since it's
> just one place and it's also obvious just what clocks and what drivers need
> aliases on device tree.

I agree that common clocks and DT bindings will make it possible for
us to remove these special cases, but from my point of view it is even
easier to kill off DT special case names like we already have in
clock-r8axxx.c when moving to common clocks (and getting rid of that
file) instead of introducing AUXDATA just to remove it soon again.

> Where are you guys at on your plans for getting DT_based clock going? That will
> sort of indicate just how temporary these clock alaises will be. I'm guessing
> we'll be living with them for a while though?

I have to deal with LPAE soon according to my todo list. After that I
will make sure common clock conversion starts moving. There are many
SoCs to convert, so it will have to happen gradually. I doubt we will
get any code ready for merge in v3.11, getting some bits into v3.12 is
probably possible.

Apart from moving to common clocks and after that adding support for a
single multi-subarch kernel binary, is there anything you want us to
implement? Anything for v3.11? I'd like to get the memory bits sorted
out if possible.

Thanks for your help.

Cheers,

/ magnus
