From: samu.p.onkalo@nokia.com (samu.p.onkalo at nokia.com)
Date: Mon, 9 Aug 2010 12:12:47 +0200
Subject: [PATCH 1/1] arm: kernel: idle loop pm constraints
In-Reply-To: <20100807141443.GA8687@n2100.arm.linux.org.uk>
References: <1281086261-23908-1-git-send-email-samu.p.onkalo@nokia.com>
	<1281086261-23908-2-git-send-email-samu.p.onkalo@nokia.com>
	<20100807141443.GA8687@n2100.arm.linux.org.uk>
Message-ID: <62697B07E9803846BC582181BD6FB6B82B994E2860@NOK-EUMSG-02.mgdnok.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
>Sent: 07 August, 2010 17:15
>To: Onkalo Samu.P (Nokia-MS/Tampere)
>Cc: linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCH 1/1] arm: kernel: idle loop pm constraints
>
>On Fri, Aug 06, 2010 at 12:17:41PM +0300, Samu Onkalo wrote:
>> Check pm qos cpu latency requirements before preparing for pm-idle
>activities.
>> Scheduling is prevented during those operations and interrupt thread
>serving
>> latency in increased. Driver can set pm qos latency requirement to
>zero to
>> indicate extreme tight latency needs.
>
>NAK.  This breaks hotplug CPU support.

ok 

>
>>  	while (1) {
>> +		if (pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY) == 0) {
>> +			preempt_enable_no_resched();
>> +			schedule();
>> +			preempt_disable();
>> +			continue;
>> +		}
>
>It's pointless to repeatedly call schedule() if need_resched() is not
>set -
>and the need_resched() check is extremely cheap.

True. But point is that we can't allow cpu to go to idle or even prepare for idle.
However it is little bit better to run locally small loop when there is no need 
to schedule instead of continuous scheduling for nothing.

>
>In any case, the parts that you're cutting out are the calls to
>leds_event() down to tick_nohz_restart_sched_tick().  Do you know
>where the additional latency comes from?  Is it the code in the
>pm_idle() hook?

pm_idle is not the problem. Neither the leds_events. tick*() functions
seems to take 0 - 120 us each. In worst case over 200 us together.

If the interrupt arrives when tick_nohz_stop_sched_tick() is just called, irqs are disabled.
Rescheduling needs are noticed in the worst case after the 120 us. It may take about the same
time when going out. pm_idle is not called in this case.

Does this make sense at all to modify idle loop to get rid of this delay?
Of course only when pm latency requirements are set to 0.
