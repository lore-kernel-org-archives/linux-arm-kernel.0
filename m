From: b-liu@ti.com (Bin Liu)
Date: Thu, 31 Mar 2016 17:21:12 -0500
Subject: [PATCH v3 15/16] usb: musb: da8xx: Use devm in probe
In-Reply-To: <1458863503-31121-16-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-16-git-send-email-david@lechnology.com>
Message-ID: <20160331222112.GA28044@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 24, 2016 at 06:51:40PM -0500, David Lechner wrote:
> Simplify things a bit by using devm functions where possible.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v3 changes:
> 
> * Kept clk variable to minimize noise.
> 
> 
>  drivers/usb/musb/da8xx.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
> index b03d3b8..0c1997c 100644
> --- a/drivers/usb/musb/da8xx.c
> +++ b/drivers/usb/musb/da8xx.c
> @@ -490,20 +490,18 @@ static int da8xx_probe(struct platform_device *pdev)
>  	struct da8xx_glue		*glue;
>  	struct platform_device_info	pinfo;
>  	struct clk			*clk;
> +	int				ret;
>  
> -	int				ret = -ENOMEM;
> -
> -	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
> +	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
>  	if (!glue) {
>  		dev_err(&pdev->dev, "failed to allocate glue context\n");
> -		goto err0;
> +		return -ENOMEM;
>  	}
>  
> -	clk = clk_get(&pdev->dev, "usb20");
> +	clk = devm_clk_get(&pdev->dev, "usb20");
>  	if (IS_ERR(clk)) {
>  		dev_err(&pdev->dev, "failed to get clock\n");
> -		ret = PTR_ERR(clk);
> -		goto err3;
> +		return PTR_ERR(clk);

memory leak due to not kfree(glue).

>  	}
>  
>  	ret = clk_enable(clk);
> @@ -560,12 +558,7 @@ err5:
>  	clk_disable(clk);
>  
>  err4:
> -	clk_put(clk);
> -
> -err3:
> -	kfree(glue);
>  
> -err0:
>  	return ret;
>  }
>  
> @@ -576,8 +569,6 @@ static int da8xx_remove(struct platform_device *pdev)
>  	platform_device_unregister(glue->musb);
>  	usb_phy_generic_unregister(glue->phy);
>  	clk_disable(glue->clk);
> -	clk_put(glue->clk);
> -	kfree(glue);

Doesn't match with $subject, I'd put them into a seperate patch.

Regards,
-Bin.
