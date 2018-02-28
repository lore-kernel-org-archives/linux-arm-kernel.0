From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 28 Feb 2018 13:57:41 +0900
Subject: [PATCH v2 0/3] lkdtm: fix irq handler entry for arm64
Message-ID: <20180228045744.12914-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lkdtm is a handy way for testing kdump in case of panic in interrupt
context:
   echo PANIC > /sys/kernel/debug/provoke-crash/INT_HARDWARE_ENTRY

But this just doesn't work on arm64 since "do_IRQ" function doesn't
exist on arm64. This patch series addresses this problem.

Patch#1 is a preliminary fix for the rest and allows for probing any
exception entries, including irq handler, on arm64.
Patch#2 provides a generalized approach for this issue on lkdtm side.
Patch#3 is an arm64-specific fix.

As a hint for further improvement, another hook doesn't work neither:
* hrtimer_start() was converted to an inline function in v4.2
but I don't know how we should deal with them.
(In my v1, I also mentioned handle_IRQ_event, but it was a wrong claim.)

Changes in v2(Feb 27, 2018):
* provide a generalized approach instead of adding "if (CONFIG_ARM64)"
  stuff

AKASHI Takahiro (2):
  lkdtm: handle unresolved name for probing
  arm64: irq: add get_handle_irq()

Masami Hiramatsu (1):
  arm64: kprobes: Remove unneeded address sanity check

 arch/arm64/kernel/irq.c            |  7 +++++++
 arch/arm64/kernel/probes/kprobes.c |  8 --------
 drivers/misc/lkdtm_core.c          | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 10 deletions(-)

-- 
2.16.2
