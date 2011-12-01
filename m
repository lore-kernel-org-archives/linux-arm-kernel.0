From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Dec 2011 14:35:06 +0000
Subject: [V2 1/3] ARM: add support for the generic syscall.h interface
In-Reply-To: <1322664382-21793-2-git-send-email-stevenrwalter@gmail.com>
References: <1322664382-21793-1-git-send-email-stevenrwalter@gmail.com>
 <1322664382-21793-2-git-send-email-stevenrwalter@gmail.com>
Message-ID: <20111201143505.GD27656@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 02:46:20PM +0000, Steven Walter wrote:
> +static inline void syscall_get_arguments(struct task_struct *task,
> +					 struct pt_regs *regs,
> +					 unsigned int i, unsigned int n,
> +					 unsigned long *args)
> +{
> +	BUG_ON(i + n > 6);

So I guess 6 is the maximum number of registers that are used for syscall
passing. That sounds about right to me, but I wondered how you worked it out
(and whether or not it should be defined somewhere?).

In fact, how are these things supposed to deal with 64-bit arguments that
straddle two registers? I think we always pack arguments such that we don't
get holes in the register layout, but it might be worth checking (EABI
requires 64-bit arguments to be passed in even registers).

> +	if (i == 0) {
> +		args[0] = regs->ARM_ORIG_r0;
> +		args++;
> +		i++;
> +		n--;
> +	}
> +
> +	memcpy(args, &regs->ARM_r1 + (i - 1), n * sizeof(args[0]));

This might look nicer as &regs->ARM_r0 + i. args[0] could also be out of
range here, but I guess sizeof is ok with that.

> +
> +static inline void syscall_set_arguments(struct task_struct *task,
> +					 struct pt_regs *regs,
> +					 unsigned int i, unsigned int n,
> +					 const unsigned long *args)
> +{
> +	BUG_ON(i + n > 6);
> +	if (i == 0) {
> +		regs->ARM_ORIG_r0 = args[0];
> +		args++;
> +		i++;
> +		n--;
> +	}
> +
> +	memcpy(&regs->ARM_r1 + (i - 1), args, n * sizeof(args[0]));
> +}

Same comments here.

Will
