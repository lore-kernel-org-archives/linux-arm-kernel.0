From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 22 Jan 2015 20:12:58 -0800
Subject: [PATCH 1/2] ARM: EXYNOS: add fixed phy support for EXYNOS5440
In-Reply-To: <1421980893-14475-2-git-send-email-ming.lei@canonical.com>
References: <1421980893-14475-1-git-send-email-ming.lei@canonical.com>
 <1421980893-14475-2-git-send-email-ming.lei@canonical.com>
Message-ID: <54C1CA4A.4030703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 22/01/2015 18:41, Ming Lei a ?crit :
> From: Byungho An <bh74.an@samsung.com>
> 
> This patch adds fixed phy codes for Exynos5440. This patch can
> support fixed_phy.
> 
> Signed-off-by: Byungho An <bh74.an@samsung.com> Signed-off-by: Ike
> Panhc <ike.pan@canonical.com> Signed-off-by: Ming Lei
> <ming.lei@canoncial.com> --- arch/arm/mach-exynos/exynos.c |   15
> +++++++++++++++ 1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/exynos.c
> b/arch/arm/mach-exynos/exynos.c index 78eca99b..dfd5699 100644 ---
> a/arch/arm/mach-exynos/exynos.c +++
> b/arch/arm/mach-exynos/exynos.c @@ -20,6 +20,8 @@ #include
> <linux/platform_device.h> #include <linux/pm_domain.h> #include
> <linux/irqchip.h> +#include <linux/phy.h> +#include
> <linux/phy_fixed.h>
> 
> #include <asm/cacheflush.h> #include <asm/hardware/cache-l2x0.h> @@
> -202,8 +204,21 @@ static void __init exynos_init_irq(void) 
> exynos_map_pmu(); }
> 
> +static struct fixed_phy_status fixed_phy_status __initdata = { +
> .link           = 1, +       .speed          = 1000, +
> .duplex         = 1, +}; + static void __init
> exynos_dt_machine_init(void) { +	struct device_node *gmac_np; +
> unsigned int tmp; + +	/* add fixed phy in need */ +	gmac_np =
> of_find_compatible_node(NULL, NULL, "snps,dwmac-3.70a"); +	if
> (of_find_property(gmac_np, "fixed_phy", NULL)) +		tmp =
> fixed_phy_add(PHY_POLL, 1, &fixed_phy_status);

Is there a particular reason you are doing this and not using
of_phy_is_fixed_link() and of_phy_register_fixed_link()?

See the gianfar and bcmsysport for examples on how to use it in a
driver along with the relevant Device Tree binding in
Documentation/devicetree/bindings/net/fixed-link.txt for examples.

> /* * This is called from smp_prepare_cpus if we've built for SMP,
> but * we still need to set it up for PM and firmware ops if not.
> 


-- 
Florian
