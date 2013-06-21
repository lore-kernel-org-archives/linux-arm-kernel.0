From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 21 Jun 2013 10:42:39 +0100
Subject: [PATCH 1/3] ARM: kernel: get cpu clock rate from cpu clock node
 first
In-Reply-To: <20130621093526.GC14268@e102568-lin.cambridge.arm.com>
References: <1371739146-32639-1-git-send-email-f.fainelli@gmail.com>
 <1371739146-32639-2-git-send-email-f.fainelli@gmail.com>
 <20130621093526.GC14268@e102568-lin.cambridge.arm.com>
Message-ID: <CAGVrzcZn7HgB6vhc7Vz+kKQJbeh1PWYY1_gQNU7eOG9VYugTpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/6/21 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>:
> On Thu, Jun 20, 2013 at 03:39:04PM +0100, Florian Fainelli wrote:
>> The current topology code will only attempt to parse a "clock-frequency"
>> property for a given CPU node. Some platforms such as the ecx-2000
>> provide a clock node. Change the logic to first look for a clock node,
>> and if we fail, fallback to parsing a "clock-frequency" property. To
>> avoid unnecessary casting, change rate from u32 to unsigned long, and
>> introduce the "prop" variable to hold the contents of the
>> "clock-frequency" property.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arm/kernel/topology.c | 23 ++++++++++++++++-------
>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
>> index c5a5954..8f340a1 100644
>> --- a/arch/arm/kernel/topology.c
>> +++ b/arch/arm/kernel/topology.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/of.h>
>>  #include <linux/sched.h>
>>  #include <linux/slab.h>
>> +#include <linux/clk.h>
>>
>>  #include <asm/cputype.h>
>>  #include <asm/topology.h>
>> @@ -104,7 +105,9 @@ static void __init parse_dt_topology(void)
>>       cpu_capacity = kzalloc(alloc_size, GFP_NOWAIT);
>>
>>       while ((cn = of_find_node_by_type(cn, "cpu"))) {
>> -             const u32 *rate, *reg;
>> +             const u32 *prop, *reg;
>> +             unsigned long rate;
>> +             struct clk *cpu_clk;
>>               int len;
>>
>>               if (cpu >= num_possible_cpus())
>> @@ -117,11 +120,17 @@ static void __init parse_dt_topology(void)
>>               if (cpu_eff->compatible == NULL)
>>                       continue;
>>
>> -             rate = of_get_property(cn, "clock-frequency", &len);
>> -             if (!rate || len != 4) {
>> -                     pr_err("%s missing clock-frequency property\n",
>> -                             cn->full_name);
>> -                     continue;
>> +             cpu_clk = of_clk_get(cn, 0);
>> +             if (IS_ERR(cpu_clk)) {
>> +                     prop = of_get_property(cn, "clock-frequency", &len);
>> +                     if (!prop || len != 4) {
>> +                             pr_err("%s missing clock-frequency property\n",
>> +                                     cn->full_name);
>> +                             continue;
>> +                     }
>> +                     rate = be32_to_cpup(prop);
>> +             } else {
>> +                     rate = clk_get_rate(cpu_clk);
>
> I am not questioning whether adding a "clocks" property is proper or
> not, but let me say cpu related info and parsing are already scattered
> all over the place and this is wrong. We are currently trying to
> consolidate CPU related info in a single structure in the kernel, and
> then this code can become a consumer of that data.

Fine, this makes sense, although it was probably hard to know it
without you telling it first.

> As to the "clocks"
> property as I mentioned in another reply, that requires more thought.

Fair enough.
--
Florian
