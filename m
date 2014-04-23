From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 23 Apr 2014 18:50:20 +0900
Subject: [PATCH] i2c: s3c2410: resume race fix
In-Reply-To: <1397254781-23833-1-git-send-email-dianders@chromium.org>
References: <1397254781-23833-1-git-send-email-dianders@chromium.org>
Message-ID: <038101cf5ed9$70b5a3a0$5220eae0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug Anderson wrote:
> 
> From: Olof Johansson <olof@lixom.net>
> 
> Don't unmark the device as suspended until after it's been re-setup.
> 
> The main race would be w.r.t. an i2c driver that gets resumed at the same
> time (asyncronously), that is allowed to do a transfer since suspended
> is set to 0 before reinit, but really should have seen the -EIO return
> instead.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin

> ---
>  drivers/i2c/busses/i2c-s3c2410.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-
> s3c2410.c
> index ae44910..bb3a996 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -1276,10 +1276,10 @@ static int s3c24xx_i2c_resume(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
> 
> -	i2c->suspended = 0;
>  	clk_prepare_enable(i2c->clk);
>  	s3c24xx_i2c_init(i2c);
>  	clk_disable_unprepare(i2c->clk);
> +	i2c->suspended = 0;
> 
>  	return 0;
>  }
> --
> 1.9.1.423.g4596e3a
