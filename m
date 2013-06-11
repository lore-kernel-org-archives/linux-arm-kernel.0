From: mario.smarduch@huawei.com (Mario Smarduch)
Date: Tue, 11 Jun 2013 17:22:49 +0200
Subject: [PATCH 1/2] add irq priodrop support
In-Reply-To: <20130611122122.478603E0A90@localhost>
References: <51B6D3B4.1020800@huawei.com>
 <20130611122122.478603E0A90@localhost>
Message-ID: <51B740C9.4030101@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,    
	appreciate the strong feedback, I agree with all
	the coding observations will make the changes. 
	I have few inline responses.


>> +static u32  gic_irq_prio_drop[DIV_ROUND_UP(1020, 32)] __read_mostly;
> 
> I believe it is possible to have more than one GIC in a system. This map
> assumes only one. The prio_drop map should probably be part of
> gic_chip_data so that it is per-instance.
> 
> Also, as discussed below, the code should be using DECLARE_BITMAP()

Agree.

> 
> gic_priodrop_remap_eoi() is used exactly once. You should instead put
> the body of it inline like so:
> 
> 	if (IS_ENABLED(CONFIG_KVM_ARM_INT_PRIO_DROP) && is_hyp_mode_available())
> 		chip->irq_eoi = gic_eoi_irq_priodrop;

Yes much cleaner.

> 
> However, this block is problematic. For each map call it modifies the
> /global/ gic_chip. It's not a per-interrupt thing, but rather changes
> the callback for all gic interrupts, on *any* gic in the system. Is this
> really what you want?
> 
> If it is, then I would expect the callback to be modified once sometime
> around gic_init_bases() time.

Yes need to move it up, now its being set for each IRQ domain mapping call.

> 
> If it is not, and what you really want is per-irq behaviour, then what
> you need to do is have a separate gic_priodrop_chip that can be used on
> a per-irq basis instead of the gic_chip.

Prio drop/deactivate is per CPU and all IRQs are affected including SGIs.
It's possible to run mixed CPU modes, but this patch enables all CPUs for
device passthrough, similar to hyp mode enable.

Another way would be the reverse - set all non-passthrough irqs to gic_priodrop_chip
and the passed through IRQ to gic_chip.  I think keeping it in one function
and just setting a bit to enable/disable is cleaner.


> 
>>  	if (hw < 32) {
>>  		irq_set_percpu_devid(irq);
>>  		irq_set_chip_and_handler(irq, &gic_chip,
>> @@ -857,4 +875,125 @@ IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
>>  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
>>  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
>>  
>> +#ifdef CONFIG_KVM_ARM_INT_PRIO_DROP
>> +/* If HYP mode enabled and PRIO DROP set EOIR function to handle PRIO DROP */
>> +static inline void gic_priodrop_remap_eoi(struct irq_chip *chip)
>> +{
>> +	if (is_hyp_mode_available())
>> +		chip->irq_eoi = gic_eoi_irq_priodrop;
>> +}
>> +
>> +/* If HYP mode set enable interrupt priority drop/deactivation, and mark
>> + * SGIs to deactive through writes to GCICC_DIR. For Guest only enable normal
>> + * mode.
>> + */
> 
> Nit: Read Documentation/kernel-doc-nano-HOWTO.txt. It's a good idea to
> stick to that format when writing function documenation. Also,
> convention is for multiline comments to have an empty /* line before the
> first line of text.

Will do.

> 


>> +}
>> +
>> +void gic_spi_clr_priodrop(int irq)
>> +{
>> +	struct irq_data *d = irq_get_irq_data(irq);
>> +	if (likely(irq >= 32 && irq < 1019)) {
> 
> "< 1019" ...
> 
>> +		clear_bit(irq % 32, (void *) &gic_irq_prio_drop[irq/32]);
>> +		writel_relaxed(irq, gic_cpu_base(d) + GIC_CPU_DIR);
>> +	}
>> +}
>> +
>> +int gic_spi_get_priodrop(int irq)
>> +{
>> +	if (likely(irq >= 32 && irq <= 1019))
> 
> ... "<= 1019"
> 
> Looks like some off-by-one errors going on here. Also, the rest of the
> gic code uses 1020, not 1019 as the upper limit. What is the reason for
> being difference in this code block?

Hmmm a mistake.

>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
