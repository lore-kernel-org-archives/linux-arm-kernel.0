From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Apr 2010 20:29:11 +0100
Subject: udelay() broken for SMP cores?
In-Reply-To: <20100421100008.GE13114@shareable.org>
References: <4BCE60C4.8020505@codeaurora.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C4FEED81@dbde02.ent.ti.com>
	<4BCE9E8B.2070103@codeaurora.org>
	<20100421072243.GA913@n2100.arm.linux.org.uk>
	<ea62885d30e4bbfb84db59758fa9e946.squirrel@www.codeaurora.org>
	<20100421095036.GA13971@n2100.arm.linux.org.uk>
	<20100421100008.GE13114@shareable.org>
Message-ID: <20100421192911.GA26616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 11:00:08AM +0100, Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
> > Well, the assumption is that the CPUs will be running at their fastest
> > speed at boot time, and therefore loops_per_jiffy will be calibrated
> > such that we guarantee _at least_ the asked-for delay - which is the
> > only guarantee udelay has.
> 
> That's an interesting and not altogether reliable assumption.

That depends which bit you're talking about.  udelay() must give you the
delay you asked for, or a longer delay.  If it gives you a shorter delay,
it's buggy plain and simple.

> On a device I'm working with, we just read a fixed-speed clock
> register in a loop.  It's slower than the CPU register loop, but given
> udelay counts in great big slow _microsecond_ delays (how quaint! ;-)
> that's fine.

We could go to ns delays, but then we have a big problem - the cost of
calculating the number of loops starts to become significant compared to
the delays - and that's a quality of implementation factor.  In fact,
the existing cost has always been significant for short delays for
slower (sub-100MHz) ARMs.
