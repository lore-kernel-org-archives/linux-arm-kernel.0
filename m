From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 16 Apr 2014 17:59:55 +0200
Subject: [patch 0/4] genirq/exynos timers: Fix the CPU hotplug wreckage
 sanely
In-Reply-To: <20140416142106.537575971@linutronix.de>
References: <20140416142106.537575971@linutronix.de>
Message-ID: <1397663995.19782.4.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2014-04-16 at 14:36 +0000, Thomas Gleixner wrote:
> The current implementation of irq_set_affinity() refuses rightfully to
> route an interrupt to an offline cpu.
> 
> But there is a special case, where this is actually desired. Some of
> the ARM SoCs have per cpu timers which require setting the affinity
> during cpu startup where the cpu is not yet in the online mask.
> 
> If we can't do that, then the local timer interrupt for the about to
> become online cpu is routed to some random online cpu.
> 
> The developers of the affected machines tried to work around that
> issue, but that results in a massive mess in that timer code.
> 
> It's saner to provide a facility to force the affinity and make the
> affected machines use that.
> 
> The following series implements that logic w/o impact on any existing
> users.
> 
> The change to the genirq core code is not that bad:
> 
>  arch/mips/cavium-octeon/octeon-irq.c |    2 +-
>  include/linux/interrupt.h            |   35 ++++++++++++++++++++++++++++++++++-
>  include/linux/irq.h                  |    3 ++-
>  kernel/irq/manage.c                  |   17 ++++++-----------
>  4 files changed, 43 insertions(+), 14 deletions(-)
> 
> The resulting fixup for gic/exynos_mct is:
> 
>  clocksource/exynos_mct.c |   12 +++---------
>  irqchip/irq-gic.c        |    8 ++++++--
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> Krzysztofs proposed workaround was slightly smaller than that, but I
> prefer having a clean solution for backporting to stable rather than a
> messy hack around which works.
> 
> @Krzysztof: Can you please retest the series? I've changed the core
> implementation versus the first attempt to make it less intrusive.

Works fine. Tested whole patchset on board with Exynos 3250.

Best regards,
Krzysztof
