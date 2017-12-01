From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Dec 2017 17:31:20 +0000
Subject: [PATCH RT] arm*: disable NEON in kernel mode
In-Reply-To: <20171201171458.3a2acsltiq54gvuu@hirez.programming.kicks-ass.net>
References: <20171130142216.GB12606@linutronix.de>
 <20171130143028.GA1351@linutronix.de>
 <20171201104331.GB1612@linutronix.de>
 <20171201134506.GF1612@linutronix.de>
 <20171201141827.yip6pl3tt7kxzek7@lakrids.cambridge.arm.com>
 <20171201143648.GK1612@linutronix.de>
 <20171201171458.3a2acsltiq54gvuu@hirez.programming.kicks-ass.net>
Message-ID: <20171201173120.GL10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 06:14:58PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 01, 2017 at 03:36:48PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2017-12-01 14:18:28 [+0000], Mark Rutland wrote:
> > > [Adding Ard, who wrote the NEON crypto code]
> > > 
> > > On Fri, Dec 01, 2017 at 02:45:06PM +0100, Sebastian Andrzej Siewior wrote:
> > > > +arm folks, to let you know
> > > > 
> > > > On 2017-12-01 11:43:32 [+0100], To linux-rt-users at vger.kernel.org wrote:
> > > > > NEON in kernel mode is used by the crypto algorithms and raid6 code.
> > > > > While the raid6 code looks okay, the crypto algorithms do not: NEON
> > > > > is enabled on first invocation and may allocate/free/map memory before
> > > > > the NEON mode is disabled again.
> > > 
> > > Could you elaborate on why this is a problem?
> > > 
> > > I guess this is because kernel_neon_{begin,end}() disable preemption?
> > > 
> > > ... is this specific to RT?
> > 
> > It is RT specific, yes. One thing are the unbounded latencies since
> > everything in this preempt_disable section can take time depending on
> > the size of the request.
> 
> Well, PREEMPT cares about that too.

Preempt may care, but it's the hit you take to use neon in the kernel.
The neon register set shares with the FPU, so preempting during that
path means that the normal FPU register saving would corrupt the
already saved user FPU context - and even worse would result in the
kernel's crypto function register contents being leaked to userspace.

If you care about preempt deeply, the only solution is to avoid using
kernel mode neon.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
