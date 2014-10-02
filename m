From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Oct 2014 17:53:50 +0100
Subject: [PATCH 6/7] arm64/kexec: Add core kexec support
In-Reply-To: <20141002135436.GB8645@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
 <20141001161621.GA28440@leverpostej>
 <20141001174714.GD14991@redhat.com>
 <20141001180304.GC5788@leverpostej>
 <20141001192245.GG14991@redhat.com>
 <20141002102625.GE5788@leverpostej>
 <20141002135436.GB8645@redhat.com>
Message-ID: <20141002165350.GC18660@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > I see that Geoff's patches flush dcaches for 
> > > certain kexec stored pages using __flush_dcache_area()
> > > (in kexec_list_flush_cb()).
> > > 
> > > arch/arm64/include/asm/cacheflush.h says following.
> > > 
> > >  *      __flush_dcache_area(kaddr, size)
> > >  *
> > >  *              Ensure that the data held in page is written back.
> > >  *              - kaddr  - page address
> > >  *              - size   - region size
> > > 
> > > So looks like we are trying to write back anything which we will access
> > > after switching off MMU. If that's the case, I have two questions.
> > > 
> > > - Why do we need to writeback that cacheline. After switching off MMU,
> > >   will we not access same cacheline. I thought caches are VIPT and tag
> > >   will still remain the same (but I might easily be wrong here).
> > 
> > As I mention above, the initial cache flush by VA is to ensure that the
> > data is visible to the CPU once translation is disabled. I'm not sure I
> > follow your reasoning.
> 
> I was assuming that even after we disable translations, cpu will still
> read data from dcache if it is available there. Looks like you are
> saying that once translation is disabled, data will be read from memory
> hence it is important to flush out dcache before disabling translation.
> Did I understand it right?

I believe you did.

When translation is disabled (i.e. SCTLR_ELx.M == 0), data accesses are
assigned Device-nGnRnE attributes regardless of whether the caches are
enabled (i.e. SCTLR_ELx.C == 1), and bypass the cache hierarchy. So
accesses to memory will go straight to PoC (essentially memory), and
won't hit in any cache.

However, instruction accesses are more complicated. They are always
assigned Normal memory attributes, and if the I-caches are enabled (i.e.
SCTLR_ELx.I == 1) they are cacheable regardless of whether translation
is enabled. So I-cache maintenance may be required when translation is
disabled.

Thanks,
Mark.
