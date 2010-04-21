From: skannan@codeaurora.org (skannan at codeaurora.org)
Date: Wed, 21 Apr 2010 02:39:39 -0700 (PDT)
Subject: udelay() broken for SMP cores?
In-Reply-To: <20100421072243.GA913@n2100.arm.linux.org.uk>
References: <4BCE60C4.8020505@codeaurora.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C4FEED81@dbde02.ent.ti.com>
	<4BCE9E8B.2070103@codeaurora.org>
	<20100421072243.GA913@n2100.arm.linux.org.uk>
Message-ID: <ea62885d30e4bbfb84db59758fa9e946.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Apr 20, 2010 at 11:43:23PM -0700, Saravana Kannan wrote:
>>
>>>> I looked at arch/arm/lib/delay.S and it looks like __udelay and
>>>> __const_udelay won't work correctly for SMP cores. The code just uses
>>>> the loops_per_jiffy variable instead of the per-CPU loops per jiffy
>>>> data.
>>>>
>>>> Is anyone already working on a fix for that? If not, I can fix it up
>>>> in
>>>> a way that's hopefully palatable to the community.
>>>
>>
>>> If you have case where individual CPUs are running at different speed
>>> and different
>>> Tick rate then only this can make difference.
>>
>> Yes. I was talking about the case where the CPUs could be running at
>> different speeds.
>
> We don't support that; if we did, we'd have to disable preempt for every
> call to mdelay/udelay to ensure that the thread is locked to a particular
> CPU.  I suspect that will (a) destroy RT scheduling preformance (b)
> increase preempt latency to an undesirable extent.
>

Is this an ARM specific decision? Cpufreq certainly supports per cpu scaling
and x86 udelay uses per-CPU data. So your concern should apply for x86
too. I had the same concern and was planning on bring it up in the cpufreq
mailing list after I made sure I didn't misunderstand anything.

Btw, your concern should apply for single core scaling too, right? Context
switch can complete within max udelay (general - 5ms, ARM - 2ms) time and
CPU could have jumped
from lowest to highest speed in that time and mess up udelay. I didn't see
any code in cpufreq that deferred scaling during udelay. So, that's something
I plan to ask cpufreq folks too.

Let me know what you think.

Thanks,
Saravana
P.S: Sent from phone. Pls excuse formatting issues.
