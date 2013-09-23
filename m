From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Sep 2013 17:19:44 +0100
Subject: [PATCH] video: mmp: drop needless devm cleanup
In-Reply-To: <1379952790-13202-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1379952790-13202-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130923161944.GU12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 06:13:10PM +0200, Uwe Kleine-K?nig wrote:
> The nice thing about devm_* is that the driver doesn't need to free the
> resources but the driver core takes care about that. This also
> simplifies the error path quite a bit and removes the wrong check for a
> clock pointer being NULL.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/mmp/hw/mmp_ctrl.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
> index 75dca19..6ac7552 100644
> --- a/drivers/video/mmp/hw/mmp_ctrl.c
> +++ b/drivers/video/mmp/hw/mmp_ctrl.c
> @@ -514,7 +514,7 @@ static int mmphw_probe(struct platform_device *pdev)
>  	if (IS_ERR(ctrl->clk)) {
>  		dev_err(ctrl->dev, "unable to get clk %s\n", mi->clk_name);
>  		ret = -ENOENT;
> -		goto failed_get_clk;
> +		goto failed;
>  	}
>  	clk_prepare_enable(ctrl->clk);
>  
> @@ -551,21 +551,8 @@ failed_path_init:
>  		path_deinit(path_plat);
>  	}
>  
> -	if (ctrl->clk) {
> -		devm_clk_put(ctrl->dev, ctrl->clk);
> -		clk_disable_unprepare(ctrl->clk);

And this patch also fixes the above: disabling/unpreparing _after_ putting
the thing - which was quite silly... :)
