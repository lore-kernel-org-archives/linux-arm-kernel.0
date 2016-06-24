From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jun 2016 17:25:44 +0100
Subject: [PATCH 6/6] arm64: trap userspace "dc cvau" cache operation on
 errata-affected core
In-Reply-To: <1462812590-4494-7-git-send-email-andre.przywara@arm.com>
References: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
 <1462812590-4494-7-git-send-email-andre.przywara@arm.com>
Message-ID: <20160624162544.GG22608@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 05:49:50PM +0100, Andre Przywara wrote:
> +#define __user_cache_maint(insn, address, res)			\
> +	asm volatile (						\
> +		"1:	" insn ", %1\n"				\
> +		"	mov	%w0, #0\n"			\
> +		"2:\n"						\
> +		"	.pushsection .fixup,\"ax\"\n"		\
> +		"	.align	2\n"				\
> +		"3:	mov	%w0, %w2\n"			\
> +		"	b	2b\n"				\
> +		"	.popsection\n"				\
> +		_ASM_EXTABLE(1b, 3b)				\
> +		: "=r" (res)					\
> +		: "r" (address), "i" (-EFAULT)			\
> +		: "memory")

I don't think we need the "memory" clobber here. It's not really
accessing memory that the compiler controls.

> +asmlinkage void __exception do_sysinstr(unsigned int esr, struct pt_regs *regs)
> +{
> +	unsigned long address;
> +	int ret;
> +
> +	/* if this is a write with: Op0=1, Op2=1, Op1=3, CRn=7 */
> +	if ((esr & 0x01fffc01) == 0x0012dc00) {
> +		int rt = (esr >> 5) & 0x1f;
> +		int crm = (esr >> 1) & 0x0f;
> +
> +		address = regs->regs[rt];
> +
> +		switch (crm) {
> +		case 11:		/* DC CVAU, gets promoted */
> +			__user_cache_maint("dc civac", address, ret);
> +			break;
> +		case 10:		/* DC CVAC, gets promoted */
> +			__user_cache_maint("dc civac", address, ret);
> +			break;
> +		case 14:		/* DC CIVAC */
> +			__user_cache_maint("dc civac", address, ret);
> +			break;
> +		case 5:			/* IC IVAU */
> +			__user_cache_maint("ic ivau", address, ret);
> +			break;
> +		default:
> +			force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
> +			return;
> +		}
> +	} else {
> +		force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
> +		return;
> +	}
> +
> +	if (ret) {
> +		int sig_code;
> +
> +		down_read(&current->mm->mmap_sem);
> +		if (find_vma(current->mm, address) == NULL)
> +			sig_code = SEGV_MAPERR;
> +		else
> +			sig_code = SEGV_ACCERR;
> +		up_read(&current->mm->mmap_sem);
> +
> +		force_signal_inject(SIGSEGV, sig_code, regs, address);

BTW, there is some duplication with set_segfault() in
armv8_deprecated.c, could you make this a common function in trap.c?

-- 
Catalin
