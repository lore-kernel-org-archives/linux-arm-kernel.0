From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Nov 2014 12:41:28 +0000
Subject: [PATCH v9 1/6] arm64: ptrace: add NT_ARM_SYSTEM_CALL regset
In-Reply-To: <1416977391-24231-2-git-send-email-takahiro.akashi@linaro.org>
References: <1416977391-24231-1-git-send-email-takahiro.akashi@linaro.org>
 <1416977391-24231-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20141126124128.GH14866@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On Wed, Nov 26, 2014 at 04:49:46AM +0000, AKASHI Takahiro wrote:
> This regeset is intended to be used to get and set a system call number
> while tracing.
> There was some discussion about possible approaches to do so:
> 
> (1) modify x8 register with ptrace(PTRACE_SETREGSET) indirectly,
>     and update regs->syscallno later on in syscall_trace_enter(), or
> (2) define a dedicated regset for this purpose as on s390, or
> (3) support ptrace(PTRACE_SET_SYSCALL) as on arch/arm
> 
> Thinking of the fact that user_pt_regs doesn't expose 'syscallno' to
> tracer as well as that secure_computing() expects a changed syscall number,
> especially case of -1, to be visible before this function returns in
> syscall_trace_enter(), (1) doesn't work well.
> We will take (2) since it looks much cleaner.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm64/kernel/ptrace.c |   35 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/elf.h   |    1 +
>  2 files changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 8a4ae8e..8b98781 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -551,6 +551,32 @@ static int tls_set(struct task_struct *target, const struct user_regset *regset,
>  	return ret;
>  }
>  
> +static int system_call_get(struct task_struct *target,
> +			   const struct user_regset *regset,
> +			   unsigned int pos, unsigned int count,
> +			   void *kbuf, void __user *ubuf)
> +{
> +	struct pt_regs *regs = task_pt_regs(target);
> +
> +	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +				   &regs->syscallno, 0, -1);

Does this work for big-endian machines? regs->syscallno is a u64, but the
regset defines it as an int. I think you need to copy to a temporary
register first.

Will
