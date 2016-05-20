From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 20 May 2016 07:23:15 +0000
Subject: [PATCH 0/2] ARM: bcm2835: probe clock and sdram driver early
Message-ID: <1463728997-8241-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Probe the clock and sdram driver early during the boot process.
This is done to minimize the risk that the PLLD_CORE0 or PLLD
clocks get disabled by another driver.

Such a situation results in the SDRAM stopping to work, which
we can trigger easily with current kernels when there are only a
few clocks enabled.

Right now both drivers are registered with core_initcall.
I am unsure if there is any link-ordering that could
impact us - if such is the case we will need to move the
priorities of one of the drivers slightly. Recommendations?

Note that this patchset requires the sdram memory driver patch
to be applied first.

Martin Sperl (2):
  clk: bcm2835: register clocks early
  memory: bcm2835: enable driver early in the boot process

 drivers/clk/bcm/clk-bcm2835.c  | 18 +++++++++++++++---
 drivers/memory/bcm2835-sdram.c | 10 +++++++++-
 2 files changed, 24 insertions(+), 4 deletions(-)

--
2.1.4
