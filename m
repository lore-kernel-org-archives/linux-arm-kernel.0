From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Aug 2011 14:56:25 +0100
Subject: [PATCH v2] ARM: sched_clock: allow sched_clock to be selected
	at runtime
In-Reply-To: <alpine.LFD.2.00.1108151931410.20358@xanadu.home>
References: <1313078531-25610-1-git-send-email-marc.zyngier@arm.com>
	<alpine.LFD.2.00.1108151931410.20358@xanadu.home>
Message-ID: <4E5CEC09.8090005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/08/11 01:00, Nicolas Pitre wrote:

Hi Nicolas,

> On Thu, 11 Aug 2011, Marc Zyngier wrote:
> 
>> sched_clock() is yet another blocker on the road to the single
>> image. This patch implements an idea by Russell King:
>>
>> http://www.spinics.net/lists/linux-omap/msg49561.html
>>
>> Instead of asking the platform to implement both sched_clock()
>> itself and the rollover callback, simply register a read()
>> function, and let the ARM code care about sched_clock() itself,
>> the conversion to ns and the rollover. sched_clock() uses
>> this read() function as an indirection to the platform code.
>>
>> This allow some simplifications and possibly some footprint gain
>> when multiple platforms are compiled in. Among the drawbacks,
>> the removal of the *_fixed_sched_clock optimization which could
>> negatively impact some platforms (sa1100, tegra, versatile
>> and omap).
>>
>> Tested on 11MPCore, OMAP4 and Tegra.
> 
> [...]
> 
>> +unsigned long long notrace sched_clock(void)
>> +{
>> +	if (read_sched_clock) {
>> +		u32 cyc = read_sched_clock();
>> +		return cyc_to_sched_clock(&cd, cyc, sched_clock_mask);
>> +	}
>> +
>> +	return (unsigned long long)(jiffies - INITIAL_JIFFIES)
>> +					* (NSEC_PER_SEC / HZ);
>> +}
> 
> This bothers me that this function has to include a conditional which 
> will _always_ be evaluated as true except during early boot.  Why not 
> simply initializing read_sched_clock with a jiffy_shed_clock function 
> instead, and let it be overriden during boot?  This way the actual 
> sched_clock() code will be more straight forward.

Good point. I'll send an updated patch in a minute.

> Of course there is the race where read_sched_clock might be updated 
> before or after the corresponding clock data/mask are updated leading to 
> funky results if you are lucky enough to call sched_clock() during that 
> exact wrong moment.  But either we don't care (switching from a jiffy to 
> a hardware clock base is going to cause quite a glitch already anyway), 
> or simply disabling IRQs during initialization should prevent the race 
> (presuming no other CPUs are running at that point).

I've added a check that interrupts are disabled at that point (which
should always be true anyway).

Thanks for reviewing,

	M.
-- 
Jazz is not dead. It just smells funny...
