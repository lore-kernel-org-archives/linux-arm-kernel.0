From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 05 Jul 2011 15:48:06 -0400 (EDT)
Subject: [PATCH] ARM: poison initmem when it is freed
In-Reply-To: <20110705192656.GJ8286@n2100.arm.linux.org.uk>
References: <20110705184254.GH8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107051509490.14596@xanadu.home>
	<20110705192656.GJ8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107051540550.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Jul 2011, Russell King - ARM Linux wrote:

> On Tue, Jul 05, 2011 at 03:17:33PM -0400, Nicolas Pitre wrote:
> > On Tue, 5 Jul 2011, Russell King - ARM Linux wrote:
> > 
> > > When the initmem is freed, we can no longer rely on its contents.  In
> > > lightly loaded systems, this memory may persist for some time, making
> > > it harder discover run-time issues (caused by the build warnings being
> > > ignored.)
> > > 
> > > Poison the initmem at the point where it is freed to encourage run-time
> > > problems when initmem is dereferenced as an aid to finding such problems.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > The default poison doesn't appear to be a judicious choice for ARM.
> > 
> > include/linux/poison.h:#define POISON_FREE_INITMEM      0xcc
> > 
> >    0:   cccccccc        stclgt  12, cr12, [ip], {204}   ; 0xcc
> > 
> > So if the gt condition is false this will execute nops until it falls 
> > out of the initmem section.  Would be nicer if a fault could be 
> > generated right at the accessed address which could be looked up.
> 
> Have you tried to find a byte-based poison value which would fault
> yet still cause a pointer dereference?  You're limited to 0xeN on
> ARM, of which there's almost nothing to chose from:
> 
>    0:   e0e0e0e0        rsc     lr, r0, r0, ror #1
>    4:   e1e1e1e1        mvn     lr, r1, ror #3
>    8:   e2e2e2e2        rsc     lr, r2, #536870926      ; 0x2000000e
>    c:   e3e3e3e3        mvn     lr, #-1946157053        ; 0x8c000003
>   10:   e4e4e4e4        strbt   lr, [r4], #1252
>   14:   e5e5e5e5        strb    lr, [r5, #1509]!
>   18:   e6e6e6e6        strbt   lr, [r6], r6, ror #13
>   1c:   e7e7e7e7        strb    lr, [r7, r7, ror #15]!
>   20:   e8e8e8e8        stmia   r8!, {r3, r5, r6, r7, fp, sp, lr, pc}^
>   24:   e9e9e9e9        stmib   r9!, {r0, r3, r5, r6, r7, r8, fp, sp, lr, pc}^
>   28:   eaeaeaea        b       0xffababd8
>   2c:   ebebebeb        bl      0xffafafe0
>   30:   ecececec        stcl    12, cr14, [ip], #944
>   34:   edededed        stcl    13, cr14, [sp, #948]!
>   38:   eeeeeeee        cdp     14, 14, cr14, cr14, cr14, {7}
>   3c:   efefefef        svc     0x00efefef
> 
> 0xefefefef looks to be about the best alternative.

Right.  Does it have to be a byte?  Having a word (or half-word if 
Thumb2) would be much more convenient.

> It then brings up whether POISON_FREE_INITMEM should be changed or not,
> as 0xcc is the expected value for this at the moment.

I would think that this should be a per architecture value to actually 
be useful.


Nicolas
