From: robherring2@gmail.com (Rob Herring)
Date: Tue, 15 Mar 2011 07:40:58 -0500
Subject: [PATCH v3 6/7] ARM: smp_twd: add clock api support
In-Reply-To: <AANLkTi=NnwEwo4XYbvevqp2zDyGPypBz9yHgozrn2jEy@mail.gmail.com>
References: <1299627277-20311-1-git-send-email-robherring2@gmail.com>	<1299627277-20311-7-git-send-email-robherring2@gmail.com>
	<AANLkTi=NnwEwo4XYbvevqp2zDyGPypBz9yHgozrn2jEy@mail.gmail.com>
Message-ID: <4D7F5E5A.5020508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin,

On 03/14/2011 09:35 PM, Colin Cross wrote:
> On Tue, Mar 8, 2011 at 3:34 PM, Rob Herring<robherring2@gmail.com>  wrote:
>> From: Rob Herring<rob.herring@calxeda.com>
>>
>> The private timer freq is currently dynamically detected
>> using jiffies count to determine the rate. This method adds
>> a delay to boot-up, so use the clock api instead to get the
>> clock rate.
>>
>> Signed-off-by: Rob Herring<rob.herring@calxeda.com>
>> ---
>> v3: Save struct clk pointer for later use (cpufreq).
>>
>>   arch/arm/include/asm/smp_twd.h |    1 +
>>   arch/arm/kernel/smp_twd.c      |   14 ++++++++++++++
>>   2 files changed, 15 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
>> index fed9981..6b0f591 100644
>> --- a/arch/arm/include/asm/smp_twd.h
>> +++ b/arch/arm/include/asm/smp_twd.h
>> @@ -24,5 +24,6 @@ extern void __iomem *twd_base;
>>
>>   int twd_timer_ack(void);
>>   void twd_timer_setup(struct clock_event_device *);
>> +void twd_timer_init(void __iomem *base);
>>
>>   #endif
>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>> index 60636f4..cce1171 100644
>> --- a/arch/arm/kernel/smp_twd.c
>> +++ b/arch/arm/kernel/smp_twd.c
>> @@ -8,6 +8,8 @@
>>   * it under the terms of the GNU General Public License version 2 as
>>   * published by the Free Software Foundation.
>>   */
>> +#include<linux/clk.h>
>> +#include<linux/err.h>
>>   #include<linux/init.h>
>>   #include<linux/kernel.h>
>>   #include<linux/delay.h>
>> @@ -24,6 +26,7 @@
>>   /* set up by the platform code */
>>   void __iomem *twd_base;
>>
>> +static struct clk *twd_clk;
>>   static unsigned long twd_timer_rate;
>>
>>   static void twd_set_mode(enum clock_event_mode mode,
>> @@ -142,3 +145,14 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
>>
>>         clockevents_register_device(clk);
>>   }
>> +
>> +void __init twd_timer_init(void __iomem *base)
>> +{
>> +       twd_clk = clk_get_sys("smp_twd", NULL);
>> +       if (!IS_ERR(twd_clk))
>> +               twd_timer_rate = clk_get_rate(twd_clk);
>> +       else
>> +               twd_clk = NULL;
>> +
>> +       twd_base = base;
>> +}
> Why not leave the old twd_base intitialization and put the clock stuff
> in twd_timer_setup?

Well the original patch had base addr and a struct clk pointer passed in 
for this function. So replacing the variable setting in platform code 
with this function made sense then. Setting variables like twd_base 
directly is generally disliked.

twd_timer_setup is called for each core, so it is probably cleaner to 
have global init and per core init separate. Although, the clock could 
be per core in future chips.

>
> Would it make sense to drop twd_calibrate_rate entirely and require a twd clock?

Yes I would like to, but the clock needs to be added to every platform 
before twd_calibrate_rate could be removed.

Rob
