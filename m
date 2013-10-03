From: will.deacon@arm.com (Will Deacon)
Date: Thu,  3 Oct 2013 19:17:31 +0100
Subject: [PATCH v2 0/3] Wire up lockless lockrefs for ARM
Message-ID: <1380824254-22337-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version two of the patch I originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/200109.html

The main changes since then are:

  * Separate cmpxchg64 from atomic64_cmpxchg, so we can implement a
    barrier-less version.

  * Use this new barrier-less function to implement cmpxchg64_relaxed

  * Finally, use cmpxchg64_relaxed to optimise cmpxchg64_local and
    implement lockless lockrefs.

This results in ~100% improvement when running Linus's t.c test
(essentially stating a file in a loop for 10 seconds).

Feedback welcome,

Will


Will Deacon (3):
  ARM: cmpxchg: implement barrier-less cmpxchg64_local
  ARM: cmpxchg: implement cmpxchg64_relaxed
  ARM: lockref: add support for lockless lockrefs using cmpxchg64

 arch/arm/Kconfig                |  1 +
 arch/arm/include/asm/cmpxchg.h  | 58 ++++++++++++++++++++++++++++++++---------
 arch/arm/include/asm/spinlock.h |  8 ++++--
 3 files changed, 53 insertions(+), 14 deletions(-)

-- 
1.8.2.2
