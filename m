From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Mar 2017 21:19:10 +0100 (CET)
Subject: Schedule affinity_notify work while migrating IRQs during hot plug
In-Reply-To: <36fe90bcca0a9c6283c4012412ed2924@codeaurora.org>
References: <05102c455476941d37904f8c6f387452@codeaurora.org>
 <a5b146bd9a36dd7b4fe2bc36cbaadade@codeaurora.org>
 <alpine.DEB.2.20.1702271818370.4732@nanos>
 <36fe90bcca0a9c6283c4012412ed2924@codeaurora.org>
Message-ID: <alpine.DEB.2.20.1703132047250.3712@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Mar 2017, Sodagudi Prasad wrote:
> On 2017-02-27 09:21, Thomas Gleixner wrote:
> > On Mon, 27 Feb 2017, Sodagudi Prasad wrote:
> > > So I am thinking that, adding following sched_work() would notify clients.
> > 
> > And break the world and some more.
> > 
> > > diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> > > index 6b66959..5e4766b 100644
> > > --- a/kernel/irq/manage.c
> > > +++ b/kernel/irq/manage.c
> > > @@ -207,6 +207,7 @@ int irq_do_set_affinity(struct irq_data *data, const
> > > struct cpumask *mask,
> > >         case IRQ_SET_MASK_OK_DONE:
> > >                 cpumask_copy(desc->irq_common_data.affinity, mask);
> > >         case IRQ_SET_MASK_OK_NOCOPY:
> > > +               schedule_work(&desc->affinity_notify->work);
> > >                 irq_set_thread_affinity(desc);
> > >                 ret = 0;
> > 
> > You cannot do that unconditionally and just slap that schedule_work() call
> > into the code. Aside of that schedule_work() would be invoked twice for all
> > calls which come via irq_set_affinity_locked() ....
> Hi Tglx,
> 
> Yes. I agree with you, schedule_work() gets invoked twice with previous
> change.
> 
> How about calling irq_set_notify_locked() instead of irq_do_set_notify()?

Is this a quiz?

Can you actually see the difference between these functions? There is a
damned good reason WHY this calls irq_do_set_affinity().

Thanks,

	tglx
