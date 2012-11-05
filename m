From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Nov 2012 22:17:59 +0000
Subject: [PATCH 0/2] clk: ux500: Add some more clk lookups for u8500
In-Reply-To: <CACRpkdZjLac9+dRwUm=ka7ZCouAx0bztNjEcjsPdsjZ=Ckz5rQ@mail.gmail.com>
References: <1351690853-13021-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdZjLac9+dRwUm=ka7ZCouAx0bztNjEcjsPdsjZ=Ckz5rQ@mail.gmail.com>
Message-ID: <20121105221759.GH28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 12:40:20PM +0100, Linus Walleij wrote:
> On Wed, Oct 31, 2012 at 2:40 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> 
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Some more clock lookups added for rng clocks and for the nomadik ske
> > keypad clocks.
> >
> > Ulf Hansson (2):
> >   clk: ux500: Register rng clock lookups for u8500
> >   clk: ux500: Register nomadik keypad clock lookups for u8500
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> for these.
> 
> They have the right name and all, apb_pclk is
> "AMBA peripheral bus, peripheral block clock"
> so a clock for the silicon, right.
> 
> ... then how it's supposed to be used, that's another
> issue...

Well, the apb pclk is the APB bus clock which times all transfers on
the APB bus.  Without the APB bus clock running, you can't talk to any
peripherals attached to that bus.

If your SoC controls the APB bus clock to each peripheral individually
(like, I seem to remember your Ux500 stuff does) and the peripheral is
not being clocked, then although the bus master may be seeing a clock,
and will manipulate the bus signals, the target will remain unresponsive
due to lack of clock.

So, the general principle is that the APB PCLK needs to be 'enabled'
whenever the peripheral in question is expecting any kind of access via
the APB bus.

All rather simple really.
