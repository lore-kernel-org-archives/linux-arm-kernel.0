From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 29 Sep 2017 11:52:28 +0100
Subject: [PATCH v3 0/2] WFE for long delays
Message-ID: <1506682350-9023-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was pointed out that there are some windows where the event stream might not
be configured, meaning we cannot safely use WFE (e.g. when using PSCI
CPU_SUSPEND for idle, PSCI might reset CPU state).

The first patch provide a function to check whether the task is in state where
it can expect events from the event stream.

Second patch actually makes use of WFE in delays.

Changes since v1:
- Keep track of event stream state
- Do not use WFE when event stream might be misconfigured

Changes since v2:
- Use cpumask to track event stream state instead of percpu variable
- Tidy a bit code in arm64/lib/delay
- Do not factor asm-generic/delay code

Julien Thierry (2):
  arm_arch_timer: Expose event stream status
  arm64: use WFE for long delays

 arch/arm/include/asm/arch_timer.h    |  1 +
 arch/arm64/include/asm/arch_timer.h  |  1 +
 arch/arm64/lib/delay.c               | 23 +++++++++++++++++++----
 drivers/clocksource/arm_arch_timer.c | 20 ++++++++++++++++++--
 include/clocksource/arm_arch_timer.h | 10 +++++++++-
 5 files changed, 48 insertions(+), 7 deletions(-)

--
1.9.1
