From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Aug 2012 15:49:28 +0100
Subject: [PATCH] ARM: io: avoid writeback addressing modes for __raw_
 accessors
In-Reply-To: <alpine.LFD.2.02.1208200902120.1754@xanadu.home>
References: <1344956366-32574-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1208161906390.1541@xanadu.home>
 <20120820124109.GK25864@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1208200902120.1754@xanadu.home>
Message-ID: <20120820144927.GP25864@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 02:29:31PM +0100, Nicolas Pitre wrote:
> On Mon, 20 Aug 2012, Will Deacon wrote:
> > Translates the following code from amba_device_add:
> > 
> > 		for (pid = 0, i = 0; i < 4; i++)
> > 			pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) <<
> > 				(i * 8);
> > 		for (cid = 0, i = 0; i < 4; i++)
> > 			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
> > 				(i * 8);
> > 
> > into:
> [...]
> 
> OK, I can see how the compiler will fold the loop increment into the IO 
> access instruction.  But my point is: is this common?  And when this 
> happens, is this a critical path?

Sure, this case isn't such a big deal (basically just boot-time probing) but
GCC could still generate this stuff in a driver, where it could end up being
an I/O bottleneck for a guest OS.

> > whilst the addressing modes are still nice, the dsb is going to be the
> > performance limitation here. That said, we could try the "Qo" constraints,
> > which I seem to remember don't generate writebacks. I'll have a play.
> 
> OK.  That would be excellent.

Looks like we have a winner (diff against the original patch below). I now
see:

00000340 <hw_init>:
 340:   e1a03000        mov     r3, r0
 344:   e3a00000        mov     r0, #0
 348:   e5830010        str     r0, [r3, #16]
 34c:   e3e02000        mvn     r2, #0
 350:   e5832014        str     r2, [r3, #20]
 354:   e5932018        ldr     r2, [r3, #24]
 358:   e38220ff        orr     r2, r2, #255    ; 0xff
 35c:   e5832030        str     r2, [r3, #48]   ; 0x30
 360:   e12fff1e        bx      lr

with the new code, which is basically the same as the old code but the mvn and
a str have switched places. The same difference occurs when targetting Thumb2.

> > To deal with this, the hypervisor will likely have to stop the virtual world
> > when emulating any MMIO accesses that report incomplete fault information to
> > avoid racing with a TLB invalidation from another virtual CPU. That will
> > certainly be more expensive than an additional instruction on each access.
> 
> I totally agree with you here.
> 
> However, for completeness and above all for security reasons, the 
> hypervisor will _ahve_ to support that case anyway.

Support it, yes, but perhaps not efficiently.

> So it is now a matter of compromise between performance and code size.  
> If the pathological case you brought up above is the exception and not 
> the rule then I think that we can live with the performance impact in 
> that case and keep the optimal pre-indexed addressing for the common 
> cases.

It looks like the new code does exactly what we want, so I think we could
actually have the best of both worlds: pre-index addressing and no
writeback.

Will

--- >8

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index b54d687..bbc94c2 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -63,38 +63,50 @@ extern void __raw_readsl(const void __iomem *addr, void *data, int longlen);
  */
 static inline void __raw_writew(u16 val, volatile void __iomem *addr)
 {
-       asm volatile("strh %0, [%1]" : : "r" (val), "r" (addr));
+       asm volatile("strh %1, %0"
+                    : "=Qo" (*(volatile u16 __force *)addr)
+                    : "r" (val));
 }
 
 static inline u16 __raw_readw(const volatile void __iomem *addr)
 {
        u16 val;
-       asm volatile("ldrh %0, [%1]" : "=r" (val) : "r" (addr));
+       asm volatile("ldrh %0, %1"
+                    : "=r" (val)
+                    : "Qo" (*(const volatile u16 __force *)addr));
        return val;
 }
 #endif
 
 static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
 {
-       asm volatile("strb %0, [%1]" : : "r" (val), "r" (addr));
+       asm volatile("strb %1, %0"
+                    : "=Qo" (*(volatile u8 __force *)addr)
+                    : "r" (val));
 }
 
 static inline void __raw_writel(u32 val, volatile void __iomem *addr)
 {
-       asm volatile("str %0, [%1]" : : "r" (val), "r" (addr));
+       asm volatile("str %1, %0"
+                    : "=Qo" (*(volatile u32 __force *)addr)
+                    : "r" (val));
 }
 
 static inline u8 __raw_readb(const volatile void __iomem *addr)
 {
        u8 val;
-       asm volatile("ldrb %0, [%1]" : "=r" (val) : "r" (addr));
+       asm volatile("ldrb %0, %1"
+                    : "=r" (val)
+                    : "Qo" (*(const volatile u8 __force *)addr));
        return val;
 }
 
 static inline u32 __raw_readl(const volatile void __iomem *addr)
 {
        u32 val;
-       asm volatile("ldr %0, [%1]" : "=r" (val) : "r" (addr));
+       asm volatile("ldr %0, %1"
+                    : "=r" (val)
+                    : "Qo" (*(const volatile u32 __force *)addr));
        return val;
 }
