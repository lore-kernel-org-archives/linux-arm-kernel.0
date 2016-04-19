From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Apr 2016 17:09:13 +0100
Subject: [PATCH] arm64: mm: take CWG into account in __inval_cache_range()
In-Reply-To: <CAKv+Gu890YWn-DU5Hevb1hHqOTLssWn9rWgdBj=oA9FsJhLF0Q@mail.gmail.com>
References: <1461061773-19571-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160419125615.GA20991@leverpostej>
 <CAKv+Gu91hFkn5k0s=xVmJ+z0vEYMNe6h6UD6z9Qb0fxe7ba0Vw@mail.gmail.com>
 <20160419141321.GD8482@e104818-lin.cambridge.arm.com>
 <CAKv+Gu9+V_i6E_85W7kArugp4mwUjYf_p-=O7AFYGn460xU2vw@mail.gmail.com>
 <20160419153238.GE8482@e104818-lin.cambridge.arm.com>
 <CAKv+Gu890YWn-DU5Hevb1hHqOTLssWn9rWgdBj=oA9FsJhLF0Q@mail.gmail.com>
Message-ID: <20160419160913.GF8482@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 05:38:56PM +0200, Ard Biesheuvel wrote:
> On 19 April 2016 at 17:32, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Apr 19, 2016 at 04:48:32PM +0200, Ard Biesheuvel wrote:
> >> On 19 April 2016 at 16:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> > The best we could do is to warn if ARCH_DMA_MINALIGN is smaller than CWG
> >> > (as Robin suggested, we could do this only if we have non-coherent DMA
> >> > masters via arch_setup_dma_ops()). Quick hack below:
> >> >
> >> > -------------------------------8<-----------------------------------
> >> > diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> >> > index 5082b30bc2c0..5967fcbb617a 100644
> >> > --- a/arch/arm64/include/asm/cache.h
> >> > +++ b/arch/arm64/include/asm/cache.h
> >> > @@ -28,7 +28,7 @@
> >> >   * cache before the transfer is done, causing old data to be seen by
> >> >   * the CPU.
> >> >   */
> >> > -#define ARCH_DMA_MINALIGN      L1_CACHE_BYTES
> >> > +#define ARCH_DMA_MINALIGN      128
> >> >
> >> >  #ifndef __ASSEMBLY__
> >> >
> >> > @@ -37,7 +37,7 @@
> >> >  static inline int cache_line_size(void)
> >> >  {
> >> >         u32 cwg = cache_type_cwg();
> >> > -       return cwg ? 4 << cwg : L1_CACHE_BYTES;
> >> > +       return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
> >>
> >> Unrelated, but this does not look right: if the CWG field is zero, we
> >> should either assume 2 KB, or iterate over all the CCSIDR values and
> >> take the maximum linesize.
> >
> > It may be a better guess but even that is not always relevant since
> > CCSIDR may not present the real hardware information. It's only meant to
> > give enough information to be able to do cache maintenance by set/way
> > and we've seen CPU implementations where this has nothing to do with the
> > actual cache geometry.
> 
> I am aware of that discussion, but that was about inferring aliasing
> properties from the way size, which combines the linesize and the
> number of sets/ways, and the latter are apparently set to 1/1 in some
> cases so that any set/way operation simply affects the entire cache.
> 
> However, the CCSIDR linesize field itself is mentioned in the
> description of CWG in the ARM ARM, as a suitable source of obtaining
> the maximum linesize in the system.

The ARM ARM confuses me. While CTR_EL0.CWG indeed talks about CCSIDR as
a fall back, the latter has a note:

  The parameters NumSets, Associativity, and LineSize in these registers
  define the architecturally visible parameters that are required for
  the cache maintenance by Set/Way instructions. They are not guaranteed
  to represent the actual microarchitectural features of a design. You
  cannot make any inference about the actual sizes of caches based on
  these parameters.

So it's not clear to me whether LineSize would give us the information
we need for cache maintenance by VA. But I'm not opposed to using this
on a CPU that doesn't have CWG (once we see one).

-- 
Catalin
