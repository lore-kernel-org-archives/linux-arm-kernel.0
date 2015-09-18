From: slash.tmp@free.fr (Mason)
Date: Fri, 18 Sep 2015 11:18:44 +0200
Subject: Recent GIC v1 patch
In-Reply-To: <55FAFD3E.7010006@arm.com>
References: <55FAE26A.9040609@free.fr> <55FAEB4D.30306@arm.com>
 <55FAF6E1.7020107@free.fr> <55FAFD3E.7010006@arm.com>
Message-ID: <55FBD6F4.8030905@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/09/2015 19:49, Marc Zyngier wrote:
> On 17/09/15 18:22, Mason wrote:
>> On 17/09/2015 18:33, Marc Zyngier wrote:
>>> Hi Mason,
>>>
>>> On 17/09/15 16:55, Mason wrote:
>>>> Hello Thomas, Marc,
>>>>
>>>> Mans pointed me to a recent patch of yours.
>>>> irqchip/gic: Use IRQD_FORWARDED_TO_VCPU flag
>>>> Get rid of the handler_data abuse.
>>>>
>>>> I'm using a Cortex A9 based SoC. The platform's interrupt
>>>> controller is cascaded into the GIC. I've been trying to
>>>> get this to work for two weeks with no success.
>>>>
>>>> Details can be found here:
>>>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/440327
>>>>
>>>> Do you think your patch might help with my situation?
>>>
>>> Not sure. A GICv1 shouldn't use EOImode==1 at all, so I don't quite see
>>> how you end-up there. Also, you seem to be using 4.2, and this code only
>>> landed during the 4.3 merge window.
>>
>> Sorry for being unclear. I'm having problems /without/ the patch,
>> and Mans suggested I try the patch.
> 
> But that patch will only apply if you run 4.3, because it fixes an issue
> in another patch that only exists in 4.3.

If I understand correctly, you're saying there is no point in
trying to rebase the referenced patch on top of v4.2?

>>>> Do you have any idea what might causing the problem?
>>>
>>> Not without more information, I'm afraid.
>>
>> Being the unimaginative type, I provided boot log, .config,
>> full port source code, and device tree description. Can you
>> explain what kind of information would be required to identify
>> the problem? (Maybe that would help me diagnose the problem.)
> 
> It looks likely that when you enable your ethernet interface, this ends
> up calling into the GIC for some reason, screwing up something.
> 
> Can you trace things happening in the GIC for hwirq 34?

For my information, what is hwirq 34?

I'm looking at the Cortex A9 TRM. I see
ID27 = global timer (not using this, I think)
ID28 = legacy nFIQ  (no idea what this is)
ID29 = twd local timer  (this is the interrupt that stops firing)
ID30 = twd watchdog timer (not using this)
ID31 = legacy nIRQ

OK, these are PPIs, so not what you were interested in, AFAIU.
SPIs start at ID32. Hmmm, how do you know what ID34 is?


Here's the stack trace when I hit twd_handler()

#0 twd_handler( irq = 196, dev_id = (void*) 0xE7AEC7A0 ) at smp_twd.c:233
#1 handle_percpu_devid_irq( irq = 196, desc = (struct irq_desc*) 0xC0379B20 ) at chip.c:714
#2 generic_handle_irq( irq = 196 ) at irqdesc.c:347
#3 __handle_domain_irq( domain = (struct irq_domain*) 0xE7402000, hwirq = 29, lookup = true, regs = (struct pt_regs*) 0xC0371ED0 ) at irqdesc.c:386
#4 gic_handle_irq( regs = (struct pt_regs*) 0xC0371ED0 ) at irq-gic.c:276
#5 [__irq_svc+0x40]


Here's the stack trace when I hit enet_isr()

#0 enet_isr( irq = 40, dev_id = (void*) 0xE75A1000 ) at tangox_enet.c:512
#1 handle_irq_event_percpu( desc = (struct irq_desc*) 0xC03739A0, action = (struct irqaction*) 0xE74A4180 ) at handle.c:143
#2 handle_irq_event( desc = (struct irq_desc*) 0xC03739A0 ) at handle.c:192
#3 handle_level_irq( irq = 40, desc = (struct irq_desc*) 0xC03739A0 ) at chip.c:459
#4 generic_handle_irq( irq = 40 ) at irqdesc.c:347
#5 tangox_dispatch_irqs( dom = (struct irq_domain*) 0xE7402400, status = 64, base = 32 ) at irq-tangox.c:69
#6 tangox_irq_handler( irq = 1, desc = (struct irq_desc*) 0xC0372140 ) at irq-tangox.c:84
#7 generic_handle_irq( irq = 1 ) at irqdesc.c:347
#8 __handle_domain_irq( domain = (struct irq_domain*) 0xE7402000, hwirq = 34, lookup = true, regs = (struct pt_regs*) 0xE7439B00 ) at irqdesc.c:386
#9 gic_handle_irq( regs = (struct pt_regs*) 0xE7439B00 ) at irq-gic.c:276
#10 [__irq_svc+0x40]


Hmmm, hwirq 34 shows up there...


I tried adding a trace to gic_handle_irq()

		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
		printk("irqstat=0x%x irqnr=%u\n", irqstat, irqnr);

but that's too brutal, the system is flooded with

[    0.100402] irqstat=0x3ff irqnr=1023
[    0.103630] irqstat=0x1d irqnr=29
[    0.103731] irqstat=0x3ff irqnr=1023
[    0.106964] irqstat=0x1d irqnr=29
[    0.107198] irqstat=0x3ff irqnr=1023
[    0.110298] irqstat=0x1d irqnr=29
[    0.110427] irqstat=0x3ff irqnr=1023
[    0.113631] irqstat=0x1d irqnr=29
[    0.113847] irqstat=0x3ff irqnr=1023
(and later, printk starts dropping messages.)

Changing printk to a histogram...

u32 irq_count, irq_histogram[1200];
...
	++irq_count; ++irq_histogram[irqnr];

and dumping the histogram right before the hanging msleep:

	for (i = 0; i < 1200; ++i) {
		u32 count = irq_histogram[i];
		if (count > 0) printk("%4u: %u\n", i, count);
	}

[    1.255370] IP-Config: Entered.
[    1.258836] TESTING msleep
[    1.763659] WAKE UP
[    1.765781] CALLING wait_for_devices
[    1.769414] CALLING ic_open_devs
[    1.774048] enet_isr
[    2.275398] IP-Config: eth0 UP (able=1, xid=3e27d617)
[    2.280490]   29: 420
[    2.282772]   34: 1
[    2.284911] 1023: 421
[    2.287194] SLEEP CONF_POST_OPEN
<hang>

Is this 1023 IRQ expected?
The system handles two interrupts for every local timer expiration?

When I hit gic_handle_irq() and irqnr == 1023,

p/x *regs
$2 = {uregs = {0x0, 0xE7AE82A8, 0x2, 0xC0024540, 0xC037C2F8, 0xC036D284, 0xC028D44C, 0xC0371F38, 0xC038EE3E, 0xC037C354, 0xC0370000, 0xC0371F24, 0xC0371F28, 0xC0371F18, 0xC0016AC0, 0xC0016AC4, 0x60000013, 0xFFFFFFFF}}

p/x *regs
$4 = {uregs = {0x0, 0xE7AE82A8, 0x6, 0xC0024540, 0xC037C2F8, 0xC036D284, 0xC028D44C, 0xC0371F38, 0xC038EE3E, 0xC037C354, 0xC0370000, 0xC0371F24, 0xC0371F28, 0xC0371F18, 0xC0016AC0, 0xC0016AC4, 0x60000013, 0xFFFFFFFF}}

p/x *regs
$5 = {uregs = {0xC03BA570, 0xE744A948, 0x2, 0x2BF, 0x0, 0xE746B380, 0xE746B500, 0x0, 0xE746B380, 0x0, 0x0, 0xE7439EA4, 0xE7439EA8, 0xE7439E98, 0xC011ADC4, 0xC028A87C, 0x60000013, 0xFFFFFFFF}}


When I hit gic_handle_irq() and irqnr == 34, (irqstat=34)

p/x *regs
$1 = {uregs = {0x6B30EFBF, 0x0, 0xFD108900, 0xF52C, 0xC03BBB58, 0x6977, 0x6B30AD41, 0xE7537030, 0x0, 0x0, 0x0, 0xE7439CEC, 0xE7439CF0, 0xE7439CE0, 0xC0162338, 0xC0025B2C, 0xA0000013, 0xFFFFFFFF}}


Don't know if anything I posted helps with diagnostics?
Or did I look in the wrong place altogether?

Regards.
