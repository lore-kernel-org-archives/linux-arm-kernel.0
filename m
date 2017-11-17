From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 17 Nov 2017 11:50:08 -0800
Subject: [PATCH 01/10] Input: ep93xx_keypad: Fix platform_get_irq's error
 checking
In-Reply-To: <1510946132-13554-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1510946132-13554-2-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20171117195008.6dev6chhzkn6fqri@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 18, 2017 at 12:45:23AM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/input/keyboard/ep93xx_keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
> index f77b295..67efdc9 100644
> --- a/drivers/input/keyboard/ep93xx_keypad.c
> +++ b/drivers/input/keyboard/ep93xx_keypad.c
> @@ -257,7 +257,7 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
>  	}
>  
>  	keypad->irq = platform_get_irq(pdev, 0);
> -	if (!keypad->irq) {
> +	if (keypad->irq < 0) {
>  		err = -ENXIO;

We should not clobber error here, so we need:

		err = keypad->irq;

>  		goto failed_free;
>  	}
> -- 
> 2.7.4
> 

-- 
Dmitry
