From: alex.williamson@redhat.com (Alex Williamson)
Date: Wed, 12 Aug 2015 12:56:10 -0600
Subject: [PATCH v3 01/10] VFIO: platform: registration of a dummy IRQ
 bypass producer
In-Reply-To: <1439212864-12954-2-git-send-email-eric.auger@linaro.org>
References: <1439212864-12954-1-git-send-email-eric.auger@linaro.org>
 <1439212864-12954-2-git-send-email-eric.auger@linaro.org>
Message-ID: <1439405770.4023.526.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-08-10 at 15:20 +0200, Eric Auger wrote:
> Register a dummy producer with void callbacks
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> 
> v2 -> v3:
> - rename vfio_platform_irq_bypass_resume into *_start
> ---
>  drivers/vfio/platform/vfio_platform_irq.c     | 32 +++++++++++++++++++++++++++
>  drivers/vfio/platform/vfio_platform_private.h |  2 ++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
> index 88bba57..b5cb8c7 100644
> --- a/drivers/vfio/platform/vfio_platform_irq.c
> +++ b/drivers/vfio/platform/vfio_platform_irq.c
> @@ -20,6 +20,7 @@
>  #include <linux/types.h>
>  #include <linux/vfio.h>
>  #include <linux/irq.h>
> +#include <linux/irqbypass.h>
>  
>  #include "vfio_platform_private.h"
>  
> @@ -177,6 +178,27 @@ static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static void vfio_platform_irq_bypass_stop(struct irq_bypass_producer *prod)
> +{
> +}
> +
> +static void vfio_platform_irq_bypass_start(struct irq_bypass_producer *prod)
> +{
> +}
> +
> +static int vfio_platform_irq_bypass_add_consumer(
> +			struct irq_bypass_producer *prod,
> +			struct irq_bypass_consumer *cons)
> +{
> +	return 0;
> +}
> +
> +static void vfio_platform_irq_bypass_del_consumer(
> +			struct irq_bypass_producer *prod,
> +			struct irq_bypass_consumer *cons)
> +{
> +}
> +
>  static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
>  			    int fd, irq_handler_t handler)
>  {
> @@ -186,6 +208,7 @@ static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
>  
>  	if (irq->trigger) {
>  		free_irq(irq->hwirq, irq);
> +		irq_bypass_unregister_producer(&irq->producer);
>  		kfree(irq->name);
>  		eventfd_ctx_put(irq->trigger);
>  		irq->trigger = NULL;
> @@ -216,6 +239,15 @@ static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
>  		return ret;
>  	}
>  
> +	irq->producer.token = (void *)trigger;
> +	irq->producer.irq = irq->hwirq;
> +	irq->producer.add_consumer = vfio_platform_irq_bypass_add_consumer;
> +	irq->producer.del_consumer = vfio_platform_irq_bypass_del_consumer;
> +	irq->producer.stop = vfio_platform_irq_bypass_stop;
> +	irq->producer.start = vfio_platform_irq_bypass_start;
> +	ret = irq_bypass_register_producer(&irq->producer);
> +	WARN_ON(ret);

For what purpose?

> +
>  	if (!irq->masked)
>  		enable_irq(irq->hwirq);
>  
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index 1c9b3d5..1d2d4d6 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -17,6 +17,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
> +#include <linux/irqbypass.h>
>  
>  #define VFIO_PLATFORM_OFFSET_SHIFT   40
>  #define VFIO_PLATFORM_OFFSET_MASK (((u64)(1) << VFIO_PLATFORM_OFFSET_SHIFT) - 1)
> @@ -37,6 +38,7 @@ struct vfio_platform_irq {
>  	spinlock_t		lock;
>  	struct virqfd		*unmask;
>  	struct virqfd		*mask;
> +	struct irq_bypass_producer producer;
>  };
>  
>  struct vfio_platform_region {
