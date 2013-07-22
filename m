From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 22 Jul 2013 19:40:57 +0400
Subject: [RFC v2] ARM: i.MX pllv1: Implement set_rate
In-Reply-To: <1374506675.4128.6.camel@weser.hi.pengutronix.de>
References: <1374308975-20596-1-git-send-email-shc_work@mail.ru>
 <20130720111639.GA29785@pengutronix.de>
 <20130720153104.96b6723a20bde172a8ea1ba1@mail.ru>
 <20130720115829.GD29785@pengutronix.de>
 <20130720161801.380bb0d9db75155f5401730b@mail.ru>
 <20130721123759.GJ29785@pengutronix.de>
 <20130722191844.56e60280573dcab51187c9f3@mail.ru>
 <1374506675.4128.6.camel@weser.hi.pengutronix.de>
Message-ID: <20130722194057.9c75acd43fd744279725bee4@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jul 2013 17:24:35 +0200
Lucas Stach <l.stach@pengutronix.de> wrote:

> Am Montag, den 22.07.2013, 19:18 +0400 schrieb Alexander Shiyan:
> > On Sun, 21 Jul 2013 14:37:59 +0200
> > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > 
> > > On Sat, Jul 20, 2013 at 04:18:01PM +0400, Alexander Shiyan wrote:
> > > > On Sat, 20 Jul 2013 13:58:29 +0200
> > > > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > > 
> > > > > > > On Sat, Jul 20, 2013 at 12:29:35PM +0400, Alexander Shiyan wrote:
> > > > > > > > This patch implements frequency change for i.MX pllv1.
> > > > > > > > Selection of the values of the registers is not optimal, since is
> > > > > > > > made by simple enumeration of all possible values.
> > > > > > > 
> > > > > > > You do not mention why you want to adjust the rate. Normally we've been
> > > > > > > happy with the static values from the bootloader.
> > > > > > 
> > > > > > For CPUfreq.
> > > > > > Only one barrier to make it workable.
> > > > > 
> > > > > Isn't it better to adjust the dividers only? I haven't made good
> > > > > experience with adjusting the PLLs.
> > > > 
> > > > The frequency value after booting can be quite arbitrary.
> > > > 
> > > > Since we define possible frequencies for the CPU (266 and 399 MHz),
> > > > I can offer as variant to use a fixed constant values for PLL.
> > > 
> > > AFAIK the PLL should run at 800MHz. With dividers of 2, 3 and 6 we get
> > > 400, 266 and 133MHz. I don't think having more fine grained control
> > > about the CPU frequency is necessary from a power saving point of view.
> > > Let's keep the variants to a minimum to make the whole stuff more
> > > robust.
> > 
> > What about switching the source?
> > In any case, I have already made an efficient algorithm to calculate
> > the PLL and after some tests, I will introduce it.
> > Thanks.
> > 
> Both changing the divider or changing source should be glitchfree in the
> CPU clock path. Using the divider should be enough to allow to scale the
> CPU frequency with the accuracy needed for simple CPUfreq.
> 
> Using the PLL to scale the frequency is a really bad idea, as it's both
> not glitchfree on it's own plus it adds considerable delay to the clock
> change. In order to use the PLL for clock scaling you have to first
> switch the CPU away from the PLL (making sure you have an alternative
> clock path that can satisfy the CPUs requirements), then reprogram PLL,
> wait for the PLL to lock, then switch back to the PLL. Sounds utterly
> complex for a simple clock change that could be done by just flipping
> the divider bits, isn't it?

It sounds logical, but the datasheet (i.MX27) says nothing about this order:

The i.MX27 device provides a way for software to save power under different
operating conditions.
- Software determines whether to change the operation frequency or not.
- Software uses DPTC to determine whether to reduce or increase the power supply.
- After the power supply has been changed, software can update MPLL configuration.
- It restarts the MPLL and operates with new frequency.

-- 
Alexander Shiyan <shc_work@mail.ru>
