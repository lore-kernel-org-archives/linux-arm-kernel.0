From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Sep 2015 12:08:51 +0100
Subject: Recent GIC v1 patch
In-Reply-To: <55FBD6F4.8030905@free.fr>
References: <55FAE26A.9040609@free.fr> <55FAEB4D.30306@arm.com>
 <55FAF6E1.7020107@free.fr> <55FAFD3E.7010006@arm.com>
 <55FBD6F4.8030905@free.fr>
Message-ID: <20150918120851.6f9fb306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Sep 2015 11:18:44 +0200
Mason <slash.tmp@free.fr> wrote:

> On 17/09/2015 19:49, Marc Zyngier wrote:
> > On 17/09/15 18:22, Mason wrote:
> >> On 17/09/2015 18:33, Marc Zyngier wrote:
> >>> Hi Mason,
> >>>
> >>> On 17/09/15 16:55, Mason wrote:
> >>>> Hello Thomas, Marc,
> >>>>
> >>>> Mans pointed me to a recent patch of yours.
> >>>> irqchip/gic: Use IRQD_FORWARDED_TO_VCPU flag
> >>>> Get rid of the handler_data abuse.
> >>>>
> >>>> I'm using a Cortex A9 based SoC. The platform's interrupt
> >>>> controller is cascaded into the GIC. I've been trying to
> >>>> get this to work for two weeks with no success.
> >>>>
> >>>> Details can be found here:
> >>>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/440327
> >>>>
> >>>> Do you think your patch might help with my situation?
> >>>
> >>> Not sure. A GICv1 shouldn't use EOImode==1 at all, so I don't quite see
> >>> how you end-up there. Also, you seem to be using 4.2, and this code only
> >>> landed during the 4.3 merge window.
> >>
> >> Sorry for being unclear. I'm having problems /without/ the patch,
> >> and Mans suggested I try the patch.
> > 
> > But that patch will only apply if you run 4.3, because it fixes an issue
> > in another patch that only exists in 4.3.
> 
> If I understand correctly, you're saying there is no point in
> trying to rebase the referenced patch on top of v4.2?

None. This patch doesn't apply to 4.2 at all.

> >>>> Do you have any idea what might causing the problem?
> >>>
> >>> Not without more information, I'm afraid.
> >>
> >> Being the unimaginative type, I provided boot log, .config,
> >> full port source code, and device tree description. Can you
> >> explain what kind of information would be required to identify
> >> the problem? (Maybe that would help me diagnose the problem.)
> > 
> > It looks likely that when you enable your ethernet interface, this ends
> > up calling into the GIC for some reason, screwing up something.
> > 
> > Can you trace things happening in the GIC for hwirq 34?
> 
> For my information, what is hwirq 34?

Well, look at your DT:

	irqintc: irq at 000 {
		reg = <0x000 0x100>;
		interrupt-parent = <&gic>;
		interrupt-controller;
		#interrupt-cells = <2>;
		interrupts = <0 2 4>;
		label = "IRQ";
	};

interrupt = <0 2 4> indicates SPI number 2, which is the GIC ID34.

> I'm looking at the Cortex A9 TRM. I see
> ID27 = global timer (not using this, I think)
> ID28 = legacy nFIQ  (no idea what this is)
> ID29 = twd local timer  (this is the interrupt that stops firing)
> ID30 = twd watchdog timer (not using this)
> ID31 = legacy nIRQ
> 
> OK, these are PPIs, so not what you were interested in, AFAIU.
> SPIs start at ID32. Hmmm, how do you know what ID34 is?

See above.

> Here's the stack trace when I hit twd_handler()
> 
> #0 twd_handler( irq = 196, dev_id = (void*) 0xE7AEC7A0 ) at smp_twd.c:233
> #1 handle_percpu_devid_irq( irq = 196, desc = (struct irq_desc*) 0xC0379B20 ) at chip.c:714
> #2 generic_handle_irq( irq = 196 ) at irqdesc.c:347
> #3 __handle_domain_irq( domain = (struct irq_domain*) 0xE7402000, hwirq = 29, lookup = true, regs = (struct pt_regs*) 0xC0371ED0 ) at irqdesc.c:386
> #4 gic_handle_irq( regs = (struct pt_regs*) 0xC0371ED0 ) at irq-gic.c:276
> #5 [__irq_svc+0x40]
> 
> 
> Here's the stack trace when I hit enet_isr()
> 
> #0 enet_isr( irq = 40, dev_id = (void*) 0xE75A1000 ) at tangox_enet.c:512
> #1 handle_irq_event_percpu( desc = (struct irq_desc*) 0xC03739A0, action = (struct irqaction*) 0xE74A4180 ) at handle.c:143
> #2 handle_irq_event( desc = (struct irq_desc*) 0xC03739A0 ) at handle.c:192
> #3 handle_level_irq( irq = 40, desc = (struct irq_desc*) 0xC03739A0 ) at chip.c:459
> #4 generic_handle_irq( irq = 40 ) at irqdesc.c:347
> #5 tangox_dispatch_irqs( dom = (struct irq_domain*) 0xE7402400, status = 64, base = 32 ) at irq-tangox.c:69
> #6 tangox_irq_handler( irq = 1, desc = (struct irq_desc*) 0xC0372140 ) at irq-tangox.c:84
> #7 generic_handle_irq( irq = 1 ) at irqdesc.c:347
> #8 __handle_domain_irq( domain = (struct irq_domain*) 0xE7402000, hwirq = 34, lookup = true, regs = (struct pt_regs*) 0xE7439B00 ) at irqdesc.c:386
> #9 gic_handle_irq( regs = (struct pt_regs*) 0xE7439B00 ) at irq-gic.c:276
> #10 [__irq_svc+0x40]
> 
> 
> Hmmm, hwirq 34 shows up there...

As expected.

> I tried adding a trace to gic_handle_irq()
> 
> 		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
> 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
> 		printk("irqstat=0x%x irqnr=%u\n", irqstat, irqnr);
> 
> but that's too brutal, the system is flooded with
> 
> [    0.100402] irqstat=0x3ff irqnr=1023
> [    0.103630] irqstat=0x1d irqnr=29
> [    0.103731] irqstat=0x3ff irqnr=1023
> [    0.106964] irqstat=0x1d irqnr=29
> [    0.107198] irqstat=0x3ff irqnr=1023
> [    0.110298] irqstat=0x1d irqnr=29
> [    0.110427] irqstat=0x3ff irqnr=1023
> [    0.113631] irqstat=0x1d irqnr=29
> [    0.113847] irqstat=0x3ff irqnr=1023
> (and later, printk starts dropping messages.)
> 
> Changing printk to a histogram...
> 
> u32 irq_count, irq_histogram[1200];
> ...
> 	++irq_count; ++irq_histogram[irqnr];
> 
> and dumping the histogram right before the hanging msleep:
> 
> 	for (i = 0; i < 1200; ++i) {
> 		u32 count = irq_histogram[i];
> 		if (count > 0) printk("%4u: %u\n", i, count);
> 	}
> 
> [    1.255370] IP-Config: Entered.
> [    1.258836] TESTING msleep
> [    1.763659] WAKE UP
> [    1.765781] CALLING wait_for_devices
> [    1.769414] CALLING ic_open_devs
> [    1.774048] enet_isr
> [    2.275398] IP-Config: eth0 UP (able=1, xid=3e27d617)
> [    2.280490]   29: 420
> [    2.282772]   34: 1
> [    2.284911] 1023: 421
> [    2.287194] SLEEP CONF_POST_OPEN
> <hang>
> 
> Is this 1023 IRQ expected?
> The system handles two interrupts for every local timer expiration?

1023 is not an interrupt. This is how the GIC tells you that there is
no other interrupt pending (see gic_handle_irq, and notice the far too
subtle "break;" statement at the bottom of the loop).

[snip register dumps]

> Don't know if anything I posted helps with diagnostics?
> Or did I look in the wrong place altogether?

No idea so far. The only thing I can immediately spot is a missing pair
of chained_irq_{enter,exit} in tangox_irq_handler, but I can't imagine
this having a terminal effect on the system.

	M.
-- 
Jazz is not dead. It just smells funny.
