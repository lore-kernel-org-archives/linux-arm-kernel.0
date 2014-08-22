From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 22 Aug 2014 10:57:09 +0200
Subject: [RFC PATCH 5/6] rtc: rtc-isl12022: Change vendor prefix for
 Intersil Corporation to isil
In-Reply-To: <1408524184-31928-6-git-send-email-p.zabel@pengutronix.de>
References: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
 <1408524184-31928-6-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1408697829.3118.28.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 20.08.2014, 10:43 +0200 schrieb Philipp Zabel:
> Currently there is a wild mixture of isl, isil, and intersil
> compatibles in the kernel. At this point, changing the vendor
> symbol to the most often used variant, which is equal to the
> NASDAQ symbol, isil, should not hurt, since the isl1208 driver
> doesn't care either way.
> Patch db04d6284e2a added device tree support using the then
> documented isl vendor prefix, so we keep that around for
> backwards compatibility.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/rtc/rtc-isl12022.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> index aa55f08..df20f18 100644
> --- a/drivers/rtc/rtc-isl12022.c
> +++ b/drivers/rtc/rtc-isl12022.c
> @@ -275,7 +275,8 @@ static int isl12022_probe(struct i2c_client *client,
>  
>  #ifdef CONFIG_OF
>  static struct of_device_id isl12022_dt_match[] = {
> -	{ .compatible = "isl,isl12022" },
> +	{ .compatible = "isil,isl12022" },
> +	{ .compatible = "isl,isl12022" }, /* for backwards compatibility */

Actually, is it even necessary to keep this around in here?
If of_driver_match_device fails, i2c_device_match will continue to try
i2c_match_id if driver->id_table is set, which matches against the
result of of_modalias_node (dropping the vendor prefix altogether).

regards
Philipp
