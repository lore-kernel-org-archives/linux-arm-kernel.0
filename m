From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 25 May 2018 11:25:34 +0100
Subject: [PATCH v4 04/26] arm64: alternative: Apply alternatives early in
 boot process
In-Reply-To: <89769f8d-2ed0-1eb7-0373-09fc25f8071a@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <1527241772-48007-5-git-send-email-julien.thierry@arm.com>
 <89769f8d-2ed0-1eb7-0373-09fc25f8071a@arm.com>
Message-ID: <7e579de3-cab2-0677-a3d0-d150ee72f839@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/05/18 11:00, Suzuki K Poulose wrote:
> On 25/05/18 10:49, Julien Thierry wrote:
>> From: Daniel Thompson <daniel.thompson@linaro.org>
>>
>> Currently alternatives are applied very late in the boot process (and
>> a long time after we enable scheduling). Some alternative sequences,
>> such as those that alter the way CPU context is stored, must be applied
>> much earlier in the boot sequence.
>>
>> Introduce apply_boot_alternatives() to allow some alternatives to be
>> applied immediately after we detect the CPU features of the boot CPU.
>>
>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>> [julien.thierry at arm.com: rename to fit new cpufeature framework better,
>> ???????????? apply BOOT_SCOPE feature early in boot]
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> ? arch/arm64/include/asm/alternative.h |? 3 +--
>> ? arch/arm64/include/asm/cpufeature.h? |? 2 ++
>> ? arch/arm64/kernel/alternative.c????? | 30 
>> +++++++++++++++++++++++++++---
>> ? arch/arm64/kernel/cpufeature.c?????? |? 5 +++++
>> ? arch/arm64/kernel/smp.c????????????? |? 7 +++++++
>> ? 5 files changed, 42 insertions(+), 5 deletions(-)
>>
> 
> ...
> 
>> +unsigned long boot_capabilities;
>> +
>> ? /*
>> ?? * Flag to indicate if we have computed the system wide
>> ?? * capabilities based on the boot time active CPUs. This
>> @@ -1370,6 +1372,9 @@ static void __update_cpu_capabilities(const 
>> struct arm64_cpu_capabilities *caps,
>> ????????? if (!cpus_have_cap(caps->capability) && caps->desc)
>> ????????????? pr_info("%s %s\n", info, caps->desc);
>> ????????? cpus_set_cap(caps->capability);
>> +
>> +??????? if (scope_mask & SCOPE_BOOT_CPU)
>> +??????????? __set_bit(caps->capability, &boot_capabilities);
> 
> Julien
> 
> I think this check is problematic. The scope_mask passed on by the boot CPU
> is (SCOPE_BOOT_CPU | SCOPE_LOCAL_CPU) to cover both BOOT CPU 
> capabilities *and*
> CPU local capabilites on the boot CPU. So, you might apply the 
> alternatives for
> a "local" CPU erratum, which is not intended. You may change the above 
> check to :
> 
>  ????if (caps->type & SCOPE_BOOT_CPU)
> 
> to make sure you check the "capability" has the SCOPE_BOOT_CPU set.
> 

Makes sense, I'll do that.

Thanks,

-- 
Julien Thierry
