From: robherring2@gmail.com (Rob Herring)
Date: Thu, 15 May 2014 08:00:16 -0500
Subject: [PATCH v3 4/6] arm: add basic support for Mediatek MT6589 boards
In-Reply-To: <4623149.HtC2qgQ8vE@wuerfel>
References: <1399938570-11356-1-git-send-email-matthias.bgg@gmail.com>
 <20140514070038.GG29258@lukather>
 <20140514212612.GK20486@codeaurora.org>
 <4623149.HtC2qgQ8vE@wuerfel>
Message-ID: <CAL_JsqJU9syDFFjjNL9H5o4jBReuidNFbDxYW4HX6HrG7yfNFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 2:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 14 May 2014 14:26:12 Stephen Boyd wrote:
>> On 05/14, Maxime Ripard wrote:
>> > On Tue, May 13, 2014 at 03:47:32PM -0700, Stephen Boyd wrote:
>> > > On 05/13, Matthias Brugger wrote:
>> > > > +       "mediatek,mt6589",
>> > > > +       NULL,
>> > > > +};
>> > > > +
>> > > > +DT_MACHINE_START(MEDIATEK_DT, "Mediatek Cortex-A7 (Device Tree)")
>> > > > +       .dt_compat      = mediatek_board_dt_compat,
>> > > > +MACHINE_END
>> > >
>> > > You shouldn't need this file at all if the platform is part of
>> > > the multi-platform kernel.
>> >
>> > From a technical point of view, you don't. But it's interesting to
>> > keep it mostly for two things:
>> >   - You get to see the platform name in /proc/cpuinfo
>> >   - If you ever need to add platform quirks, it's already there
>> >
>> > We had a similar discussion two weeks ago for mach-sunxi with Olof and
>> > Arnd, and ended up keeping this minimal machine.
>> >
>>
>> It looks like it's only useful to make /proc/cpuinfo have the
>> platform name because it really isn't that hard to add this file
>> if we need to add platform quirks. The downside is we have to
>> keep adding compatibles when we support new SoCs.
>
> We also still add Kconfig entries for each new platform, and I'd like
> to leave it at that for the time being. In a lot of cases we end
> up adding stuff to the machine descriptor later, e.g. for SMP support
> (hopefully no more thanks to your work though).
>
> Once we have a significant number of machines that are actually
> usable rather than stubs and that we are confident about never
> needing any additional pointers, we can revisit this discussion.
>
> At that point, we should also discuss how to avoid adding a Kconfig
> entry for each new platform, which e.g. involves making the
> clocksource drivers user selectable. That part has been surprisingly
> controversial in the past.

The kconfig part doesn't really worry me. The cpuinfo string is
something we should decide now because it leaks to userspace. There
are 3 possible positions I can think of:

1) The name is part of the ABI and we can never remove/change the string.

2) The name is not an ABI and either:
a) we don't care if it changes with matching a machine desc or not.
b) we still want it to be consistent independent of matching

2a is what we have today. I'm in favor of 2b and therefore should get
the name from DT. It is similar to names in /sys/bus/platform/ which
are not considered part of the ABI. The string already changed moving
platforms to DT and that did not seem to cause any issues that I heard
of.

Rob
