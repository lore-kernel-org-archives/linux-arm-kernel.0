From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Feb 2013 16:18:11 +0000
Subject: mx28evk does not boot with linux-next 20130207
In-Reply-To: <CAOMZO5D5ipAF0JOUOFezGz4Zr66M4bRm819ZurAfwPOrduBo5w@mail.gmail.com>
References: <CAOMZO5Ar1T3Lg2KRvSLK-gjNAaAFAf39f6KqaYeF03w5bNj6EQ@mail.gmail.com>
 <20130207125801.GA19091@S2101-09.ap.freescale.net>
 <CAOMZO5D5ipAF0JOUOFezGz4Zr66M4bRm819ZurAfwPOrduBo5w@mail.gmail.com>
Message-ID: <20130208161811.GW17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 04:04:58PM -0200, Fabio Estevam wrote:
> Yes, it fixes the build issue and now I get:

Hmm, interesting...

> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.8.0-rc6-next-20130207-dirty
> (fabio at fabio-Latitude-E6410) (gcc version 4.4.4 (4.4.4_09.06.2010) )
> #1062
> Thu Feb 7 16:00:51 BRST 2013
> [    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177

Ok, so this is an ARMv5 kernel.

> [    0.000000] CPU: 0    Not tainted  (3.8.0-rc6-next-20130207-dirty #1062)
> [    0.000000] PC is at paging_init+0x63c/0x6fc
> [    0.000000] LR is at paging_init+0x614/0x6fc
> [    0.000000] pc : [<c04fc48c>]    lr : [<c04fc464>]    psr: 600000d3
> [    0.000000] sp : c051df60  ip : 00100000  fp : 000000cf
> [    0.000000] r10: 0000000f  r9 : 000001cf  r8 : 00000009
> [    0.000000] r7 : c051df68  r6 : c0531f20  r5 : f5100000  r4 : 00000000
> [    0.000000] r3 : 20000001  r2 : f5200000  r1 : f5100000  r0 : c7ffdfa0
...
> [    0.000000] Code: 1affffd9 ee074f9a ee084f16 ee084f15 (ee074fd5)

And this is failing at:

   0:	1affffd9 	bne	0xffffff6c
   4:	ee074f9a 	mcr	15, 0, r4, cr7, cr10, {4}
   8:	ee084f16 	mcr	15, 0, r4, cr8, cr6, {0}
   c:	ee084f15 	mcr	15, 0, r4, cr8, cr5, {0}
  10:	ee074fd5 	mcr	15, 0, r4, cr7, cr5, {6}

which is local_flush_tlb_all().  The last instruction is the faulting
instruction - because ARM926 doesn't have it... and... that was introduced
by:

commit 5d9e3f9d7fcd7d09feb5d23974768a60bcea4094
Author: Will Deacon <will.deacon@arm.com>
Date:   Thu Jan 31 19:15:49 2013 +0100

    ARM: 7636/1: tlb: perform branch predictor maintenance for whole invalidation
    
    The ARM architecture requires explicit branch predictor maintenance
    when updating an instruction stream for a given virtual address. In
    reality, this isn't so much of a burden because the branch predictor
    is flushed during the cache maintenance required to make the new
    instructions visible to the I-side of the processor.
    
    One exception to this rule is when we flush the entire TLB for a CPU in
    response to something other than writing new instructions (for example,
    ASID rollover or switching to an identity mapping before disabling the
    MMU).
    
    This patch ensures that we flush the branch predictor as part of
    invalidating the entire TLB.
    
    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

And this patch looking at it now, is obviously wrong.  Will, can you
take a look please?

Also note - we used to do BTB maintanence, but I dropped it in this
commit after discussing it with folk in ARM:

commit 4348810a241a330d3d143d62d7c988ec8b2e6629
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Tue Jul 5 09:01:13 2011 +0100

    ARM: btc: avoid invalidating the branch target cache on kernel TLB maintanence
    
    Kernel space needs very little in the way of BTC maintanence as most
    mappings which are created and destroyed are non-executable, and so
    could never enter the instruction stream.
    
    The case which does warrant BTC maintanence is when a module is loaded.
    This creates a new executable mapping, but at that point the pages have
    not been initialized with code and data, so at that point they contain
    unpredictable information.  Invalidating the BTC at this stage serves
    little useful purpose.
    
    Before we execute module code, we call flush_icache_range(), which deals
    with the BTC maintanence requirements.  This ensures that we have a BTC
    maintanence operation before we execute code via the newly created
    mapping.
    
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

So, I think we can do away entirely with your patch.
