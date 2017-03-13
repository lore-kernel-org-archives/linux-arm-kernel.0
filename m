From: psodagud@codeaurora.org (Sodagudi Prasad)
Date: Mon, 13 Mar 2017 12:43:53 -0700
Subject: Schedule affinity_notify work while migrating IRQs during hot plug
In-Reply-To: <alpine.DEB.2.20.1702271818370.4732@nanos>
References: <05102c455476941d37904f8c6f387452@codeaurora.org>
 <a5b146bd9a36dd7b4fe2bc36cbaadade@codeaurora.org>
 <alpine.DEB.2.20.1702271818370.4732@nanos>
Message-ID: <36fe90bcca0a9c6283c4012412ed2924@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-02-27 09:21, Thomas Gleixner wrote:
> On Mon, 27 Feb 2017, Sodagudi Prasad wrote:
>> So I am thinking that, adding following sched_work() would notify 
>> clients.
> 
> And break the world and some more.
> 
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index 6b66959..5e4766b 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -207,6 +207,7 @@ int irq_do_set_affinity(struct irq_data *data, 
>> const
>> struct cpumask *mask,
>>         case IRQ_SET_MASK_OK_DONE:
>>                 cpumask_copy(desc->irq_common_data.affinity, mask);
>>         case IRQ_SET_MASK_OK_NOCOPY:
>> +               schedule_work(&desc->affinity_notify->work);
>>                 irq_set_thread_affinity(desc);
>>                 ret = 0;
> 
> You cannot do that unconditionally and just slap that schedule_work() 
> call
> into the code. Aside of that schedule_work() would be invoked twice for 
> all
> calls which come via irq_set_affinity_locked() ....
Hi Tglx,

Yes. I agree with you, schedule_work() gets invoked twice with previous 
change.

How about calling irq_set_notify_locked() instead of 
irq_do_set_notify()?

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 011f8c4..e8ce0db 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -18,8 +18,8 @@ static bool migrate_one_irq(struct irq_desc *desc)
  {
         struct irq_data *d = irq_desc_get_irq_data(desc);
         const struct cpumask *affinity = d->common->affinity;
-       struct irq_chip *c;
         bool ret = false;
+       int r;

         /*
          * If this is a per-CPU interrupt, or the affinity does not
@@ -34,15 +34,10 @@ static bool migrate_one_irq(struct irq_desc *desc)
                 ret = true;
         }

-       c = irq_data_get_irq_chip(d);
-       if (!c->irq_set_affinity) {
-               pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-       } else {
-               int r = irq_do_set_affinity(d, affinity, false);
-               if (r)
-                       pr_warn_ratelimited("IRQ%u: set affinity 
failed(%d).\n",
+       r = irq_set_affinity_locked(d, affinity, false);
+       if (r)
+               pr_warn_ratelimited("IRQ%u: set affinity failed(%d).\n",
                                             d->irq, r);
-       }

         return ret;


-Thanks, Prasad
> 
> Thanks,
> 
> 	tglx

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
