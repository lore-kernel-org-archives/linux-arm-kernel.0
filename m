From: jld@mozilla.com (Jed Davis)
Date: Fri, 19 Jul 2013 20:43:21 -0700
Subject: [PATCH] ARM: perf: Implement perf_arch_fetch_caller_regs
In-Reply-To: <20130715135342.GF10000@mudshark.cambridge.arm.com>
References: <1373685434-1581-1-git-send-email-jld@mozilla.com>
 <20130715135342.GF10000@mudshark.cambridge.arm.com>
Message-ID: <20130720034321.GB9433@mozilla.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 02:53:42PM +0100, Will Deacon wrote:
> On Sat, Jul 13, 2013 at 04:17:14AM +0100, Jed Davis wrote:
[...]
> > +#ifdef CONFIG_THUMB2_KERNEL
> > +#define perf_arch_fetch_caller_regs(regs, ip)				\
> > +	do {								\
> > +		__u32 _cpsr, _pc;					\
> > +		__asm__ __volatile__("str r7, [%[_regs], #(7 * 4)]\n\t" \
> > +				     "str r13, [%[_regs], #(13 * 4)]\n\t" \
> > +				     "str r14, [%[_regs], #(14 * 4)]\n\t" \
> 
> Is this safe? How can we be sure that the registers haven't been clobbered
> by the callee before this macro is expanded? For example, you can end up
> with the following code:

They might be clobbered, but if they are, then...

> 00000058 <perf_ftrace_function_call>:
>   58:   e92d 43f0       stmdb   sp!, {r4, r5, r6, r7, r8, r9, lr}
>   5c:   b09b            sub     sp, #108        ; 0x6c
>   5e:   ac08            add     r4, sp, #32
>   60:   4681            mov     r9, r0
>   62:   4688            mov     r8, r1
>   64:   4620            mov     r0, r4
>   66:   2148            movs    r1, #72 ; 0x48
>   68:   f7ff fffe       bl      0 <__memzero>
>   6c:   61e7            str     r7, [r4, #28]
>   6e:   f8c4 d034       str.w   sp, [r4, #52]   ; 0x34
>   72:   f8c4 e038       str.w   lr, [r4, #56]   ; 0x38
> 
> but the call to __memzero will have corrupted the lr.

...the function's unwinding entry will restore them from the stack, and
can't assume anything about their values before then.  It's the same
problem as if the code was interrupted by a profiler timer at that point
and we tried unwinding from the trap state.

Hopefully.  It's hard to be as rigorous as I'd like about this, because
the Exception Handling ABI was meant for exception handling, so as
specified it only needs to work at points where C++ exceptions can be
thrown, as I understand it.  Fortunately GCC isn't limited to that, but
there are more issues, because -fasynchronous-unwind-tables doesn't
actually make things work from *any* instruction as documented (which is
not entirely bad, because working correctly would significantly increase
the size of .extab/.exidx).

All that said, the unwinding program for a function should work at any
point after the prologue and before the epilogue.

> > +				     "mov %[_pc],  r15\n\t"		\
> > +				     "mrs %[_cpsr], cpsr\n\t"		\
> > +				     : [_cpsr] "=r" (_cpsr),		\
> > +				       [_pc] "=r" (_pc)			\
> > +				     : [_regs] "r" (&(regs)->uregs)	\
> 
> It would be cleaner to pass a separate argument for each register, using the
> ARM_rN macros rather than calculating the offset by hand.

I'll do that.  If there were more arguments there might be a problem
at -O0, because the naive translation can run out of registers in
some cases, but that shouldn't be a problem here.  (Nor if someone
later extends this to all the core registers, because {r0-r13} can and
presumably should use a store-multiple.)

Thanks for the quick review, and sorry for the delay in responding.

--Jed
