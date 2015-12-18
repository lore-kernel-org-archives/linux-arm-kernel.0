From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Dec 2015 08:58:02 +0000
Subject: [PATCH 1/2] arm: Fix "NMI" backtrace for Inforce IFC6410
In-Reply-To: <1450285686-844-2-git-send-email-daniel.thompson@linaro.org>
References: <1450285686-844-1-git-send-email-daniel.thompson@linaro.org>
 <1450285686-844-2-git-send-email-daniel.thompson@linaro.org>
Message-ID: <5673CA9A.8030607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/12/15 17:08, Daniel Thompson wrote:
> SysRq-L does not generate a backtrace from all CPUs when I test it
> on my Inforce IFC6410 platform (Snapdragon 600). The stack dump code,
> triggered by IPI_CPU_BACKTRACE, never runs on the other CPUs.
> Eventually we hit the 10 second timeout and a subset of the expected
> stack dumps on are shown on the console.
> 
> It is likely this is because SGI IDs 14 and 15 have been reserved for
> use by secure world on this platform. For IFC6410 platform the code
> works as expected when IPI_CPU_BACKTRACE is set to any value in the
> interval 9..13.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  arch/arm/kernel/smp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index b26361355dae..78205927fcd4 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -73,7 +73,8 @@ enum ipi_msg_type {
>  	IPI_CPU_STOP,
>  	IPI_IRQ_WORK,
>  	IPI_COMPLETION,
> -	IPI_CPU_BACKTRACE = 15,
> +	IPI_CPU_BACKTRACE = 13,
> +	/* 14 and 15 are reserved; they do not work on some Krait CPUs */
>  };
>  
>  static DECLARE_COMPLETION(cpu_running);
> 

It looks to me that we're just moving the goal posts and keep using a
SGI that is likely to be reserved by the secure side. Quoting the GIC spec:

In any system that implements the ARM Security Extensions, to support a
consistent model for message passing between processors, ARM strongly
recommends that all processors reserve:
* ID0-ID7 for Non-secure interrupts
* ID8-ID15 for Secure interrupts.

Of course, this is only a recommendation, but it is one that is likely
to be followed...

Now, we are already using our 8 "non-secure" SGIs, but we can
immediately reclaim one (IPI_CALL_FUNC_SINGLE is not that useful
anymore). I'll cook a patch for that.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
