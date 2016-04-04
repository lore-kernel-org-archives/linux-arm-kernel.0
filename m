From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Apr 2016 15:53:47 +0200
Subject: [PATCH v2 02/16] arm64: dts: add sp804 timer node for Hi6220
In-Reply-To: <20160404134237.GC402@leoy-linaro>
References: <1459589383-16914-1-git-send-email-guodong.xu@linaro.org>
 <1459589383-16914-3-git-send-email-guodong.xu@linaro.org>
 <CACRpkdbWuKx6=aF5xW=3EKfuUf-MYM_EEnovyhBnOGVOeHyCmQ@mail.gmail.com>
 <20160404014359.GA15178@leoy-linaro>
 <CACRpkdZ=_86Rhc+ei+3uE0dda9+onC8pQwosheMfEj4tOqmcDA@mail.gmail.com>
 <20160404134237.GC402@leoy-linaro>
Message-ID: <CACRpkdb_aMpj3X-m-FdM-PCCSuXgHnect5+nWPFnGVzGx4zrbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 4, 2016 at 3:42 PM, Leo Yan <leo.yan@linaro.org> wrote:
> On Mon, Apr 04, 2016 at 01:21:00PM +0200, Linus Walleij wrote:

>> This is not about enabling/disabling the clock(s) to the timer.
>> It doesn't matter if these clocks are always on.
>>
>> It is about determining the *frequency* of the timers.
>>
>> It is vital that the timer driver get the right frequency of the clock
>> to the block from the clock implementation, and I do not think
>> it is the same as the "apb_pclk".
>
> Thanks for reminding. Fortunately, apb_pclk and timer's clock are
> same, all of them's rate are 19.2MHz.

OK I was wrong, worrying about nothing.

>> The thing is that of course "any frequency" will
>> work but what you will notice is that the timer runs very
>> weirdly compared to wall-clock time unless the right clock
>> yielding the right frequency has been specified here.
>
> Compared sp804 timer counter with wall-clock (which is using ARM's
> arch timer), and confirmed that sp804 timer's counter register is
> decreasing with rate 19.2MHz.

Thanks, awesome.

> Also have checked Hi6220's spec, there have no timer's dediated clock
> enabling bits. This is the reason before I only registered one clock.
> So according to you and Rob's comments, how about change as below?
>
>                 dual_timer0: timer at f8008000 {
>                         compatible = "arm,sp804", "arm,primecell";
>                         reg = <0x0 0xf8008000 0x0 0x1000>;
>                         interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&ao_ctrl HI6220_TIMER0_PCLK>,
>                                  <&ao_ctrl HI6220_TIMER0_PCLK>,
>                                  <&ao_ctrl HI6220_TIMER0_PCLK>;
>                         clock-names = "apb_pclk", "apb_pclk", "apb_pclk";

This works for me, though I think only the last name
matters so I would name the first two "timer1" and "timer2".

Yours,
Linus Walleij
