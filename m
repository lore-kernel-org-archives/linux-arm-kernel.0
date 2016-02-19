From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 19 Feb 2016 13:20:14 +0900
Subject: [PATCH 3/3] thermal: exynos: Defer probe if vtmu is present but
 not registered
In-Reply-To: <1455819551-4666-4-git-send-email-javier@osg.samsung.com>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
 <1455819551-4666-4-git-send-email-javier@osg.samsung.com>
Message-ID: <20160219042014.GB27936@samsunx.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

Just a question...

> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index f4f36bba7be9..f3ce94ec73b5 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -1318,6 +1318,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>  			return ret;
>  		}
>  	} else {
> +		if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;

shouldn't we return also in case of -ENOMEM? -ENOMEM is a Kernel
failure, not depending on the regulator itself.

Andi

>  		dev_info(&pdev->dev, "Regulator node (vtmu) not found\n");
>  	}
