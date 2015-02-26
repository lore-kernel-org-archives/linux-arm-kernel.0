From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 26 Feb 2015 09:06:13 +0100
Subject: [RFC PATCH 1/3] genirq: prevent system wakeup when dealing with
 IRQF_NO_SUSPEND IRQs
In-Reply-To: <1721977.3MjzADDQbj@vostro.rjw.lan>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <1424771762-16343-2-git-send-email-boris.brezillon@free-electrons.com>
 <1721977.3MjzADDQbj@vostro.rjw.lan>
Message-ID: <20150226090613.465c95a9@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Feb 2015 23:01:31 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Tuesday, February 24, 2015 10:56:00 AM Boris Brezillon wrote:
> > Mixing IRQF_NO_SUSPEND and !IRQF_NO_SUSPEND on the same IRQ line is highly
> > discouraged, but in some cases (IRQ shared by a timer and other devices)
> > you don't have any other choice.
> > Since some devices sharing the IRQ line might tag it as a wakeup source,
> > you might end up with your handler that requested IRQF_NO_SUSPEND not
> > being called in suspended state, or invalid system wakeup (the system is
> > woken up without any wakeup source actually requesting it).
> > 
> > To deal with such unlikely situations, you'll have to:
> > 1/ prevent any automatic wakeup when at least one of the IRQ users
> >    registered with IRQF_NO_SUSPEND
> > 2/ let IRQ users decide if/when they should wake the system up
> > 
> > This patch is taking care of 1.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  kernel/irq/pm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> > index 3ca5325..1743162 100644
> > --- a/kernel/irq/pm.c
> > +++ b/kernel/irq/pm.c
> > @@ -16,7 +16,8 @@
> >  
> >  bool irq_pm_check_wakeup(struct irq_desc *desc)
> >  {
> > -	if (irqd_is_wakeup_armed(&desc->irq_data)) {
> > +	if (irqd_is_wakeup_armed(&desc->irq_data) &&
> > +	    !desc->no_suspend_depth) {
> >  		irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
> >  		desc->istate |= IRQS_SUSPENDED | IRQS_PENDING;
> >  		desc->depth++;
> > 
> 
> I'm not sure how this helps, because irqd_is_wakeup_armed() is false for
> IRQs having no_suspend_depth different from zero (please see the first
> check in suspend_device_irq()).
> 
> 

Indeed, it seems I overlooked this test in suspend_device_irq, and this
makes my irq_is_wakeup_armed test useless.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
