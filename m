From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 12 Aug 2015 13:38:27 +0100
Subject: [PATCH 1/6] irqchip: GICv3: Convert to EOImode == 1
In-Reply-To: <55C9BD00.7030901@linaro.org>
References: <1436447951-22357-1-git-send-email-marc.zyngier@arm.com>
 <1436447951-22357-2-git-send-email-marc.zyngier@arm.com>
 <55C9BD00.7030901@linaro.org>
Message-ID: <55CB3E43.3010209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/15 10:14, Eric Auger wrote:
> Hi Marc,
> On 07/09/2015 03:19 PM, Marc Zyngier wrote:
>> So far, GICv3 has been used in with EOImode == 0. The effect of this
>> mode is to perform the priority drop and the deactivation of the
>> interrupt at the same time.
>>
>> While this works perfectly for Linux (we only have a single priority),
>> it causes issues when an interrupt is forwarded to a guest, and when
>> we want the guest to perform the EOI itself.
>>
>> For this case, the GIC architecture provides EOImode == 1, where:
>> - A write to ICC_EOIR1_EL1 drops the priority of the interrupt and leaves
>> it active. Other interrupts at the same priority level can now be taken,
>> but the active interrupt cannot be taken again
>> - A write to ICC_DIR_EL1 marks the interrupt as inactive, meaning it can
>> now be taken again.
>>
>> This patch converts the driver to be able to use this new mode, depending
>> on whether or not the kernel can behave as a hypervisor. No feature change.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/irqchip/irq-gic-v3.c       | 28 +++++++++++++++++++++++++---
>>  include/linux/irqchip/arm-gic-v3.h |  9 +++++++++
>>  2 files changed, 34 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index c52f7ba..49768fc 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -30,6 +30,7 @@
>>  #include <asm/cputype.h>
>>  #include <asm/exception.h>
>>  #include <asm/smp_plat.h>
>> +#include <asm/virt.h>
>>  
>>  #include "irq-gic-common.h"
>>  #include "irqchip.h"
>> @@ -50,6 +51,7 @@ struct gic_chip_data {
>>  };
>>  
>>  static struct gic_chip_data gic_data __read_mostly;
>> +static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
>>  
>>  #define gic_data_rdist()		(this_cpu_ptr(gic_data.rdists.rdist))
>>  #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
>> @@ -293,7 +295,10 @@ static int gic_irq_get_irqchip_state(struct irq_data *d,
>>  
>>  static void gic_eoi_irq(struct irq_data *d)
>>  {
>> -	gic_write_eoir(gic_irq(d));
>> +	if (static_key_true(&supports_deactivate))
>> +		gic_write_dir(gic_irq(d));
>> +	else
>> +		gic_write_eoir(gic_irq(d));
>>  }
>>  
>>  static int gic_set_type(struct irq_data *d, unsigned int type)
>> @@ -343,6 +348,10 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>>  
>>  		if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
>>  			int err;
>> +
>> +			if (static_key_true(&supports_deactivate))
>> +				gic_write_eoir(irqnr);
>> +
>>  			err = handle_domain_irq(gic_data.domain, irqnr, regs);
>>  			if (err) {
>>  				WARN_ONCE(true, "Unexpected interrupt received!\n");
> shouldn't we DIR here as well in case of err (we did EOI before)?

Yes, we should, very good point. I'll fix that up.

> Besides Reviewed-by: Eric Auger <eric.auger@linaro.org> if it can help.
> 

Thanks!

	M.
-- 
Jazz is not dead. It just smells funny...
