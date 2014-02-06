From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 15:20:48 +0000
Subject: [PATCH 3/6] irqchip: gic: use writel instead of dsb +
 writel_relaxed
In-Reply-To: <20140206132643.GS26035@mudshark.cambridge.arm.com>
References: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
 <1391686253-13436-3-git-send-email-will.deacon@arm.com>
 <20140206114559.GK29446@arm.com>
 <20140206115121.GN26035@mudshark.cambridge.arm.com>
 <20140206115430.GN29446@arm.com>
 <20140206115739.GP26035@mudshark.cambridge.arm.com>
 <20140206120035.GQ29446@arm.com>
 <20140206121350.GQ26035@mudshark.cambridge.arm.com>
 <20140206122340.GC32520@arm.com>
 <20140206132643.GS26035@mudshark.cambridge.arm.com>
Message-ID: <20140206152048.GD32520@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 01:26:44PM +0000, Will Deacon wrote:
> On Thu, Feb 06, 2014 at 12:23:40PM +0000, Catalin Marinas wrote:
> > On Thu, Feb 06, 2014 at 12:13:50PM +0000, Will Deacon wrote:
> > > Ok, so if we assume that a dsb(ishst) is sufficient because the CPU we're
> > > talking to is either (a) coherent in the inner-shareable domain or (b)
> > > incoherent, and we flushed everything to PoC, then why wouldn't a dmb(ishst)
> > > work?
> > 
> > Because you want to guarantee the ordering between a store to Normal
> > Cacheable memory vs store to Device for the IPI (see the mailbox example
> > in the Barrier Litmus section ;)). The second is just a slave access, DMB
> > guarantees observability from the master access perspective.
> 
> Ok, my reasoning is as follows:
> 
>   - CPU0 tries to message CPU1. It writes to a location in normal memory,
>     then writes to the GICD to send the SGI
> 
>   - We need to ensure that CPU1 observes the write to normal memory before
>     the write to GICD reaches the distributor. This is *not* about end-point
>     ordering (the usual non-coherent DMA example).
> 
>   - A dmb ishst ensures that the two writes are observed in order by CPU1
>     (and, in fact, the inner-shareable domain containing CPU0).

The last bullet point is not correct. DMB would only guarantee that the
two writes (memory and GICD) are observed by CPU1 if CPU1 actually read
the GICD (observability is defined for master accesses).

> so the only way this can break is if the GICD write reaches the distributor
> before being observed by CPU1 (otherwise, we know the mailbox write was
> observed by CPU1). I dread to think how you would build such a beast
> (dual-ported GICD with no serialisation to the same locations?)...

The above is possible because the CPU1 would never "observe" the GICD
write. It observes a side-effect of that write (interrupt) which is not
covered by DMB. You could argue that CPU1 reads GICC in the interrupt
handler but I'm not sure GICC vs GICD ordering is guaranteed (and I know
of hardware where not even accesses to the same GICD are guaranteed ;)).

> Furthermore, if we decide that device writes can reach their endpoints

Device writes are not observed according to the ARM ARM meaning of
"observability" (master accesses only; well, there is something about
Strongly Ordered memory and devices but it's not the case here and IIRC
refers to when a _device_ observes the write rather than a CPU observing
the write to that device, I need to read it again).

> before being observed by other inner-shareable observers, then doesn't that
> pose a potential problem for spinlocks? If I take a lock and write to a
> device, the write can hit the device before the lock appears to be taken.
> That doesn't sound right to me.

For simplicity, assuming that the lock acquiring was a simple STR, the
write to device can indeed hit the device before the STR is observed by
another CPU or device (that's why writel() has a DSB). This is however
not relevant as you don't care when it hit the device (unless you issue
IPIs). If considering master accesses, the below is valid even though B
could hit the device before A is observed by CPU1:

CPU0:
	STR A, [Normal]
	DMB
	STR B, [Device]

CPU1:
	LDR C, [Device]
	DMB
	LDR D, [Normal]

If on CPU1 C == B then D == A. The key here is that observability of
STR B, [Device] is done via another master access on CPU1 (LDR C,
[Device]) and not just the change to the device state.

When we talk about LDREX/STREX loop, I don't think the write to the
device can be issued before the STREX has been guaranteed to succeed
(not necessarily observed) and therefore the spinlock acquired (we don't
issue writes speculatively and the spinlock loop has a conditional
branch).

If we go to the definition of the STR observability (in short):

  1. A load from a location returns the value written by the observed
     store.
  2. A store to a location changes the value written by the observed
     store.

The "not observability" means _any_ of the above conditions is false. So
going back to your example, the write to the device can hit the device
_and_ the load of the spinlock value on another CPU1 still return the
unlocked value. However, a subsequent STREX on CPU1 would fail and the
LDREX restarted, eventually observing the STREX on CPU0.

If we talk about lock acquiring on another CPU and issuing of device
accesses, the DMB guarantees ordering (master accesses).

Another interesting scenario is the write to device followed by
spin_unlock and on another CPU spin_lock and device write. As per my
example above, I don't see any issue (change Normal with Device).

> Using a dsb(ishst) will ensure that we don't issue the GICD write until the
> mailbox is visible to CPU1, but may be overkill.

In the ARM ARM examples, the mailbox write generates the interrupt (it
is not visible to the other CPU at all).

-- 
Catalin
