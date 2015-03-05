From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 5 Mar 2015 16:03:21 +0800
Subject: [PATCH v9 14/21] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
In-Reply-To: <2411054.s4TkmAUKjT@vostro.rjw.lan>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-15-git-send-email-hanjun.guo@linaro.org>
 <2411054.s4TkmAUKjT@vostro.rjw.lan>
Message-ID: <54F80DC9.3090808@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/5 6:46, Rafael J. Wysocki wrote:
> On Wednesday, February 25, 2015 04:39:54 PM Hanjun Guo wrote:
>> Introduce a new function map_gicc_mpidr() to allow MPIDRs to be obtained
>> from the GICC Structure introduced by ACPI 5.1.
>>
>> The ARM architecture defines the MPIDR register as the CPU hardware
>> identifier. This patch adds the code infrastructure to retrieve the MPIDR
>> values from the ARM ACPI GICC structure in order to look-up the kernel CPU
>> hardware ids required by the ACPI core code to identify CPUs.
>>
>> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Yijing Wang <wangyijing@huawei.com>
>> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
>> Tested-by: Jon Masters <jcm@redhat.com>
>> Tested-by: Timur Tabi <timur@codeaurora.org>
>> Tested-by: Robert Richter <rrichter@cavium.com>
>> Acked-by: Robert Richter <rrichter@cavium.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/arm64/include/asm/acpi.h | 12 ++++++++++++
>>  drivers/acpi/processor_core.c | 30 ++++++++++++++++++++++++++++++
>>  2 files changed, 42 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index 9719921..9a23369 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -13,6 +13,8 @@
>>  #define _ASM_ACPI_H
>>  
>>  #include <linux/mm.h>
>> +#include <asm/cputype.h>
>> +#include <asm/smp_plat.h>
>>  
>>  /* Basic configuration for ACPI */
>>  #ifdef	CONFIG_ACPI
>> @@ -27,6 +29,9 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>>  }
>>  #define acpi_os_ioremap acpi_os_ioremap
>>  
>> +typedef u64 phys_cpuid_t;
>> +#define CPU_PHYS_ID_INVALID INVALID_HWID
>> +
> Any chance to combine this with patch [2/21]?  Or at least put them next to each
> other in the series so as to indicate that they are related or *mention* patch
> [2/21] in the changelog here?

Both are ok to me. I separated those two patches for the assumption that you will merge
the first two patches in your tree, I will put them next to each other.

>
> IMO, you really need to define phys_cpuid_t in a common place or people will
> forget that it may be 64-bit, because they'll only be looking at their arch.

Since x86 and ARM64 are using different types for phys_cpuid_t, we need to
introduce something like following if define it in common place:

in linux/acpi.h,

#if defined(CONFIG_X86) || defined(CONFIG_IA64)
typedef u32 phys_cpuid_t;
#define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
#else if defined(CONFIG_ARM64)
typedef u64 phys_cpuid_t;
#define PHYS_CPUID_INVALID INVALID_HWID
#endif

I think it's awful, did I miss something?

Thanks
Hanjun
