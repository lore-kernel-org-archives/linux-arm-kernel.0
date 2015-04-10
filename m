From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 10 Apr 2015 15:11:05 +0100
Subject: [RFC] mixture of cleanups to cache-v7.S
In-Reply-To: <20150410132723.GD6854@e104818-lin.cambridge.arm.com>
References: <20150402224947.GX24899@n2100.arm.linux.org.uk>
 <20150410132723.GD6854@e104818-lin.cambridge.arm.com>
Message-ID: <20150410141105.GA16979@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 02:27:42PM +0100, Catalin Marinas wrote:
> On Thu, Apr 02, 2015 at 11:49:47PM +0100, Russell King - ARM Linux wrote:
> > Several cleanups are in the patch below... I'll separate them out, but
> > I'd like to hear comments on them.  Basically:
> > 
> > 1. cache-v7.S is built for ARMv7 CPUs, so there's no reason not to
> >    use movw and movt when loading large constants, rather than using
> >    "ldr rd,=constant"
> > 
> > 2. we can do a much more efficient check for the errata in
> >    v7_flush_dcache_louis than we were doing - rather than putting the
> >    work-around code in the fast path, we can re-organise this such that
> >    we only try to run the workaround code if the LoU field is zero.
> > 
> > 3. shift the bitfield we want to extract in the CLIDR to the appropriate
> >    bit position prior to masking; this reduces the complexity of the
> >    code, particularly with the SMP differences in v7_flush_dcache_louis.
> > 
> > 4. pre-shift the Cortex A9 MIDR value to be checked, and shift the
> >    actual MIDR to lose the bottom four revision bits.
> > 
> > 5. as the v7_flush_dcache_louis code is more optimal, I see no reason not
> >    to enable this workaround by default now - if people really want it to
> >    be disabled, they can still choose that option.  This is in addition
> >    to Versatile Express enabling it.  Given the memory corrupting abilities
> >    of not having this errata enabled, I think it's only sane that it's
> >    something that should be encouraged to be enabled, even though it only
> >    affects r0pX CPUs.
> > 
> > One obvious issue comes up here though - in the case that the LoU bits
> > are validly zero, we merely return from v7_flush_dcache_louis with no
> > DSB or ISB.  However v7_flush_dcache_all always has a DSB or ISB at the
> > end, even if LoC is zero.  Is this an intentional difference, or should
> > v7_flush_dcache_louis always end with a DSB+ISB ?
> 
> Cc'ing Lorenzo since he added this code.
> 
> The DSB+ISB at the end is usually meant to wait for the completion of
> the cache maintenance operation. If there is no cache maintenance
> required, you don't need the barriers (nor the DMB at the beginning of
> the function), unless the semantics of this function always imply
> barrier. I assume not since we have a DSB anyway before issuing the WFI
> to put the CPU into a sleep state but I'll wait for Lorenzo to confirm.

I do not think the cache functions always imply barrier semantics,
as you said the barriers are there to ensure completion of cache
operations, if there is nothing to flush the barriers should not be
there.

> As for the v7_flush_dcache_all always having the barriers, I guess
> no-one is expecting a v7 CPU without caches.

Well, yes, actually I'd rather remove the barriers if LoC is 0 instead
of adding them to LoUIS API in case there is nothing to flush, I do not
think that's a problem in the first place.

Lorenzo
