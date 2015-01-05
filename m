From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 05 Jan 2015 10:52:13 +0100
Subject: [PATCH] ARM: EXYNOS: do not try to map PMU for exynos5440
In-Reply-To: <1420449268-24707-1-git-send-email-pankaj.dubey@samsung.com>
References: <1420449268-24707-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1420451533.15910.19.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-01-05 at 14:44 +0530, Pankaj Dubey wrote:
> Commit id: 2e94ac42898f84d76e3c21dd91bc is not taking care
> of mapping of exynos5440 PMU register which will result in kernel panic
> on exynos5440.
> 
> As exynos5440 DTS does not have PMU node, and also we are skipping
> exynos_pm_init in case of exynos5440, let's avoid mapping of exynos5440 PMU.


> Reported-by: Ming Lei <tom.leiming@gmail.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index c13d083..1891b8c 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -208,7 +208,8 @@ static void __init exynos_init_irq(void)
>  	 * DT is not unflatten so we can't use DT APIs before
>  	 * init_irq
>  	 */
> -	exynos_map_pmu();
> +	if (!of_machine_is_compatible("samsung,exynos5440"))
> +		exynos_map_pmu();
>  }
>  
>  static void __init exynos_dt_machine_init(void)

Why the blacklist approach rather then simply making exynos_map_pmu exit
rather then panicing if it couldn't find a pmu node in the dts?


-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150105/72bb9903/attachment.bin>
