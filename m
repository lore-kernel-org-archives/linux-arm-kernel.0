From: ldv@altlinux.org (Dmitry V. Levin)
Date: Wed, 14 Mar 2018 02:58:50 +0300
Subject: ARM: Call syscall_trace_exit even when system call skipped
In-Reply-To: <20180203152112.2449-1-T.E.Baldwin99@members.leeds.ac.uk>
References: <20180203152112.2449-1-T.E.Baldwin99@members.leeds.ac.uk>
Message-ID: <20180313235850.GA18373@altlinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kees,

As you probably know, ptracing of processes affected by SECCOMP_RET_TRAP
is broken on ARM since your commit v3.7-rc1-11-gad75b51459ae.

Could you review the proposed fix, please?

P.S. There is a test for this kernel bug in strace test suite,
you might find it useful:
https://github.com/strace/strace/compare/ldv/SECCOMP_RET_TRAP

On Sat, Feb 03, 2018 at 03:21:12PM +0000, Timothy E Baldwin wrote:
> On at least x86 and ARM64, and as documented in the ptrace man page
> a skipped system call will still cause a syscall exit ptrace stop.
> 
> Previous to this commit 32-bit ARM did not, resulting in strace
> being confused when seccomp skips system calls.
> 
> This change also impacts programs that use ptrace to skip system calls.
> 
> Fixes: ad75b51459ae ("ARM: 7579/1: arch/allow a scno of -1 to not cause a SIGILL")
> Signed-off-by: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
> ---
>  arch/arm/kernel/entry-common.S | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 99c908226065..88a65157307d 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -288,16 +288,15 @@ __sys_trace:
>  	cmp	scno, #-1			@ skip the syscall?
>  	bne	2b
>  	add	sp, sp, #S_OFF			@ restore stack
> -	b	ret_slow_syscall
>  
> -__sys_trace_return:
> -	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
> +__sys_trace_return_nosave:
> +	enable_irq_notrace
>  	mov	r0, sp
>  	bl	syscall_trace_exit
>  	b	ret_slow_syscall
>  
> -__sys_trace_return_nosave:
> -	enable_irq_notrace
> +__sys_trace_return:
> +	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
>  	mov	r0, sp
>  	bl	syscall_trace_exit
>  	b	ret_slow_syscall

-- 
ldv
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180314/f540b10f/attachment.sig>
