From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 2 Sep 2015 21:32:58 +0200
Subject: [PATCH v3 06/10] VFIO: platform: add irq bypass producer
 management
In-Reply-To: <1439212864-12954-7-git-send-email-eric.auger@linaro.org>
References: <1439212864-12954-1-git-send-email-eric.auger@linaro.org>
 <1439212864-12954-7-git-send-email-eric.auger@linaro.org>
Message-ID: <20150902193258.GU10991@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 03:21:00PM +0200, Eric Auger wrote:
> This patch populates the IRQ bypass callacks:
> - stop/start producer simply consist in disabling/enabling the host irq
> - add/del consumer: basically set the automasked flag to false/true
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> v2 -> v3:
> - vfio_platform_irq_bypass_add_consumer now returns an error in case
>   the IRQ is recognized as active
> - active boolean not set anymore
> - do not VFIO mask the IRQ anymore on unforward
> 
> v1 -> v2:
> - device handle caching in vfio_platform_device is introduced in a
>   separate patch
> - use container_of
> ---
>  drivers/vfio/platform/vfio_platform_irq.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
> index efaee58..400a188 100644
> --- a/drivers/vfio/platform/vfio_platform_irq.c
> +++ b/drivers/vfio/platform/vfio_platform_irq.c
> @@ -224,23 +224,44 @@ static int vfio_platform_is_active(struct vfio_platform_irq *irq)
>  
>  static void vfio_platform_irq_bypass_stop(struct irq_bypass_producer *prod)
>  {
> +	disable_irq(prod->irq);
>  }
>  
>  static void vfio_platform_irq_bypass_start(struct irq_bypass_producer *prod)
>  {
> +	enable_irq(prod->irq);
>  }
>  
>  static int vfio_platform_irq_bypass_add_consumer(
>  			struct irq_bypass_producer *prod,
>  			struct irq_bypass_consumer *cons)
>  {
> -	return 0;
> +	struct vfio_platform_irq *irq =
> +		container_of(prod, struct vfio_platform_irq, producer);
> +
> +	/*
> +	 * if the IRQ is active at irqchip level or VFIO (auto)masked
           If                                       masked by VFIO?
> +	 * this means the host IRQ is already under injection in the
> +	 * guest and this not safe to change the forwarding state at
> +	 * that stage.

is this really specifically bound to guests?

> +	 * It is not possible to differentiate user-space masking
> +	 * from auto-masking, leading to possible false detection of
> +	 * active state.

ok, what is the consequence of that?

> +	 */
> +	if (vfio_platform_is_active(irq))
> +		return -EAGAIN;
> +
> +	return vfio_platform_set_automasked(irq, false);
>  }
>  
>  static void vfio_platform_irq_bypass_del_consumer(
>  			struct irq_bypass_producer *prod,
>  			struct irq_bypass_consumer *cons)
>  {
> +	struct vfio_platform_irq *irq =
> +		container_of(prod, struct vfio_platform_irq, producer);
> +
> +	vfio_platform_set_automasked(irq, true);
>  }
>  
>  static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
> -- 
> 1.9.1
> 
