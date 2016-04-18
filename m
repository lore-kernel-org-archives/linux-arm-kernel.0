From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 17:13:57 +0200
Subject: [Question] reset controlling
In-Reply-To: <CAK7LNARJo-xDkkwZ0qA+DaKmQ0SixxGytNSKWBZMZ_N_6eWWow@mail.gmail.com>
References: <CAK7LNATcVwx1q0Nb2WMSpqW3LcoRkZx3RgpMjmbt2EmffJnFvg@mail.gmail.com>
 <5910310.IeFB0QAt6Q@wuerfel>
 <CAK7LNARJo-xDkkwZ0qA+DaKmQ0SixxGytNSKWBZMZ_N_6eWWow@mail.gmail.com>
Message-ID: <4342692.6LEQF6clJv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 17 April 2016 17:16:58 Masahiro Yamada wrote:
> 2016-04-17 4:23 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> >> Reset signals are sometimes cascaded.
> >> For example, the UART blocks on my SoCs have a reset for the whole of
> >> UART blocks
> >> besides per-channel reset signals.
> >>
> >>                      |---(UART ch0 reset)---> UART0
> >>                      |
> >> ----(UART reset)-----|---(UART ch1 reset)---> UART1
> >>                      |
> >>                      |---(UART ch2 reset)---> UART2
> >>
> >> I found this works well with clk-gate drivers.
> >> Even reset_control_reset() can be implemented
> >> with clk_disable() followed by clk_enable().
> >>
> >
> > Interesting. My feeling from your description is that this is something
> > that should be added to the reset controller subsystem. It has probably
> > not been a serious issue for anyone else, but it's also likely that you
> > are not the only one that would benefit from having support for nested
> > resets in the API.
> 
> I want reset sub-system to support (1) nesting,  (2) enable_count.
> 
> To get these two features supported, the reset frame-work
> would be similar implementation to the clock subsystem.
> (In other words, we would duplicate effort
> between clock and reset.)
> 
> Moreover, it is very common to control resets and clocks
> from one hardware block.
> 
> So, I am looking for some idea that perhaps can unify the clock
> and reset subsystems.

If you find parts of the code that could be shared, we can probably
split those out into a file in lib/*.c and have that used by both
subsystems and potentially others as well.

> I found some SoCs implement reset drivers in drivers/clk.
> 
> 
> masahiro at grover:~/workspace/linux/drivers/clk$ git grep
> reset_controller_register
> mediatek/reset.c:       ret = reset_controller_register(&data->rcdev);
> mmp/reset.c:    reset_controller_register(&unit->rcdev);
> qcom/common.c:  ret = reset_controller_register(&reset->rcdev);
> rockchip/softrst.c:     ret = reset_controller_register(&softrst->rcdev);
> sirf/clk-atlas7.c:      reset_controller_register(&atlas7_rst_ctlr);
> sunxi/clk-a10-ve.c:     err = reset_controller_register(&reset_data->rcdev);
> sunxi/clk-sun9i-mmc.c:  ret = reset_controller_register(&data->rcdev);
> sunxi/clk-usb.c:        reset_controller_register(&reset_data->rcdev);
> tegra/clk.c:    reset_controller_register(&rst_ctlr);

I think these are all the ones that have a shared hardware block doing
both clocks and resets. My guess is that most other hardware does it
differently.

> I asked about this in the following thread.
> https://lkml.org/lkml/2015/11/10/724

Your hardware seems to be in a third category, which is not uncommon
either: you have clocks, resets and additional registers all in a
single block without a structure around them.

You can handle this with purely syscon based abstraction, or you
can have a driver for the combined device that registers itself
to multiple subsystems in addition to being a syscon.

	Arnd
