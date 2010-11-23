From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Nov 2010 19:50:26 +0000
Subject: [PATCH v2] arm: GIC: Do not try to register more then NR_IRQS
	interrupts
In-Reply-To: <1290541542-12917-1-git-send-email-pawel.moll@arm.com>
References: <1290541542-12917-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20101123195026.GC26510@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 07:45:42PM +0000, Pawel Moll wrote:
> @@ -227,46 +227,45 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
>  	/*
>  	 * Find out how many interrupts are supported.
>  	 */
> -	max_irq = readl(base + GIC_DIST_CTR) & 0x1f;
> -	max_irq = (max_irq + 1) * 32;
> -
> -	/*
> -	 * The GIC only supports up to 1020 interrupt sources.
> -	 * Limit this to either the architected maximum, or the
> -	 * platform maximum.
> -	 */
> -	if (max_irq > max(1020, NR_IRQS))
> -		max_irq = max(1020, NR_IRQS);
> +	gic_irqs = readl(base + GIC_DIST_CTR) & 0x1f;
> +	gic_irqs = (gic_irqs + 1) * 32;

I think this should still be limited to 1020 IRQs.  Note that 1020 is not
divisible by 32, so gic_irqs ends up being 1024 which is wrong.
