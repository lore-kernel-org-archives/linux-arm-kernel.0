From: eric@anholt.net (Eric Anholt)
Date: Mon, 13 Jul 2015 11:48:57 -0700
Subject: [PATCH 4/4] irqchip: Add bcm2836 interrupt controller for
 Raspberry Pi 2.
In-Reply-To: <55A0A5EB.4090007@wwwdotorg.org>
References: <1436303617-17185-1-git-send-email-eric@anholt.net>
 <1436303617-17185-5-git-send-email-eric@anholt.net>
 <55A0A5EB.4090007@wwwdotorg.org>
Message-ID: <87bnffao6e.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 07/07/2015 03:13 PM, Eric Anholt wrote:
>> This interrupt controller is the new root interrupt controller with
>> the timer, PMU events, and IPIs, and the bcm2835's interrupt
>> controller is chained off of it to handle the peripherals.
>> 
>> SMP IPI support was mostly written by Andrea Merello, while I wrote
>> most of the rest of the IRQ handling.
>> 
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>
> I'd expect the git patch author to be Andrea if he wrote the original
> patch and you enhanced it.

I wrote the IRQs patch, and Andrea added the IPI bits to it.

>> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
>
>> +struct arm_local_intc {
>> +	struct irq_domain *domain;
>> +	void __iomem *base;
>> +};
>> +
>> +static struct arm_local_intc intc  __read_mostly;
>
> It'd be nice to give everything (types, functions, variables) a
> consistent symbol prefix; bcm2836_arm_irqchip_ sounds like a good
> bikeshed to me, but perhaps just propagating the above arm_local_ to the
> functions too would be good, although that seems to risk symbol name
> collisions with other ARM SoCs.

Done.

>> +static void bcm2836_mask_gpu_irq(struct irq_data *d)
>> +{
>> +}
>> +
>> +static void bcm2836_unmask_gpu_irq(struct irq_data *d)
>> +{
>> +}
>
> If the IRQs can't be masked, should these functions actually be implemented?

They are called unconditionally at IRQ enable time.  I don't see a way
to mask them.

>> +static void __exception_irq_entry bcm2836_handle_irq(struct pt_regs *regs)
>> +{
>> +	int cpu = smp_processor_id();
>> +	u32 stat;
>> +
>> +	stat = readl_relaxed(intc.base + LOCAL_IRQ_PENDING0 + 4 * cpu);
>> +	if (stat & 0x10) {
>> +		void __iomem *mailbox0 = (intc.base +
>> +					  LOCAL_MAILBOX0_CLR0 + 16 * cpu);
>> +		u32 mbox_val = readl(mailbox0);
>> +		u32 ipi = ffs(mbox_val) - 1;
>> +
>> +		writel(1 << ipi, mailbox0);
>> +		handle_IPI(ipi, regs);
>
> Given that bcm2836_send_ipi() is #ifdef CONFIG_SMP, should this code be too?

Sure, done.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150713/4d75b89e/attachment.sig>
