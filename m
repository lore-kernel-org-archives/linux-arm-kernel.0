From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Sep 2012 15:14:55 +0100
Subject: [PATCH 4/6 v2] ARM: integrator: initial device tree support
In-Reply-To: <5048A31E.2090704@gmail.com>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-2-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-3-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
 <5043E4BE.1060508@gmail.com>
 <CACRpkdbTRCUnx1JjCQ+WT4PoxtDG38MP=ctUp6TBPd64xQ39jw@mail.gmail.com>
 <5048A31E.2090704@gmail.com>
Message-ID: <20120906141455.GA13739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 08:20:30AM -0500, Rob Herring wrote:
> Well, the dts doesn't really need to describe how Linux is using things.
> I'd like to get to common DT code for sp804 so all platforms just have a
> call to sp804_dt_init() which does all the initialization.

They don't all have SP804 timers.  The Integrator/AP does not have SP804,
and it would be wrong to try and merge them into the clean SP804 driver.

Integrator/AP timers are strictly 16-bit only affairs, which need special
clocking handling to ensure that their rollover rate is sufficiently long.
SP804 timers are 32-bit or 16-bit timers, we drive the only in 32-bit mode,
and so they don't suffer from the above issue.  Polluting this code with
the legacy 16-bit stuff just for one platform is not a good idea.  They
weren't even called SP804 in the Integrator/AP days - they were just a
random timer design embedded into a FPGA.

> Realview and Versatile use timer0 for clk-event and timer3 for clk-src.
> Is there something broken with timer1 and timer2? It is certainly
> possible the h/w has the clock tied off for 1 of the 2 timers.

I don't believe so, that's the way the timers were used when I received
the initial code drop from ARM Ltd, before it got cleaned up.  The
selection of what timers are used appears to me to be completely random.

> VExpress CA9 has broken timers on the core tile (at least they were
> ifdef'ed out before the last clean-up). We could just remove/disable
> them in the dts so they are not used.

The motherboard timers can be switched between 32kHz and 1MHz mode.  The
core tile timers can probably be switched between 32kHz and 1MHz mode but
god knows how - they default to 32kHz.  So given that choice, I opted for
the higher resolution motherboard timers and left the hooks for the core
tile timers in place, in the hope that someone would tell me or implement
the switching to 1MHz mode.

Obviously, no one did, and the code got removed.  I doubt it makes any
difference what so ever.

And that's a very good point - in the current way things are handled on
these platforms, the tweaking of the SP804 input clocks has been divorced
from the SP804 initialization.  This is bad, because it means that
dependency has been hidden by the DT conversion...

So, selection of the right SP804s to use is also a function of "do we know
how to control its clock rate".  If we don't, we can't be certain of the
rate at which the timer ticks.
