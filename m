From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Oct 2012 18:34:40 +0000
Subject: [PATCH 6/6] mfd: Differentiate between u8500 and u9540 TCDM
 address mapping
In-Reply-To: <1349882335-6786-7-git-send-email-lee.jones@linaro.org>
References: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
 <1349882335-6786-7-git-send-email-lee.jones@linaro.org>
Message-ID: <201210101834.40749.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 October 2012, Lee Jones wrote:
> @@ -2688,7 +2688,11 @@ void __init db8500_prcmu_early_init(void)
>                         iounmap(tcpm_base);
>                 }
>  
> -               tcdm_base = __io_address(U8500_PRCMU_TCDM_BASE);
> +               if (cpu_is_u9540())
> +                       tcdm_base = ioremap_nocache(U8500_PRCMU_TCDM_BASE,
> +                                               SZ_4K + SZ_8K) + SZ_8K;
> +               else
> +                       tcdm_base = __io_address(U8500_PRCMU_TCDM_BASE);
>         } else {
>                 pr_err("prcmu: Unsupported chip version\n");
>                 BUG();

Would it be possible to get the base out of the device tree and always
map it from there? Adding another dependency on a fixed constant is
just going to make the conversion to multiplatform harder, since it
was decided that device drivers should not have access to platform
header files in the multiplatform case.

	Arnd
