From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Jul 2013 12:36:23 +0100
Subject: [PATCH 0/6] Add support for pldw instruction on v7 MP cores
Message-ID: <1374579389-32704-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for the pldw instruction implemented on
ARMv7 SMP processors. The instruction is used to implement the prefetchw
macro, which is then used around barrier-less ldrex/strex sections (i.e.
the prefetch isn't blocked either side by memory barriers) to increase
the chances of the strex succeeding initially.

On my TC2 board (A7s + A15s), I see a ~1.3% boost in hackbench scores
on top of my barriers patch series.

All feedback welcome,

Will


Will Deacon (6):
  ARM: prefetch: remove redundant "cc" clobber
  ARM: smp_on_up: move inline asm ALT_SMP patching macro out of
    spinlock.h
  ARM: prefetch: add support for prefetchw using pldw on SMP ARMv7+ CPUs
  ARM: locks: prefetch the destination word for write prior to strex
  ARM: atomics: prefetch the destination word for write prior to strex
  ARM: bitops: prefetch the destination word for write prior to strex

 arch/arm/include/asm/atomic.h    |  7 +++++++
 arch/arm/include/asm/processor.h | 33 +++++++++++++++++++++++++--------
 arch/arm/include/asm/spinlock.h  | 24 ++++++++++++------------
 arch/arm/include/asm/unified.h   |  4 ++++
 arch/arm/lib/bitops.h            |  5 +++++
 5 files changed, 53 insertions(+), 20 deletions(-)

-- 
1.8.2.2
