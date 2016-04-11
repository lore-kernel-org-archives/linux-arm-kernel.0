From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Apr 2016 09:50:39 +0100
Subject: [PATCH v2 3/3] mfd: mt6397: check the EPROBE_DEFER from
 platform_get_irq.
In-Reply-To: <1460098729-25549-3-git-send-email-henryc.chen@mediatek.com>
References: <1460098729-25549-1-git-send-email-henryc.chen@mediatek.com>
 <1460098729-25549-3-git-send-email-henryc.chen@mediatek.com>
Message-ID: <20160411085039.GL4592@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 08 Apr 2016, Henry Chen wrote:

> If get the -EPROBE_DEFER from platform_get_irq, it should return back directly.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 15050cb..b9b1e28 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -271,6 +271,8 @@ static int mt6397_probe(struct platform_device *pdev)
>  	}
>  
>  	pmic->irq = platform_get_irq(pdev, 0);
> +	if (pmic->irq == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

if (ret < 0)
   return ret;

... is more common, as it covers more bases, etc.

>  	switch (id & 0xff) {
>  	case MT6323_CID_CODE:

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
