From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:12:47 +0100
Subject: [PATCH 0/5] ARM: hw_breakpoint: updates for 3.2
Message-ID: <1312823572-9807-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I finally got my paws on a Cortex-A15 FPGA and updated the hw_breakpoint
code to make use of the shiny new features in debug architecture 7.1.

This patch series adds support for:

  1.) Debug architecture 7.1 detection and initialisation
  2.) Reading of the DFAR on watchpoint exceptions, so now we can handle
      more than just a single watchpoint.
  3.) Graceful failure when a debug-hating implementor decides to tie
      DBGSWENABLE low.

I've taken it for a spin with perf on Cortex-A9 and A15 platforms and it
seems to work. I've also booted it on my 1176 to ensure that the new
initialisation code doesn't barf there.

All feedback welcome.

Will


Will Deacon (5):
  ARM: hw_breakpoint: add initial Cortex-A15 (debug v7.1) support
  ARM: hw_breakpoint: reserve one breakpoint for watchpoint stepping
  ARM: hw_breakpoint: add support for multiple watchpoints
  ARM: hw_breakpoint: reduce the number of WARN_ONCE invocations
  ARM: hw_breakpoint: trap undef instruction exceptions in
    reset_ctrl_regs

 arch/arm/include/asm/hw_breakpoint.h |    2 +
 arch/arm/kernel/hw_breakpoint.c      |  267 ++++++++++++++++++++-------------
 2 files changed, 164 insertions(+), 105 deletions(-)
