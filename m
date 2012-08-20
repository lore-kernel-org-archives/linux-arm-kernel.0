From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 20 Aug 2012 14:04:01 -0400 (EDT)
Subject: [PATCH] ARM: io: avoid writeback addressing modes for __raw_
 accessors
In-Reply-To: <20120820165405.GU25864@mudshark.cambridge.arm.com>
References: <1344956366-32574-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1208161906390.1541@xanadu.home>
 <20120820124109.GK25864@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1208200902120.1754@xanadu.home>
 <20120820144927.GP25864@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1208201150010.1754@xanadu.home>
 <20120820165405.GU25864@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1208201356130.1754@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Aug 2012, Will Deacon wrote:

> On Mon, Aug 20, 2012 at 05:09:06PM +0100, Nicolas Pitre wrote:
> > On Mon, 20 Aug 2012, Will Deacon wrote:
> > > diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> > > index b54d687..bbc94c2 100644
> > > --- a/arch/arm/include/asm/io.h
> > > +++ b/arch/arm/include/asm/io.h
> > > @@ -63,38 +63,50 @@ extern void __raw_readsl(const void __iomem *addr, void *data, int longlen);
> > >   */
> > >  static inline void __raw_writew(u16 val, volatile void __iomem *addr)
> > >  {
> > > -       asm volatile("strh %0, [%1]" : : "r" (val), "r" (addr));
> > > +       asm volatile("strh %1, %0"
> > > +                    : "=Qo" (*(volatile u16 __force *)addr)
> > > +                    : "r" (val));
> > >  }
> > >  
> > >  static inline u16 __raw_readw(const volatile void __iomem *addr)
> > >  {
> > >         u16 val;
> > > -       asm volatile("ldrh %0, [%1]" : "=r" (val) : "r" (addr));
> > > +       asm volatile("ldrh %0, %1"
> > > +                    : "=r" (val)
> > > +                    : "Qo" (*(const volatile u16 __force *)addr));
> > >         return val;
> > >  }
> > 
> > Semantically, I think the qualifier on the Qo constraint should be + as 
> > in "+Qo" listed in the input operand list in both cases since we may not 
> > assume anything about the memory location when it is referring to IO 
> > registers.  It is not because you write to it that previous writes can 
> > be optimized away, and it is not because you read from it that the 
> > accessed memory location will remain the same after the read.  Granted, 
> > the volatile should take care of that, but it doesn't hurt to be 
> > explicit.
> 
> Hmm, ok. I too would hope that the volatile keyword would sort that out but,
> since the '+' doesn't seem to change the generated code, I can add that. It
> does, however, mean we have to cast away the `const' in the read accessors
> which makes the code even uglier.

Nah... the const is wrong.  The way you wrote it means that addr may 
change but the pointed data is constant.  This is obviously wrong since 
we expect the pointed location to change even from a read.


Nicolas
