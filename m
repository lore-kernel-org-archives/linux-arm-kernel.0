From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 14 Jun 2016 18:22:48 +0300
Subject: [PATCH 02/10] i2c: designware-platdrv: Gate clk in error path
 in ->probe()
In-Reply-To: <1465916848-8207-3-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
 <1465916848-8207-3-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1465917768.30123.65.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-06-14 at 17:07 +0200, Ulf Hansson wrote:
> The call to i2c_dw_probe() may fail in ->probe() in which case the
> clock
> remains ungated. Fix the error path by gating the clock before the
> error
> code is returned.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> ?drivers/i2c/busses/i2c-designware-platdrv.c | 10 ++++++++--
> ?1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index e39962b..19174e7 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -235,6 +235,7 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
> ?	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
> ?	adap->dev.of_node = pdev->dev.of_node;
> 

?
> +	pm_runtime_get_noresume(&pdev->dev);

> +	pm_runtime_put(&pdev->dev);

I don't see an explanation of these add-ons.

-- 

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
