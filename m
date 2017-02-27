From: psodagud@codeaurora.org (Sodagudi Prasad)
Date: Mon, 27 Feb 2017 09:12:00 -0800
Subject: Schedule affinity_notify work while migrating IRQs during hot plug
In-Reply-To: <05102c455476941d37904f8c6f387452@codeaurora.org>
References: <05102c455476941d37904f8c6f387452@codeaurora.org>
Message-ID: <a5b146bd9a36dd7b4fe2bc36cbaadade@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-02-21 12:59, Sodagudi Prasad wrote:
> Hi Thomas,
> 
> Currently irq_set_affinity() is called to migrate irqs from 
> migrate_one_irq()
> during cpu hot plug and clients which are interested to know the irq
> affinity change
> not getting notified
> 
> take_cpu_down () --> __cpu_disable() --> 
> irq_migrate_all_off_this_cpu();
> 
> irq_set_affinity() is changing the IRQ affinity at chip level
> but it is not notifying the affinity_notify work.
> 

Hi Thomas and All,

I could see that in the 3.10 kernel irq affinity notifiers are getting 
called when a core getting hot plugged. But in later kernel versions api 
used to change
affinity was changed from irq_set_affinity_locked() to 
irq_do_set_affinity(), so irq notifiers are not getting called when a 
core hot plugged.
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/kernel/irq/manage.c?id=refs/tags/v3.10.105#n201


In latest kernel following path is executed to migrate IRQs.
irq_migrate_all_off_this_cpu() --> migrate_one_irq() -> 
irq_do_set_affinity().

As I mentioned above, irq_set_affinity_locked() notifies all clients 
drivers, which are registered for IRQ affinity change but 
irq_do_set_affinity() API just changes the affinity at irq chip level 
but does not notify the clients drivers. I am not sure whether it is 
just a miss during IRQ framework refactor or intentionally done like 
this. Can you please check whether following code change make sense or 
not?

So I am thinking that, adding following sched_work() would notify 
clients.

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 6b66959..5e4766b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -207,6 +207,7 @@ int irq_do_set_affinity(struct irq_data *data, const 
struct cpumask *mask,
         case IRQ_SET_MASK_OK_DONE:
                 cpumask_copy(desc->irq_common_data.affinity, mask);
         case IRQ_SET_MASK_OK_NOCOPY:
+               schedule_work(&desc->affinity_notify->work);
                 irq_set_thread_affinity(desc);
                 ret = 0;
         }


> How about below change, so that clients drivers gets notified about
> irq affinity changes?
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -207,6 +207,7 @@ int irq_do_set_affinity(struct irq_data *data,
> const struct cpumask *mask,
>         case IRQ_SET_MASK_OK_DONE:
>                 cpumask_copy(desc->irq_common_data.affinity, mask);
>         case IRQ_SET_MASK_OK_NOCOPY:
> +               schedule_work(&desc->affinity_notify->work);
>                 irq_set_thread_affinity(desc);
>                 ret = 0;
> 
> With this change, notifications of IRQ affinity gets executed and 
> notified
> to client drivers.

-Thanks, Prasad
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
