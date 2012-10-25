From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Oct 2012 12:17:05 +0100
Subject: Possible regression in arm/io.h
In-Reply-To: <1351148122.2507.63.camel@sauron.fi.intel.com>
References: <CABYn4syj0GZAsDYVQfXg_qKAFkbrxPLoZWpKRzwf3gfRkMGZkQ@mail.gmail.com>
 <20121024105223.GC23775@mudshark.cambridge.arm.com>
 <1351148122.2507.63.camel@sauron.fi.intel.com>
Message-ID: <20121025111705.GD11267@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 07:55:22AM +0100, Artem Bityutskiy wrote:
> On Wed, 2012-10-24 at 11:52 +0100, Will Deacon wrote:
> > 	(a) Understand what has changed in GCC to cause this error to start
> > 	    cropping up.
> 
> This is about already quite old gcc 4.6.3, which I use for about 4 last
> kernel releases already. So it is only the kernel that changed.

Looks like it's broken with gcc 4.7 too, so it might be that it's never
worked. The problem seems to be that offsettable addresses are assumed by
GCC to have a 12-bit immediate range, which isn't true for half- and double-
work accessors, so GAS barfs when presented with the final (invalid) code.

Since we don't have double-word I/O accessors, we can just fallback to "Q"
for the half-word case:


diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 35c1ed8..42f042e 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -64,7 +64,7 @@ extern void __raw_readsl(const void __iomem *addr, void *data, int longlen);
 static inline void __raw_writew(u16 val, volatile void __iomem *addr)
 {
        asm volatile("strh %1, %0"
-                    : "+Qo" (*(volatile u16 __force *)addr)
+                    : "+Q" (*(volatile u16 __force *)addr)
                     : "r" (val));
 }
 
@@ -72,7 +72,7 @@ static inline u16 __raw_readw(const volatile void __iomem *addr)
 {
        u16 val;
        asm volatile("ldrh %1, %0"
-                    : "+Qo" (*(volatile u16 __force *)addr),
+                    : "+Q" (*(volatile u16 __force *)addr),
                       "=r" (val));
        return val;
 }


but this has the downside of *always* generating the target address into a
register and then using the basic [rN] addressing mode. A simple example
being smsc911x_rx_readfifo, where we see:

  c021bbe4:       e1d230b2        ldrh    r3, [r2, #2]

changed into:

  c021bd50:       e2820002        add     r0, r2, #2
  c021bd54:       e1d030b0        ldrh    r3, [r0]

which sucks, frankly. Unfortunately, GCC doesn't give us another constraint
that we can use for this, so I think we just have to grin and bear it.

Will
