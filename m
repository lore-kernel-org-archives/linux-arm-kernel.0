From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Wed, 08 Jan 2014 10:58:34 +0000
Subject: [PATCH] ARM: DT/kernel: fix arch_match_cpu_phys_id to avoid
 erroneous match
In-Reply-To: <20140107165815.GF4180@e106331-lin.cambridge.arm.com>
References: <1382358632-32762-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <20140107165815.GF4180@e106331-lin.cambridge.arm.com>
Message-ID: <52CD2F5A.5000001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 07/01/14 16:58, Mark Rutland wrote:
> Hi,
> 
> I was just looking in devtree.c and I noticed this seems to have fallen
> by the wayside. Given that this fixes a possible bug and there have been
> no negative comments, I think it's good for mainline.
> 
> Could you place this in the patch system, assuming Russell has no
> comments?
> 

Can I put this in patch tracker if you have no objections ?

Regards,
Sudeep

> Cheers,
> Mark.
> 
> On Mon, Oct 21, 2013 at 01:30:32PM +0100, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> The MPIDR contains specific bitfields(MPIDR.Aff{2..0}) which uniquely
>> identify a CPU, in addition to some non-identifying information and
>> reserved bits. The ARM cpu binding defines the 'reg' property to only
>> contain the affinity bits, and any cpu nodes with other bits set in
>> their 'reg' entry are skipped.
>>
>> As such it is not necessary to mask the phys_id with MPIDR_HWID_BITMASK,
>> and doing so could lead to matching erroneous CPU nodes in the device
>> tree. This patch removes the masking of the physical identifier.
>>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> ---
>>  arch/arm/kernel/devtree.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
>> index f35906b..41960fb 100644
>> --- a/arch/arm/kernel/devtree.c
>> +++ b/arch/arm/kernel/devtree.c
>> @@ -171,7 +171,7 @@ void __init arm_dt_init_cpu_maps(void)
>>  
>>  bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
>>  {
>> -	return (phys_id & MPIDR_HWID_BITMASK) == cpu_logical_map(cpu);
>> +	return phys_id == cpu_logical_map(cpu);
>>  }
>>  
>>  /**
>> -- 
>> 1.8.1.2
>>
