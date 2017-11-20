From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 20 Nov 2017 10:06:53 +0100
Subject: [PATCH 2/2 v2] misc: atmel-ssc: Fix platform_get_irq's error
 checking
In-Reply-To: <03c6f3e9df6d3077717e1f14b4775f2864a0304a.1510995185.git.arvind.yadav.cs@gmail.com>
References: <6e238a28aa79c581c90329060805c0b07e2187a7.1510995185.git.arvind.yadav.cs@gmail.com>
 <03c6f3e9df6d3077717e1f14b4775f2864a0304a.1510995185.git.arvind.yadav.cs@gmail.com>
Message-ID: <fa7e7cbc-1c18-64f8-67eb-505ad5dcbad5@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/11/2017 at 10:10, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2 :
>               Add failure case '<= 0' instead of '< 0'. IRQ 0 is not valid.
> 
>  drivers/misc/atmel-ssc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index b2a0340..9d9eeae 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -235,9 +235,9 @@ static int ssc_probe(struct platform_device *pdev)
>  	clk_disable_unprepare(ssc->clk);
>  
>  	ssc->irq = platform_get_irq(pdev, 0);
> -	if (!ssc->irq) {
> +	if (ssc->irq <= 0) {
>  		dev_dbg(&pdev->dev, "could not get irq\n");
> -		return -ENXIO;
> +		return ssc->irq;

if ssc->irq = 0, I believe that returning 0 is not the right thing to do.

Regards,

>  	}
>  
>  	spin_lock(&user_lock);
> 


-- 
Nicolas Ferre
