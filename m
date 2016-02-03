From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Feb 2016 18:12:52 +0000
Subject: [PATCH v4 4/7] arm64: Handle early CPU boot failures
In-Reply-To: <20160203175351.GG1234@leverpostej>
References: <1453745225-27736-1-git-send-email-suzuki.poulose@arm.com>
 <1453745225-27736-5-git-send-email-suzuki.poulose@arm.com>
 <20160203125735.GA26487@MBP.local>
 <20160203164632.GC1234@leverpostej>
 <20160203173448.GD26487@MBP.local>
 <20160203175351.GG1234@leverpostej>
Message-ID: <20160203181250.GE26487@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 05:53:51PM +0000, Mark Rutland wrote:
> On Wed, Feb 03, 2016 at 05:34:49PM +0000, Catalin Marinas wrote:
> > On Wed, Feb 03, 2016 at 04:46:32PM +0000, Mark Rutland wrote:
> > > On Wed, Feb 03, 2016 at 12:57:38PM +0000, Catalin Marinas wrote:
> > > > On Mon, Jan 25, 2016 at 06:07:02PM +0000, Suzuki K. Poulose wrote:
> > > > > + * update_early_cpu_boot_status tmp, status
> > > > > + *  - Corrupts tmp, x0, x1
> > > > > + *  - Writes 'status' to __early_cpu_boot_status and makes sure
> > > > > + *    it is committed to memory.
> > > > > + */
> > > > > +
> > > > > +	.macro	update_early_cpu_boot_status tmp, status
> > > > > +	mov	\tmp, lr
> > > > > +	adrp	x0, __early_cpu_boot_status
> > > > > +	add	x0, x0, #:lo12:__early_cpu_boot_status
> > > > 
> > > > Nitpick: you could use the adr_l macro.
> > > > 
> > > > > +	mov	x1, #\status
> > > > > +	str	x1, [x0]
> > > > > +	add	x1, x0, 4
> > > > > +	bl	__inval_cache_range
> > > > > +	mov	lr, \tmp
> > > > > +	.endm
> > > > 
> > > > If the CPU that's currently booting has the MMU off, what's the point of
> > > > invalidating the cache here?
> > > 
> > > To invalidate stale lines for this address, held in any caches prior to
> > > the PoC. I'm assuming that __early_cpu_boot_status is sufficiently
> > > padded to the CWG.
> > 
> > I would have rather invalidated it before writing the [x0], if that's
> > what it's aimed at.
> 
> That alone wouldn't not be sufficient, due to speculative fetches
> allocating new (clean) lines prior to the write completing.

Indeed.

> I was expecting the CWG-aligned region to only be written to with the
> MMU off, i.e. we'd only have clean stale lines and no dirty lines.

I assume that's true even in a guest.

> > > Cache maintenance works when SCTLR_ELx.M == 0, though barriers are
> > > required prior to cache maintenance as non-cacheable accesses do not
> > > hazard by VA.
> > > 
> > > The MMU being off has no effect on the cache maintenance itself.
> > 
> > I know, but whether it has an effect on other CPUs is a different
> > question (it probably has). Anyway, I would rather do the invalidation
> > on the CPU that actually reads this status.
> 
> My only worry would be how this gets ordered against the (non-cacheable)
> store. I guess we'd complete that with a DSB SY regardless.

The synchronisation on the primary CPU is a bit flaky anyway and just
relies on long timeouts. It waits for a while to complete (1 sec) and
than it reads the status. So it assumes that the secondary CPU finished
its writing but neither DSB nor cache maintenance guarantee this.

> Given that, I have no problem doing the invalidate on the read side.
> Assuming we only write from the side with the MMU off, we don't need
> maintenance on that side.

I agree.

> > > > The operation may not even be broadcast to the other CPU. So you
> > > > actually need the invalidation before reading the status on the
> > > > primary CPU.
> > > 
> > > We require that CPUs are coherent when they enter the kernel, so any
> > > cache maintenance operation _must_ affect all coherent caches (i.e. it
> > > must be broadcast and must affect all coherent caches prior to the PoC
> > > in this case).
> > 
> > In general, if you perform cache maintenance on a non-shareable mapping,
> > I don't think it would be broadcast. But in this case, the MMU is off,
> > data accesses default to Device_nGnRnE and considered outer shareable,
> > so it may actually work. Is this stated anywhere in the ARM ARM?
> 
> In ARM DDI 0487A.h, D4.2.8 "The effects of disabling a stage of address
> translation" we state:
> 
> 	Cache maintenance instructions act on the target cache
> 	regardless of whether any stages of address translation are
> 	disabled, and regardless of the values of the memory attributes.
> 	However, if a stage of address translation is disabled, they use
> 	the flat address mapping for that translation stage.

But does "target cache" include other CPUs in the system?

-- 
Catalin
