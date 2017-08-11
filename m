From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 11 Aug 2017 17:00:35 -0500
Subject: [PATCH 1/4] i2c: davinci: Preserve return value of devm_clk_get
In-Reply-To: <20170802221753.13786-2-fcooper@ti.com>
References: <20170802221753.13786-1-fcooper@ti.com>
 <20170802221753.13786-2-fcooper@ti.com>
Message-ID: <3598274c-4567-eacb-adaa-24c4fd1c1ace@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/02/2017 05:17 PM, Franklin S Cooper Jr wrote:
> The i2c driver can run into driver dependency issues if its loaded
> before a clock driver it depends on. Therefore, EPROBE_DEFER may be
> returned by devm_clk_get and should be returned in probe to allow the
> kernel to reprobe the driver at a later time. This patch allows the error
> value returned by devm_clk_get to be passed through and not overwritten.
> 
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

I think it's better to drop internal tags.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

> ---
>   drivers/i2c/busses/i2c-davinci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 9e7ef5c..5749aac 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -801,7 +801,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>   
>   	dev->clk = devm_clk_get(&pdev->dev, NULL);
>   	if (IS_ERR(dev->clk))
> -		return -ENODEV;
> +		return PTR_ERR(dev->clk);
>   	clk_prepare_enable(dev->clk);
>   
>   	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 

-- 
regards,
-grygorii
