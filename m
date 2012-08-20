From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 20 Aug 2012 12:09:06 -0400 (EDT)
Subject: [PATCH] ARM: io: avoid writeback addressing modes for __raw_
 accessors
In-Reply-To: <20120820144927.GP25864@mudshark.cambridge.arm.com>
References: <1344956366-32574-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1208161906390.1541@xanadu.home>
 <20120820124109.GK25864@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1208200902120.1754@xanadu.home>
 <20120820144927.GP25864@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1208201150010.1754@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Aug 2012, Will Deacon wrote:
> On Mon, Aug 20, 2012 at 02:29:31PM +0100, Nicolas Pitre wrote:
> > On Mon, 20 Aug 2012, Will Deacon wrote:
> > > That said, we could try the "Qo" constraints, which I seem to 
> > > remember don't generate writebacks. I'll have a play.
> > 
> > OK.  That would be excellent.
> 
> Looks like we have a winner (diff against the original patch below). I now
> see:
> 
> 00000340 <hw_init>:
>  340:   e1a03000        mov     r3, r0
>  344:   e3a00000        mov     r0, #0
>  348:   e5830010        str     r0, [r3, #16]
>  34c:   e3e02000        mvn     r2, #0
>  350:   e5832014        str     r2, [r3, #20]
>  354:   e5932018        ldr     r2, [r3, #24]
>  358:   e38220ff        orr     r2, r2, #255    ; 0xff
>  35c:   e5832030        str     r2, [r3, #48]   ; 0x30
>  360:   e12fff1e        bx      lr
> 
> with the new code, which is basically the same as the old code but the mvn and
> a str have switched places. The same difference occurs when targetting Thumb2.

OK.  Of course the compiler cannot have the same cost evaluation when 
instructions are hidden inside an asm statement which might change the 
instruction scheduling slightly.  But I don't think that matters much 
for IO accesses.

> --- >8
> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index b54d687..bbc94c2 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -63,38 +63,50 @@ extern void __raw_readsl(const void __iomem *addr, void *data, int longlen);
>   */
>  static inline void __raw_writew(u16 val, volatile void __iomem *addr)
>  {
> -       asm volatile("strh %0, [%1]" : : "r" (val), "r" (addr));
> +       asm volatile("strh %1, %0"
> +                    : "=Qo" (*(volatile u16 __force *)addr)
> +                    : "r" (val));
>  }
>  
>  static inline u16 __raw_readw(const volatile void __iomem *addr)
>  {
>         u16 val;
> -       asm volatile("ldrh %0, [%1]" : "=r" (val) : "r" (addr));
> +       asm volatile("ldrh %0, %1"
> +                    : "=r" (val)
> +                    : "Qo" (*(const volatile u16 __force *)addr));
>         return val;
>  }

Semantically, I think the qualifier on the Qo constraint should be + as 
in "+Qo" listed in the input operand list in both cases since we may not 
assume anything about the memory location when it is referring to IO 
registers.  It is not because you write to it that previous writes can 
be optimized away, and it is not because you read from it that the 
accessed memory location will remain the same after the read.  Granted, 
the volatile should take care of that, but it doesn't hurt to be 
explicit.

If you fix that then you can add...

Reviewed-by: Nicolas Pitre <nico@linaro.org>


Nicolas
