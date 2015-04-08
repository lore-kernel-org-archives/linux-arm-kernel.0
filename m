From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 08 Apr 2015 11:23:20 +0100
Subject: [RESEND PATCH 4.0-rc5 v19 3/6] irqchip: gic: Introduce plumbing
 for IPI FIQ
In-Reply-To: <088d01d071d4$cddd9240$6998b6c0$@alibaba-inc.com>
References: <088701d071d3$ec642a90$c52c7fb0$@alibaba-inc.com>
 <088d01d071d4$cddd9240$6998b6c0$@alibaba-inc.com>
Message-ID: <55250198.1010808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/15 09:19, Hillf Danton wrote:
>> +/*
>> + * Fully acknowledge (both ack and eoi) any outstanding FIQ-based IPI,
>> + * otherwise do nothing.
>> + */
>> +void gic_handle_fiq_ipi(void)
>> +{
>> +	struct gic_chip_data *gic = &gic_data[0];
>> +	void __iomem *cpu_base = gic_data_cpu_base(gic);
>> +	unsigned long irqstat, irqnr;
>> +
>> +	if (WARN_ON(!in_nmi()))
>> +		return;
>> +
>> +	while ((1u << readl_relaxed(cpu_base + GIC_CPU_HIGHPRI)) &
>> +	       SMP_IPI_FIQ_MASK) {
>> +		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
>> +		writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
>> +
>> +		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
>> +		WARN_RATELIMIT(irqnr > 16,
>> +			       "Unexpected irqnr %lu (bad prioritization?)\n",
>
> Help more if s/Unexpected/Unexpected FIQ/ ?

The GIC logic to prioritize interrupts is independent of the logic to 
route interrupt sources to IRQ or FIQ. Thus if this code acknowledges an 
unexpected interrupt source then we really don't know whether it is an 
IRQ or a FIQ so we cannot accurately describe this is an unexpected FIQ.

If there is bad prioritization then we cannot predict what type of 
interrupt INTACK will give use.
