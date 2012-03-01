From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 01 Mar 2012 13:39:18 +0900
Subject: [PATCH] ARM: SAMSUNG: Fixup prevent bug related to 'Unchecked
 return value'
In-Reply-To: <018e01cce88b$0501bd40$0f0537c0$@samsung.com>
References: <018e01cce88b$0501bd40$0f0537c0$@samsung.com>
Message-ID: <077001ccf765$438ccbc0$caa66340$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Huisung Kang wrote:
> 
> 
> [prevent bug]
> In s5p_pmu_init(): Value returned from a function is not checked for
> erros before being used.
> 
> Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
> ---
>  arch/arm/plat-samsung/devs.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> index 3e38dc4..3e6e1f2 100644
> --- a/arch/arm/plat-samsung/devs.c
> +++ b/arch/arm/plat-samsung/devs.c
> @@ -1092,7 +1092,14 @@ struct platform_device s5p_device_pmu = {
> 
>  static int __init s5p_pmu_init(void)
>  {
> -	platform_device_register(&s5p_device_pmu);
> +	int ret;
> +
> +	ret = platform_device_register(&s5p_device_pmu);
> +	if (ret) {
> +		pr_warning("s5p_pmu_init: pmu device not registered.\n");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  arch_initcall(s5p_pmu_init);
> --
> 1.7.1

I think, in this case, following can be used instead.

	return platform_device_register(&s5p_device_pmu);

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
