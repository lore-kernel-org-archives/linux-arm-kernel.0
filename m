From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Feb 2016 16:46:32 +0000
Subject: [PATCH v4 4/7] arm64: Handle early CPU boot failures
In-Reply-To: <20160203125735.GA26487@MBP.local>
References: <1453745225-27736-1-git-send-email-suzuki.poulose@arm.com>
 <1453745225-27736-5-git-send-email-suzuki.poulose@arm.com>
 <20160203125735.GA26487@MBP.local>
Message-ID: <20160203164632.GC1234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 12:57:38PM +0000, Catalin Marinas wrote:
> Hi Suzuki,
> 
> On Mon, Jan 25, 2016 at 06:07:02PM +0000, Suzuki K. Poulose wrote:
> > + * update_early_cpu_boot_status tmp, status
> > + *  - Corrupts tmp, x0, x1
> > + *  - Writes 'status' to __early_cpu_boot_status and makes sure
> > + *    it is committed to memory.
> > + */
> > +
> > +	.macro	update_early_cpu_boot_status tmp, status
> > +	mov	\tmp, lr
> > +	adrp	x0, __early_cpu_boot_status
> > +	add	x0, x0, #:lo12:__early_cpu_boot_status
> 
> Nitpick: you could use the adr_l macro.
> 
> > +	mov	x1, #\status
> > +	str	x1, [x0]
> > +	add	x1, x0, 4
> > +	bl	__inval_cache_range
> > +	mov	lr, \tmp
> > +	.endm
> 
> If the CPU that's currently booting has the MMU off, what's the point of
> invalidating the cache here?

To invalidate stale lines for this address, held in any caches prior to
the PoC. I'm assuming that __early_cpu_boot_status is sufficiently
padded to the CWG.

Cache maintenance works when SCTLR_ELx.M == 0, though barriers are
required prior to cache maintenance as non-cacheable accesses do not
hazard by VA.

The MMU being off has no effect on the cache maintenance itself.

> The operation may not even be broadcast to the other CPU. So you
> actually need the invalidation before reading the status on the
> primary CPU.

We require that CPUs are coherent when they enter the kernel, so any
cache maintenance operation _must_ affect all coherent caches (i.e. it
must be broadcast and must affect all coherent caches prior to the PoC
in this case).

> > +
> > +ENTRY(__early_cpu_boot_status)
> > +	.long 	0
> > +END(__early_cpu_boot_status)
> 
> I think we should just do like __boot_cpu_mode and place it in the
> .data..cacheline_aligned section.

I think we should add a separate __writeback_aligned annotation for
stuff like this, even if it falls in .data..cacheline_aligned for now.

Otherwise, agreed.

> You can always use the safe clean+invalidate before reading the value
> so that we don't care much about the write-back granule.

To get correct data out we need to pad to the CQG regardless of whether
the reader or the writer perform the maintenance.

Mark.
