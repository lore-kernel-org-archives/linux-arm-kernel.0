From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Dec 2013 08:16:16 -0600
Subject: [PATCH] arm64: print cpu frequency in /proc/cpuinfo
In-Reply-To: <20131213103632.GC19177@mudshark.cambridge.arm.com>
References: <1386924222-23169-1-git-send-email-vkale@apm.com>
 <20131213103632.GC19177@mudshark.cambridge.arm.com>
Message-ID: <CAL_Jsq+Z9K4sus6xwN9KYyCUVWy7NFBQCGYvz0wrt=J7h+G35Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 4:36 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Dec 13, 2013 at 08:43:42AM +0000, Vinayak Kale wrote:
>> Print the cpu frequency field in /proc/cpuinfo.
>
> Why? ["x86 does this" isn't a valid answer :)].

People want to know this stuff. How about making lscpu work and print
useful things. Here is what you get on x66. You get a lot less on ARM
IIRC. lscpu uses on cpuinfo and sysfs data. The cache info is based on
sysfs cache data which I believe someone is working on for ARM.

Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                4
On-line CPU(s) list:   0-3
Thread(s) per core:    2
Core(s) per socket:    2
Socket(s):             1
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 37
Stepping:              5
CPU MHz:               2393.881
BogoMIPS:              4787.76
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              3072K
NUMA node0 CPU(s):     0-3


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
> Just use the existing sysfs interfaces exposed by the cpufreq governers if
> you need to know this stuff.

We should be able to get the frequency independently from cpufreq
being enabled. This should come from DT cpu clock-frequency property
if cpufreq is not enabled.

Rob
