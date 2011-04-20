From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Apr 2011 10:34:04 +0200 (CEST)
Subject: [PATCH 04/10] clk: implement parent pass through functions
In-Reply-To: <20110420071641.GR31131@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-5-git-send-email-s.hauer@pengutronix.de>
	<4DADC45C.1020202@codeaurora.org>
	<20110419175318.GB15233@pengutronix.de>
	<20110419190910.GQ31131@pengutronix.de>
	<alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<20110420071641.GR31131@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1104201009181.2744@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr 2011, Uwe Kleine-K?nig wrote:

> On Tue, Apr 19, 2011 at 11:54:21PM +0200, Thomas Gleixner wrote:
> > On Tue, 19 Apr 2011, Uwe Kleine-K?nig wrote:
> > > > +1 for letting the core enable/disable and prepare/unprepare the parent
> > > > clocks. I scanned the different arm clock implementations and they all
> > > > do it, except the ones which do not implement parents at all.
> > > Then the question is if all do handle parents in the same way. (i.e.
> > > in enable do parent first, in disable do child first?)
> > 
> > That's not a question at all. Anything which does it the other way
> > round is broken. Period.
> I havn't checked, but I remember Jeremy not wanting to handle parents in
> the generic part because he saw some differences.

It does not matter whether you checked or not. And it does not matter
whether Jeremy found code which does it the other way round.

The only safe way is parent first on enable and child first on
disable. That's a matter of hardware and not a question of random Joe
hacker got it wrong and it happens to work.

Sure it works on a simple divider which is connected to the parent
clock, but think "child is a PLL".

So having a strict ordering enforced is the only sane way, unless you
can prove that a particular piece of hardware requires it the other
way round. And I doubt that you can find one.

So the framework should be coded for the sane case in the first
place. If the unlikely case of reverse ordering surfaces one day, then
it's not rocket science to deal with that with a flag in struct clk
which tells clk_enable/disable or prepare/unprepare to do it the other
way round.

Thanks,

	tglx
