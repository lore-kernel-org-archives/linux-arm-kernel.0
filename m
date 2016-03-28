From: ashok.sekar@broadcom.com (Ashok Sekar)
Date: Mon, 28 Mar 2016 18:01:38 +0530
Subject: [PATCH v2 3/6] arm64/perf: Filter common events based on
 PMCEIDn_EL0
In-Reply-To: <56F40799.1030409@arm.com>
References: <1458823960-32760-1-git-send-email-ashoks@broadcom.com>
 <1458823960-32760-4-git-send-email-ashoks@broadcom.com>
 <56F40799.1030409@arm.com>
Message-ID: <CANK38rZ+6f_KLM01XjODRjJagTM8vJTSArVDUCY_Yz0CDo0+pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On Thu, Mar 24, 2016 at 8:58 PM, Suzuki K. Poulose
<Suzuki.Poulose@arm.com> wrote:
> On 24/03/16 12:52, Ashok Kumar wrote:
>>
>> The complete common architectural and micro-architectural
>> event number structure is filtered based on PMCEIDn_EL0 and
>> copied to a new structure which is exposed to /sys
>>
>> The function which derives event bitmap from PMCEIDn_EL0 is
>> executed in the cpus, which has the pmu being initialized,
>> for heterogeneous pmu support.
>>
>> Enforced armv8_pmuv3_event_attrs array for event number
>> ordering as this is indexed with event number now.
>>
>> Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
>> ---
>>   arch/arm64/kernel/perf_event.c | 281
>> ++++++++++++++++++++++++++++-------------
>>   1 file changed, 195 insertions(+), 86 deletions(-)
>>
>
>> +static inline u32 armv8pmu_pmceidn_read(int reg)
>> +{
>> +       u32 val = 0;
>> +
>> +       if (reg == 0)
>> +               asm volatile("mrs %0, pmceid0_el0" : "=r" (val));
>> +       else if (reg == 1)
>> +               asm volatile("mrs %0, pmceid1_el0" : "=r" (val));
>> +
>> +       return val;
>> +}
>
>
>> +       reg[0] = armv8pmu_pmceidn_read(0);
>> +       reg[1] = armv8pmu_pmceidn_read(1);
>
>
> Could we not add definitions for SYS_PMCEID0_EL0 and SYS_PMCEID1_EL0
> in asm/sysreg.h and simply do
>
> reg[0] = read_cpuid(SYS_PMCEID0_EL0);
> reg[1] = read_cpuid(SYS_PMCEID1_EL0);
>
> ?
Yes, it is possible but looks like read_cpuid is used only in cpuid
related contexts.
Maybe we need to define separate definition for pmu/general context and use it?
perf_event.c has other instances where the pmu registers are directly read and
needs to be converted to this format if we are doing it. Let me know
your suggestion.
Currently I have posted v3 adhering to the convention of already
existing pmu register reads.

Thanks,
Ashok
>
> Thanks
> Suzuki
