From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 30 Jun 2014 12:39:26 +0200
Subject: [PATCH v2 1/2] ARM: topology: Use a clock if possible to get the
 CPU frequency
In-Reply-To: <20140630102934.GV32514@n2100.arm.linux.org.uk>
References: <1404123143-13041-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404123143-13041-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140630102934.GV32514@n2100.arm.linux.org.uk>
Message-ID: <CAKfTPtC+XcH122AytyZ=x1JVx9THmxCasJLA3Z1e17X_OmH1xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2014 12:29, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Mon, Jun 30, 2014 at 12:12:22PM +0200, Maxime Ripard wrote:
>> The Cortex-A7 and Cortex-A15 based SoCs need a clock-frequency property in the
>> topology code.
>>
>> Allow to use a clock to provide the same information.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> This looks fine to me, but I don't know this code.  Maybe Vincent Guittot
> should be on the To: list (added)?

Thanks

>
>> ---
>>  arch/arm/kernel/topology.c | 25 ++++++++++++++++++-------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
>> index 9d853189028b..268443d88094 100644
>> --- a/arch/arm/kernel/topology.c
>> +++ b/arch/arm/kernel/topology.c
>> @@ -11,6 +11,7 @@
>>   * for more details.
>>   */
>>
>> +#include <linux/clk.h>
>>  #include <linux/cpu.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/export.h>
>> @@ -100,8 +101,8 @@ static void __init parse_dt_topology(void)
>>                                GFP_NOWAIT);
>>
>>       for_each_possible_cpu(cpu) {
>> -             const u32 *rate;
>> -             int len;
>> +             struct clk *clk;
>> +             u32 rate = 0;
>>
>>               /* too early to use cpu->of_node */
>>               cn = of_get_cpu_node(cpu, NULL);
>> @@ -117,14 +118,24 @@ static void __init parse_dt_topology(void)
>>               if (cpu_eff->compatible == NULL)
>>                       continue;
>>
>> -             rate = of_get_property(cn, "clock-frequency", &len);
>> -             if (!rate || len != 4) {
>> -                     pr_err("%s missing clock-frequency property\n",
>> -                             cn->full_name);
>> +             clk = of_clk_get(cn, 0);
>> +             if (!IS_ERR(clk))
>> +                     rate = clk_get_rate(clk);

We need the max frequency as it will be used to weight the different
CPUs capacity. How do you ensure that the current clock rate is the
max one ?

Vincent

>> +             else
>> +                     of_property_read_u32(cn, "clock-frequency", &rate);
>> +
>> +             if (!rate) {
>> +                     pr_err("%s missing clocks or clock-frequency properties\n",
>> +                            cn->full_name);
>> +                     continue;
>> +             }
>> +
>> +             if (!rate) {
>> +                     pr_err("%s invalid CPU frequency", cn->full_name);
>>                       continue;
>>               }
>>
>> -             capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
>> +             capacity = ((rate) >> 20) * cpu_eff->efficiency;
>>
>>               /* Save min capacity of the system */
>>               if (capacity < min_capacity)
>> --
>> 2.0.0
>>
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
