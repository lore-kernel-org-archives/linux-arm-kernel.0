From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 29 Jan 2010 11:03:02 +0000
Subject: [RFC PATCH 07/12] arm: mm: support error reporting in L1/L2
	caches onQSD
In-Reply-To: <1264719577-5436-8-git-send-email-dwalker@codeaurora.org>
References: <1264719577-5436-8-git-send-email-dwalker@codeaurora.org>
Message-ID: <1264762983.4242.44.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-01-28 at 22:59 +0000, Daniel Walker wrote:
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -246,6 +246,14 @@ __v7_setup:
>  #ifdef CONFIG_ARCH_MSM_SCORPION
>         mov     r0, #0x77
>         mcr     p15, 3, r0, c15, c0, 3          @ set L2CR1
> +
> +       mrc     p15, 0, r0, c1, c0, 1           @ read ACTLR
> +#ifdef CONFIG_CPU_CACHE_ERR_REPORT
> +       orr     r0, r0, #0x37                   @ turn on L1/L2 error reporting
> +#else
> +       bic     r0, r0, #0x37
> +#endif
> +       mcr     p15, 0, r0, c1, c0, 1           @ write ACTLR
>  #endif
>         /*
>          * Memory region attributes with SCTLR.TRE=1

As for the previous patch, maybe it will make sense to move these kind
of settings out of the kernel.

-- 
Catalin
