From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 04 Dec 2013 23:53:55 +0800
Subject: [RFC part1 PATCH 5/7] ARM64 / ACPI: Introduce arm_core.c and
 its related head file
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88024941A4@SHSMSX101.ccr.corp.intel.com>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-6-git-send-email-hanjun.guo@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E88024941A4@SHSMSX101.ccr.corp.intel.com>
Message-ID: <529F5013.4050502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?04? 13:46, Zheng, Lv wrote:
>> From: linux-acpi-owner at vger.kernel.org [mailto:linux-acpi-owner at vger.kernel.org] On Behalf Of Hanjun Guo
>> Sent: Wednesday, December 04, 2013 12:37 AM
>>
>> introduce arm_core.c and its related head file, after this patch,
>> we can get ACPI tables from BIOS on ARM64 now.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/include/asm/acpi.h |   57 +++++++++++
>>   arch/arm64/kernel/setup.c     |    8 ++
>>   drivers/acpi/Makefile         |    2 +
>>   drivers/acpi/plat/Makefile    |    1 +
>>   drivers/acpi/plat/arm-core.c  |  219 +++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 287 insertions(+)
>>   create mode 100644 drivers/acpi/plat/Makefile
>>   create mode 100644 drivers/acpi/plat/arm-core.c
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index c186f5b..e9444e4 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -19,6 +19,43 @@
>>   #ifndef _ASM_ARM_ACPI_H
>>   #define _ASM_ARM_ACPI_H
>>
>> +#include <asm/cacheflush.h>
>> +
>> +#include <linux/init.h>
>> +
>> +#define COMPILER_DEPENDENT_INT64	long long
>> +#define COMPILER_DEPENDENT_UINT64	unsigned long long
>> +
>> +/*
>> + * Calling conventions:
>> + *
>> + * ACPI_SYSTEM_XFACE        - Interfaces to host OS (handlers, threads)
>> + * ACPI_EXTERNAL_XFACE      - External ACPI interfaces
>> + * ACPI_INTERNAL_XFACE      - Internal ACPI interfaces
>> + * ACPI_INTERNAL_VAR_XFACE  - Internal variable-parameter list interfaces
>> + */
>> +#define ACPI_SYSTEM_XFACE
>> +#define ACPI_EXTERNAL_XFACE
>> +#define ACPI_INTERNAL_XFACE
>> +#define ACPI_INTERNAL_VAR_XFACE
>> +
>> +/* Asm macros */
>> +#define ACPI_FLUSH_CPU_CACHE() flush_cache_all()
> Well, you may need to check the following environments defined in <acpi/platform/aclinux.h> is sufficient for ARM targets:
> 49 #define ACPI_USE_SYSTEM_CLIBRARY
> 50 #define ACPI_USE_DO_WHILE_0
> 51 #define ACPI_MUTEX_TYPE             ACPI_BINARY_SEMAPHORE
>
> 70 #define ACPI_MACHINE_WIDTH          BITS_PER_LONG
> Will this zap IO addresses on ARM32 platforms?

In this patch set, we only implemented ACPI for ARM64, and ARM32 is
not included in this patch set.

My bad, sorry for the vague changelog.

> And following default settings in <acpi/platform/acenv.h> and <acpi/acxxx.h> is sufficient for ARM targets:
> 179 #if defined (__IA64__) || defined (__ia64__)
> 180 #define ACPI_MISALIGNMENT_NOT_SUPPORTED
> 181 #endif
> Will this cause any exceptions on ARM by executing ACPICA name functions?
>
> 444 #if ACPI_MACHINE_WIDTH == 64
> 445 #define ACPI_USE_NATIVE_DIVIDE  /* Use compiler native 64-bit divide */
> 446 #endif
> I think you may see build breakage on ARM32 as you haven't implemented the following ACPICA macros for ARM:
> 67 #define ACPI_DIV_64_BY_32(n_hi, n_lo, d32, q32, r32)
> 74 #define ACPI_SHIFT_RIGHT_64(n_hi, n_lo)
> Have you tested this yet?

Yes, we tested on ARM32 and it works fine on linaro-acpi, but patches
for ARM32 is not sent out for upstream yet, that's why you can't see
the code you needed.


>
> I'm not sure if all global lock code blocks are not referenced by ACPI_REDUCED_HARDWARE and I'm not sure what mechanism is implemented on ARM ACPI platforms to offer the synchronization mechanism between firmware and OSPM.  So you may need to implement the following synchronization protocol in <asm/acpi.h>:
> 58 #define ACPI_ACQUIRE_GLOBAL_LOCK(facs, Acq)
> 61 #define ACPI_RELEASE_GLOBAL_LOCK(facs, Acq)

In reduced hardware mode, No hardware resource sharing between
OSPM and other asynchronous operating environments, such as
UEFI Runtime Services or System Management Mode. (The Global Lock
is not supported)
  
please refer to chapter 3.11.1 of ACPI 5.0.


>
> I only reviewed the ACPICA stuffs in <asm/acpi.h>, I didn't take a look at your Linux ACPI stuff in <asm/acpi.h>.  You may need more instructions on the porting issues from Linux ACPI guys.

Yes, I will. Thank you for the review and guidance, and you are the expert
for ACPICA, we need your instructions too

Thanks
Hanjun
