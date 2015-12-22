From: alchark@gmail.com (Alexey Charkov)
Date: Tue, 22 Dec 2015 12:09:58 +0300
Subject: [PATCH 0/4] clocksource/vt8500: Fix hangs in small delays
In-Reply-To: <20151221233359.268fe6da@anonymous>
References: <1450650492-18996-1-git-send-email-v1ron@mail.ru>
 <20151221112916.40373d2f@anonymous>
 <20151221233359.268fe6da@anonymous>
Message-ID: <CABjd4Ywg83CuMMdLE=ZcHa295CkxVB6p2=siA-_u3TgYpxjo_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-12-21 23:33 GMT+03:00 Roman Volkov <v1ron@mail.ru>:
>> Roman Volkov <v1ron <at> mail.ru> writes:
>>
>> >
>> > From: Roman Volkov <rvolkov <at> v1ros.org>
>> >
>> > vt8500 timer requires special synchronization for accessing some of
>> > its registers. Define special read and write functions to handle
>> > this process transparently.
>>
>> Maybe introduce such accessor functions (conditionally) into the PXA
>> driver and kill this one altogether then?
>
> I don't think maintainers will accept a lot of #ifdefs. I have an idea
> to move the common code from the PXA to something like pxa_common.c
> (can we give the correct name for it?) and include it from the
> vt8500_timer.c and pxa_timer.c.

Can't this be done via different OF compatible strings, setting some
global 'static bool needs_bus_sync = true' or such for vt8500, and
then checking it in the accessor functions? Then no ifdefs needed, and
the driver can actually work for both variants within the same kernel
image.

<skip>

>> > +#define vt8500_timer_sync(bit)     { while (readl_relaxed \
>> > +                               (regbase + TIMER_AS_VAL) &
>> > bit) \
>> > +                                   cpu_relax(); }
>>
>> The whole issue around 'loops' counter in these busy waits basically
>> boils down to whether we would like a way to try and recover from a
>> potential hardware misbehavior.
>>
>> You can of course argue that when the system timer misbehaves you
>> already have bigger issues to worry about, but does a 10 msec limit
>> that was in the original version really hurt?
>
> If we do the merging work with PXA, this code will go away. Have this
> variable already fixed some _real_ problem? Otherwise this is excessive
> coding.

Never had any issues without the guarding loop counter. I got that
suggestion as part of feedback to my original submission of the timer
code, and thought it doesn't hurt. Can't say I'm particularly attached
to it, though, so fine for me if you drop it :)

>> >  #define MIN_OSCR_DELTA             16
>> >
>> >  static void __iomem *regbase;
>> >
>> > -static cycle_t vt8500_timer_read(struct clocksource *cs)
>> > +static void vt8500_timer_write(unsigned long reg, u32 value)
>>
>> Maybe define this with 'value' first, 'reg' second - to be in line
>> with the common prototype of writel and such?
>
> Oh my right-handed habits :)
>
>> Plus if you could take the same name for the macro above
>> (timer_writel) and this accessor (vt8500_timer_write) that would
>> somewhat reduce extra additions/deletions in this patch. Same for the
>> read function.
>
> When we perform our merging work, we have to use the following glue:
> ...
> vt8500_timer_read { ... }
> #define timer_read(reg) vt8500_timer_read(reg)
> ...
> #include pxa_common.c

...or make it a runtime switch without ifdefs or includes. Anyway,
this only matters for making the patch series more readable - just
reducing the number of insertions/additions that don't have much
semantic meaning.

Best regards,
Alexey
