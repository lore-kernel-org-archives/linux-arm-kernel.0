From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2009 10:55:16 +0100
Subject: [PATCH] ARM: add warning for invalid kernel page faults
In-Reply-To: <1254131304-32057-1-git-send-email-imre.deak@nokia.com>
References: <20090928092919.GA30271@localhost>
	<1254131304-32057-1-git-send-email-imre.deak@nokia.com>
Message-ID: <20090928095516.GB6715@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 12:48:24PM +0300, Imre Deak wrote:
> To easier detect code that can trigger the above error, add a check
> also for the case where mmap_sem is acquired. As this has an overhead
> make it a VM debug warning.

It _is_ already easy.  I'm not sure why you want even more noise, and
why you want to break the page fault handling.  From the warning you
received in your previous post, it said:

[   92.422729] PC is at v7_coherent_kern_range+0x18/0x44
[   92.427825] LR is at arm_syscall+0x1c4/0x2b0
...
[   92.588867] [<c0030528>] (arm_syscall+0x0/0x2b0) from [<c002c940>] (ret_fast_syscall+0x0/0x2c)
[   92.597625]  r6:00000001 r5:bea99ef4 r4:00000000
[   92.602294] Code: e3a02010 e1a02312 e2423001 e1c00003 (ee070f3b)

which is quite clear - the fault happened in v7_coherent_kern_range()
and the code line disassembles to:

   0:   e3a02010        mov     r2, #16 ; 0x10
   4:   e1a02312        lsl     r2, r2, r3
   8:   e2423001        sub     r3, r2, #1      ; 0x1
   c:   e1c00003        bic     r0, r0, r3
  10:   ee070f3b        mcr     15, 0, r0, cr7, cr11, {1}

If we look up v7_coherent_kern_range(), we find:

ENTRY(v7_coherent_user_range)
        dcache_line_size r2, r3
        sub     r3, r2, #1
        bic     r0, r0, r3
1:      mcr     p15, 0, r0, c7, c11, 1          @ clean D line to the point of unification
        dsb

So we know which bit of kernel code caused the problem.

If we want to know what address, there is one simple, and one slightly
more complicated way to find out:

[   92.347442] Unable to handle kernel paging request at virtual address 00012000

The above line is the simple way.  The slightly more complicated way is
by looking at the above code, realising that 'r0' is the address which
was being cleaned, and then looking it up in the register dump:

[   92.432159] pc : [<c0033b88>]    lr : [<c00306ec>]    psr: 80000053
[   92.432159] sp : cf2a3e80  ip : cf1de0b0  fp : cf2a3fa4
[   92.443725] r10: 40024000  r9 : cf2a2000  r8 : 00000000
[   92.449005] r7 : 000f0002  r6 : 00000000  r5 : 00012fff  r4 : 00012000
[   92.455596] r3 : 0000003f  r2 : 00000040  r1 : 00013000  r0 : 00012000

I'm not sure what other information you would want.

And we _certainly_ do not want to allow the thread to continue if we
encounter an unexpected kernel page fault.  Jumping to no_context is
definitely the right thing to do.
