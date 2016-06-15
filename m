From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Wed, 15 Jun 2016 10:04:00 +0300
Subject: [PATCH 01/10] i2c: designware-platdrv: Return error in ->probe()
 when clk ungate fails
In-Reply-To: <1465916848-8207-2-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
 <1465916848-8207-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <c72735ae-a51d-2ac1-5855-4f4f68920b24@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2016 06:07 PM, Ulf Hansson wrote:
> The error code received from clk_prepare_enable() becomes ignored when
> i2c_dw_plat_prepare_clk() is called in ->probe().
>
> Fix this by invoking clk_prepare_enable() in ->probe() instead of
> i2c_dw_plat_prepare_clk(), as it allows the error code to be properly
> propagated.
>
> A side-effect from this change, makes the i2c_dw_plat_prepare_clk() used
> only when CONFIG_PM is set. Avoid the compiler warning by moving the
> function within the corresponding #ifdef.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 30 ++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index d656657..e39962b 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -136,18 +136,6 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
>  }
>  #endif
>
> -static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
> -{
> -	if (IS_ERR(i_dev->clk))
> -		return PTR_ERR(i_dev->clk);
> -
> -	if (prepare)
> -		return clk_prepare_enable(i_dev->clk);
> -
> -	clk_disable_unprepare(i_dev->clk);
> -	return 0;
> -}
> -
>  static int dw_i2c_plat_probe(struct platform_device *pdev)
>  {
>  	struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
> @@ -220,7 +208,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>  			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
>
>  	dev->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (!i2c_dw_plat_prepare_clk(dev, true)) {
> +	if (!IS_ERR(dev->clk)) {
> +		r = clk_prepare_enable(dev->clk);
> +		if (r)

Looks ok to me. My only worry was commit b33af11de236 ("i2c: designware: 
Do not require clock when SSCN and FFCN are provided") but I think it's 
the IS_ERR(dev->clk) that captures that case not the clk_prepare_enable().

Suravee: Am I right IS_ERR(dev->clk) is enough to handle your case?

-- 
Jarkko
