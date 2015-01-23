From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 23 Jan 2015 10:03:30 +0000
Subject: [PATCH] irqchip: gicv3-its: fix ITS CPU init
In-Reply-To: <54AFFD76.7060401@arm.com>
References: <1420818645-2349-1-git-send-email-vladimir.murzin@arm.com>
 <54AFFD76.7060401@arm.com>
Message-ID: <54C21C72.2030302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/15 16:10, Marc Zyngier wrote:
> Hi Vladimir,
> 
> On 09/01/15 15:50, Vladimir Murzin wrote:
>> We skip initialisation of ITS in case the device-tree has no
>> corresponding description, but we are still accessing to ITS bits while
>> setting CPU interface what leads to the kernel panic:
>>
>> ITS: No ITS available, not enabling LPIs
>> CPU0: found redistributor 0 region 0:0x000000002f100000
>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> pgd = ffffffc0007fb000
>> [00000000] *pgd=00000000fc407003, *pud=00000000fc407003, *pmd=00000000fc408003, *pte=006000002f000707
>> Internal error: Oops: 96000005 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.19.0-rc2+ #318
>> Hardware name: FVP Base (DT)
>> task: ffffffc00077edb0 ti: ffffffc00076c000 task.ti: ffffffc00076c000
>> PC is at its_cpu_init+0x2c/0x320
>> LR is at gic_cpu_init+0x168/0x1bc
>>
>> It happens in gic_rdists_supports_plpis() because gic_rdists is NULL.
>> The gic_rdists is set to non-NULL only when ITS node is presented in
>> the device-tree.
>>
>> Fix this by moving the call to gic_rdists_supports_plpis() inside the
>> !list_empty(&its_nodes) block, because it is that list that guards the
>> validity of the rest of the information in this driver.
>>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> 
> Looks good to me.
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> 	M.
> 

Thomas, Jason, are you OK with this patch?

Vladimir

>> ---
>>  drivers/irqchip/irq-gic-v3-its.c |    9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 86e4684..128a12b 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1382,12 +1382,11 @@ static bool gic_rdists_supports_plpis(void)
>>  
>>  int its_cpu_init(void)
>>  {
>> -	if (!gic_rdists_supports_plpis()) {
>> -		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
>> -		return -ENXIO;
>> -	}
>> -
>>  	if (!list_empty(&its_nodes)) {
>> +		if (!gic_rdists_supports_plpis()) {
>> +			pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
>> +			return -ENXIO;
>> +		}
>>  		its_cpu_init_lpis();
>>  		its_cpu_init_collection();
>>  	}
>>
> 
> 
