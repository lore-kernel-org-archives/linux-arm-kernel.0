From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Thu, 15 Sep 2011 23:36:23 +0200
Subject: [RFC PATCH 1/3] genirq: add support for per-cpu dev_id interrupts
In-Reply-To: <1316105551-17505-2-git-send-email-marc.zyngier@arm.com>
References: <1316105551-17505-1-git-send-email-marc.zyngier@arm.com>
	<1316105551-17505-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAHXqBFKOQNOePc00yuzfotrYP6wT0ue_CJfv7rKdC+gEkomunA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/15 Marc Zyngier <marc.zyngier@arm.com>:
[...]
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index a103732..f9b7fa3 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -95,6 +95,7 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
> ?* @flags: ? ? flags (see IRQF_* above)
> ?* @name: ? ? ?name of the device
> ?* @dev_id: ? ?cookie to identify the device
> + * @percpu_dev_id: ? ? cookie to identify the device
> ?* @next: ? ? ?pointer to the next irqaction for shared interrupts
> ?* @irq: ? ? ? interrupt number
> ?* @dir: ? ? ? pointer to the proc/irq/NN/name entry
> @@ -104,17 +105,20 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
> ?* @thread_mask: ? ? ? bitmask for keeping track of @thread activity
> ?*/
> ?struct irqaction {
[...]
> + ? ? ? void ? ? ? ? ? ? ? ? ? ?*dev_id;
> +#ifdef CONFIG_IRQ_PERCPU_DEVID
> + ? ? ? void __percpu ? ? ? ? ? *percpu_dev_id;
> +#endif

Those two can share the memory (in a anonymous union), if I read the
idea correctly.

Best Regards,
Micha? Miros?aw
