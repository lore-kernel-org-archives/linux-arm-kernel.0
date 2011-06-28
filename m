From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 28 Jun 2011 15:45:22 -0700
Subject: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
In-Reply-To: <CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
Message-ID: <4E0A5982.8040002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/28/2011 3:29 PM, Colin Cross wrote:
> <resending as plain text>
>
> On Fri, Jun 24, 2011 at 6:53 AM, Sanjeev Premi<premi@ti.com>  wrote:
>>

>> +#ifdef CONFIG_SMP
>> +       /* Adjust jiffies before transition */
>> +       for_each_cpu(i, policy->cpus) {
>> +               unsigned long lpj = per_cpu(cpu_data, i).loops_per_jiffy;
>> +
>> +               per_cpu(cpu_data, i).loops_per_jiffy = cpufreq_scale(lpj,
>> +                                                       freqs.old,
>> +                                                       freqs.new);

This isn't the right patch since it does suffer from the progressive
error. There was an updated patch on this thread from Russell which
I re-based.
> Can't this rewrite the loops_per_jiffy for the other CPU while it is
> in a udelay?  If it has already calculated the number of loops
> necessary, and the CPU frequency increases, it could end up returning
> too early from udelay.
>
> There were previous discussions about polling a fixed-frequency timer
> for udelay on SMP systems.
>
The udelay code doesn't use the per-cpu lpj variable. It uses the global
lpj. Secondly the calibration of no. of loops to be done is
precalculateed so overwrite shouldn't impact the scenario you mentioned.

Though it has an issue where, pre-calculated loops can become short/long
based on new clock change which impacts both CPU's on OMAP, when the 
other CPU is in in the middle of u-delay routine..

When CPU can scale independently, then we have bigger problem since
global lpj based udelay becomes always error prone in all scenario's.

So for the OMAP, where the whole CPU cluster is scaled together,
I don't see this as a bigger problem.

Regards
Santosh
