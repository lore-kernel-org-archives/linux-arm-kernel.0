From: james.morse@arm.com (James Morse)
Date: Tue, 17 Jan 2017 10:31:21 +0000
Subject: [PATCH V7 04/10] arm64: exception: handle Synchronous External
 Abort
In-Reply-To: <1484244924-24786-5-git-send-email-tbaicar@codeaurora.org>
References: <1484244924-24786-1-git-send-email-tbaicar@codeaurora.org>
 <1484244924-24786-5-git-send-email-tbaicar@codeaurora.org>
Message-ID: <587DF279.1010402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On 12/01/17 18:15, Tyler Baicar wrote:
> SEA exceptions are often caused by an uncorrected hardware
> error, and are handled when data abort and instruction abort
> exception classes have specific values for their Fault Status
> Code.
> When SEA occurs, before killing the process, go through
> the handlers registered in the notification list.
> Update fault_info[] with specific SEA faults so that the
> new SEA handler is used.

> @@ -480,6 +496,28 @@ static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  	return 1;
>  }
>  
> +/*
> + * This abort handler deals with Synchronous External Abort.
> + * It calls notifiers, and then returns "fault".
> + */
> +static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> +{
> +	struct siginfo info;
> +
> +	atomic_notifier_call_chain(&sea_handler_chain, 0, NULL);
> +
> +	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
> +		 fault_name(esr), esr, addr);
> +
> +	info.si_signo = SIGBUS;
> +	info.si_errno = 0;
> +	info.si_code  = 0;

Half of the other do_*() functions in this file read the signo and code from the
fault_info table.


> +	info.si_addr  = (void __user *)addr;

addr here was read from FAR_EL1, but for some of the classes of exception you
have listed below this register isn't updated with the faulting address.

The ARM-ARM version 'k' in D1.10.5 "Summary of registers on faults taken to an
Exception level that is using Aarch64" has:
> The architecture permits that the FAR_ELx is UNKNOWN for Synchronous External
> Aborts other than Synchronous External Aborts on Translation Table Walks. In
> this case, the ISS.FnV bit returned in ESR_ELx  indicates whether FAR_ELx is
> valid.

This is a problem if we get 'synchronous external abort' or 'synchronous parity
error' while a user space process was running.


> +	arm64_notify_die("", regs, &info, esr);
> +
> +	return 0;
> +}
> +
>  static const struct fault_info {
>  	int	(*fn)(unsigned long addr, unsigned int esr, struct pt_regs *regs);
>  	int	sig;


Thanks,

James
