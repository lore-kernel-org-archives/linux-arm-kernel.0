From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Wed, 15 Jun 2016 15:47:15 +0300
Subject: [PATCH 03/10] i2c: designware-platdrv: Unconditionally enable
 runtime PM
In-Reply-To: <1465916848-8207-4-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
 <1465916848-8207-4-git-send-email-ulf.hansson@linaro.org>
Message-ID: <334641d7-10e4-9dcb-5e99-3f244070645f@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2016 06:07 PM, Ulf Hansson wrote:
> In cases when the designware specific flag "pm_runtime_disable" is set,
> ->probe() calls pm_runtime_forbid() for the device, but without enabling
> runtime PM. This increases the runtime PM usage count for the device, but
> as runtime PM is disabled it's pointless.
>
As far as I remember reason for that was to prevent suspending the 
device when unloading the driver.

> Let's instead convert to unconditionally enable runtime PM, which has the
> effect of making a parent device aware of its child.
>
> To also maintain the old behaviour when the "pm_runtime_disable" flag is
> set, which prevents userspace to enable runtime PM suspend via sysfs,
> switch from calling pm_runtime_forbid() into pm_runtime_get_noresume()
> during ->probe().
>
> While changing this, let's also also correct the error path in ->probe()
> and fix ->remove(), as to decrease the runtime PM usage count when it has
> been in increased by pm_runtime_forbid() (after this change, by
> pm_runtime_get_noresume()).
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 19174e7..94ff953 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -236,21 +236,21 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>  	adap->dev.of_node = pdev->dev.of_node;
...
> +	if (dev->pm_runtime_disabled)
> +		pm_runtime_get_noresume(&pdev->dev);

> @@ -267,10 +267,11 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
>
>  	i2c_dw_disable(dev);
>
> +	if (dev->pm_runtime_disabled)
> +		pm_runtime_put_noidle(&pdev->dev);

That will trigger power down after returning from dw_i2c_plat_remove() 
by looking at debug print from acpi_device_set_power() but now I don't 
find what call chain is actually causing it.

Must be something to do with drivers/acpi/acpi_lpss.c and notifier calls 
from drivers/base/dd.c. Also I was wondering why RPM usage counts don't 
increase monotonically over repeated module load/unload cycle.

I had a few paper notes about these when I last time looked and debugged 
PM in i2c-designware but throw away them :-(

-- 
Jarkko
