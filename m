From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Feb 2014 13:26:44 +0000
Subject: [PATCH 3/6] irqchip: gic: use writel instead of dsb +
 writel_relaxed
In-Reply-To: <20140206122340.GC32520@arm.com>
References: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
 <1391686253-13436-3-git-send-email-will.deacon@arm.com>
 <20140206114559.GK29446@arm.com>
 <20140206115121.GN26035@mudshark.cambridge.arm.com>
 <20140206115430.GN29446@arm.com>
 <20140206115739.GP26035@mudshark.cambridge.arm.com>
 <20140206120035.GQ29446@arm.com>
 <20140206121350.GQ26035@mudshark.cambridge.arm.com>
 <20140206122340.GC32520@arm.com>
Message-ID: <20140206132643.GS26035@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 12:23:40PM +0000, Catalin Marinas wrote:
> On Thu, Feb 06, 2014 at 12:13:50PM +0000, Will Deacon wrote:
> > Ok, so if we assume that a dsb(ishst) is sufficient because the CPU we're
> > talking to is either (a) coherent in the inner-shareable domain or (b)
> > incoherent, and we flushed everything to PoC, then why wouldn't a dmb(ishst)
> > work?
> 
> Because you want to guarantee the ordering between a store to Normal
> Cacheable memory vs store to Device for the IPI (see the mailbox example
> in the Barrier Litmus section ;)). The second is just a slave access, DMB
> guarantees observability from the master access perspective.

Ok, my reasoning is as follows:

  - CPU0 tries to message CPU1. It writes to a location in normal memory,
    then writes to the GICD to send the SGI

  - We need to ensure that CPU1 observes the write to normal memory before
    the write to GICD reaches the distributor. This is *not* about end-point
    ordering (the usual non-coherent DMA example).

  - A dmb ishst ensures that the two writes are observed in order by CPU1
    (and, in fact, the inner-shareable domain containing CPU0).

so the only way this can break is if the GICD write reaches the distributor
before being observed by CPU1 (otherwise, we know the mailbox write was
observed by CPU1). I dread to think how you would build such a beast
(dual-ported GICD with no serialisation to the same locations?)...

Furthermore, if we decide that device writes can reach their endpoints
before being observed by other inner-shareable observers, then doesn't that
pose a potential problem for spinlocks? If I take a lock and write to a
device, the write can hit the device before the lock appears to be taken.
That doesn't sound right to me.

Using a dsb(ishst) will ensure that we don't issue the GICD write until the
mailbox is visible to CPU1, but may be overkill.

Will
