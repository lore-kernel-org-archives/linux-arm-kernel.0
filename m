From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 03 Feb 2017 16:17:17 +0000
Subject: [PATCH] arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling
In-Reply-To: <1485987318-9145-1-git-send-email-tbaicar@codeaurora.org> (Tyler
 Baicar's message of "Wed, 1 Feb 2017 15:15:18 -0700")
References: <1485987318-9145-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <877f57qmeq.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tyler Baicar <tbaicar@codeaurora.org> writes:

> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
>
> Add VM_FAULT_HWPOISON[_LARGE] handling to the arm64 page fault
> handler. Handling of VM_FAULT_HWPOISON[_LARGE] is very similar
> to VM_FAULT_OOM, the only difference is that a different si_code
> (BUS_MCEERR_AR) is passed to user space and si_addr_lsb field is
> initialized.
>
> Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  arch/arm64/mm/fault.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c

[...]

> @@ -426,7 +439,17 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  		 */
>  		sig = SIGBUS;
>  		code = BUS_ADRERR;
> -	} else {
> +	}
> +#ifdef CONFIG_MEMORY_FAILURE
> +	else if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {

Please add spaces around '|'.

> +		pr_err(
> +	"Killing %s:%d due to hardware memory corruption fault at %lx\n",
> +			tsk->comm, tsk->pid, addr);

The message is misleading as we're not really killing a task but
delivering a signal (SIGBUS) which might not always lead to the receiver
being killed.

But considering that we don't print any message for the other faults,
I'd prefer that we drop this pr_err.

> +		sig = SIGBUS;
> +		code = BUS_MCEERR_AR;
> +	}
> +#endif

Although to get a HWPOISON fault CONFIG_MEMORY_FAILURE is needed, the
handling seems safe even when it is not enabled. Can the ifdeffery be
dropped?

Also, I was wondering how this code was tested? Did you by any chance
try using hwpoison inject debugfs interface?

Thanks,
Punit

> +	else {
>  		/*
>  		 * Something tried to access memory that isn't in our memory
>  		 * map.
> @@ -436,7 +459,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  			SEGV_ACCERR : SEGV_MAPERR;
>  	}
>  
> -	__do_user_fault(tsk, addr, esr, sig, code, regs);
> +	__do_user_fault(tsk, addr, esr, sig, code, regs, fault);
>  	return 0;
>  
>  no_context:
