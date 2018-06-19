From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 15:21:25 +0100
Subject: [PATCHv3 08/19] arm64: convert raw syscall invocation to C
In-Reply-To: <20180618120310.39527-9-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-9-mark.rutland@arm.com>
Message-ID: <20180619142125.esqcbknxd2pqeotb@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:02:59PM +0100, Mark Rutland wrote:
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> new file mode 100644
> index 000000000000..b463b962d597
> --- /dev/null
> +++ b/arch/arm64/kernel/syscall.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/nospec.h>
> +#include <linux/ptrace.h>
> +
> +long do_ni_syscall(struct pt_regs *regs);
> +
> +typedef long (*syscall_fn_t)(unsigned long, unsigned long,
> +			     unsigned long, unsigned long,
> +			     unsigned long, unsigned long);
> +
> +static void __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
> +{
> +	regs->regs[0] = syscall_fn(regs->regs[0], regs->regs[1],
> +				   regs->regs[2], regs->regs[3],
> +				   regs->regs[4], regs->regs[5]);
> +}
> +
> +asmlinkage void invoke_syscall(struct pt_regs *regs, unsigned int scno,
> +			       unsigned int sc_nr,
> +			       syscall_fn_t syscall_table[])
> +{
> +	if (scno < sc_nr) {
> +		syscall_fn_t syscall_fn;
> +		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
> +		__invoke_syscall(regs, syscall_fn);
> +	} else {
> +		regs->regs[0] = do_ni_syscall(regs);
> +	}
> +}

While reviewing the subsequent patch, it crossed my mind that we no
longer have any callers to do_ni_syscall() outside this file. Can we not
more it here and have a similar implementation to __invoke_syscall() for
consistency, i.e. set regs->regs[0].

-- 
Catalin
