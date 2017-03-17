From: psodagud@codeaurora.org (Sodagudi Prasad)
Date: Fri, 17 Mar 2017 03:51:19 -0700
Subject: Schedule affinity_notify work while migrating IRQs during hot plug
In-Reply-To: <alpine.DEB.2.20.1703132047250.3712@nanos>
References: <05102c455476941d37904f8c6f387452@codeaurora.org>
 <a5b146bd9a36dd7b4fe2bc36cbaadade@codeaurora.org>
 <alpine.DEB.2.20.1702271818370.4732@nanos>
 <36fe90bcca0a9c6283c4012412ed2924@codeaurora.org>
 <alpine.DEB.2.20.1703132047250.3712@nanos>
Message-ID: <559ce4c1fef10c45eab12f65c4e0f0d9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-03-13 13:19, Thomas Gleixner wrote:
> On Mon, 13 Mar 2017, Sodagudi Prasad wrote:
>> On 2017-02-27 09:21, Thomas Gleixner wrote:
>> > On Mon, 27 Feb 2017, Sodagudi Prasad wrote:
>> > > So I am thinking that, adding following sched_work() would notify clients.
>> >
>> > And break the world and some more.
>> >
>> > > diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> > > index 6b66959..5e4766b 100644
>> > > --- a/kernel/irq/manage.c
>> > > +++ b/kernel/irq/manage.c
>> > > @@ -207,6 +207,7 @@ int irq_do_set_affinity(struct irq_data *data, const
>> > > struct cpumask *mask,
>> > >         case IRQ_SET_MASK_OK_DONE:
>> > >                 cpumask_copy(desc->irq_common_data.affinity, mask);
>> > >         case IRQ_SET_MASK_OK_NOCOPY:
>> > > +               schedule_work(&desc->affinity_notify->work);
>> > >                 irq_set_thread_affinity(desc);
>> > >                 ret = 0;
>> >
>> > You cannot do that unconditionally and just slap that schedule_work() call
>> > into the code. Aside of that schedule_work() would be invoked twice for all
>> > calls which come via irq_set_affinity_locked() ....
>> Hi Tglx,
>> 
>> Yes. I agree with you, schedule_work() gets invoked twice with 
>> previous
>> change.
>> 
>> How about calling irq_set_notify_locked() instead of 
>> irq_do_set_notify()?
> 
> Is this a quiz?
> 
> Can you actually see the difference between these functions? There is a
> damned good reason WHY this calls irq_do_set_affinity().
Other option is that, adding an argument to irq_do_set_affinity() and 
queue
work to notify when that new parameter set.  I have attached patch for 
the same.

I tested this change on arm64 bit platform and observed that clients 
drivers
are getting notified during cpu hot plug.

> Thanks,
> 
> 	tglx

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-genirq-Notify-clients-whenever-there-is-change-in-af.patch
Type: text/x-diff
Size: 3321 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170317/409d9484/attachment-0001.bin>
