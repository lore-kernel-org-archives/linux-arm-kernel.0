From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Feb 2015 17:39:24 +0000
Subject: [PATCH] arm64: annotate psci invoke functions as notrace
In-Reply-To: <20150218172638.GB1772@redacted.bos.redhat.com>
References: <20150218172638.GB1772@redacted.bos.redhat.com>
Message-ID: <20150218173924.GH29429@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kyle,

On Wed, Feb 18, 2015 at 05:26:38PM +0000, Kyle McMartin wrote:
> Using GCC 5 to build the kernel with ftrace enabled, we encounter the
> following error as a result of the mcount prologue changing the expected
> register use of the function parameters,
> 
> /tmp/cc8Kpn7A.s: Assembler messages:
> /tmp/cc8Kpn7A.s:41: Error: .err encountered
> /tmp/cc8Kpn7A.s:42: Error: .err encountered
> /tmp/cc8Kpn7A.s:43: Error: .err encountered
> /tmp/cc8Kpn7A.s:101: Error: .err encountered
> /tmp/cc8Kpn7A.s:102: Error: .err encountered
> /tmp/cc8Kpn7A.s:103: Error: .err encountered
> scripts/Makefile.build:257: recipe for target 'arch/arm64/kernel/psci.o' failed
> 
> Fix this by annotating the function as notrace, to suppress the
> generation of profiling prologues and epilogues on the function.
> 
> Signed-off-by: Kyle McMartin <kyle@redhat.com>

Will and I have patches for arm64 and arm, moving the invocations out to
separate assembly files as discussed when Andy Whitcroft reported the
issue previously [1].

Given that GCC 5 is still in development we were planning to post those
when -rc1 arrives.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/319344.html

> 
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -113,7 +113,7 @@ static void psci_power_state_unpack(u32 power_state,
>   * The following two functions are invoked via the invoke_psci_fn pointer
>   * and will not be inlined, allowing us to piggyback on the AAPCS.
>   */
> -static noinline int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1,
> +static noinline notrace int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1,
>  					 u64 arg2)
>  {
>  	asm volatile(
> @@ -128,7 +128,7 @@ static noinline int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1,
>  	return function_id;
>  }
>  
> -static noinline int __invoke_psci_fn_smc(u64 function_id, u64 arg0, u64 arg1,
> +static noinline notrace int __invoke_psci_fn_smc(u64 function_id, u64 arg0, u64 arg1,
>  					 u64 arg2)
>  {
>  	asm volatile(
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
