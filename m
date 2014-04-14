From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Apr 2014 14:29:53 +0100
Subject: [PATCH] ARM: errata: Fix the workaround for erratum 764369
In-Reply-To: <1396308564-4613-1-git-send-email-nitin.garg@freescale.com>
References: <1396308564-4613-1-git-send-email-nitin.garg@freescale.com>
Message-ID: <20140414132953.GF3530@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 12:29:24AM +0100, Nitin Garg wrote:
> The SCU diagnostic control register at offset 0x30 is
> write-only register, so do not do read-modify write.

As far as I can tell, the register isn't even documented, so I'd rather
leave the code as-is unless it's causing you problems.

If the behaviour is as you suggest, then doing multiple writes to the
register would undo prvious writes (otherwise it wouldn't be possible to
clear bits), which doesn't sound realistic to me.

Will

> Signed-off-by: Nitin Garg <nitin.garg@freescale.com>
> ---
>  arch/arm/kernel/smp_scu.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
> index 1aafa0d..b0cca7e 100644
> --- a/arch/arm/kernel/smp_scu.c
> +++ b/arch/arm/kernel/smp_scu.c
> @@ -42,9 +42,7 @@ void scu_enable(void __iomem *scu_base)
>  #ifdef CONFIG_ARM_ERRATA_764369
>  	/* Cortex-A9 only */
>  	if ((read_cpuid_id() & 0xff0ffff0) == 0x410fc090) {
> -		scu_ctrl = readl_relaxed(scu_base + 0x30);
> -		if (!(scu_ctrl & 1))
> -			writel_relaxed(scu_ctrl | 0x1, scu_base + 0x30);
> +		writel_relaxed(0x1, scu_base + 0x30);
>  	}
>  #endif
>  
> -- 
> 1.7.4.1
> 
> 
> 
