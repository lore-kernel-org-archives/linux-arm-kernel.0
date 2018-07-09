From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 10 Jul 2018 00:09:11 +0200 (CEST)
Subject: [PATCH 2/2] clocksource: arm_arch_timer: set arch_mem_timer
 cpumask to cpu_possible_mask
In-Reply-To: <1531151136-18297-2-git-send-email-sudeep.holla@arm.com>
References: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
 <1531151136-18297-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <alpine.DEB.2.21.1807100008100.1590@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 Jul 2018, Sudeep Holla wrote:

> Currently, arch_mem_timer cpumask is set to cpu_all_mask which should be
> fine. However, cpu_possible_mask is more accurate and if there are other
> clockevent source in the system which are set to cpu_possible_mask, then
> having cpu_all_mask may result in issue.
> 
> E.g. on a platform with arm,sp804 timer with rating 300 and
> cpu_possible_mask and this arch_mem_timer timer with rating 400 and
> cpu_all_mask, tick_check_preferred may choose both preferred as the
> cpumasks are not equal though they must be.
> 
> This issue was root caused incorrectly initially and a fix was merged as
> commit 1332a9055801 ("tick: Prefer a lower rating device only if it's CPU
> local device").

To avoid that in the future we really should fix the decision logic to mask
out the non possible CPUs from the supplied masks.

Thanks,

	tgkx
