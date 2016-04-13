From: eric@anholt.net (Eric Anholt)
Date: Wed, 13 Apr 2016 12:49:19 -0700
Subject: [PATCH 2/4] irqchip: bcm2836: Drop smp_set_ops on arm64 builds
In-Reply-To: <201604082243.52300.arnd@arndb.de>
References: <1459827858-3871-1-git-send-email-eric@anholt.net>
 <1459827858-3871-3-git-send-email-eric@anholt.net>
 <201604082243.52300.arnd@arndb.de>
Message-ID: <878u0hwaps.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday 05 April 2016, Eric Anholt wrote:
>> For arm64, the bootloader will instead be implementing the spin-table
>> enable method.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  drivers/irqchip/irq-bcm2836.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
>> index 233ccdd..4ae9f76 100644
>> --- a/drivers/irqchip/irq-bcm2836.c
>> +++ b/drivers/irqchip/irq-bcm2836.c
>> @@ -223,6 +223,7 @@ static struct notifier_block bcm2836_arm_irqchip_cpu_notifier = {
>>  	.priority = 100,
>>  };
>>  
>> +#ifdef ARM
>>  int __init bcm2836_smp_boot_secondary(unsigned int cpu,
>>  				      struct task_struct *idle)
>>  {
>> @@ -238,7 +239,7 @@ int __init bcm2836_smp_boot_secondary(unsigned int cpu,
>>  static const struct smp_operations bcm2836_smp_ops __initconst = {
>>  	.smp_boot_secondary	= bcm2836_smp_boot_secondary,
>>  };
>> -
>> +#endif
>>  #endif
>>  
>>  static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
>> @@ -256,8 +257,11 @@ bcm2836_arm_irqchip_smp_init(void)
>>  	register_cpu_notifier(&bcm2836_arm_irqchip_cpu_notifier);
>>  
>>  	set_smp_cross_call(bcm2836_arm_irqchip_send_ipi);
>> +
>> +#ifdef ARM
>>  	smp_set_ops(&bcm2836_smp_ops);
>>  #endif
>> +#endif
>>  }
>
> I'd suggest instead using CPU_METHOD_OF_DECLARE and moving the SMP code
> to arch/arm/mach-bcm/platsmp-bcm2835.c. It doesn't really belong in the
> irqchip code.

I think because of DT ABI (sigh) we're stuck with the current
implementation.

FWIW, I had started with the SMP bits in a platsmp.c, but moved it into
the irqchip because that was so much simpler than reaching over into the
irqchip node to map its registers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160413/714a26ec/attachment.sig>
