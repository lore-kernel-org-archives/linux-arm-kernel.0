From: robherring2@gmail.com (Rob Herring)
Date: Tue, 14 Feb 2012 13:12:52 -0600
Subject: [PATCH v3] ARM: rpc: make default fiq handler run-time installed
In-Reply-To: <alpine.LFD.2.02.1202141233470.24536@xanadu.home>
References: <alpine.LFD.2.02.1202082229400.1656@xanadu.home>
 <1329231018-15625-1-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1202141233470.24536@xanadu.home>
Message-ID: <4F3AB234.3060704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2012 11:37 AM, Nicolas Pitre wrote:
> On Tue, 14 Feb 2012, Rob Herring wrote:
> 
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Only rpc uses disable_fiq macro. Change it to a run-time installed
>> default FIQ handler. The handler is installed before FIQ is enabled
>> so the behavior should be unchanged.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
>> Nico,
>>
>> This removes the use of disable_fiq now. To keep it bisectable, the macro
>> gets removed from entry-macro-iomd.S in the last patch now.
>>
> 
> [...]
> 
>> --- /dev/null
>> +++ b/arch/arm/mach-rpc/fiq.S
>> @@ -0,0 +1,16 @@
>> +#include <linux/linkage.h>
>> +#include <asm/assembler.h>
>> +#include <mach/hardware.h>
>> +#include <mach/entry-macro.S>
> 
> Do you need to include <mach/entry-macro.S> here?
> 

Yes, for...

> In any case:
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
>> +
>> +	.text
>> +
>> +	.global	rpc_default_fiq_end
>> +ENTRY(rpc_default_fiq_start)
>> +	mov	r12, #ioc_base_high

...these defines which are needed in both files.

Rob

>> +	.if	ioc_base_low
>> +	orr	r12, r12, #ioc_base_low
>> +	.endif
>> +	strb	r12, [r12, #0x38]	@ Disable FIQ register
>> +	subs	pc, lr, #4
>> +rpc_default_fiq_end:
>> diff --git a/arch/arm/mach-rpc/irq.c b/arch/arm/mach-rpc/irq.c
>> index 2e1b530..cf0e669 100644
>> --- a/arch/arm/mach-rpc/irq.c
>> +++ b/arch/arm/mach-rpc/irq.c
>> @@ -5,6 +5,7 @@
>>  #include <asm/mach/irq.h>
>>  #include <asm/hardware/iomd.h>
>>  #include <asm/irq.h>
>> +#include <asm/fiq.h>
>>  
>>  static void iomd_ack_irq_a(struct irq_data *d)
>>  {
>> @@ -112,6 +113,8 @@ static struct irq_chip iomd_fiq_chip = {
>>  	.irq_unmask	= iomd_unmask_irq_fiq,
>>  };
>>  
>> +extern unsigned char rpc_default_fiq_start, rpc_default_fiq_end;
>> +
>>  void __init rpc_init_irq(void)
>>  {
>>  	unsigned int irq, flags;
>> @@ -121,6 +124,9 @@ void __init rpc_init_irq(void)
>>  	iomd_writeb(0, IOMD_FIQMASK);
>>  	iomd_writeb(0, IOMD_DMAMASK);
>>  
>> +	set_fiq_handler(&rpc_default_fiq_start,
>> +		&rpc_default_fiq_end - &rpc_default_fiq_start);
>> +
>>  	for (irq = 0; irq < NR_IRQS; irq++) {
>>  		flags = IRQF_VALID;
>>  
>> -- 
>> 1.7.5.4
>>
