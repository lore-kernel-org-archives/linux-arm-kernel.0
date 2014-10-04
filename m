From: peter.chen@freescale.com (Peter Chen)
Date: Sat, 4 Oct 2014 10:48:55 +0800
Subject: [PATCH 1/1] usb: chipidea: Fix oops when removing the ci_hdrc
 module
In-Reply-To: <1412326880-3268-1-git-send-email-to-fleischer@t-online.de>
References: <1412326880-3268-1-git-send-email-to-fleischer@t-online.de>
Message-ID: <20141004024853.GA3713@peterchendt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 03, 2014 at 11:01:20AM +0200, Torsten Fleischer wrote:
> The call of 'kfree(ci->hw_bank.regmap)' in ci_hdrc_remove() sometimes causes
> a kernel oops when removing the ci_hdrc module.
> 
> Since there is no separate memory allocated for the ci->hw_bank.regmap array,
> there is no need to free it.
> 
> Signed-off-by: Torsten Fleischer <to-fleischer@t-online.de>
> ---
>  drivers/usb/chipidea/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 619d13e..4ecb650 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -732,7 +732,6 @@ static int ci_hdrc_remove(struct platform_device *pdev)
>  	ci_role_destroy(ci);
>  	ci_hdrc_enter_lpm(ci, true);
>  	usb_phy_shutdown(ci->transceiver);
> -	kfree(ci->hw_bank.regmap);
>  
>  	return 0;
>  }
> -- 
> 1.8.4.5
> 

Good fix, applied, thanks.

-- 
Best Regards,
Peter Chen
