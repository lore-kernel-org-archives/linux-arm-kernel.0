From: eric@anholt.net (Eric Anholt)
Date: Mon, 13 Jul 2015 09:06:10 -0700
Subject: [PATCH 4/4] irqchip: Add bcm2836 interrupt controller for
 Raspberry Pi 2.
In-Reply-To: <alpine.DEB.2.11.1507110940420.17353@nanos>
References: <1436303617-17185-1-git-send-email-eric@anholt.net>
 <1436303617-17185-5-git-send-email-eric@anholt.net>
 <55A0A5EB.4090007@wwwdotorg.org> <alpine.DEB.2.11.1507110940420.17353@nanos>
Message-ID: <878uakqbyl.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Fri, 10 Jul 2015, Stephen Warren wrote:
>> On 07/07/2015 03:13 PM, Eric Anholt wrote:
>> > +static void bcm2836_mask_per_cpu_irq(unsigned int reg, unsigned int bit)
>> > +{
>> > +	void __iomem *reg_base = intc.base + reg;
>> > +	unsigned int i;
>> > +
>> > +	for (i = 0; i < 4; i++)
>> 
>> Is "4" there the CPU count? Perhaps this should use one of the Linux
>> APIs to query the CPU count rather than hard-coding it?
>> 
>> Should per-CPU IRQs automatically be masked on all CPUs at once, or only
>> on the current CPU? A very quick look at the ARM GIC driver implies it
>> doesn't iterate over all CPUs when masking per-CPU IRQs.
>
> Usually per cpu interrupts are only masked on the cpu which is calling
> the function. The whole reason why per cpu interrupts exist is that
> you can share the same interrupt number for all cores.
>
> So masking all interrupts is not a good idea. In this case if a cpu is
> hot unplugged, then all other cpus would not longer get timer
> interrupts. Not what you really want, right?

I was replicating the behavior of the downstream driver, but it seemed
suspicious.  Converting to using smp_processor_id() to just mask/unmask
this CPU's interrupts seems to have gone fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150713/4eca8e6e/attachment.sig>
