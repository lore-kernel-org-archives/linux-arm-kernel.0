From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Apr 2012 20:59:02 +0100
Subject: [PATCH v2 2/3] ARM: tegra: Add SMMU enabler in AHB
In-Reply-To: <1335269116-9578-2-git-send-email-hdoyu@nvidia.com>
References: <1335269116-9578-1-git-send-email-hdoyu@nvidia.com>
 <1335269116-9578-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <20120424195901.GC3628@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 03:05:15PM +0300, Hiroshi DOYU wrote:
> +#define AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE_DONE	1
> +#define AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE_SHIFT	17
> +
>  struct __tegra_ahb {
>  	void __iomem	*regs;
>  	struct device	*dev;
> @@ -95,6 +98,21 @@ static inline void gizmo_writel(unsigned long value, unsigned long offset)
>  	writel(value, tegra_ahb->regs + offset);
>  }
>  
> +#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> +
> +void tegra_ahb_enable_smmu(void)
> +{
> +	unsigned long val;
> +
> +	val = gizmo_readl(AHB_ARBITRATION_XBAR_CTRL);
> +	val |= AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE_DONE <<
> +		AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE_SHIFT;

In addition to what Felipe said...

Why do you need two constants where you have only one use point?
What's wrong with having just a single definition which gives you
the right bitmask?
