From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 10 Mar 2016 17:50:58 +0800
Subject: [PATCH v3 05/12] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
In-Reply-To: <56D6F3EA.4050904@gmail.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-6-git-send-email-guohanjun@huawei.com>
 <56D6F3EA.4050904@gmail.com>
Message-ID: <56E14382.1070003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

Sorry for the late reply, on a travelling now.

On 03/02/2016 10:08 PM, Matthias Brugger wrote:
>
>
> On 23/01/16 10:39, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> Introduce a new file to hold ACPI based NUMA information
>> parsing from SRAT and SLIT.
>>
>> SRAT includes the CPU ACPI ID to Proximity Domain mappings
>> and memory ranges to Proximity Domain mapping.
>> SLIT has the information of inter node
>> distances(relative number for access latency).
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
[..]
>>
>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>> index 9e8704b..e974995 100644
>> --- a/arch/arm64/mm/numa.c
>> +++ b/arch/arm64/mm/numa.c
>> @@ -17,6 +17,7 @@
>>    * along with this program.  If not, see
>> <http://www.gnu.org/licenses/>.
>>    */
>>
>> +#include <linux/acpi.h>
>>   #include <linux/bootmem.h>
>>   #include <linux/ctype.h>
>>   #include <linux/init.h>
>> @@ -385,10 +386,8 @@ void __init arm64_numa_init(void)
>>   {
>>       int ret = -ENODEV;
>>
>> -#ifdef CONFIG_OF_NUMA
>>       if (!numa_off)
>> -        ret = numa_init(arm64_of_numa_init);
>> -#endif
>> +        ret = numa_init(acpi_disabled ? arm64_of_numa_init :
>> arm64_acpi_numa_init);
>
> Header asm/acpi.h is included in linux/acpi.h but only if CONFIG_ACPI=y
> arm64_acpi_numa_init is declared in asm/acpi.h, so if we don't use the
> ifdef CONFIG_* approach from Robert, we will need to include as/acpi.h
> implicitly here. Otherwise we get a compilation error if CONFIG_ACPI is
> not set.

Yes, I noticed the same issue as you spotted out, and I agree with
you and Robert that I should use the ifdef CONFIG_* approach.

Thanks
Hanjun
