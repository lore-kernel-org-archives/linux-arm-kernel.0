From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  4 May 2018 18:39:31 +0100
Subject: [PATCH 0/6] arm64: add instrumented atomics
Message-ID: <20180504173937.25300-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series (based on v4.17-rc3) allows arm64's atomics to be
instrumented, which should make it easier to catch bugs where atomics
are used on erroneous memory locations.

The bulk of the diffstat is teaching the generic instrumentation about
the acquire/release/relaxed variants of each atomic, along with some
optional atomics which x86 doesn't implement directly.

To build an arm64 defonfig one additional patch [1] is required, which
fixes an include in the SUNRPC code. I've pushed the series, along with
that patch, to my arm64/atomic-instrumentation branch [2].

This has seen basic testing on a Juno R1 machine so far.

Thanks,
Mark.

[1] https://lkml.kernel.org/r/1489574142-20856-1-git-send-email-mark.rutland at arm.com
[2] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/atomic-instrumentation

Mark Rutland (6):
  locking/atomic, asm-generic: instrument ordering variants
  locking/atomic, asm-generic: instrument atomic*andnot*()
  arm64: use <linux/atomic.h> for cmpxchg
  arm64: fix assembly constraints for cmpxchg
  arm64: use instrumented atomics
  arm64: instrument smp_{load_acquire,store_release}

 arch/arm64/include/asm/atomic.h           |  299 +++----
 arch/arm64/include/asm/atomic_ll_sc.h     |   30 +-
 arch/arm64/include/asm/atomic_lse.h       |   43 +-
 arch/arm64/include/asm/barrier.h          |   22 +-
 arch/arm64/include/asm/cmpxchg.h          |   25 +-
 arch/arm64/include/asm/pgtable.h          |    2 +-
 arch/arm64/include/asm/sync_bitops.h      |    3 +-
 arch/arm64/mm/fault.c                     |    2 +-
 include/asm-generic/atomic-instrumented.h | 1305 +++++++++++++++++++++++++----
 9 files changed, 1339 insertions(+), 392 deletions(-)

-- 
2.11.0
