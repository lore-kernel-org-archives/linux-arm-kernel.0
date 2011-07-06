From: tixy@yxit.co.uk (Tixy)
Date: Wed, 06 Jul 2011 10:08:20 +0100
Subject: [PATCH] ARM: poison initmem when it is freed
In-Reply-To: <alpine.LFD.2.00.1107051540550.14596@xanadu.home>
References: <20110705184254.GH8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107051509490.14596@xanadu.home>
	<20110705192656.GJ8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107051540550.14596@xanadu.home>
Message-ID: <1309943300.2279.9.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-07-05 at 15:48 -0400, Nicolas Pitre wrote:
> On Tue, 5 Jul 2011, Russell King - ARM Linux wrote:
> > Have you tried to find a byte-based poison value which would fault
> > yet still cause a pointer dereference?  You're limited to 0xeN on
> > ARM, of which there's almost nothing to chose from:
> > 
> >    0:   e0e0e0e0        rsc     lr, r0, r0, ror #1
> >    4:   e1e1e1e1        mvn     lr, r1, ror #3
> >    8:   e2e2e2e2        rsc     lr, r2, #536870926      ; 0x2000000e
> >    c:   e3e3e3e3        mvn     lr, #-1946157053        ; 0x8c000003
> >   10:   e4e4e4e4        strbt   lr, [r4], #1252
> >   14:   e5e5e5e5        strb    lr, [r5, #1509]!
> >   18:   e6e6e6e6        strbt   lr, [r6], r6, ror #13
> >   1c:   e7e7e7e7        strb    lr, [r7, r7, ror #15]!
> >   20:   e8e8e8e8        stmia   r8!, {r3, r5, r6, r7, fp, sp, lr, pc}^
> >   24:   e9e9e9e9        stmib   r9!, {r0, r3, r5, r6, r7, r8, fp, sp, lr, pc}^
> >   28:   eaeaeaea        b       0xffababd8
> >   2c:   ebebebeb        bl      0xffafafe0
> >   30:   ecececec        stcl    12, cr14, [ip], #944
> >   34:   edededed        stcl    13, cr14, [sp, #948]!
> >   38:   eeeeeeee        cdp     14, 14, cr14, cr14, cr14, {7}
> >   3c:   efefefef        svc     0x00efefef
> > 
> > 0xefefefef looks to be about the best alternative.
> 
> Right.  Does it have to be a byte?  Having a word (or half-word if 
> Thumb2) would be much more convenient.

For Thumb, 0xde?? is Permanently UNDEFINED, so we could have 0xdede for
a single byte pattern or an even more descriptive 0xdead if we don't
have that restriction.

-- 
Tixy
