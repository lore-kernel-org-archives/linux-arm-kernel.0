From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 17 Nov 2017 11:56:59 -0800
Subject: [PATCH 08/10] Input: twl4030-pwrbutton: Handle return value of
 platform_get_irq
In-Reply-To: <1510946132-13554-9-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1510946132-13554-9-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20171117195659.jb6765dnzobvvlrg@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 18, 2017 at 12:45:30AM +0530, Arvind Yadav wrote:
> platform_get_irq() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/input/misc/twl4030-pwrbutton.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
> index b307cca..0dcf311 100644
> --- a/drivers/input/misc/twl4030-pwrbutton.c
> +++ b/drivers/input/misc/twl4030-pwrbutton.c
> @@ -58,6 +58,9 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
>  	int irq = platform_get_irq(pdev, 0);
>  	int err;
>  
> +	if (irq < 0)
> +		return -ENOMEM;

Why on earth it would translate to ENOMEM? Also, if we do the check I'd
prefer to keep assignment and the check together.

> +
>  	pwr = devm_input_allocate_device(&pdev->dev);
>  	if (!pwr) {
>  		dev_err(&pdev->dev, "Can't allocate power button\n");
> -- 
> 2.7.4
> 

-- 
Dmitry
