From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 26 Aug 2015 17:12:30 +0100
Subject: [PATCH 1/1] irqchip: imx-gpcv2:  Simplify the implemenation
In-Reply-To: <1440604166-2624-1-git-send-email-shenwei.wang@freescale.com>
References: <1440604166-2624-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <55DDE56E.2040206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

typo in $subject

On 26/08/15 16:49, Shenwei Wang wrote:
> Based on Sudeep Holla's review comments, the implementation can
> be simplified by using the two flags: IRQCHIP_SKIP_SET_WAKE and
> IRQCHIP_MASK_ON_SUSPEND. This patch enables the flags in the
> struct irq_chip and removes the unnecessory syscore_ops callbacks.
>
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> ---
>   drivers/irqchip/irq-imx-gpcv2.c | 83 +++++++----------------------------------
>   1 file changed, 13 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
> index 4a97afa..e25df78 100644
> --- a/drivers/irqchip/irq-imx-gpcv2.c
> +++ b/drivers/irqchip/irq-imx-gpcv2.c
> @@ -22,7 +22,6 @@ struct gpcv2_irqchip_data {
>   	struct raw_spinlock    rlock;
>   	void __iomem       *gpc_base;
>   	u32 wakeup_sources[IMR_NUM];
> -	u32 saved_irq_mask[IMR_NUM];
>   	u32 cpu2wakeup;
>   };
>
> @@ -30,79 +29,25 @@ static struct gpcv2_irqchip_data *imx_gpcv2_instance;
>
>   u32 imx_gpcv2_get_wakeup_source(u32 **sources)

I assume this patch is against -next and I don't see any users of
imx_gpcv2_get_wakeup_source in -next.

If possible I would avoid exposing this function by implementing
suspend_ops just as before(just saving raw h/w reg values and restoring
then back on resume w/o tagging them as wakeup mask though they might be
indeed wakeup mask).

In that way, this driver is self-contained and whatever imx code calls
this function will not have dependency on this driver, no ? Do you need
access to imx_gpcv2_get_wakeup_source too early in resume much before
suspend_ops resume ? I would like to see the user of that function to
comment on that any further.

Regards,
Sudeep
