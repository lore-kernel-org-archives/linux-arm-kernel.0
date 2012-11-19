From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 19 Nov 2012 12:21:34 -0600
Subject: [PATCH] ARM: cti: fix manipulation of debug lock registers
In-Reply-To: <1353015653-23711-1-git-send-email-will.deacon@arm.com>
References: <1353015653-23711-1-git-send-email-will.deacon@arm.com>
Message-ID: <50AA78AE.5050609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/15/2012 03:40 PM, Will Deacon wrote:
> The LOCKSTATUS register for memory-mapped coresight devices indicates
> whether or not the device in question implements hardware locking. If
> not, locking is not present (i.e. LSR.SLI == 0) and LAR is write-ignore,
> so software doesn't actually need to check the status register at all.
> 
> This patch removes the broken LSR checks.
> 
> Cc: Ming Lei <ming.lei@canonical.com>
> Reported-by: Mike Williams <michael.williams@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/cti.h |   20 ++------------------
>  1 files changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cti.h b/arch/arm/include/asm/cti.h
> index a0ada3e..f2e5cad 100644
> --- a/arch/arm/include/asm/cti.h
> +++ b/arch/arm/include/asm/cti.h
> @@ -146,15 +146,7 @@ static inline void cti_irq_ack(struct cti *cti)
>   */
>  static inline void cti_unlock(struct cti *cti)
>  {
> -	void __iomem *base = cti->base;
> -	unsigned long val;
> -
> -	val = __raw_readl(base + LOCKSTATUS);
> -
> -	if (val & 1) {
> -		val = LOCKCODE;
> -		__raw_writel(val, base + LOCKACCESS);
> -	}
> +	__raw_writel(LOCKCODE, cti->base + LOCKACCESS);
>  }
>  
>  /**
> @@ -166,14 +158,6 @@ static inline void cti_unlock(struct cti *cti)
>   */
>  static inline void cti_lock(struct cti *cti)
>  {
> -	void __iomem *base = cti->base;
> -	unsigned long val;
> -
> -	val = __raw_readl(base + LOCKSTATUS);
> -
> -	if (!(val & 1)) {
> -		val = ~LOCKCODE;
> -		__raw_writel(val, base + LOCKACCESS);
> -	}
> +	__raw_writel(~LOCKCODE, cti->base + LOCKACCESS);
>  }
>  #endif

I gave this a whirl on omap4430 and PMU is working fine with this, so ...

Tested-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
