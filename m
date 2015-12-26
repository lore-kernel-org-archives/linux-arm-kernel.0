From: huawei.libin@huawei.com (Li Bin)
Date: Sat, 26 Dec 2015 17:28:07 +0800
Subject: [RFC] arm64: ftrace with regs for livepatch support
In-Reply-To: <564F0846.5000001@linaro.org>
References: <564F0846.5000001@linaro.org>
Message-ID: <567E5DA7.70904@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



on 2015/11/20 19:47, AKASHI Takahiro wrote:
> In this RFC, I'd like to describe and discuss some issues on adding ftrace/
> livepatch support on arm64 before actually submitting patches. In fact,
> porting livepatch is not a complicated task, but adding "ftrace with
> regs(CONFIG_DYNAMIC_FTRACE_WITH_REGS)" which livepatch heavily relies on
> is a matter.
> (There is another discussion about "arch-independent livepatch" in LKML.)
>
> Under "ftrace with regs", a ftrace helper function (ftrace_regs_caller)
> will be called with cpu registers (struct pt_regs_t) at the beginning of
> a function if tracing is enabled on the function. Livepatch utilizes this
> argument to replace PC and jump back into a new (patched) function.
> (Please note that this feature will also be used for ftrace-based kprobes.)
>
> On arm64, there is no template for a function prologue, and "instruction
> scheduling" may mix it with a function body. So a helper function, which
> is inserted by gcc's "-pg" option, cannot (at least potentially) recognize
> correct values of registers because some may have already been overwritten
> at that point.
>
> Instead, X86 uses gcc's "-mfentry" option, which inserts "call _mcount" as
> the first instruction of a function, to implement "ftrace with regs".
> As this option is arch-specific, after discussions with toolchain folks,
> we are proposing a new arch-neutral option, "-fprolog-pad=N"[1].
> This option inserts N nop instructions before a function prologue so that
> any architecture can utilize it to replace nops with whatever instruction
> sequence they want later on when required.
> (I assume that nop is very cheap in terms of performance impact.)
>
> First, let me explain how we can implement "ftrace with regs", or more
> specifically, ftrace_make_call() and ftrace_make_nop() as well as how
> inserted instruction sequences look like. Implementing ftrace_regs_caller
> is quite straightforward, we don't have to care (at least, in this RFC).
>
> 1) instruction sequence
> Unlike x86, we have to preserve link register(x30) explicitly on arm64 since
> a ftrace help function will be invoked before a function prologue. so we
> need a few, not one, instructions here. Two possible ways:
>
>  (a) stp x29, x30, [sp, #-16]!
>      mov x29, sp
>      bl <mcount>
>      ldp x29, x30, [sp], #16
>      <function prologue>
>      ...
>
>  (b) mov x9, x30
>      bl <mcount>
>      mov x30, x9
>      <function prologue>
>      ...
>
> (a) complies with a normal calling convention.
> (b) is Li Bin's idea in his old patch. While (b) can save some memory
> accesses by using a scratch register(x9 in this example), we have no way
> to recover an actual value for this register.
>
>       Q#1. Which approach should we take here?
>
>
> 2) replacing an instruction sequence
>    (This issue is orthogonal to Q#1.)
>
> Replacing can happen anytime, so we have to do it (without any locking) in
> such a safe way that any task either calls a helper or doesn't call it, but
> never runs in any intermediate state.
>
> Again here, two possible ways:
>
>   (a) initialize the code in the shape of (A') at boot time,
>             (B) -> (B') -> (A')
>       then switching to (A) or (A')
>   (b) take a few steps each time. For example,
>       to enable tracing,
>             (B) -> (B') -> (A') -> (A)
>       to disable tracing,
>             (A) -> (A') -> (B') -> (A)
>       Obviously, we need cache flushing/invalidation and barriers between.
>
>     (A)                                (A')
>         stp x29, x30, [sp, #-16]!           b 1f
>         mov x29, sp                         mov x29, sp
>         bl <_mcount>                        bl <_mcount>
>         ldp x29, x30, [sp], #16             ld x29, x30, [sp], #16
>                                          1:
>         <function prologue>
>         <function body>
>         ...
>
>     (B)                                (B')
>         nop                                 b 1f
>         nop                                 nop
>         nop                                 nop
>         nop                                 nop
>                                          1:
>         <function prologue>
>         <function body>
>         ...
>

Hi takahiro,
This method can not guarantee the correctness of replacing the multi instrucions
from  (A') to (B') or from (B') to (A'), even if under kstop_machine especially for
preemptable kernel or NMI context (which will be supported on arm64 in future).
Right?

Thanks,
Li Bin

> (a) is much simpler, but (b) has less performance penalty(?) when tracing
> is disabled. I'm afraid that I might simplify the issue too much.
>
>        Q#2. Which one is more preferable?
>
>
> [1] https://gcc.gnu.org/ml/gcc/2015-05/msg00267.html, and
>     https://gcc.gnu.org/ml/gcc/2015-10/msg00090.html
>
>
> Thanks,
> -Takahiro AKASHI
>
> .
>
