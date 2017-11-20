From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 20 Nov 2017 10:08:30 +0100
Subject: [PATCH 2/2 v3] misc: atmel-ssc: Fix platform_get_irq's error
 checking
In-Reply-To: <fbe464e8bd8039463c4984835286b19060509f82.1511065797.git.arvind.yadav.cs@gmail.com>
References: <3ce95a4e4eb4476b19868f36cd1f11e4b62b6203.1511065797.git.arvind.yadav.cs@gmail.com>
 <fbe464e8bd8039463c4984835286b19060509f82.1511065797.git.arvind.yadav.cs@gmail.com>
Message-ID: <6cb39a71-ebba-fa26-41e1-0a0cb0bb4748@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/2017 at 05:34, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2 :
>               Add failure case '<= 0' instead of '< 0'. IRQ 0 is not valid.
> changes in v3:
>               Return -ENODEV instead of ssc->irq.

Okay, I didn't see this v3 before commenting on v2...

> 
>  drivers/misc/atmel-ssc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index b2a0340..2ec0f9e 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -235,7 +235,7 @@ static int ssc_probe(struct platform_device *pdev)
>  	clk_disable_unprepare(ssc->clk);
>  
>  	ssc->irq = platform_get_irq(pdev, 0);
> -	if (!ssc->irq) {
> +	if (ssc->irq <= 0) {
>  		dev_dbg(&pdev->dev, "could not get irq\n");
>  		return -ENXIO;
>  	}
> 


-- 
Nicolas Ferre
