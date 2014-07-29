From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 29 Jul 2014 20:44:11 +0800
Subject: [PATCH v2 2/2] ARM: smp_scu: enable SCU standby support
In-Reply-To: <1406275790-18617-3-git-send-email-shawn.guo@freescale.com>
References: <1406275790-18617-1-git-send-email-shawn.guo@freescale.com>
 <1406275790-18617-3-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140729124410.GI24750@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 04:09:50PM +0800, Shawn Guo wrote:
> With SCU standby enabled, SCU CLK will be turned off when all processors
> are in WFI mode.  And the clock will be turned on when any processor
> leaves WFI mode.
> 
> This behavior should be preferable in terms of power efficiency of
> system idle.  So let's set the SCU standby bit to enable the support in
> function scu_enable().
> 
> Cortex-A9 earlier than r2p0 has no standby bit in SCU, so we need to
> skip setting the bit for those.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

If there is no objection on the patch, I will put it into patch tracker
soon.

Russell,

I know it's late for 3.17 at this point, and I'm fine that you queue it
for 3.18.

Shawn

> ---
>  arch/arm/kernel/smp_scu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
> index c947508f84e6..72f9241ad5db 100644
> --- a/arch/arm/kernel/smp_scu.c
> +++ b/arch/arm/kernel/smp_scu.c
> @@ -18,6 +18,7 @@
>  
>  #define SCU_CTRL		0x00
>  #define SCU_ENABLE		(1 << 0)
> +#define SCU_STANDBY_ENABLE	(1 << 5)
>  #define SCU_CONFIG		0x04
>  #define SCU_CPU_STATUS		0x08
>  #define SCU_INVALIDATE		0x0c
> @@ -55,6 +56,12 @@ void scu_enable(void __iomem *scu_base)
>  		return;
>  
>  	scu_ctrl |= SCU_ENABLE;
> +
> +	/* Cortex-A9 earlier than r2p0 has no standby bit in SCU */
> +	if ((read_cpuid_id() & 0xff0ffff0) == 0x410fc090 &&
> +	    (read_cpuid_id() & 0x00f0000f) >= 0x00200000)
> +		scu_ctrl |= SCU_STANDBY_ENABLE;
> +
>  	writel_relaxed(scu_ctrl, scu_base + SCU_CTRL);
>  
>  	/*
> -- 
> 1.9.1
> 
