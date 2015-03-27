From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 27 Mar 2015 21:40:26 +0800
Subject: [patch v11 13/23] ACPI / processor: Introduce phys_cpuid_t for
 CPU hardware ID
In-Reply-To: <551381CD.5010804@huawei.com>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-14-git-send-email-hanjun.guo@linaro.org>
 <20150325172109.GJ14585@localhost> <551381CD.5010804@huawei.com>
Message-ID: <55155DCA.3060006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?03?26? 11:49, Hanjun Guo wrote:
> On 2015/3/26 1:21, Catalin Marinas wrote:
>> On Tue, Mar 24, 2015 at 10:02:46PM +0800, Hanjun Guo wrote:
>>> CPU hardware ID (phys_id) is defined as u32 in structure acpi_processor,
>>> but phys_id is used as int in acpi processor driver, so it will lead to
>>> some inconsistence for the drivers.
>>>
>>> Furthermore, to cater for ACPI arch ports that implement 64 bits CPU
>>> ids a generic CPU physical id type is required.
>>>
>>> So introduce typedef u32 phys_cpuid_t in a common file, and introduce
>>> a macro PHYS_CPUID_INVALID as (phys_cpuid_t)(-1) if it's not defined
>>> by other archs, this will solve the inconsistence in acpi processor driver,
>>> and will prepare for the ACPI on ARM64 for the 64 bit CPU hardware ID
>>> in the following patch.
>>>
>>> CC: Rafael J Wysocki <rjw@rjwysocki.net>
>>> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Reviewed-by: Grant Likely <grant.likely@linaro.org>
>>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>> [hj: reworked cpu physid map return codes]
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> BTW, am I still the author of this patch? If yes, it's missing a From:
>> line.
>
> Oops, you should be the author, can Will fix this in his tree?
>
>>
>>> --- a/drivers/acpi/acpi_processor.c
>>> +++ b/drivers/acpi/acpi_processor.c
>>> @@ -170,7 +170,7 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>>>   	acpi_status status;
>>>   	int ret;
>>>
>>> -	if (pr->phys_id == -1)
>>> +	if (pr->phys_id == PHYS_CPUID_INVALID)
>>>   		return -ENODEV;
>> If PHYS_CPUID_INVALID is the same as INVALID_HWID, we should get rid of
>> the latter in the arm64 code (as a subsequent clean-up patch).
>
> OK, I'm preparing a patch set to introduce invalid_phys_cpuid() and invalid_logical_cpuid()
> to remove the direct comparison of PHYS_CPUID_INVALID and -1 in ACPI processor drivers,
> which is suggested by Rafael, I will cleanup PHYS_CPUID_INVALID in this patch set.

I met difficulty to do so, because we use

+#ifndef PHYS_CPUID_INVALID
+typedef u32 phys_cpuid_t;
+#define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
+#endif

in the common head file linux/acpi.h, we need macro
PHYS_CPUID_INVALID to identify if phys_cpuid_t is typedefed
for different arch, so if we want remove PHYS_CPUID_INVALID
for ARM64, we need to got back to typedef phys_cpuid_t for
each arch using ACPI. which means that

+typedef u32 phys_cpuid_t;  for ia64 and x86,

and
+typedef u64 phys_cpuid_t;  for arm64

and
+#define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
in this linux/acpi.h for common use.

Rafael, would you mind doing so?

Thanks
Hanjun
