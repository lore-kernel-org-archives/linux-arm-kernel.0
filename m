From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 27 Feb 2017 18:21:20 +0100 (CET)
Subject: Schedule affinity_notify work while migrating IRQs during hot plug
In-Reply-To: <a5b146bd9a36dd7b4fe2bc36cbaadade@codeaurora.org>
References: <05102c455476941d37904f8c6f387452@codeaurora.org>
 <a5b146bd9a36dd7b4fe2bc36cbaadade@codeaurora.org>
Message-ID: <alpine.DEB.2.20.1702271818370.4732@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Feb 2017, Sodagudi Prasad wrote:
> So I am thinking that, adding following sched_work() would notify clients.

And break the world and some more.

> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 6b66959..5e4766b 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -207,6 +207,7 @@ int irq_do_set_affinity(struct irq_data *data, const
> struct cpumask *mask,
>         case IRQ_SET_MASK_OK_DONE:
>                 cpumask_copy(desc->irq_common_data.affinity, mask);
>         case IRQ_SET_MASK_OK_NOCOPY:
> +               schedule_work(&desc->affinity_notify->work);
>                 irq_set_thread_affinity(desc);
>                 ret = 0;

You cannot do that unconditionally and just slap that schedule_work() call
into the code. Aside of that schedule_work() would be invoked twice for all
calls which come via irq_set_affinity_locked() ....

Thanks,

	tglx
