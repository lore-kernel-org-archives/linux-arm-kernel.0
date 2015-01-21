From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 21 Jan 2015 17:03:37 +0000
Subject: [RFC PATCH v2 0/5] irq: Allow irqs to be routed to NMI/FIQ
In-Reply-To: <1421166931-14134-1-git-send-email-daniel.thompson@linaro.org>
References: <1421166931-14134-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1421859822-3621-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Hi Russell:
    This RFC is particularly for your attention since it results
    directly from feedback I've received from both of you, albeit
    quite a few months ago now.

This patchset demonstrates using FIQ to improve the quality of the
PMU trace on ARM systems. To do so it introduces generic changes
that allow irqs to be routed to NMI.

This patchset applies on top of my own patchset:

    arm: Implement arch_trigger_all_cpu_backtrace
    http://thread.gmane.org/gmane.linux.kernel/1864829

I think most important aspects of the code are clear without reference to
the previous patchset however the patches will not run (nor apply cleanly)
without the previous patchset.

v2:

* Removed the direct calls in handle_fiq_as_nmi (Joshua Clayton). There
  is now indirection in the default FIQ handler so, to address RMK's
  concerns regarding code review, there is also a means for arch code to
  filter the avaiable handlers.

  The new approach has got rid of a *lot* of nasty hairballs in the code
  (including those that came up in the reviews Joshua Clayton and
  Russell King).


Daniel Thompson (5):
  arm: irq: Add a __nmi_count stat
  irq: Allow interrupts to routed to NMI (or similar)
  irq: gic: Add support for NMI routing
  arm: perf: Make v7 support FIQ-safe
  arm: perf: Use FIQ to handle PMU events.

 arch/arm/include/asm/hardirq.h   |  1 +
 arch/arm/include/asm/pmu.h       |  2 ++
 arch/arm/kernel/irq.c            |  7 ++++-
 arch/arm/kernel/perf_event.c     |  2 +-
 arch/arm/kernel/perf_event_cpu.c | 14 +++++++--
 arch/arm/kernel/perf_event_v7.c  | 11 ++-----
 arch/arm/kernel/traps.c          | 35 ++++++++++++++++++----
 drivers/irqchip/irq-gic.c        | 64 ++++++++++++++++++++++++++++------------
 include/linux/interrupt.h        |  5 ++++
 include/linux/irq.h              |  2 ++
 include/linux/irqchip/arm-gic.h  |  6 +++-
 include/linux/irqdesc.h          |  3 ++
 kernel/irq/irqdesc.c             | 48 ++++++++++++++++++++++++++++++
 kernel/irq/manage.c              | 46 +++++++++++++++++++++++++++++
 14 files changed, 207 insertions(+), 39 deletions(-)

--
1.9.3
