From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 25 Feb 2015 23:03:14 +0100
Subject: [RFC PATCH 2/3] genirq: add helper functions to deal with wakeup
 on shared IRQF_NO_SUSPEND IRQs
In-Reply-To: <1424771762-16343-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <1424771762-16343-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <2476478.8N4TxgeN3h@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 24, 2015 10:56:01 AM Boris Brezillon wrote:
> Add two helper functions to help drivers that are sharing IRQs with
> timer devices (or other devices setting the IRQF_NO_SUSPEND flag) deal
> with system wakeup and state detection.
> 
> Such drivers should expect their IRQ handler to be called in 2 different
> contexts:
> 1/ the system is resumed and the handler should act normally
> 2/ the system is suspended and the handler should wake it up, and
>    potentially save the received events so that they could be taken care
>    of when the resume callback is called
> 
> irq_is_wakeup_armed provides mean to test the current state (true means
> the system is suspended).
> 
> irq_pm_force_wakeup provides mean to force a system wakeup.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  include/linux/interrupt.h |  3 +++
>  kernel/irq/manage.c       | 16 ++++++++++++++++
>  kernel/irq/pm.c           |  6 ++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index d9b05b5..052a3b2 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -356,6 +356,9 @@ static inline int disable_irq_wake(unsigned int irq)
>  	return irq_set_irq_wake(irq, 0);
>  }
>  
> +bool irq_is_wakeup_armed(unsigned int irq);
> +
> +void irq_pm_force_wakeup(void);
>  
>  #ifdef CONFIG_IRQ_FORCED_THREADING
>  extern bool force_irqthreads;
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 196a06f..5424be0 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -551,6 +551,22 @@ int irq_set_irq_wake(unsigned int irq, unsigned int on)
>  }
>  EXPORT_SYMBOL(irq_set_irq_wake);
>  
> +bool irq_is_wakeup_armed(unsigned int irq)
> +{
> +	unsigned long flags;
> +	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
> +	bool ret;
> +
> +	if (!desc)
> +		return false;
> +
> +	ret = irqd_is_wakeup_armed(&desc->irq_data);
> +
> +	irq_put_desc_busunlock(desc, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL(irq_is_wakeup_armed);

Ugly that is ...

> +
>  /*
>   * Internal function that tells the architecture code whether a
>   * particular irq has been exclusively allocated or is available
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index 1743162..1110a37 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -28,6 +28,12 @@ bool irq_pm_check_wakeup(struct irq_desc *desc)
>  	return false;
>  }
>  
> +void irq_pm_force_wakeup(void)
> +{
> +	pm_system_wakeup();
> +}
> +EXPORT_SYMBOL_GPL(irq_pm_force_wakeup);

Why don't you export pm_system_wakeup() instead and use it directly?

> +
>  /*
>   * Called from __setup_irq() with desc->lock held after @action has
>   * been installed in the action chain.
> 


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
