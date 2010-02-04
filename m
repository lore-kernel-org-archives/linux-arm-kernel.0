From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Feb 2010 14:42:50 +0000
Subject: [PATCH 4/5] ARM: L2 : Errata 588369: Clean & Invalidate do not
	invalidate clean lines
In-Reply-To: <1265293547-18960-4-git-send-email-santosh.shilimkar@ti.com>
References: <1265293547-18960-1-git-send-email-santosh.shilimkar@ti.com>
	<1265293547-18960-2-git-send-email-santosh.shilimkar@ti.com>
	<1265293547-18960-3-git-send-email-santosh.shilimkar@ti.com>
	<1265293547-18960-4-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20100204144250.GB27344@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2010 at 07:55:46PM +0530, Santosh Shilimkar wrote:
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 1a14d18..6241f10 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -56,12 +56,41 @@ static inline void l2x0_inv_line(unsigned long addr)
>  	writel(addr, base + L2X0_INV_LINE_PA);
>  }
>  
> +#ifdef CONFIG_PL310_ERRATA_588369
> +extern void omap_smc1(u32 fn, u32 arg);
> +static void debug_writel(unsigned long val)
> +{

You could move the external declaration into this function, thereby
making it entirely local to this function (and hiding it from the
file scope.)
