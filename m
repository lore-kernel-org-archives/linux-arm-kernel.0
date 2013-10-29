From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 29 Oct 2013 13:59:48 +0100 (CET)
Subject: [PATCH] genirq: error reporting for non-percpu interrupt in
 request_percpu_irq()
In-Reply-To: <CAPrCYke1_RjUgH79vZW99pwdExo4BspCaVi7zL-8hapKb0=gwQ@mail.gmail.com>
References: <1382090789-18177-1-git-send-email-vkale@apm.com>
 <CAPrCYke1_RjUgH79vZW99pwdExo4BspCaVi7zL-8hapKb0=gwQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1310291358150.8257@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Oct 2013, Vinayak Kale wrote:

> Need for this patch is discussed in mail-thread [1].
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/204414.html
> 

I can't see anything which makes use of the separate error code in
that patch.

Thanks,

	tglx

> On Fri, Oct 18, 2013 at 3:36 PM, Vinayak Kale <vkale@apm.com> wrote:
> > Return a separate error code when a non-percpu interrupt is passed to
> > request_percpu_irq().
> >
> > Suggested-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Vinayak Kale <vkale@apm.com>
> > ---
> >  kernel/irq/manage.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> > index 514bcfd..c2713ae 100644
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -1671,10 +1671,12 @@ int request_percpu_irq(unsigned int irq, irq_handler_t handler,
> >                 return -EINVAL;
> >
> >         desc = irq_to_desc(irq);
> > -       if (!desc || !irq_settings_can_request(desc) ||
> > -           !irq_settings_is_per_cpu_devid(desc))
> > +       if (!desc || !irq_settings_can_request(desc))
> >                 return -EINVAL;
> >
> > +       if (!irq_settings_is_per_cpu_devid(desc))
> > +               return -EPERM;
> > +
> >         action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
> >         if (!action)
> >                 return -ENOMEM;
> > --
> > 1.7.9.5
> >
> 
