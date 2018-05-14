From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Mon, 14 May 2018 20:00:29 +0200
Subject: [PATCH 08/18] arm64: convert raw syscall invocation to C
In-Reply-To: <20180514094640.27569-9-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-9-mark.rutland@arm.com>
Message-ID: <20180514180029.GA23250@light.dominikbrodowski.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static void __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
> +{
> +	regs->regs[0] = syscall_fn(regs->regs[0], regs->regs[1],
> +				   regs->regs[2], regs->regs[3],
> +				   regs->regs[4], regs->regs[5]);
> +}

Any specific reason to have this in a separate function? This seems to be
called only from one instance, namely

> +asmlinkage void invoke_syscall(struct pt_regs *regs, int scno, int sc_nr,
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

and result in a one-liner in the last patch of the series.

Thanks,
	Dominik
