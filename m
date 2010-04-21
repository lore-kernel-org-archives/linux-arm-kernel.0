From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 21 Apr 2010 21:47:18 +0100
Subject: udelay() broken for SMP cores?
In-Reply-To: <20100421202115.GH26616@n2100.arm.linux.org.uk>
References: <4BCE60C4.8020505@codeaurora.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C4FEED81@dbde02.ent.ti.com>
	<4BCE9E8B.2070103@codeaurora.org>
	<20100421072243.GA913@n2100.arm.linux.org.uk>
	<ea62885d30e4bbfb84db59758fa9e946.squirrel@www.codeaurora.org>
	<20100421095036.GA13971@n2100.arm.linux.org.uk>
	<20100421100008.GE13114@shareable.org>
	<20100421192911.GA26616@n2100.arm.linux.org.uk>
	<20100421195225.GS27575@shareable.org>
	<20100421202115.GH26616@n2100.arm.linux.org.uk>
Message-ID: <20100421204718.GY27575@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Apr 21, 2010 at 08:52:25PM +0100, Jamie Lokier wrote:
> > Russell King - ARM Linux wrote:
> > > We could go to ns delays, but then we have a big problem - the cost of
> > > calculating the number of loops starts to become significant compared to
> > > the delays - and that's a quality of implementation factor.  In fact,
> > > the existing cost has always been significant for short delays for
> > > slower (sub-100MHz) ARMs.
> > 
> > I'm surprised it makes much difference to, say, 20MHz ARMs because you
> > could structure it as a nested loop, the inner one executed once per
> > microsecond and calibrated to 1us.  The delays don't have to be super
> > accurate.
> 
> You don't understand the issue.  On older ARMs, the single 32-bit
> multiply is not cheap; it shows up as having a significant time
> expense for very short delays - and that _does_ matter.
> 
> Consider system performance where you're driving a bus using udelay()
> to provide 1us timings, but udelay ends up taking 10us instead every
> time because of the calculation for number of loops for a 1us timing.

Hence nested loop.  You don't multiply.  No calculation.

> > With a fixed-speed clock register known at compile time, the
> > calculation tends to constant-fold nicely, even for ns delays.  Not
> > suitable for multi-target kernels but good on single-target.
> 
> Here you're making a very big assumption - that there's some register
> you can read which is regularly clocked.  That's not true on a lot of
> older ARMs, where we struggle to satisfy sched_clock() due to lack of
> such a register.

Yes, I know.  I'm lucky to have one :-)

Where there is one, it seems like a good idea to use it if it's fast to read.

-- Jamie
