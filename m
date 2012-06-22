From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2012 16:09:32 +0100
Subject: [PATCH 0/2] Use architected timers for delay loop
Message-ID: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series reworks our delay loop implementation to allow the
busy-loop to be replaced with the physical counter included as part of
the architected timer on recent CPUs. The polling implementation is
still maintained to support cores without the timers and we use the same
maths and upper delay bound of 2ms.

Russell - I think my maths is correct, but why can't we increase the
          precision by using a magic constant of 4398046U and a right
	  shift of 31?

As usual, all feedback is welcome,

Will


Will Deacon (2):
  ARM: arch timer: implement read_current_timer and get_cycles
  ARM: delay: allow timer-based delay implementation to be selected

 arch/arm/include/asm/arch_timer.h      |    1 +
 arch/arm/include/asm/delay.h           |   19 +++++++--
 arch/arm/include/asm/timex.h           |   10 +++--
 arch/arm/kernel/arch_timer.c           |   11 +++++
 arch/arm/kernel/armksyms.c             |    3 +-
 arch/arm/lib/Makefile                  |    2 +-
 arch/arm/lib/{delay.S => delay-loop.S} |   16 +++----
 arch/arm/lib/delay.c                   |   66 ++++++++++++++++++++++++++++++++
 arch/arm/mach-sa1100/sleep.S           |    8 ++--
 9 files changed, 112 insertions(+), 24 deletions(-)
 rename arch/arm/lib/{delay.S => delay-loop.S} (85%)
 create mode 100644 arch/arm/lib/delay.c

-- 
1.7.4.1
