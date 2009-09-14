From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Sep 2009 15:26:15 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <20090914142148.GE21580@n2100.arm.linux.org.uk>
References: <1250890146.29685.18.camel@david-laptop>
	<1251128692.28977.17.camel@pc1117.cambridge.arm.com>
	<1251134043.31975.23.camel@david-laptop>
	<1251135709.28977.40.camel@pc1117.cambridge.arm.com>
	<20090914014353.GA4762@shareable.org>
	<20090914100056.GC16644@n2100.arm.linux.org.uk>
	<1252922773.16853.62.camel@pc1117.cambridge.arm.com>
	<1252928832.16853.96.camel@pc1117.cambridge.arm.com>
	<1252930881.16853.99.camel@pc1117.cambridge.arm.com>
	<20090914140908.GD21580@n2100.arm.linux.org.uk>
	<20090914142148.GE21580@n2100.arm.linux.org.uk>
Message-ID: <1252938375.16853.118.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-14 at 15:21 +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 14, 2009 at 03:09:09PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Sep 14, 2009 at 01:21:21PM +0100, Catalin Marinas wrote:
> > > And here's an untested patch to clear the exclusive monitor on the
> > > exception return path. If you are OK with the idea, I'll do some testing
> > > before pushing it for upstream:
> > 
> > However, a plain STR is not guaranteed to change the state of the
> > exclusive monitor - it is implementation defined whether STR does
> > or not.
> > 
> > This is true for both the local and global exclusive monitors.
> 
> ... only for the same local CPU.  A STR done by another CPU to the
> address being monitored clears the global monitor.

Yes, that's A3.4.2 in the ARM ARM. And with this patch, we take care for
the local monitor by clearing the monitor state on exception return.

I think the reason we weren't seeing any issues is that many locking
operations take place with interrupts disabled.

-- 
Catalin
