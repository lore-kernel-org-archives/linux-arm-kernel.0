From: feng.wu@intel.com (Wu, Feng)
Date: Tue, 7 Jul 2015 08:47:55 +0000
Subject: [RFC v2 6/6] KVM: eventfd: add irq bypass consumer management
In-Reply-To: <1436184692-20927-7-git-send-email-eric.auger@linaro.org>
References: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
 <1436184692-20927-7-git-send-email-eric.auger@linaro.org>
Message-ID: <E959C4978C3B6342920538CF579893F0025F2A47@SHSMSX104.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Eric Auger [mailto:eric.auger at linaro.org]
> Sent: Monday, July 06, 2015 8:12 PM
> To: eric.auger at st.com; eric.auger at linaro.org;
> linux-arm-kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu;
> kvm at vger.kernel.org; christoffer.dall at linaro.org; marc.zyngier at arm.com;
> alex.williamson at redhat.com; pbonzini at redhat.com; avi.kivity at gmail.com;
> mtosatti at redhat.com; Wu, Feng; joro at 8bytes.org;
> b.reynal at virtualopensystems.com
> Cc: linux-kernel at vger.kernel.org; patches at linaro.org
> Subject: [RFC v2 6/6] KVM: eventfd: add irq bypass consumer management
> 
> This patch adds the registration/unregistration of an
> irq_bypass_consumer on irqfd assignment/deassignment.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> 
> v1 -> v2:
> - populate of kvm and gsi removed
> - unregister the consumer on irqfd_shutdown
> ---
>  include/linux/kvm_irqfd.h |  1 +
>  virt/kvm/eventfd.c        | 14 +++++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
> index f926b39..3c0bd07 100644
> --- a/include/linux/kvm_irqfd.h
> +++ b/include/linux/kvm_irqfd.h
> @@ -64,6 +64,7 @@ struct kvm_kernel_irqfd {
>  	struct list_head list;
>  	poll_table pt;
>  	struct work_struct shutdown;
> +	struct irq_bypass_consumer consumer;
>  };
> 
>  #endif /* __LINUX_KVM_IRQFD_H */
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index b79dc61..9452754 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -35,6 +35,7 @@
>  #include <linux/srcu.h>
>  #include <linux/slab.h>
>  #include <linux/seqlock.h>
> +#include <linux/irqbypass.h>
>  #include <trace/events/kvm.h>
> 
>  #include <kvm/iodev.h>
> @@ -140,6 +141,7 @@ irqfd_shutdown(struct work_struct *work)
>  	/*
>  	 * It is now safe to release the object's resources
>  	 */
> +	irq_bypass_unregister_consumer(&irqfd->consumer);
>  	eventfd_ctx_put(irqfd->eventfd);
>  	kfree(irqfd);
>  }
> @@ -380,7 +382,14 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd
> *args)
>  	 */
>  	fdput(f);
> 
> -	/* irq_bypass_register_consumer(); */
> +	irqfd->consumer.token = (void *)irqfd->eventfd;
> +	irqfd->consumer.add_producer = kvm_arch_irq_bypass_add_producer;
> +	irqfd->consumer.del_producer = kvm_arch_irq_bypass_del_producer;
> +	irqfd->consumer.stop = kvm_arch_irq_bypass_stop;
> +	irqfd->consumer.resume = kvm_arch_irq_bypass_resume;
> +	irqfd->consumer.update = kvm_arch_irq_bypass_update;
> +	ret = irq_bypass_register_consumer(&irqfd->consumer);
> +	WARN_ON(ret);
> 
>  	return 0;
> 
> @@ -481,8 +490,6 @@ kvm_irqfd_deassign(struct kvm *kvm, struct kvm_irqfd
> *args)
>  	struct kvm_kernel_irqfd *irqfd, *tmp;
>  	struct eventfd_ctx *eventfd;
> 
> -	/* irq_bypass_unregister_consumer() */
> -
>  	eventfd = eventfd_ctx_fdget(args->fd);
>  	if (IS_ERR(eventfd))
>  		return PTR_ERR(eventfd);
> @@ -501,6 +508,7 @@ kvm_irqfd_deassign(struct kvm *kvm, struct kvm_irqfd
> *args)
>  			irqfd->irq_entry.type = 0;
>  			write_seqcount_end(&irqfd->irq_entry_sc);
>  			irqfd_deactivate(irqfd);
> +			irq_bypass_unregister_consumer(&irqfd->consumer);

consumer is unregistered in irqfd_shutdown(), why need we do it here?

Thanks,
Feng

>  		}
>  	}
> 
> --
> 1.9.1
