From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 Apr 2014 15:09:13 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <535913D4.6020401@ti.com>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <20140423171727.GK5649@arm.com>
 <20140423183742.GK24070@n2100.arm.linux.org.uk>
 <6414220.SShvCHLvZQ@wuerfel>
 <20140423190448.GB26756@n2100.arm.linux.org.uk>
 <20140424104737.GE8521@arm.com>
 <20140424111547.GP26756@n2100.arm.linux.org.uk>
 <20140424112152.GF19564@arm.com> <535913D4.6020401@ti.com>
Message-ID: <20140424140913.GB14110@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 02:38:28PM +0100, Santosh Shilimkar wrote:
> On Thursday 24 April 2014 07:21 AM, Will Deacon wrote:
> > On Thu, Apr 24, 2014 at 12:15:47PM +0100, Russell King - ARM Linux wrote:
> >> Yes, the hardware /is/ broken, but if you want to get it working in a
> >> way that's acceptable in upstream kernels, adding that barrier to rmb()
> >> is probably the only acceptable solution - especially if you have other
> >> stuff going in between the rmb() and the DMA unmap.
> > 
> > The problem then is that the additional barrier may well require
> > bus-specific knowledge and access to parts of bus driver code which we can't
> > use inside the rmb() macro. To solve this properly, the bus topology topic
> > once again rears its ugly head, as I think you'd need a callback from the
> > device driver to the bus on which it resides in order to provide the
> > appropriate barrier (which isn't something that can be done sanely for
> > the platform_bus).
> > 
> Not exactly against the bus notifier point but we can't afford to have such
> notifier calls in hot paths. Especially gigabit network drivers per packet
> processing paths where even 10 cycle cost makes huge impact on the throughput.

I don't think anybody is suggesting that you do this per-packet. This is a
per-DMA-transfer barrier, which is required anyway. The details of the
barrier are what varies, and are likely bus-specific.

> Interconnect barriers are really needed for completion. I think CPUs within at
> least same clusters will be ordered with rmb(). But same is not true when you
> have multiple clusters and then further down coherent interconnect comes into
> picture where all other non-CPU coherent masters are participating.

You're making a lot of rash generalisations here. The architected barrier
instructions as used by Linux will work perfectly well within the
inner-shareable domain. That means you don't need to worry about
multiple-clusters of CPUs.

However, you can't read *anything* into how a barrier instruction executed
on the CPU affects writes from another master; there is inherently a race
there which must be dealt with by either the external master or some
implementation-specific action by the CPU. This is the real problem.

> If rmb() has to reach all the way to coherent masters(non-CPU), then I suspect
> most of the ARM coherent architectures are broken. If you take any typical SOC,
> ARM CPUs are bolted with other coherent masters at AXI boundary or may be with
> ACP interfaces. At this level rmb() isn't good enough and you at least
> need a dsb() for completion.

An rmb() expands to dsb, neither of which give you anything in this scenario
as described by the architecture.

> So in my view unless and until you have features like DVM in hardware, dsb() is
> needed to guarantee even the ordering within CPUs sitting across clusters.

Firstly, you can only have multiple clusters of CPUs running with a single
Linux image if hardware coherency is supported between them. In this case,
all the CPUs will live in the same inner-shareable domain and dmb ish is
sufficient to enforce ordering between them.

Secondly, a dsb executed by a CPU is irrelevant to ordering of accesses by
an external peripheral, regardless of whether that peripheral is cache
coherent. If you think about this as a producer/consumer problem, you need
ordering at *both* ends to make any guarantees.

Will
