From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 1 Mar 2017 11:17:05 -0800
Subject: [PATCH 4/5] clk: sunxi-ng: Add driver for A83T CCU
In-Reply-To: <20170215094954.h3wyaxlqkeb342yu@lukather>
References: <20170214033526.16977-1-wens@csie.org>
 <20170214033526.16977-5-wens@csie.org>
 <20170214095819.utsftcvti5zdmlmi@lukather>
 <CAGb2v66PxbhUdqSwFc5iFN2wDVQbOsibDkckXpFsxXW1WJNe3w@mail.gmail.com>
 <20170215094954.h3wyaxlqkeb342yu@lukather>
Message-ID: <20170301191705.GS25384@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15, Maxime Ripard wrote:
> On Tue, Feb 14, 2017 at 06:26:39PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Feb 14, 2017 at 5:58 PM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> > > On Tue, Feb 14, 2017 at 11:35:25AM +0800, Chen-Yu Tsai wrote:
> > >> +/*
> > >> + * MMC2 supports what's called the "new timing mode". The CCU and the MMC
> > >> + * controller must be in sync about which mode is used. The new mode moves
> > >> + * the clock delay controls (and possibly the delay lines) into the MMC
> > >> + * block. Also, the output of the clock is divided by 2. The output and
> > >> + * sample phase clocks are unused under this mode.
> > >> + *
> > >> + * This new mode seems to be preferred. Hence we force this clock to the
> > >> + * new mode. And we don't add the phase clocks.
> > >> + */
> > >
> > > I'm sorry, but I said this several times, this isn't working. We
> > > should model it properly, and not hack this around in the clock
> > > driver.
> > >
> > > As you say in your comment, the MMC driver needs to be aware about
> > > which mode is used, in order to also set a bit in one of its registers
> > > accordingly, and modify its sampling behaviour.
> > >
> > > The new timing is preferred, but our previous clock implementations
> > > didn't hardcode it, so we can't even rely on that behaviour to always
> > > write it in our driver.
> > 
> > Correct. With the A83T there has never been a merged clock driver though.
> > I realize this is a one off thing.
> > 
> > > This is not something specific to the A83T, but is found in all the
> > > SoCs since the A23, so we need to come up with a good solution to
> > > address that.
> > >
> > > I'm not sure what a good solution would be though. One would be to
> > > just have a private function of our own to switch in the new mode (if
> > > relevant, because only the MMC2 controllers have it), but that would
> > > lead to troubles with !sunxi-ng. Not something we can't deal with, but
> > > some extra precautions should be taken (make sure to protect the call
> > > through an ifdef / IS_DEFINED, check that the sunxi-ng driver has been
> > > probed, etc.)
> > 
> > If the custom function route is acceptable, I'll come up with something.
> 
> I think it would be a great start yes. I'll try to discuss it with
> Mike and Stephen at ELC and see what they think about that.
> 

I didn't hear anything at ELC. Can someone explain what the issue
is? Could something like clk_get_phase() + clk_get_rate() tell us
if we're in one mode vs. the other?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
