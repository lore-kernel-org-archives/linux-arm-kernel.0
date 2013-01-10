From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Jan 2013 11:47:09 -0500 (EST)
Subject: [PATCH 01/16] ARM: b.L: secondary kernel entry code
In-Reply-To: <CAHkRjk65PEVDS6vi=07g_hef8yXOR+mTYV_Nchu1fAuLnOJLOw@mail.gmail.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-2-git-send-email-nicolas.pitre@linaro.org>
 <CAHkRjk65PEVDS6vi=07g_hef8yXOR+mTYV_Nchu1fAuLnOJLOw@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1301101132080.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jan 2013, Catalin Marinas wrote:

> Hi Nico,
> 
> On 10 January 2013 00:20, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > --- /dev/null
> > +++ b/arch/arm/common/bL_entry.c
> ...
> > +extern volatile unsigned long bL_entry_vectors[BL_NR_CLUSTERS][BL_CPUS_PER_CLUSTER];
> 
> IMHO, we should keep this array linear and ignore the cluster grouping
> at this stage. This information could be added to latter patches that
> actually need to know about the b.L topology.

That's virtually all of them.  Everything b.L related is always 
expressed in terms of a cpu,cluster tuple at the low level.

> This would also imply that we treat the MPIDR just as an ID without 
> digging into its bit layout.

That makes for too large an index space.  We always end up needing to 
break the MPIDR into a cpu,cluster thing as the MPIDR bits are too 
sparse.

> > +void bL_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
> > +{
> > +       unsigned long val = ptr ? virt_to_phys(ptr) : 0;
> > +       bL_entry_vectors[cluster][cpu] = val;
> > +       smp_wmb();
> > +       __cpuc_flush_dcache_area((void *)&bL_entry_vectors[cluster][cpu], 4);
> > +       outer_clean_range(__pa(&bL_entry_vectors[cluster][cpu]),
> > +                         __pa(&bL_entry_vectors[cluster][cpu + 1]));
> 
> Why are you using the smp_wmb() here? We don't need any barrier since
> data cache ops by MVA are automatically ordered in relation to stores
> to the same MVA (as long as the MVA is in Normal Cacheable memory).

That was the result of monkeying the write_pen_release() code.  I'll 
remove that as the rest of the code added later doesn't use that anyway.

> > --- /dev/null
> > +++ b/arch/arm/common/bL_head.S
> ...
> > +ENTRY(bL_entry_point)
> > +
> > + THUMB(        adr     r12, BSYM(1f)   )
> > + THUMB(        bx      r12             )
> > + THUMB(        .thumb                  )
> > +1:
> > +       mrc     p15, 0, r0, c0, c0, 5
> 
> Minor thing, maybe a comment for this line like @ MPIDR.

ACK.


Nicolas
