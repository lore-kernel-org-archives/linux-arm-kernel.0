From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Apr 2010 15:38:11 +0100
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v5)
In-Reply-To: <20100409180033.5003.19340.stgit@e101986-lin>
References: <20100409175628.5003.10282.stgit@e101986-lin>
	<20100409180033.5003.19340.stgit@e101986-lin>
Message-ID: <1272033491.15107.57.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-04-09 at 19:00 +0100, Leif Lindholm wrote:
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -152,8 +152,10 @@ ENTRY(cpu_v7_set_pte_ext)
>  
>  	tst	r1, #L_PTE_USER
>  	orrne	r3, r3, #PTE_EXT_AP1
> +#ifndef CONFIG_SWP_EMULATE
>  	tstne	r3, #PTE_EXT_APX
>  	bicne	r3, r3, #PTE_EXT_APX | PTE_EXT_AP0
> +#endif

I think we could use:

#ifndef CONFIG_CPU_HAS_TLS_REG
...
#endif

And since we always have a TLS register on ARMv7, we can probably remove
these lines entirely.

-- 
Catalin
