From: will.deacon@arm.com (Will Deacon)
Date: Tue, 01 Mar 2011 13:54:05 +0000
Subject: [PATCH 2/4] msm: scm: Fix improper register assignment
In-Reply-To: <alpine.LFD.2.00.1102261452340.22034@xanadu.home>
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
	<1298573085-23217-3-git-send-email-sboyd@codeaurora.org>
	<1298640219.958.74.camel@e102144-lin.cambridge.arm.com>
	<4D688AF1.1090607@codeaurora.org>
	<20110226084736.GB3640@n2100.arm.linux.org.uk>
	<8yazkpi3cfa.fsf@huya.qualcomm.com>
	<alpine.LFD.2.00.1102261452340.22034@xanadu.home>
Message-ID: <1298987645.8741.172.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

On Sat, 2011-02-26 at 20:04 +0000, Nicolas Pitre wrote:
> Right.  A minimal test case may look like this if someone feels like
> filling a gcc bug report:
> 
> extern int foo(int x);
> 
> int bar(int x)
> {
>         register int a asm("r0") = 1;
>         x = foo(x);
>         asm ("add %0, %1, %2" : "=r" (x) : "r" (a), "r" (x));
>         return x;
> }
> 
> And the produced code is:
> 
> bar:
>         stmfd   sp!, {r3, lr}
>         bl      foo
> #APP
>         add r0, r0, r0
>         ldmfd   sp!, {r3, pc}
> 
> So this is clearly bogus.


I've had a chat with the compiler guys and they confirmed that this is a
known bug. There's a really hairy bug report here:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=38815

It looks like the GCC stance will change in the future so that register
variables will only be guaranteed to live in the specified register
during asm blocks which use them. If the register is required elsewhere,
spill/reload code will be emitted as necessary. This might break some
weird and wonderful code (passing hidden operands to functions?) but I
don't think we rely on the current behaviour anywhere in the kernel.

Will
