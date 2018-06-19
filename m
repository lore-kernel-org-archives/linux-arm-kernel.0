From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jun 2018 15:48:45 +0100
Subject: [PATCHv3 08/19] arm64: convert raw syscall invocation to C
In-Reply-To: <20180619142125.esqcbknxd2pqeotb@localhost>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-9-mark.rutland@arm.com>
 <20180619142125.esqcbknxd2pqeotb@localhost>
Message-ID: <20180619144845.22mgd4req5cnp5tv@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 03:21:25PM +0100, Catalin Marinas wrote:
> On Mon, Jun 18, 2018 at 01:02:59PM +0100, Mark Rutland wrote:
> > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > new file mode 100644
> > index 000000000000..b463b962d597
> > --- /dev/null
> > +++ b/arch/arm64/kernel/syscall.c
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/nospec.h>
> > +#include <linux/ptrace.h>
> > +
> > +long do_ni_syscall(struct pt_regs *regs);
> > +
> > +typedef long (*syscall_fn_t)(unsigned long, unsigned long,
> > +			     unsigned long, unsigned long,
> > +			     unsigned long, unsigned long);
> > +
> > +static void __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
> > +{
> > +	regs->regs[0] = syscall_fn(regs->regs[0], regs->regs[1],
> > +				   regs->regs[2], regs->regs[3],
> > +				   regs->regs[4], regs->regs[5]);
> > +}
> > +
> > +asmlinkage void invoke_syscall(struct pt_regs *regs, unsigned int scno,
> > +			       unsigned int sc_nr,
> > +			       syscall_fn_t syscall_table[])
> > +{
> > +	if (scno < sc_nr) {
> > +		syscall_fn_t syscall_fn;
> > +		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
> > +		__invoke_syscall(regs, syscall_fn);
> > +	} else {
> > +		regs->regs[0] = do_ni_syscall(regs);
> > +	}
> > +}
> 
> While reviewing the subsequent patch, it crossed my mind that we no
> longer have any callers to do_ni_syscall() outside this file. Can we not
> more it here and have a similar implementation to __invoke_syscall() for
> consistency, i.e. set regs->regs[0].

I think so, though it complicates the logic in do_ni_syscall(), since
there are two places we may return a value.

Would you be happy if instead I made __invoke_syscall() return the
result, and have invoke_syscall() place the result in regs->regs[0] in
either case, e.g. as below?

Thanks,
Mark.

---->8----
// SPDX-License-Identifier: GPL-2.0

#include <linux/errno.h>
#include <linux/nospec.h>
#include <linux/ptrace.h>
#include <linux/syscalls.h>

#include <asm/compat.h>

long compat_arm_syscall(struct pt_regs *regs);

static long do_ni_syscall(struct pt_regs *regs)
{
#ifdef CONFIG_COMPAT
	long ret;
	if (is_compat_task()) {
		ret = compat_arm_syscall(regs);
		if (ret != -ENOSYS)
			return ret;
	}
#endif

	return sys_ni_syscall();
}

typedef long (*syscall_fn_t)(unsigned long, unsigned long,
			     unsigned long, unsigned long,
			     unsigned long, unsigned long);

static long __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
{
	return syscall_fn(regs->regs[0], regs->regs[1], regs->regs[2],
			  regs->regs[3], regs->regs[4], regs->regs[5]);
}

asmlinkage void invoke_syscall(struct pt_regs *regs, unsigned int scno,
			       unsigned int sc_nr,
			       syscall_fn_t syscall_table[])
{
	long ret;

	if (scno < sc_nr) {
		syscall_fn_t syscall_fn;
		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
		ret = __invoke_syscall(regs, syscall_fn);
	} else {
		ret = do_ni_syscall(regs);
	}

	regs->regs[0] = ret;
}
