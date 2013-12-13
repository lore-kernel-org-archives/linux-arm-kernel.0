From: vkale@apm.com (Vinayak Kale)
Date: Fri, 13 Dec 2013 18:42:55 +0530
Subject: [PATCH] arm64: print cpu frequency in /proc/cpuinfo
In-Reply-To: <20131213103632.GC19177@mudshark.cambridge.arm.com>
References: <1386924222-23169-1-git-send-email-vkale@apm.com>
 <20131213103632.GC19177@mudshark.cambridge.arm.com>
Message-ID: <CAPrCYkfMW2zWiLWRvEkGcM2OdAXKHas7=sMRke=mp0oz2eETyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 4:06 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Dec 13, 2013 at 08:43:42AM +0000, Vinayak Kale wrote:
>> Print the cpu frequency field in /proc/cpuinfo.
>
> Why? ["x86 does this" isn't a valid answer :)].

Well, that's actually the main motive :-)

Secondly, earlier in amr64 port, /proc/cpuinfo used to print BogoMIPS.
So people used to get mislead with the values. Although in current
tree, we don't have that print. So that's not much of a concern now.
(You had removed it I guess for the same reason :))

>
>> Signed-off-by: Vinayak Kale <vkale@apm.com>
>> ---
>>  arch/arm64/kernel/setup.c |   15 +++++++++++++++
>>  1 files changed, 15 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index bd9bbd0..bca982b 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -41,6 +41,7 @@
>>  #include <linux/memblock.h>
>>  #include <linux/of_fdt.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/cpufreq.h>
>>
>>  #include <asm/cputype.h>
>>  #include <asm/elf.h>
>> @@ -278,9 +279,19 @@ static const char *hwcap_str[] = {
>>       NULL
>>  };
>>
>> +static unsigned int get_cpufreq_khz(unsigned int cpu)
>> +{
>> +#ifdef CONFIG_CPU_FREQ
>> +     return cpufreq_quick_get(cpu);
>> +#else
>> +     return 0;
>> +#endif
>> +}
>
> That's going to be hilarious fun when cpufreq isn't compiled in.

In that case, we are not printing the value since above function will return 0.

> Just use the existing sysfs interfaces exposed by the cpufreq governers if
> you need to know this stuff.
>
> Will
