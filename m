From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jan 2016 05:49:32 +0000
Subject: [PATCH] mfd: mt6397: convert to arch_initcall
In-Reply-To: <1450862711-22124-1-git-send-email-henryc.chen@mediatek.com>
References: <1450862711-22124-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <20160111054932.GH3331@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Dec 2015, Henry Chen wrote:

> Since pinctrl or regulator of mt6396 need to initialize earlier to avoid
> probe deferring, also change the core driver to arch_init.

This is exactly what deferring probe was designed for; so that you
don't have to mess around with initcall ordering.

> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 1749c1c..af98b4b 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -285,7 +285,11 @@ static struct platform_driver mt6397_driver = {
>  	},
>  };
>  
> -module_platform_driver(mt6397_driver);
> +static int __init mt6397_core_init(void)
> +{
> +	return platform_driver_register(&mt6397_driver);
> +}
> +arch_initcall(mt6397_core_init);
>  
>  MODULE_AUTHOR("Flora Fu, MediaTek");
>  MODULE_DESCRIPTION("Driver for MediaTek MT6397 PMIC");

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
