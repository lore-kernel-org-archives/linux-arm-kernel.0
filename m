From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Jun 2016 18:50:16 +0100
Subject: [PATCH 0/2] arm-cc*: ensure perf synchronisation
Message-ID: <1467136218-15789-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As discovered during review of the X-Gene SoC PMU [1], the arm-cc{i,n} drivers
don't ensure that IRQ balancers don't migrate interrupts.

This is problematic for the perf core code, which requires mutual exclusion of
certain operations (e.g. event rotation, cross-calls, and irq handling) to be
provided by disabling IRQs, which only works if all operations occur on the
same CPU. This is also required for safe (lockless) manipulation of some data
structures.

To avoid this problem, we must request interrupts with IRQF_NOBALANCING, as is
already the case for CPU PMU drivers which make use of interrupts.

To ensure synchronisation between IRQ handlers and other manipulation of said
data structures or HW state, we must also ensure that the interrupt handlers
are not threaded, by requesting them with IRQF_NO_THREAD, as is already the
case for CPU PMU drivers.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/439589.html

Mark Rutland (2):
  arm-ccn: ensure perf synchronisation
  arm-cci: ensure perf synchronisation

 drivers/bus/arm-cci.c | 3 ++-
 drivers/bus/arm-ccn.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
1.9.1
