From: olof@lixom.net (Olof Johansson)
Date: Sun, 2 Oct 2016 17:25:07 -0700
Subject: [GIT PULL 1/3] ARM: soc: exynos: Drivers for v4.9
In-Reply-To: <20160919155302.GA4447@kozik-book>
References: <1474216788-17282-1-git-send-email-krzk@kernel.org>
 <1474216788-17282-2-git-send-email-krzk@kernel.org>
 <2663426.T8oUku18qe@wuerfel> <20160919155302.GA4447@kozik-book>
Message-ID: <CAOesGMgSu=bfVwWYkEG0+eDKBxh_zqSM0uxFAq3Y3X-O0vLGKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 8:53 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Sep 19, 2016 at 05:02:40PM +0200, Arnd Bergmann wrote:
>> On Sunday, September 18, 2016 6:39:46 PM CEST Krzysztof Kozlowski wrote:
>> > Samsung drivers/soc update for v4.9:
>> > 1. Allow compile testing of exynos-mct clocksource driver on ARM64.
>> > 2. Document Exynos5433 PMU compatible (already used by clkout driver and more
>> >    will be coming soon).
>>
>> Pulled into next/drivers, thanks
>>
>> Just for my understanding: why do we need the exynos-mct driver on ARM64
>> but not the delay-timer portion of it?
>
> I think we want all of it but Doug's optimization 3252a646aa2c
> ("clocksource: exynos_mct: Only use 32-bits where possible") is not
> ARM64 friendly. One way of dealing with it would be to prepare two
> versions of exynos4_read_current_timer(). One reading only lower 32-bit
> value for ARMv7 and second (slow) reading lower and upper for ARMv8.
>
>>
>> Is there an advantage in using MCT over the architected timer on these
>> chips? If so, should we also have a way to use it as the delay timer?
>
> No, there is no real advantage... except that the SoC has some
> interesting "characteristics"... The timers are tightly coupled. Very
> tightly. I spent a lot of time and failed to boot my ARMv8 board without
> some MCT magic.

What kind of magic is that? I can understand that needing the MCT for
some system-level timer functionality might be true (wakeups, etc),
but for system timesource avoiding the MMIO timer and using the arch
ones is a substantial performance improvement for gettimeofday() and
friends.

There was extensive discussion last year over using arch timers on
5420/5422, and it fizzled out with vague comments about something not
working right between A15/A7 on b.L. hardware. I'm presuming whatever
implementation details of that SoC has since been fixed on later chips
(including v8). Any chance you can confirm? It'd be very nice to leave
MCT behind on v8 as a system time source.


-Olof
