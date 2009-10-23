From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Oct 2009 22:37:24 +0100
Subject: [PATCH] Use Normal uncached memory rather than Strongly
	Ordered on ARMv6+
In-Reply-To: <20091023213031.GA17468@huya.quicinc.com>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
	<20091023100639.GA19437@n2100.arm.linux.org.uk>
	<1256293374.6564.27.camel@pc1117.cambridge.arm.com>
	<20091023103420.GC19437@n2100.arm.linux.org.uk>
	<1256295591.6564.42.camel@pc1117.cambridge.arm.com>
	<20091023113001.GA22853@n2100.arm.linux.org.uk>
	<1256299512.6564.74.camel@pc1117.cambridge.arm.com>
	<20091023123600.GB22853@n2100.arm.linux.org.uk>
	<20091023213031.GA17468@huya.quicinc.com>
Message-ID: <20091023213724.GC29639@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 02:30:31PM -0700, David Brown wrote:
> On Fri, Oct 23, 2009 at 05:36:00AM -0700, Russell King - ARM Linux wrote:
> 
> > > Alternatively, we can place a DMB in readl/writel but I'm not sure about
> > > the performance impact.
> > 
> > If you do that, you might as well use strongly ordered memory for device
> > mappings - since you'll be causing the CPU to stall after each access.
> 
> Actually, the DMB is stronger than strongly ordered.  Strongly
> ordered only guarantees ordering within somewhat arbitrarily
> defined (and not completely settled) 1KB boundaries, for memory
> mapped peripherals.

I don't believe so for ARMv6 and below.  The ARMv6 ARM (DDI0100I) is
quite explicit about the ordering there and contains no such exception
(I checked tonight).  See B2.5, figure B2-1 and its associated text.

ARMv7 is a different kettle of fish, where memory accesses are completely
unordered with respect to any other kind of access.
