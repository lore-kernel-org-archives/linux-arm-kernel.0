From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 27 Aug 2015 11:43:43 -0500
Subject: [PATCH] soc: ti: reset irq affinity before freeing irq
In-Reply-To: <1440690671-1029-1-git-send-email-m-karicheri2@ti.com>
References: <1440690671-1029-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <55DF3E3F.6030506@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2015 10:51 AM, Murali Karicheri wrote:
> When using accumulator queue for rx side for network driver, following
> warning is seen when doing a reboot command from Linux console. This
> is because, affinity value is not reset before calling free_irq(). This
> patch fixes this.
> 
> Deconfiguring network interfaces...
> [   55.176589] ------------[ cut here ]-----------
> [   55.181232] WARNING: CPU: 0 PID: 2081 at kernel/irq/manage.c:1370
> __free_irq+0x208/0x214

The full content of the warning should be included in the commit
message; __free_irq has several potential sources of warning messages,
and line 1370 doesn't correspond to any of them in 4.2-rc8.


> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  - Applies to v4.2.0-rc8
> 
>  drivers/soc/ti/knav_qmss_acc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
> index ef6f69d..b98fe56 100644
> --- a/drivers/soc/ti/knav_qmss_acc.c
> +++ b/drivers/soc/ti/knav_qmss_acc.c
> @@ -261,6 +261,10 @@ static int knav_range_setup_acc_irq(struct knav_range_info *range,
>  	if (old && !new) {
>  		dev_dbg(kdev->dev, "setup-acc-irq: freeing %s for channel %s\n",
>  			acc->name, acc->name);
> +		ret = irq_set_affinity_hint(irq, NULL);
> +		if (ret)
> +			dev_warn(range->kdev->dev,
> +				 "Failed to set IRQ affinity\n");

Seems unnecessary to add a warning here.
