From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 26 Jul 2016 10:00:53 -0700
Subject: [PATCH] pinctrl: meson: Drop pinctrl_unregister for devm_
 registered device
In-Reply-To: <1469544718-32001-1-git-send-email-weiyj.lk@gmail.com>
References: <1469544718-32001-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160726170053.GA40841@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 02:51:58PM +0000, Wei Yongjun wrote:
> It's not necessary to unregister pin controller device registered
> with devm_pinctrl_register() and using pinctrl_unregister() leads
> to a double free.
> 
> This is detected by Coccinelle semantic patch.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Fixes: e649f7ec8c5f ("pinctrl: meson: Use devm_pinctrl_register() for
pinctrl registration")

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/pinctrl/meson/pinctrl-meson.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index 11623c6..44e69c9 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -727,13 +727,7 @@ static int meson_pinctrl_probe(struct platform_device *pdev)
>  		return PTR_ERR(pc->pcdev);
>  	}
>  
> -	ret = meson_gpiolib_register(pc);
> -	if (ret) {
> -		pinctrl_unregister(pc->pcdev);
> -		return ret;
> -	}
> -
> -	return 0;
> +	return meson_gpiolib_register(pc);
>  }
>  
>  static struct platform_driver meson_pinctrl_driver = {
> 

Thanks.

-- 
Dmitry
