From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 22 Apr 2011 10:22:46 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110422070918.GB841@atomide.com>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
	<alpine.LFD.2.02.1104211045220.3323@ionos>
	<20110421103117.GB16776@sirena.org.uk>
	<20110421114220.GJ13688@atomide.com>
	<alpine.LFD.2.02.1104211651540.3323@ionos>
	<20110422070918.GB841@atomide.com>
Message-ID: <alpine.LFD.2.02.1104221014250.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Apr 2011, Tony Lindgren wrote:
> * Thomas Gleixner <tglx@linutronix.de> [110421 07:49]:
> > On Thu, 21 Apr 2011, Tony Lindgren wrote:
> > > Also there can be multiple parent clocks. An example are the timers on
> > > omaps where the parent clock can be either the 32KiHz clock or external
> > > source clock. ?his may need to be reprogrammed dynamically in some cases
> > > for advanced idle modes as one of the parent clocks may be shut down.
> > 
> > If you need to propagate from bottom up, then you need a list of
> > childs in struct clk. Right ?
> 
> Yes we need to be able to reprogram all children if the parent clock needs
> to be reprogrammed for cpufreq/DVFS.

Bottom up propagation is not rocket science. :)

> Also a child may need to change the parent clock like I wrote above.
> However, it might be possible to deal with this by registering the same
> child for both parents and handle that directly in the driver for the
> special cases if that simplifies things.
> 
> In some clk_set_rate cases for a child the parent clock may need to be
> reprogrammed to provide the desired rate. I don't know how common this
> is, and this may be doable by requesting both parent and child in the
> driver if that simplifies things.

I don't think so. That should be done in a library function which
traverses the tree an validates whether this can be done or
not. Though that's an orthogonal problem and not necessary for the
primary set of functionality as long as we have the proper bottom up
propagation and validation mechanisms in place.

Thanks,

	tglx
