From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 3 May 2016 15:36:03 +0200
Subject: [PATCH v2 04/11] clocksource/moxart: Generalise timer for use on
 other socs
In-Reply-To: <CACPK8XfgDPPYG=ON-Z+gEKSg1fe4PuqRWoMz8P-9oCMvgQKmhw@mail.gmail.com>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-5-git-send-email-joel@jms.id.au>
 <571A5FBA.9010204@linaro.org>
 <CACPK8XfgDPPYG=ON-Z+gEKSg1fe4PuqRWoMz8P-9oCMvgQKmhw@mail.gmail.com>
Message-ID: <20160503133603.GA19298@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 03:26:33PM +0930, Joel Stanley wrote:
> Hey Daniel,
> 
> Thanks for the review.
> 
> On Sat, Apr 23, 2016 at 3:00 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> > On 04/21/2016 10:04 AM, Joel Stanley wrote:
> >>
> >> The moxart timer IP is shared with another soc made by Aspeed.
> >> Generalise the registers that differ so the same driver can be used for
> >> both.
> >>
> >> As we now depend on CLKSRC_MMIO, create a Kconfig symbol for the driver
> >> so we can express this dependency.
> >>
> >> Signed-off-by: Joel Stanley <joel@jms.id.au>
> >> ---
> >
> >
> > In the future, please Cc the maintainers.
> 
> Sure.
> 
> >
> > You probably can remove all the unused macro definition here for both MOXART
> > and ASPEED to have something just a couple of definition.
> 
> I agree with Ben; we're helping out by documenting the hardware in
> lieu of a public datasheet. I'd prefer to keep this here.

Ok, let's keep it.
 
> >>   static void __iomem *base;
> >>   static unsigned int clock_count_per_tick;
> >> +static unsigned int t1_disable_val, t1_enable_val;
> >
> >
> > It will be cleaner to:
> >
> > 1. Factor out:
> >         writel(TIMER1_DISABLE, base + TIMER_CR);
> >         writel(TIMER1_ENABLE, base + TIMER_CR);
> 
> I considered this myself but went with the minimal change. I'm not
> fussed, so I will rework it as you suggest.
> 
> From the register layout I suspect this IP block is a Faraday Tech
> FTTMR010[1], but I don't have any other evidence.

Apparently, it could be the fttmr010 [2].

May be Jonas Jensen can confirm that.

> Would you take a
> patch to change the name or would you prefer leaving it as moxart?

If Jonas can confirm the moxart SoC is using the faraday timer, then it 
would make much more sense to rename it to timer-fttmr010.c and have the 
different instance of this timer to set it up with the platform specific 
bits.

> [1] https://lists.nongnu.org/archive/html/qemu-devel/2013-03/msg04333.html

[2] 
http://git.denx.de/?p=u-boot.git;a=blob;f=include/faraday/fttmr010.h;h=2ab68d10218ed8241e5d2c916437c5918c17173d;hb=HEAD
