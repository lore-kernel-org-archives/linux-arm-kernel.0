From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Apr 2016 09:53:23 +0100
Subject: [PATCH v2 2/3] mfd: mt6397: Checking for null before
 irq_domain_remove.
In-Reply-To: <1460098729-25549-2-git-send-email-henryc.chen@mediatek.com>
References: <1460098729-25549-1-git-send-email-henryc.chen@mediatek.com>
 <1460098729-25549-2-git-send-email-henryc.chen@mediatek.com>
Message-ID: <20160411085323.GM4592@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FAO Thomas,

On Fri, 08 Apr 2016, Henry Chen wrote:
> It is possible that pmic->irq_domain will be NULL in fail_irq error handling.
> Check before calling irq_domain_remove.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index a879223..15050cb 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -312,7 +312,8 @@ static int mt6397_probe(struct platform_device *pdev)
>  
>  fail_irq:
>  	if (ret) {
> -		irq_domain_remove(pmic->irq_domain);
> +		if (pmic->irq_domain)
> +			irq_domain_remove(pmic->irq_domain);

You might be better off making this change in the framework.

Just get irq_domain_remove() to harmlessly return if !irq_domain.

>  		dev_err(&pdev->dev, "failed to add child devices: %d\n", ret);
>  	}
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
