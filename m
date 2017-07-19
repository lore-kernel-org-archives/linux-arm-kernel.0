From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 19 Jul 2017 08:01:53 +0200
Subject: [PATCH] soc: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-49-robh@kernel.org>
References: <20170718214339.7774-49-robh@kernel.org>
Message-ID: <20170719060153.GD6246@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 04:43:29PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-samsung-soc at vger.kernel.org
> ---
>  drivers/soc/fsl/qbman/bman_ccsr.c    | 10 +++++-----
>  drivers/soc/fsl/qbman/bman_portal.c  |  8 +++-----
>  drivers/soc/fsl/qbman/qman_ccsr.c    | 12 ++++++------
>  drivers/soc/fsl/qbman/qman_portal.c  | 11 ++++-------
>  drivers/soc/fsl/qe/gpio.c            |  4 ++--
>  drivers/soc/mediatek/mtk-pmic-wrap.c |  4 ++--
>  drivers/soc/renesas/rcar-rst.c       |  4 ++--
>  drivers/soc/renesas/rcar-sysc.c      |  6 +++---
>  drivers/soc/samsung/pm_domains.c     |  8 ++++----
>  9 files changed, 31 insertions(+), 36 deletions(-)
> 

(...)

> diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
> index a6a5d807cc2b..c630eba32066 100644
> --- a/drivers/soc/samsung/pm_domains.c
> +++ b/drivers/soc/samsung/pm_domains.c
> @@ -237,11 +237,11 @@ static __init int exynos4_pm_init_power_domain(void)
>  			continue;
> 
>  		if (of_genpd_add_subdomain(&parent, &child))
> -			pr_warn("%s failed to add subdomain: %s\n",
> -				parent.np->full_name, child.np->full_name);
> +			pr_warn("%pOF failed to add subdomain: %pOF\n",
> +				parent.np, child.np);
>  		else
> -			pr_info("%s has as child subdomain: %s.\n",
> -				parent.np->full_name, child.np->full_name);
> +			pr_info("%pOF has as child subdomain: %pOF.\n",
> +				parent.np, child.np);
>  	}
> 
>  	return 0;

I guess this will go through arm-soc?

For Samsung, looks good:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
