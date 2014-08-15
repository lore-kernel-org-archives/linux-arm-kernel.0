From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Fri, 15 Aug 2014 16:12:09 -0700
Subject: [PATCH] arm64: smp: Update the topology masks before calling
 CPU_STARTING notifiers
In-Reply-To: <20140815104333.GH27466@arm.com>
References: <1407892269-28650-1-git-send-email-rvaswani@codeaurora.org>
 <20140815104333.GH27466@arm.com>
Message-ID: <53EE93C9.9060306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/15/2014 3:43 AM, Will Deacon wrote:
> On Wed, Aug 13, 2014 at 02:11:09AM +0100, Rohit Vaswani wrote:
>> Currently, the CPU_STARTING notifiers would observe an incorrect sibling
>> mask since the notifier chain is called before the topology masks are updated
>> for the new cpu.
>> Update the topology masks before calling the notifier chain to fix this
>> problem.
>>
>> Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
>> ---
>>   arch/arm/kernel/smp.c   | 4 ++--
>>   arch/arm64/kernel/smp.c | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
>> index 7c4fada..0e2237c 100644
>> --- a/arch/arm/kernel/smp.c
>> +++ b/arch/arm/kernel/smp.c
>> @@ -363,12 +363,12 @@ asmlinkage void secondary_start_kernel(void)
>>   	if (smp_ops.smp_secondary_init)
>>   		smp_ops.smp_secondary_init(cpu);
>>   
>> +	smp_store_cpu_info(cpu);
>> +
>>   	notify_cpu_starting(cpu);
>>   
>>   	calibrate_delay();
>>   
>> -	smp_store_cpu_info(cpu);
>> -
> Hmm, smp_store_cpu_info takes a copy of loops_per_jiffy. Are you sure it's
> safe to move the call before calibrate_delay?

Right! - I had looked at the arm64 version .  I checked for arm32 now 
and I think we should be
safe to move calibrate_delay before the smp_store_cpu_info and I can 
push a v2 version if
there are no concerns. I did not see calibrate_delay having any 
dependency for cpu_starting notifiers.

-Rohit
> Will


Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
