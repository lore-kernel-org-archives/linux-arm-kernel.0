From: olof@lixom.net (Olof Johansson)
Date: Thu, 28 Aug 2014 09:28:22 -0700
Subject: [PATCH 11/14] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <20140828094846.GD14650@leverpostej>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-3-git-send-email-ch.naveen@samsung.com>
 <20140828035639.GB4972@localhost>
 <20140828094846.GD14650@leverpostej>
Message-ID: <CAOesGMjY8wfAcq2fLgs=ZWHdiWtFqxr+ncUKTje0SnXqO-CCgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 2:48 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
>> > +   cpus {
>> > +           #address-cells = <2>;
>> > +           #size-cells = <0>;
>>
>> Why size-cells=2? Can you not fit a cpuid in 32 bits?
>
> As of commit 72aea393a2e7 (arm64: smp: honour #address-size when parsing
> CPU reg property) Linux can handle single-cell cpu node reg entries
> where /cpus/#address-cells = <1>.
>
> I can't make any guarantees about other code (e.g. bootloaders) which
> might try to do things with cpu nodes, YMMV.

Ok. If address-cells is kept at 2 the unit address needs to be changed
to "0,0". So one or the other has to be changed.

> [...]
>
>> > +   hsi2c_2: hsi2c at 14E60000 {
>>
>> I much prefer lowercase hex in unit addresses (and reg entries) below. I
>> know 32-bit uses uppercase, but let's switch going forward here.
>
> My preference also; I'm happy to enforce that on new dts.
>
> [...]
>
>> > +   timer {
>> > +           compatible = "arm,armv8-timer";
>> > +           interrupts = <1 13 0xff01>,
>> > +                        <1 14 0xff01>,
>> > +                        <1 11 0xff01>,
>> > +                        <1 10 0xff01>;
>> > +           clock-frequency = <24000000>;
>> > +           use-clocksource-only;
>> > +           use-physical-timer;
>>
>> These two properties are not standard, and I would expect any 64-bit
>> platform to come with PSCI such that you have a way to initialize the
>> virtual timers.
>
> Likewise with clock-frequency. It's not a full workaround, and it's not
> hard to initialise CNTFRQ on each CPU.

Technically clock-frequency is documented, but not recommended to be
used unless needed for working around firmware that doesn't setup the
register value. :)

In this case it's likely a cargo cult carry over from 5250 where the
CNTFRQ requirement happened around the same time as we were working on
it so that generation firmware lacked support for it -- it should
since then have been fixed properly.


-Olof
