From: vgoyal@redhat.com (Vivek Goyal)
Date: Thu, 2 Oct 2014 09:54:36 -0400
Subject: [PATCH 6/7] arm64/kexec: Add core kexec support
In-Reply-To: <20141002102625.GE5788@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
 <20141001161621.GA28440@leverpostej>
 <20141001174714.GD14991@redhat.com>
 <20141001180304.GC5788@leverpostej>
 <20141001192245.GG14991@redhat.com>
 <20141002102625.GE5788@leverpostej>
Message-ID: <20141002135436.GB8645@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 02, 2014 at 11:26:25AM +0100, Mark Rutland wrote:
> On Wed, Oct 01, 2014 at 08:22:45PM +0100, Vivek Goyal wrote:
> > On Wed, Oct 01, 2014 at 07:03:04PM +0100, Mark Rutland wrote:
> > 
> > [..]
> > > I assume we'd have the first kernel perform the required cache maintenance.
> > > 
> > 
> > Hi Mark,
> > 
> > I am wondering, what kind of cache management is required here? What kind of
> > dcaches are present on arm64.
> 
> In ARMv8 there's a hierarchy of quasi-PIPT D-caches; they generally
> behave like (and can be maintained as if) they are PIPT but might not
> actually be PIPT. There may be a system level cache between the
> architected cache hierarchy and memory (that should respect cache
> maintenance by VA).
> 
> The MT_NORMAL attributes are such that most memory the kernel maps will
> have write-back read/write allocate attributes. So cache maintenance is
> required to ensure that data is cleaned from the D-caches out to the PoC
> (the point in the memory system at which non-cacheable accesses can see
> the same data), such that the CPU can see the images rather than stale
> data once translation is disabled.
> 
> > I see that Geoff's patches flush dcaches for 
> > certain kexec stored pages using __flush_dcache_area()
> > (in kexec_list_flush_cb()).
> > 
> > arch/arm64/include/asm/cacheflush.h says following.
> > 
> >  *      __flush_dcache_area(kaddr, size)
> >  *
> >  *              Ensure that the data held in page is written back.
> >  *              - kaddr  - page address
> >  *              - size   - region size
> > 
> > So looks like we are trying to write back anything which we will access
> > after switching off MMU. If that's the case, I have two questions.
> > 
> > - Why do we need to writeback that cacheline. After switching off MMU,
> >   will we not access same cacheline. I thought caches are VIPT and tag
> >   will still remain the same (but I might easily be wrong here).
> 
> As I mention above, the initial cache flush by VA is to ensure that the
> data is visible to the CPU once translation is disabled. I'm not sure I
> follow your reasoning.

I was assuming that even after we disable translations, cpu will still
read data from dcache if it is available there. Looks like you are
saying that once translation is disabled, data will be read from memory
hence it is important to flush out dcache before disabling translation.
Did I understand it right?

Thanks
Vivek
