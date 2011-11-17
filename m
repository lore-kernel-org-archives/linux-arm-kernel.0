From: eric.miao@linaro.org (Eric Miao)
Date: Thu, 17 Nov 2011 17:03:15 +0800
Subject: [RFC 1/1] ARM: imx6q: move clock register map to
 machine_desc.map_io
In-Reply-To: <20111117090731.GG14656@S2100-06.ap.freescale.net>
References: <1321494612-24795-1-git-send-email-richard.zhao@linaro.org>
 <CAMPhdO8vE4cer-EQZ53VDQrZpQ1JVvus2=RpDCfdJRa7gwLUqg@mail.gmail.com>
 <20111117032012.GF14656@S2100-06.ap.freescale.net>
 <20111117084453.GK9581@n2100.arm.linux.org.uk>
 <20111117090731.GG14656@S2100-06.ap.freescale.net>
Message-ID: <CAMPhdO8u0jjR0po_rrd6w-pimX7ypvXdri933mANTQ3APt=3zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 5:07 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Thu, Nov 17, 2011 at 08:44:53AM +0000, Russell King - ARM Linux wrote:
>> On Thu, Nov 17, 2011 at 11:20:13AM +0800, Shawn Guo wrote:
>> > On Thu, Nov 17, 2011 at 10:56:53AM +0800, Eric Miao wrote:
>> > > On Thu, Nov 17, 2011 at 9:50 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
>> > > > If the map is in machine_desc.timer.init, the registers will not be
>> > > > able to access after bootup (probably after "Freeing init memory").
>> > >
>> > > Given that devicemaps_init() does additional work after creating
>> > > the mapping, flushing TLB and cache, machine_desc->map_io() is
>> > > what I assume the best place for these static IO mappings than
>> > > elsewhere.
>> > >
>> > > Shawn?
>> > >
>> > I'm still trying to understand what happened. ?I do not understand
>> > how the map can become unusable after "Freeing init memory". ?Also
>> > I can not reproduce the problem on my side.
>>
>> It's very simple. ?iotable_init() allocates memory using memblock.
>> memblock marks the memory it allocates in its reserved map. ?At the
>> end of map_io(), the information stored inside memblock is transferred
>> to bootmem and then the normal page allocator. ?Once this is done,
>> memblock must not be changed because there is no way to couple any
>> further memblock allocations into the normal page allocator.
>>
>> Look. ?I've made this point before and I'm getting pissed off with
>> people who think they know better. ?The callbacks in the machine
>> descriptor are NAMED. ?They're NAMED for a reason - they have a PURPOSE
>> and that PURPOSE is well defined because there are DEPENDENCIES there.
>> They tell you what you SHOULD be doing in there. ?Doing something else
>> will result in BAD THINGS happening.
>>
>> If people can't understand this, then the only solution is to make the
>> backing functions for this stuff (like iotable_init() etc) BUG() when
>> they're abused. ?That means adding a lot more checks and slowing down
>> the boot because people seem to be incapable of comprehending that
>> initialisation needs to be done in a well defined order.
>>
> Russell,
>
> Thanks for help understand the issue.
>
> Richard,
>
> Please revise the patch to introduce function like imx6q_clock_map_io()
> to be called in imx6q_map_io().

Or simply imx6q_io_desc[], and doing a iotable_init() for all (and
considering ANATOP not necessarily include clocks registers only)
other possible static IO mappings in the future.
