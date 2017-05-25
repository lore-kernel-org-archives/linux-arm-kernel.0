From: wei@redhat.com (Wei Huang)
Date: Thu, 25 May 2017 10:49:49 -0500
Subject: [PATCH 1/1] drivers/perf: arm_pmu_acpi: avoid perf IRQ init when
 guest PMU is off
In-Reply-To: <20170525152814.GR2859@arm.com>
References: <1495636601-14726-1-git-send-email-wei@redhat.com>
 <20170525152814.GR2859@arm.com>
Message-ID: <c11672c5-b167-f50f-2035-40a3db3ec598@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/25/2017 10:28 AM, Will Deacon wrote:
> Hi Wei,
> 
> On Wed, May 24, 2017 at 09:36:41AM -0500, Wei Huang wrote:
>> We saw perf IRQ init failures when running Linux kernel in an ACPI
>> guest without PMU (i.e. pmu=off). This is because perf IRQ is not
>> present when pmu=off, but arm_pmu_acpi still tries to register
>> or unregister GSI. This patch addresses the problem by checking
>> gicc->performance_interrupt. If it is 0, which is the value set
>> by qemu when pmu=off, we skip the IRQ register/unregister process.
>>
>> [    4.069470] bc00: 0000000000040b00 ffff0000089db190
>> [    4.070267] [<ffff000008134f80>] enable_percpu_irq+0xdc/0xe4
>> [    4.071192] [<ffff000008667cc4>] arm_perf_starting_cpu+0x108/0x10c
>> [    4.072200] [<ffff0000080cbdd4>] cpuhp_invoke_callback+0x14c/0x4ac
>> [    4.073210] [<ffff0000080ccd3c>] cpuhp_thread_fun+0xd4/0x11c
>> [    4.074132] [<ffff0000080f1394>] smpboot_thread_fn+0x1b4/0x1c4
>> [    4.075081] [<ffff0000080ec90c>] kthread+0x10c/0x138
>> [    4.075921] [<ffff0000080833c0>] ret_from_fork+0x10/0x50
>> [    4.076947] genirq: Setting trigger mode 4 for irq 43 failed
>> (gic_set_type+0x0/0x74)
>>
>> Signed-off-by: Wei Huang <wei@redhat.com>
>> ---
>>  drivers/perf/arm_pmu_acpi.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>> index 34c862f..d6bb75d 100644
>> --- a/drivers/perf/arm_pmu_acpi.c
>> +++ b/drivers/perf/arm_pmu_acpi.c
>> @@ -29,6 +29,9 @@ static int arm_pmu_acpi_register_irq(int cpu)
>>  		return -EINVAL;
>>  
>>  	gsi = gicc->performance_interrupt;
>> +	if (!gsi)
>> +		return 0;
> 
> So a GSI of zero means we return an IRQ of zero, which correctly gets
> treated as "No ACPI PMU"...

Yes, returning 0 here and dmesg prints out "No ACPI PMU IRQ for CPU" is
acceptable.

> 
>>  	if (gicc->flags & ACPI_MADT_PERFORMANCE_IRQ_MODE)
>>  		trigger = ACPI_EDGE_SENSITIVE;
>>  	else
>> @@ -58,7 +61,8 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>>  		return;
>>  
>>  	gsi = gicc->performance_interrupt;
>> -	acpi_unregister_gsi(gsi);
>> +	if (gsi)
>> +		acpi_unregister_gsi(gsi);
> 
> ... but then I don't see how we can get here, so I'll drop this hunk.

I am OK to drop it. It was added just to be cautious... Do you need
another version from me or you will remove this hunk?

> 
> Will
> 
