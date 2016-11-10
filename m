From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 10 Nov 2016 18:46:06 +0200
Subject: [PATCH v3 1/2] ARM: EXYNOS: Remove static mapping of SCU SFR
In-Reply-To: <a43af947-6002-bc65-f73b-02d57a78d6cb@samsung.com>
References: <1478693755-11953-1-git-send-email-pankaj.dubey@samsung.com>
 <1478693755-11953-2-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161110115456epcas2p4524185a083cd7173e354f46b94be9183@epcas2p4.samsung.com>
 <5066943.nydi3GQ3KP@wuerfel>
 <a43af947-6002-bc65-f73b-02d57a78d6cb@samsung.com>
Message-ID: <20161110164606.GA3613@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 06:07:54PM +0530, pankaj.dubey wrote:
> So if CONFIG_SMP is disable then there is no sense of exynos_scu_enable
> as well. So wow about using below patch?
> 
> --------------------------------------------------------
> 
> Subject: [PATCH] ARM: exynos: fix build fail due to exynos_scu_enable
> 
> Build failed if we disable CONFIG_SMP as shown below:

This is fine with me.

(...)

> Of-course your idea to move it in core SCU file is also good that we
> lots of duplication in different architecture can be avoided.
> 
> In that case I can think of following patch:
> 
> [PATCH] ARM: scu: use SCU device node to enable SCU
> 
> Many platforms are duplicating code for enabling SCU, lets add
> common code to enable SCU using SCU device node so the duplication in
> each platform can be avoided.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/include/asm/smp_scu.h |  2 ++
>  arch/arm/kernel/smp_scu.c      | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
> index bfe163c..e5e2492 100644
> --- a/arch/arm/include/asm/smp_scu.h
> +++ b/arch/arm/include/asm/smp_scu.h
> @@ -38,8 +38,10 @@ static inline int scu_power_mode(void __iomem
> *scu_base, unsigned int mode)
>  #endif
> 
>  #if defined(CONFIG_SMP) && defined(CONFIG_HAVE_ARM_SCU)
> +int of_scu_enable(void);
>  void scu_enable(void __iomem *scu_base);
>  #else
> +static inline int of_scu_enable(void) {return 0;}
>  static inline void scu_enable(void __iomem *scu_base) {}
>  #endif
> 
> diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
> index 72f9241..7c16d16 100644
> --- a/arch/arm/kernel/smp_scu.c
> +++ b/arch/arm/kernel/smp_scu.c
> @@ -34,6 +34,23 @@ unsigned int __init scu_get_core_count(void __iomem
> *scu_base)
>  	return (ncores & 0x03) + 1;
>  }
> 
> +int of_scu_enable(void)
> +{
> +	struct device_node *np;
> +	void __iomem *scu_base;
> +
> +	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
> +	scu_base = of_iomap(np, 0);
> +	of_node_put(np);
> +	if (!scu_base) {
> +		pr_err("%s failed to map scu_base\n", __func__);
> +		return -ENOMEM;
> +	}
> +	scu_enable(scu_base);
> +	iounmap(scu_base);
> +	return 0;
> +}
> +
>  /*
>   * Enable the SCU
>   */
> -- 
> 
> 
> Followed by cleanup in various architecture where this piece of code is
> duplicated and all of them can call directly of_scu_enable()

This looks better to me.

> 
> 
> Please let me know which one you will prefer for fixing build issue.
> 
> @Krzysztof, please let me know if I need to resubmit SCU series again
> with fix or you will accept build fix patch on top of already taken patch.

The code is already in my next/soc branch and I prefer to avoid
rebasing/dropping commits so how about:
1. Creating a generic wrapper which arm-soc will apply,
2. Provide me a tag with it (by arm-soc folks),
3. Fix the Exynos !SMP build on top of the tag (by using generic
   approach).

Arnd,
Are you fine with this?

Best regards,
Krzysztof
