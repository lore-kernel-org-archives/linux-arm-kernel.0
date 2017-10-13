From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 13 Oct 2017 14:32:54 +0100
Subject: [PATCH v4 0/2] WFE for long delays
Message-ID: <1507901576-34641-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was pointed out that there are some windows where the event stream might not
be configured, meaning we cannot safely use WFE (e.g. when using PSCI
CPU_SUSPEND for idle, PSCI might reset CPU state).

The first patch provide a function to check whether the task is in state where
it can expect events from the event stream.

Second patch actually makes use of WFE in delays.

Changes since v1:
* Keep track of event stream state
* Do not use WFE when event stream might be misconfigured

Changes since v2:
* Use cpumask to track event stream state instead of percpu variable
* Tidy a bit code in arm64/lib/delay
* Do not factor asm-generic/delay code

Changes since v3:
* Use static initialiser for event stream cpumask
* Remove double negation when checking steam availability
* Use raw_smp_processor_id instead of smp_processor_id
* Fix typo
* Change macro argument to lower case

Cheers,

Julien Thierry (2):
  arm_arch_timer: Expose event stream status
  arm64: use WFE for long delays

 arch/arm/include/asm/arch_timer.h    |  1 +
 arch/arm64/include/asm/arch_timer.h  |  1 +
 arch/arm64/lib/delay.c               | 23 +++++++++++++++++++----
 drivers/clocksource/arm_arch_timer.c | 25 ++++++++++++++++++++++---
 include/clocksource/arm_arch_timer.h | 10 +++++++++-
 5 files changed, 52 insertions(+), 8 deletions(-)

--
1.9.1
