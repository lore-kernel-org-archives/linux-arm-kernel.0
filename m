From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 06 Jul 2011 10:41:47 +0300
Subject: [PATCH 3/4] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <1309771536-10597-4-git-send-email-leiwen@marvell.com>
References: <1309319494-17951-1-git-send-email-leiwen@marvell.com>
	<1309771536-10597-4-git-send-email-leiwen@marvell.com>
Message-ID: <4E1411BB.4010000@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/11 12:25, Lei Wen wrote:

>  #ifdef CONFIG_PM
> @@ -1203,8 +1259,12 @@ static int pxa3xx_nand_resume(struct platform_device *pdev)
>  {
>  	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
>  
> -	nand_writel(info, NDTR0CS0, info->host->ndtr0cs0);
> -	nand_writel(info, NDTR1CS0, info->host->ndtr1cs0);
> +	/*
> +	 * Directly set the chip select to a invalid value,
> +	 * then the driver would reset the timing according
> +	 * to current chip select at the beginning of cmdfunc
> +	 */
> +	info->cs = 0xff;

Thinking of this for the second (or third) time,
If you have keep config enabled and have only one nand chip,
this will brake the keep config...

Daniel,

have you tested the suspend/resume with this patch?
(and keep_config on?)


-- 
Regards,
Igor.
