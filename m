From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 26 Nov 2012 11:30:34 +0200
Subject: [PATCH 2/2] pinctrl: mvebu: make pdma clock on dove mandatory
In-Reply-To: <1353921634-25210-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1353921525-25163-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1353921634-25210-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20121126093033.GH12673@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Mon, Nov 26, 2012 at 10:20:34AM +0100, Sebastian Hesselbarth wrote:

[...]

> diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c 
> b/drivers/pinctrl/mvebu/pinctrl-dove.c
> index 40c9c3e..90f257d 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-dove.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
> @@ -595,8 +595,11 @@ static int __devinit dove_pinctrl_probe(struct platform_device *pdev)
>  	 * grab clk to make sure it is ticking.
>  	 */
>  	clk = devm_clk_get(&pdev->dev, NULL);
> -	if (!IS_ERR(clk))
> -		clk_prepare_enable(clk);
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "Unable to get pdma clock");
> +		return -ENODEV;

Why not propagate the error up using PTR_RET(clk)?

baruch

> +	}
> +	clk_prepare_enable(clk);
>  
>  	return mvebu_pinctrl_probe(pdev);
>  }

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
