From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Jul 2011 20:45:24 -0400 (EDT)
Subject: [PATCH 37/51] ARM: kprobes: Optimise emulation of LDM and STM
In-Reply-To: <1310209058-20980-38-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
	<1310209058-20980-38-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1107112037190.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 9 Jul 2011, Tixy wrote:

> From: Jon Medhurst <tixy@yxit.co.uk>
> 
> This patch improves the performance of LDM and STM instruction
> emulation. This is desirable because.
> 
> - jprobes and kretprobes probe the first instruction in a function and,
>   when the frame pointer is omitted, this instruction is often a STM
>   used to push registers onto the stack.
> 
> - The STM and LDM instructions are common in the body and tail of
>   functions.
> 
> - At the same time as being a common instruction form, they also have
>   one of the slowest and most complicated simulation routines.
> 
> The approach taken to optimisation is to use simulation rather than
> emulation,

Isn't it the other way around i.e. emulation rather than simulation?

> +static void __kprobes
> +emulate_generic_r2_14_noflags(struct kprobe *p, struct pt_regs *regs)
> +{
> +	emulate_generic_r0_12_noflags(p, (struct pt_regs *)(regs->uregs+2));
> +}
> +
> +static void __kprobes
> +emulate_ldm_r3_15(struct kprobe *p, struct pt_regs *regs)
> +{
> +	emulate_generic_r0_12_noflags(p, (struct pt_regs *)(regs->uregs+3));
> +	load_write_pc(regs->ARM_pc, regs);
> +}

Pretty sneaky!  :-)

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


Nicolas
