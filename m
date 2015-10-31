From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 31 Oct 2015 10:06:11 +0000
Subject: [PATCH v3 2/3] iio: light: lm3533-als: Print error message on
 invalid resistance
In-Reply-To: <1446249040-16552-2-git-send-email-bjorn.andersson@sonymobile.com>
References: <1446249040-16552-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1446249040-16552-2-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <56349293.7030107@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/10/15 23:50, Bjorn Andersson wrote:
> Print an error message to indicate that invalid configuration data was
> provided in the platform_data, rather than just aborting initialization.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Seems sensible to me.

Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> 
> This patch can be picked independently of the other 2, but included in the
> series for "completeness".
> 
> No changes since v1 in this patch.
> 
>  drivers/iio/light/lm3533-als.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index 076bc46fad03..e56937c40a18 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -743,8 +743,10 @@ static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
>  {
>  	int ret;
>  
> -	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX)
> +	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
> +		dev_err(&als->pdev->dev, "invalid resistor value\n");
>  		return -EINVAL;
> +	};
>  
>  	ret = lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR_SELECT, val);
>  	if (ret) {
> 
