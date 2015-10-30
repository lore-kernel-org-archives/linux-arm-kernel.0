From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 30 Oct 2015 11:05:00 +0100 (CET)
Subject: [PATCH] gpio: zynq: Implement irq_(request|release)_resources
In-Reply-To: <562FA849.2070306@metafoo.de>
References: <1445607381-7794-1-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkda4QKEJvwkwGLS7OLTP8Nxu5W05tzbcFXA_FPnBsFtKhw@mail.gmail.com>
 <562FA849.2070306@metafoo.de>
Message-ID: <alpine.DEB.2.11.1510301103150.4032@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Oct 2015, Lars-Peter Clausen wrote:
> On 10/27/2015 04:53 PM, Linus Walleij wrote:
> > On Fri, Oct 23, 2015 at 3:36 PM, Soren Brinkmann
> > <soren.brinkmann@xilinx.com> wrote:
> > 
> >> The driver uses runtime PM to leverage low power techniques. For
> >> use-cases using GPIO as interrupt the device needs to be in an
> >> appropriate state.
> >>
> >> Reported-by: John Linn <linnj@xilinx.com>
> >> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> >> Tested-by: John Linn <linnj@xilinx.com>
> > 
> > As pointed out by Grygorii in
> > commit aca82d1cbb49af34b69ecd4571a0fe48ad9247c1:
> > 
> >     The PM runtime API can't be used in atomic contex on -RT even if
> >     it's configured as irqsafe. As result, below error report can
> >     be seen when PM runtime API called from IRQ chip's callbacks
> >     irq_startup/irq_shutdown/irq_set_type, because they are
> >     protected by RAW spinlock:
> > (...)
> >     The IRQ chip interface defines only two callbacks which are executed in
> >     non-atomic contex - irq_bus_lock/irq_bus_sync_unlock, so lets move
> >     PM runtime calls there.
> > 
> > I.e. these calls are atomic context and it's just luck that it works
> > and this is fragile.
> > 
> > Can you please check if you can move it to
> > irq_bus_lock()/irq_sync_unlock()
> > like Grygorii does?
> 
> That only powers up the chip when the chip is accessed. For proper IRQ
> operation the chip needs to be powered up though as long as the IRQ is
> enabled. request_irq() and free_irq() must always be called from sleepable
> context. The thing is just that request_resource/release_resource are called
> from within a raw spinlock, which is necessary since otherwise you can't
> guarantee that they are only called once for shared interrupts.
> 
> It might make sense to add a separate set of callbacks to the irq_chip
> struct that are called from the sleepable sections of
> request_irq()/free_irq() which are meant for power management purposes and
> which wont have the guarantee that they are only called once for shared IRQs
> (but are still balanced).
> 
> Thomas, do you have any thoughts on this?

If you want to keep the chip powered as long as an interrupt is
enabled, then having a irq chip callback might be the proper solution.

Thanks,

	tglx
