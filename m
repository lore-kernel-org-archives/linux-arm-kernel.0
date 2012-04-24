From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Apr 2012 15:32:52 +0300
Subject: [PATCH v2 2/3] ARM: tegra: Add SMMU enabler in AHB
In-Reply-To: <1335269116-9578-2-git-send-email-hdoyu@nvidia.com>
References: <1335269116-9578-1-git-send-email-hdoyu@nvidia.com>
 <1335269116-9578-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <20120424123248.GG8444@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 24, 2012 at 03:05:15PM +0300, Hiroshi DOYU wrote:
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
> +	gizmo_writel(val, AHB_ARBITRATION_XBAR_CTRL);
> +}
> +EXPORT_SYMBOL(tegra_ahb_enable_smmu);

ok, so this is the only place where you need that global pointer. Who
would call this ? Can you do runtime detection of the SoC and enable
SMMU based on that ?

I mean, will this function always be called for TEGRA 3 SoCs or is there
another condition to that ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120424/68ab90d6/attachment.sig>
