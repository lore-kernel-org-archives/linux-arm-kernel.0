From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu,  1 Feb 2018 18:34:57 +0900
Subject: [PATCH 0/2] lkdtm: fix irq handler entry for arm64
Message-ID: <20180201093459.20477-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lkdtm is a handy way for testing kdump in case of panic in interrupt
context:
   echo PANIC > /sys/kernel/debug/provoke-crash/INT_HARDWARE_ENTRY

But this just doesn't work on arm64 since "do_IRQ" function doesn't
exist on arm64. This patch series addresses this problem.

Patch#1 is a preliminary fix for patch#2 and allows for probing any
exception entries, including irq handler.

For further improvements, some of other hooks doesn't work:
* handle_IRQ_event() was removed in v2.6.39
* hrtimer_start() was converted to an inline function in v4.2

but I don't know how we should deal with them.


AKASHI Takahiro (1):
  lkdtm: fix irq handler entry for arm64

Masami Hiramatsu (1):
  arm64: kprobes: Remove unneeded address sanity check

 arch/arm64/kernel/probes/kprobes.c |  8 --------
 drivers/misc/lkdtm_core.c          | 20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 10 deletions(-)

-- 
2.15.1
