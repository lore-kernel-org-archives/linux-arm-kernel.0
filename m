From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 4 Jun 2011 00:53:02 +0100
Subject: using identity_mapping_add & switching MMU state - how ?
In-Reply-To: <alpine.DEB.2.00.1106030834240.2311@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106021621400.2311@localhost6.localdomain6>
	<20110602201611.GA10532@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106030834240.2311@localhost6.localdomain6>
Message-ID: <20110603235302.GA26822@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2011 at 11:44:02AM +0100, Frank Hofmann wrote:
> On Thu, 2 Jun 2011, Russell King - ARM Linux wrote:
>> But... it requires the v:p offset in r1, and the _virtual_ address of
>> the code to continue at in lr.  These are specifically saved for it by
>> cpu_suspend in arch/arm/kernel/sleep.S.
>
> I've read that - that's why the hibernation resume path has been written  
> this way. I'm trying to create the conditions necessary, i.e. set up  
> r0/r1/lr _and_ the MMU state in such a way that it's callable unmodified.

I think you missed my point.  Go back and look at this bit of your code,
and indentify what _exactly_ is in r1 at the point cpu_do_resume is
called.  I'll give you a hint - it's not the v:p offset as required.

        ldr     r2, =cpu_do_resume
        sub     r2, r1                  @ __pa()
        ldr     r3, =.Lmmu_is_off
        sub     r3, r1                  @ __pa()
        sub     r0, r1                  @ __pa()
        ldr     lr, =.Lpost_mmu
        mrc     p15, 0, r1, c1, c0, 0
        bic     r1, #CR_M
        mcr     p15, 0, r1, c1, c0, 0   @ MMU OFF

        mrc     p15, 0, r1, c2, c0, 0   @ queue a dependency on CP15
        sub     pc, r3, r1, lsr #32     @ to local label, phys addr
.ltorg
.align 5
.Lmmu_is_off:
        mov     pc, r2                  @ jump to phys cpu_v6_do_resume
