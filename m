From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 23:42:08 +0800
Subject: [PATCH v3 03/11] clocksource: sp804: add device tree support
In-Reply-To: <1363188595.3100.101.camel@hornet>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-4-git-send-email-haojian.zhuang@linaro.org>
 <1363172730.3100.17.camel@hornet> <51408A71.9090501@gmail.com>
 <1363185757.3100.66.camel@hornet> <51409276.8050601@gmail.com>
 <1363186548.3100.75.camel@hornet>
 <CAD6h2NTP+X6RVr23Y-XLrQMqHptH974oYooTX=Y6F_Q4hyrmNA@mail.gmail.com>
 <1363188238.3100.95.camel@hornet>
 <CAD6h2NR+SC4cN5cBzHUNBfDQ1=x8Rbn3C4AizNyy562iMjyU6A@mail.gmail.com>
 <1363188595.3100.101.camel@hornet>
Message-ID: <CAD6h2NQa-RhR555o_1_RYPuPb4366H_AwK1U9S3pRVPdo_xNNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2013 23:29, Pawel Moll <pawel.moll@arm.com> wrote:
> On Wed, 2013-03-13 at 15:25 +0000, Haojian Zhuang wrote:
>> On 13 March 2013 23:23, Pawel Moll <pawel.moll@arm.com> wrote:
>> > On Wed, 2013-03-13 at 14:17 +0000, Rob Herring wrote:
>> >> How about:
>> >>
>> >> 1 irq - TIMINT1
>> >> 2 irqs w/ same source # - TIMINTC
>> >> 2 irqs w/ different source # - TIMINT1 and TIMINT2
>> >
>> > On Wed, 2013-03-13 at 15:11 +0000, Haojian Zhuang wrote:
>> >> What's the scenario that we must use TIMINTC? TIMINT1 & TIMINT2 are
>> >> already enough on these two TIMERs. If we really needn't TIMINTC, we
>> >> need to support it. Since it's over-designed.
>> >>
>> >> If TIMINT1 & TIMINT2 aren't routed, and only TIMINTC is routed. It's another
>> >> case. We can consider it as replacement of TIMINT1.
>> >
>> > Just a thought... How to describe a SP804 with only TIMINT2 wired up?
>> >
>> > Pawe?
>> >
>> >
>> There's no difference on TIMINTC is only used to replace TIMINT1 or TIMINT2.
>> We only need to tell sp804 driver which timer is using irq, and the irq number.
>
> If I understand you well:
>
> * Both TIMINT1 and TIMINT2 wired up - TIMINTC doesn't matter
>
>         interrupts = <1>, <2>;
>
> * TIMINT1 wired up, TIMINT2 not wired up
>
>         interrupts = <1>;
>
> * Only TIMINTC wired up - treat it as TIMINT1
>
>         interrupts = <1>;
>
> So far so good. My question is, how do you describe the following:
>
> * _Only_ TIMINT2 wired up, TIMINT1 and TIMINTC _not_ wired up
>
>         interrupts = ???
>
> Pawe?
>
>
>
In my current implementation, I need two things to judge whether
irq is really necessary.

If the timer contains "arm,sp804-clockevent = <evtoffs>" property,
I'll check whether the timer irq is specified at the same time.

TIMINT1 & TIMINTC are not routed. TIMINT2 is used for clock event.

     interrupts = <any number> <1>;

        if (!retevt) {
                if (evtoffs) {
                        /* TIMER2 is clock event */
                        i = 1;
                        evtoffs = TIMER_2_BASE;
                } else {
                        /* TIMER1 is clock event */
                        i = 0;
                        evtoffs = TIMER_1_BASE;
                }
                irq = irq_of_parse_and_map(np, i);
                ...
        }

If the timer contains "arm,sp804-clocksource = <srcoffs>" property,
I won't check the timer irq. You even needn't define it.

TIMINT1 & TIMINTC are not routed. TIMER2 is used for clock source.
      interrupts = <any number> <any number>;
or
      don't define interrupts

        if (!retsrc) {
                if (srcoffs) {
                        /* TIMER2 is clock source */
                        i = 1;
                        srcoffs = TIMER_2_BASE;
                } else {
                        /* TIMER1 is clock source */
                        i = 0;
                        srcoffs = TIMER_1_BASE;
                }
                ...
        }
