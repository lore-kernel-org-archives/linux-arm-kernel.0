From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 18 Nov 2017 10:30:29 -0800
Subject: [PATCH 01/10 v3] Input: ep93xx_keypad: Fix platform_get_irq's
 error checking
In-Reply-To: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171118183029.zooxomhrejzatuvd@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 18, 2017 at 04:25:08PM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>                Return keypad->irq insted of -ENXIO.
> changes in v3 :
>                Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
> 
>  drivers/input/keyboard/ep93xx_keypad.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
> index f77b295..01788a7 100644
> --- a/drivers/input/keyboard/ep93xx_keypad.c
> +++ b/drivers/input/keyboard/ep93xx_keypad.c
> @@ -257,8 +257,8 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
>  	}
>  
>  	keypad->irq = platform_get_irq(pdev, 0);
> -	if (!keypad->irq) {
> -		err = -ENXIO;
> +	if (keypad->irq <= 0) {
> +		err = keypad->irq;

Argh, so what will happen if you return with keypad->irq == 0? Can you
please stop and consider what exactly  you are doing before churning
patches like crazy?

>  		goto failed_free;
>  	}
>  
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
