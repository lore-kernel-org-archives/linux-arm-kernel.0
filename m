From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Wed, 15 Jun 2016 16:22:31 +0300
Subject: [PATCH 06/10] i2c: designware-platdrv: Update runtime PM last
 busy mark in ->probe()
In-Reply-To: <1465916848-8207-7-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
 <1465916848-8207-7-git-send-email-ulf.hansson@linaro.org>
Message-ID: <cd324193-3eb3-7c6f-a9b5-9e428962a07b@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2016 06:07 PM, Ulf Hansson wrote:
> To avoid the device to be immediately runtime suspended when ->probe()
> returns, update the last busy mark to use the delay from autosuspend.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 4083376..106856f 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -253,6 +253,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>  		if (dev->pm_runtime_disabled)
>  			pm_runtime_put_noidle(&pdev->dev);
>  	}
> +	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put(&pdev->dev);
>
I was thinking this too earlier shortly while doing cd998ded5c12 ("i2c: 
designware: Prevent runtime suspend during adapter registration") but 
decided to keep suspending immediately after probe is better in cases 
when there are no slaves connected to a bus or if they start 
communicating after host auto-suspend timeout has already fired.

But I don't have strong opinion against this.

-- 
Jarkko
