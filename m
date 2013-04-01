From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 15:58:31 -0500
Subject: [PATCH v2 0/3] ARM sched_clock selection enhancements
Message-ID: <1364849914-26420-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to move more timer initialization to use CLKSRC_OF and
out of the platforms, a way to select the timer used for sched_clock is
needed. This series makes the ARM sched_clock function override-able and
makes the sched_clock setup code prefer higher frequency counters. This
is sufficient at least on ARM Ltd boards to use the 24MHz counter rather
than sp804 and to always use the 64-bit architected timer when present.
This mechanism can be extended to DT properties if needed for any
non-discoverable h/w feature.

Patch 1 is unchanged from the prior version. Patch 2 is completely
rewritten and more simple than the prior version. It simply converts
sched_clock to a function pointer which can be overridden by the
architected timer init. It seems unlikely we will have other 64-bit
timers or not want to use the architected timer.

Rob

Rob Herring (3):
  ARM: sched_clock: allow changing to higher frequency counter
  ARM: make sched_clock just call a function pointer
  ARM: arch_timer: use full 64-bit counter for sched_clock

 arch/arm/include/asm/sched_clock.h |    2 ++
 arch/arm/kernel/arch_timer.c       |   15 ++++++++++-----
 arch/arm/kernel/sched_clock.c      |   15 +++++++++++++--
 3 files changed, 25 insertions(+), 7 deletions(-)

-- 
1.7.10.4
