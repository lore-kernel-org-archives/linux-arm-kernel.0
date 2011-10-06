From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Oct 2011 08:46:47 +0100
Subject: [RFC/PATCH 7/7] ARM: ARM11 MPCore: cpu_v6_set_pte_ext is not
	preempt safe
In-Reply-To: <1317877714-11355-8-git-send-email-gdavis@mvista.com>
References: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
	<1317877714-11355-1-git-send-email-gdavis@mvista.com>
	<1317877714-11355-8-git-send-email-gdavis@mvista.com>
Message-ID: <20111006074647.GA26349@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2011 at 01:08:34AM -0400, gdavis at mvista.com wrote:
> diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
> index a923aa0..dd2e5e5 100644
> --- a/arch/arm/mm/proc-v6.S
> +++ b/arch/arm/mm/proc-v6.S
> @@ -122,7 +122,18 @@ ENTRY(cpu_v6_switch_mm)
>  
>  ENTRY(cpu_v6_set_pte_ext)
>  #ifdef CONFIG_MMU
> +#ifdef CONFIG_PREEMPT
> +	ALT_SMP(stmdb	sp!, {r4, r10, r11})
> +	ALT_SMP(get_thread_info r10)
> +	ALT_SMP(ldr	r4, [r10, #TI_PREEMPT])	@ get preempt count
> +	ALT_SMP(add	r11, r4, #1)		@ increment it
> +	ALT_SMP(str	r11, [r10, #TI_PREEMPT])	@ disable preempt
> +#endif
>  	armv6_set_pte_ext cpu_v6
> +#ifdef CONFIG_PREEMPT
> +	ALT_SMP(str	r4, [r10, #TI_PREEMPT])	@ restore preempt count
> +	ALT_SMP(ldmia	sp!, {r4, r10, r11})
> +#endif
>  #endif

And what effect do you expect the above to have?  Do you understand
the purpose of the ALT_SMP macro?  Do you understand that it should
be paired with ALT_UP ?
