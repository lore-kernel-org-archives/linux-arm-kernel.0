From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Dec 2017 16:15:41 +0000
Subject: [PATCH RESEND] arm64: fault: avoid send SIGBUS two times
In-Reply-To: <20171205150235.46325-1-gengdongjiu@huawei.com>
References: <20171205150235.46325-1-gengdongjiu@huawei.com>
Message-ID: <20171206161540.GB25408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 11:02:35PM +0800, Dongjiu Geng wrote:
> If APEI handling the memory error is failed, the do_mem_abort()
> and do_sea() will all deliver SIGBUS. In fact, sending one time
> can be enough, so correct it.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  arch/arm64/mm/fault.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index fcf2ede3..9e3f7ca 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -570,7 +570,6 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  {
>  	struct siginfo info;
>  	const struct fault_info *inf;
> -	int ret = 0;
>  
>  	inf = esr_to_fault_info(esr);
>  	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
> @@ -585,7 +584,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  		if (interrupts_enabled(regs))
>  			nmi_enter();
>  
> -		ret = ghes_notify_sea();
> +		ghes_notify_sea();
>  
>  		if (interrupts_enabled(regs))
>  			nmi_exit();
> @@ -600,7 +599,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  		info.si_addr  = (void __user *)addr;
>  	arm64_notify_die("", regs, &info, esr);
>  
> -	return ret;
> +	return 0;

Hmm, so this code is a bit of mess.

Wouldn't it be better to have the signal dispatching code in do_mem_abort
check ESR.ESR_ELx_FnV, so then do_sea wouldn't have to, and we could just
return an error instead?

Will
