From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 02 Sep 2016 23:21:12 +0200
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <20160902185641.GF1041@n2100.armlinux.org.uk> (Russell King's
 message of "Fri, 2 Sep 2016 19:56:41 +0100")
References: <87k2eycip0.fsf@belgarion.home>
 <20160830184612.GO1041@n2100.armlinux.org.uk>
 <87fupmc59b.fsf@belgarion.home>
 <20160831084938.GQ1041@n2100.armlinux.org.uk>
 <20160831102721.GR1041@n2100.armlinux.org.uk>
 <87twe0krym.fsf@belgarion.home>
 <20160901092754.GU1041@n2100.armlinux.org.uk>
 <87oa47l1tn.fsf@belgarion.home>
 <20160901230248.GA1041@n2100.armlinux.org.uk>
 <87inuekx78.fsf@belgarion.home>
 <20160902185641.GF1041@n2100.armlinux.org.uk>
Message-ID: <87zinqj8vr.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Fri, Sep 02, 2016 at 07:50:35PM +0200, Robert Jarzmik wrote:
> It should enable the interrupt - the end of that does:
>
>         if (handle != handle_bad_irq && is_chained) {
>                 irq_settings_set_noprobe(desc);
>                 irq_settings_set_norequest(desc);
>                 irq_settings_set_nothread(desc);
>                 desc->action = &chained_action;
>                 irq_startup(desc, true);
>         }
>
> and indeed, I see that it gets enabled on Assabet.  That irq_startup()
> should result in the irqchip's irq_startup, irq_enable, or irq_unmask
> method being called.
In my case, irq_startup() is never called for irq 305, ie. LUBBOCK_SA1111_IRQ.
See deep down the mail for the cause ...

> So, that should result in the IRQ to which the sa1111 is connected
> being unmasked.
Hmm, it never happens to me ...

> Chained interrupts don't appear in /proc/interrupts.
Ah ok.

>> I traced the code in the interrupt controller (pxa_cplds_irqs), the SA1111
>> physical line is not set (even with an AT/2 keyboard connected, and I don't
>> think anybody tried this AT/2 on a lubbock for a long time).
>
> Hmm.  Looking at pxa_cplds_irqs, that's trying to support the CPLD
> interrupts using a very very old and inefficient technique.  The
> whole point of the chained interrupt system is to avoid several
> overheads in the system...  I'm curious why PXA moved away from that.
I think I traced that in the commit message of :
aa8d6b73ea33 ("ARM: pxa: pxa_cplds: add lubbock and mainstone IO")

The concern I had was that the former mechanism was not working anymore as the
chained handler was overwritten in gpio-pxa.c, and I wanted that gpio be
possibly probed at device initcall time.

> One of the problems is that we end up nesting irq_entry()/irq_exit()
> which contains a lot of code, eg trying to run softirqs.  All that
> stuff is pure overhead because we'll never get to run anything like
> that in this path.
>
> I'm also very concerned that the conversion is wrong.  The old code
> has this comment in the irq_unmask function:
>
> -       /* the irq can be acknowledged only if deasserted, so it's done here */
> -       LUB_IRQ_SET_CLR &= ~(1 << lubbock_irq);
>
> In other words, we "acknowledge" (really clear the latched status) of
> the interrupt _after_ we've serviced the peripheral, not before.
> The new code tries to clear down the interrupt when masking it - in
> other words, before the peripheral handler has had a chance to clear
> down its interrupt.

I will check it more carefully. I remember having made tests, and cross-checked
the user manual of the Cotulla Development board, chapter 3.4 "Managing
Peripheral Interrupts", where there is no restriction on when the latched status
can be cleared.

I understand the concern that clearing the status before the interrupt source is
serviced can re-set the status during the peripheral handler, if it's a level
interrupt.

Maybe it worked so far by sheer luck, or because the ethernet card was the only
really tested interrupt.

> I suspect you're seeing about twice as many interrupt counts on your
> ethernet interface because of this - you'll be entering the handler
> once for the real interrupt, but because the clear-down was ineffective,
> you end up re-entering it a second time when hopefully the peripheral
> is no longer asserting the interrupt.
Mmm I will check, but see 2 cat /proc/interrupts in a row :
307:       9384  pxa_cplds   3 Edge      eth0
307:       9417  pxa_cplds   3 Edge      eth0

The difference is not a multiple of 2. I will check anyway.

>> The interrupt is for sure masked, and therefore the SA1111 interrupts are not
>> fired. Even if they would have been enabled, the "pending interrupts register"
>> doesn't show any sa1111 interrupt pending, so there is something else.
>
> Masked where though - in the SA1111 or FPGA?
In the FPGA.

>> As I don't know if "enable_irq()" in sa1111.c would be an option as I have no
>> sight on sa1111.c requirements, I would take any advice here.
>
> It shouldn't be required, as I say above, irq_set_chained_handler_and_data()
> deals with unmasking the IRQ already.
Ah I think I know what happens. The trick is that when this
irq_set_chained_handler_and_data() is called, the irq_desc for irq 305 is not
yet allocated (ie. is NULL). And it is not allocated because
pxa_cplds_irqs.cplds_probe() was not yet called, and had not allocated the irq
descriptors.

I would bet that on neponset the input interrupt to the SA1111 is within
0..NR_IRQS, which is not the case on lubbock anymore since the pxa_cplds_irqs
conversion.

It looks that I have an ordering problem :
 - I want gpio-pxa.probe() to be called at device initcall time
 - pxa_cplds_irqs.probe() cannot complete before gpio-pxa.probe() because it
   needs GPIO0 as its interrupt source
   => it might need to honor -EPROBE_DEFER
 - sa1111.sa1111_probe() cannot complete before pxa_cplds_irqs.probe() because
   it needs IRQ305 as its source
   => it might need to honor -EPROBE_DEFER

I fail to see how the "optimized" irq chained handler can be used in a
device-tree type build, where I don't think the probe ordering is guaranteed.

Cheers.

-- 
Robert
