From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Mar 2011 10:42:38 -0000
Subject: [PATCH 1/2] ARM: fix compiling error due to debug_info change
In-Reply-To: <1299493870-8217-1-git-send-email-bryan.wu@canonical.com>
References: <1299493870-8217-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <000801cbdcb4$612bde40$23839ac0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

> Subject: [PATCH 1/2] ARM: fix compiling error due to debug_info change

Is there a patch 2/2 as well? (I only received this one).
 
> This bug was introduced by "ARM: 6668/1: ptrace: remove single-step emulation code" from Will Deacon
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
>  arch/arm/include/asm/a.out-core.h |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/a.out-core.h b/arch/arm/include/asm/a.out-core.h
> index 93d04ac..639f5c8 100644
> --- a/arch/arm/include/asm/a.out-core.h
> +++ b/arch/arm/include/asm/a.out-core.h
> @@ -32,12 +32,6 @@ static inline void aout_dump_thread(struct pt_regs *regs, struct user *dump)
>  	dump->u_dsize = (tsk->mm->brk - tsk->mm->start_data + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	dump->u_ssize = 0;
> 
> -	dump->u_debugreg[0] = tsk->thread.debug.bp[0].address;
> -	dump->u_debugreg[1] = tsk->thread.debug.bp[1].address;
> -	dump->u_debugreg[2] = tsk->thread.debug.bp[0].insn.arm;
> -	dump->u_debugreg[3] = tsk->thread.debug.bp[1].insn.arm;
> -	dump->u_debugreg[4] = tsk->thread.debug.nsaved;
> -
>  	if (dump->start_stack < 0x04000000)
>  		dump->u_ssize = (0x04000000 - dump->start_stack) >> PAGE_SHIFT;

Damn, looks like I forgot to update this code. I think it might be better
to memset zero the u_debugreg array rather than ignore the assignment and
also add a comment to struct user to explain that thie field is no longer
used.

Will
