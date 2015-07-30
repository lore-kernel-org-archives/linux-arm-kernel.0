From: mturquette@linaro.org (Michael Turquette)
Date: Wed, 29 Jul 2015 17:27:26 -0700
Subject: [PATCH v7 0/5] clk: Provide support for always-on clocks
In-Reply-To: <1437570255-21049-1-git-send-email-lee.jones@linaro.org>
References: <1437570255-21049-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20150730002726.642.33056@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2015-07-22 06:04:10)
> Lots of platforms contain clocks which if turned off would prove fatal.
> The only way to recover from these catastrophic failures is to restart
> the board(s).  Now, when a clock provider is registered with the
> framework it is possible for a list of critical clocks to be supplied
> which must be kept ungated.  Each clock mentioned in the newly
> introduced 'critical-clock' property will be clk_prepare_enable()d
> where the normal references will be taken.  This will prevent the
> common clk framework from attempting to gate them during the normal
> clk_disable_unused() and disable_clock() procedures.
> 
> Note that it will still be possible for knowledgeable drivers to turn
> these clocks off using clk_{enable,disable}_critical() calls.

Hi Lee,

Thanks for submitting the series.

It has been a little while since v6. It would be helpful to remind me of
why a new api is necessary, versus using the existing clk_prepare_unused
call at the time that a clock is enabled.

I'm looking over the patches in detail now, but one question stands out:
besides the DT use case, would a Linux device driver ever call
clk_enable_critical instead of using clk_enable? If so, why?

Thanks,
Mike

> 
> Changelog:
> v6 => v7:
>   - Introduce API to enable and disable critical clocks
>   - Rename 'always-on-clock' to 'critical-clock'
> 
> v5 => v6:
>   - Use of_clk_get_from_provider() instead of of_clk_get_by_clkspec()
>   - Explicitly describe expected DT values
>   - Be pedantic with regards to printk() format specifiers
> 
> vX => v5:
>   Implementations have changed drastically between versions, thus I
>   would like for this set to be thought of independently from its
>   predecessors.  The only reason for identifying as 'v5' is ease of
>   differentiation on the list, which stems from the confusion caused
>   by submitting 'v4' as a separate entity.
> 
> Lee Jones (5):
>   ARM: sti: stih407-family: Supply defines for CLOCKGEN A0
>   ARM: sti: stih410-clocks: Identify critical clocks
>   clk: Supply the critical clock {init, enable, disable} framework
>   clk: Provide critical clock support
>   clk: dt: Introduce binding for critical clock support
> 
>  .../devicetree/bindings/clock/clock-bindings.txt   | 39 +++++++++++++++++++
>  arch/arm/boot/dts/stih410-clock.dtsi               | 10 +++++
>  drivers/clk/clk-conf.c                             | 45 +++++++++++++++++++++-
>  drivers/clk/clk.c                                  | 45 ++++++++++++++++++++++
>  include/dt-bindings/clock/stih407-clks.h           |  4 ++
>  include/linux/clk-provider.h                       |  2 +
>  include/linux/clk.h                                | 30 +++++++++++++++
>  7 files changed, 174 insertions(+), 1 deletion(-)
> 
> -- 
> 1.9.1
> 
