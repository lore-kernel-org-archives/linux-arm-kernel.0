From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Aug 2010 15:14:43 +0100
Subject: [PATCH 1/1] arm: kernel: idle loop pm constraints
In-Reply-To: <1281086261-23908-2-git-send-email-samu.p.onkalo@nokia.com>
References: <1281086261-23908-1-git-send-email-samu.p.onkalo@nokia.com>
	<1281086261-23908-2-git-send-email-samu.p.onkalo@nokia.com>
Message-ID: <20100807141443.GA8687@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 06, 2010 at 12:17:41PM +0300, Samu Onkalo wrote:
> Check pm qos cpu latency requirements before preparing for pm-idle activities.
> Scheduling is prevented during those operations and interrupt thread serving
> latency in increased. Driver can set pm qos latency requirement to zero to
> indicate extreme tight latency needs.

NAK.  This breaks hotplug CPU support.

>  	while (1) {
> +		if (pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY) == 0) {
> +			preempt_enable_no_resched();
> +			schedule();
> +			preempt_disable();
> +			continue;
> +		}

It's pointless to repeatedly call schedule() if need_resched() is not set -
and the need_resched() check is extremely cheap.

In any case, the parts that you're cutting out are the calls to
leds_event() down to tick_nohz_restart_sched_tick().  Do you know
where the additional latency comes from?  Is it the code in the
pm_idle() hook?
