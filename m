From: nm@ti.com (Nishanth Menon)
Date: Fri, 2 May 2014 00:18:10 -0500
Subject: [RFC PATCH] PM / OPP: move cpufreq specific OPP functions out of
 generic OPP library
In-Reply-To: <CAKohpokEuZ69HnnKE89maXk=21cgAMjEYjEvEcaoBpg4bLRsGg@mail.gmail.com>
References: <1398992810-14957-1-git-send-email-nm@ti.com>
 <CAKohpokEuZ69HnnKE89maXk=21cgAMjEYjEvEcaoBpg4bLRsGg@mail.gmail.com>
Message-ID: <CAGo_u6ohKZh+zKWSzGbvT+AKgnhSjzX7v9isqpd2pc-Cpmxocg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 1, 2014 at 11:30 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 2 May 2014 06:36, Nishanth Menon <nm@ti.com> wrote:
>> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
>> index 1fbe11f..281ccfb 100644
>> --- a/drivers/cpufreq/Kconfig
>> +++ b/drivers/cpufreq/Kconfig
>> @@ -17,6 +17,11 @@ config CPU_FREQ
>>
>>  if CPU_FREQ
>>
>> +config CPU_FREQ_PM_OPP
>> +       bool
>> +       depends on PM_OPP
>> +       default y
>> +
>
> Don't need this

ok.

>
>>  config CPU_FREQ_GOV_COMMON
>>         bool
>>
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index 0dbb963..16eea68 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -1,5 +1,7 @@
>>  # CPUfreq core
>>  obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o
>> +obj-$(CONFIG_CPU_FREQ_PM_OPP)          += cpufreq_opp.o
>
> Just use: obj-$(CONFIG_PM_OPP)
ok.

>
>> +
>>  # CPUfreq stats
>>  obj-$(CONFIG_CPU_FREQ_STAT)             += cpufreq_stats.o
>>
>
>> diff --git a/drivers/cpufreq/cpufreq_opp.c b/drivers/cpufreq/cpufreq_opp.c
>> new file mode 100644
>> index 0000000..2602ff8
>> --- /dev/null
>> +++ b/drivers/cpufreq/cpufreq_opp.c
>> @@ -0,0 +1,102 @@
>> +/*
>> + * Generic OPP Interface for CPUFREQ drivers
>> + *
>> + * Copyright (C) 2009-2014 Texas Instruments Incorporated.
>> + *     Nishanth Menon
>> + *     Romit Dasgupta
>> + *     Kevin Hilman
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>
> I hope you have just copy pasted routines to this file, and haven't done
> even the most minor modification in those, as its hard to review it.

there is code replacement ofcourse ->
* the logic of walking down the list holding a mutex has been replaced
with rcu locks,
* instead of reading internal data structure and generating the list,
use the existing search API that does exactly the same.
* Documentation update for the same.

Both are needed if you have to move the code out. functionally, both
are equivalent

>
>> +#include <linux/slab.h>
>
> Sure? That's it, nothing else required to compile this file independently?
> As a rule include all the files directly which might be required for compilation
> of this file and don't expect them to be included by some other header
> files indirectly.

Alrite. will do, I try to trim the headers down to bare minimum, but
will take care of it in the formal post.

>
>> diff --git a/drivers/cpufreq/cpufreq_opp.h b/drivers/cpufreq/cpufreq_opp.h
>
> Two problems, driver may lie in arch/ as well, though we don't recommend
> them, secondly move these in cpufreq.h, don't need a header here for sure.

There are none at the moment. ideally, we'd like to discourage folks
putting cpufreq drivers in arch/ given the amount of effort you have
undertaken in bringing them all here. but I have personally no strong
objection to getting rid of the private header and using the generic
cpufreq header.

Otherwise, I assume you are ok with this approach and will post a
formal patch by monday.

Regards,
Nishanth Menon
