From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 2 Sep 2015 21:29:32 +0200
Subject: [PATCH v3 05/10] VFIO: platform: add vfio_platform_is_active
In-Reply-To: <1439212864-12954-6-git-send-email-eric.auger@linaro.org>
References: <1439212864-12954-1-git-send-email-eric.auger@linaro.org>
 <1439212864-12954-6-git-send-email-eric.auger@linaro.org>
Message-ID: <20150902192932.GT10991@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 03:20:59PM +0200, Eric Auger wrote:
> This function returns whether the IRQ is active at irqchip level or
> VFIO masked. If either is true, it is considered the IRQ is active.
> Currently there is no way to differentiate userspace masked IRQ from
> automasked IRQ. There might be false detection of activity. However
> it is currently acceptable to have false detection.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> ---
>  drivers/vfio/platform/vfio_platform_irq.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
> index a285384..efaee58 100644
> --- a/drivers/vfio/platform/vfio_platform_irq.c
> +++ b/drivers/vfio/platform/vfio_platform_irq.c
> @@ -205,6 +205,23 @@ static int vfio_platform_set_automasked(struct vfio_platform_irq *irq,
>  	return 0;
>  }
>  
> +static int vfio_platform_is_active(struct vfio_platform_irq *irq)
> +{
> +	unsigned long flags;
> +	bool active, masked, outstanding;
> +	int ret;
> +
> +	spin_lock_irqsave(&irq->lock, flags);
> +
> +	ret = irq_get_irqchip_state(irq->hwirq, IRQCHIP_STATE_ACTIVE, &active);
> +	BUG_ON(ret);
> +	masked = irq->masked;
> +	outstanding = active || masked;

outstanding?

why not just return active || masked ?

-Christoffer

> +
> +	spin_unlock_irqrestore(&irq->lock, flags);
> +	return outstanding;
> +}
> +
>  static void vfio_platform_irq_bypass_stop(struct irq_bypass_producer *prod)
>  {
>  }
> -- 
> 1.9.1
> 
