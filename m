From: marex@denx.de (Marek Vasut)
Date: Mon, 18 Feb 2013 13:17:28 +0100
Subject: [PATCH] i2c: Remove unneeded xxx_set_drvdata(..., NULL) calls
In-Reply-To: <1360970315-32116-1-git-send-email-dianders@chromium.org>
References: <1360953682-25066-1-git-send-email-dianders@chromium.org>
 <1360970315-32116-1-git-send-email-dianders@chromium.org>
Message-ID: <201302181317.28645.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Doug Anderson,

> There is simply no reason to be manually setting the private driver
> data to NULL in the remove/fail to probe cases.  This is just extra
> cruft code that can be removed.
> 
> A few notes:
> * Nothing relies on drvdata being set to NULL.
> * The __device_release_driver() function eventually calls
>   dev_set_drvdata(dev, NULL) anyway, so there's no need to do it
>   twice.
> * I verified that there were no cases where xxx_get_drvdata() was
>   being called in these drivers and checking for / relying on the NULL
>   return value.
> 
> This could be cleaned up kernel-wide but for now just take the baby
> step and remove from the i2c subsystem.
> 
> Reported-by: Wolfram Sang <wsa@the-dreams.de>
> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

For

>  drivers/i2c/busses/i2c-mxs.c                | 2 --

[...]

> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 22d8ad3..120f246 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -697,8 +697,6 @@ static int mxs_i2c_remove(struct platform_device *pdev)
> 
>  	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
> 
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return 0;
>  }

[...]

Add my:
Reviewed-by: Marek Vasut <marex@denx.de>
