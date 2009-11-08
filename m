From: karl@hiramoto.org (Karl Hiramoto)
Date: Sun, 08 Nov 2009 21:24:39 +0100
Subject: IXP4xx repetitive 16-bit/32-bit I/O macros/inlines.
In-Reply-To: <m3iqdkc0n6.fsf@intrepid.localdomain>
References: <m3iqdkc0n6.fsf@intrepid.localdomain>
Message-ID: <4AF72907.1060705@hiramoto.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Halasa wrote:
> Anybody using 32-bit PATA/SATA transfers on IXP4xx? :-)
>   
Yes, on  HPT371 IDE chip on the PCI  bus to interface to compact flash 
to store logs.  For what it's worth I've only ever been able to make PIO 
work, I've never had any luck with the IDE DMA modes.  It hasn't been a 
high enough priority to investigate further.

> Long story, mostly with PCI in mind:
> - readb/readw/readl, writeb/writew/writel macros are value-preserving
> - __raw_* are order-preserving (i.e., strings are preserved)
> but the repetitive versions (outs[wl], ins[wl], ioread*_rep,
> iowrite*_rep) are supposed to preserve order as well (while lacking the
> __raw_ prefix).
>
> Comments?
>
> Is it worth it to change the names to __raw_*, or maybe to some other
> variant like native_*, to avoid confusion? It's really confusing.
> There aren't many users in the tree (I'd also change readl() and friends
> to something like read_le32, but it would be massive, comments welcome).
>
> Or perhaps we should have *_le32, *_be32, _order32? It should be
> something the compiler can optimize out if used wi
*_le32, *_be32, _order32 sounds like a good idea.


> th le32_to_cpu etc.
>
>
> --- a/arch/arm/mach-ixp4xx/include/mach/io.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/io.h
> @@ -311,7 +311,7 @@ static inline void
>  __ixp4xx_outsl(u32 io_addr, const u32 *vaddr, u32 count)
>  {
>  	while (count--)
> -		outl(*vaddr++, io_addr);
> +		outl(cpu_to_le32(*vaddr++), io_addr);
>  }
>  
>  static inline u8 
> @@ -366,7 +366,7 @@ static inline void
>  __ixp4xx_insl(u32 io_addr, u32 *vaddr, u32 count)
>  {
>  	while (count--)
> -		*vaddr++ = inl(io_addr);
> +		*vaddr++ = le32_to_cpu(inl(io_addr));
>  }
>  
>  #define PIO_OFFSET      0x10000UL
>   
