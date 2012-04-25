From: balbi@ti.com (Felipe Balbi)
Date: Wed, 25 Apr 2012 14:29:50 +0300
Subject: [PATCHv3 2/4] ARM: tegra: Add SMMU enabler in AHB
In-Reply-To: <1335352072-4001-2-git-send-email-hdoyu@nvidia.com>
References: <1335352072-4001-1-git-send-email-hdoyu@nvidia.com>
 <1335352072-4001-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <20120425112950.GC3564@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 25, 2012 at 02:07:37PM +0300, Hiroshi DOYU wrote:
> Add extern func, "tegra_ahb_enable_smmu()" to inform AHB that SMMU is
> ready.
> 
> Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> Cc: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-tegra/include/mach/tegra-ahb.h |   19 +++++++++++++++++++
>  drivers/platform/arm/tegra-ahb.c             |   24 ++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/include/mach/tegra-ahb.h b/arch/arm/mach-tegra/include/mach/tegra-ahb.h
> new file mode 100644
> index 0000000..296688c
> --- /dev/null
> +++ b/arch/arm/mach-tegra/include/mach/tegra-ahb.h
> @@ -0,0 +1,19 @@
> +/*
> + * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#ifndef __MACH_TEGRA_AHB_H__
> +#define __MACH_TEGRA_AHB_H__
> +
> +extern int tegra_ahb_enable_smmu(void);
> +
> +#endif	/* __MACH_TEGRA_AHB_H__ */
> diff --git a/drivers/platform/arm/tegra-ahb.c b/drivers/platform/arm/tegra-ahb.c
> index dcad2ec..7ad9dfd 100644
> --- a/drivers/platform/arm/tegra-ahb.c
> +++ b/drivers/platform/arm/tegra-ahb.c
> @@ -78,6 +78,10 @@
>  
>  #define AHB_ARBITRATION_AHB_MEM_WRQUE_MST_ID	0xf8
>  
> +#define AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE BIT(17)
> +
> +static struct platform_driver tegra_ahb_driver;
> +
>  static u32 tegra_ahb_gizmo[] = {
>  	AHB_ARBITRATION_DISABLE,
>  	AHB_ARBITRATION_PRIORITY_CTRL,
> @@ -126,6 +130,26 @@ static inline void gizmo_writel(struct tegra_ahb *ahb, u32 value, u32 offset)
>  	writel(value, ahb->regs + offset);
>  }
>  
> +#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> +static int __tegra_ahb_enable_smmu(struct device *dev, void *data)
> +{
> +	u32 val;
> +	struct tegra_ahb *ahb = dev_get_drvdata(dev);
> +
> +	val = gizmo_readl(ahb, AHB_ARBITRATION_XBAR_CTRL);
> +	val |= AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE;
> +	gizmo_writel(ahb, val, AHB_ARBITRATION_XBAR_CTRL);
> +	return 0;
> +}
> +
> +int tegra_ahb_enable_smmu(void)
> +{
> +	return driver_for_each_device(&tegra_ahb_driver.driver, NULL, NULL,
> +				      __tegra_ahb_enable_smmu);
> +}
> +EXPORT_SYMBOL(tegra_ahb_enable_smmu);
> +#endif

this is still not correct. If you will always call this whenever you run
on tegra 3, why do you even expose this function ? You can use your
compatible flag to do runtime detection of where you're running and call
this accordingly. Something like:

static const struct of_device_id tegra_ahb_match_table[] = {
{
	.compatible = "nvidia,tegra2",
}, {
	.compatible = "nvidia,tegra3",
	.data	= AHB_HAS_SMMU,
},
{  }
};

or something similar, then on probe, you can capture your id and check
if that bit is true, if it is just call tegra_ahb_enable_smmu(), you
really don't need all this trickery with driver_for_each_device().

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120425/4b5a66be/attachment.sig>
