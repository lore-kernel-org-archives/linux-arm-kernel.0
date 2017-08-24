From: hoeun.ryu@gmail.com (Hoeun Ryu)
Date: Thu, 24 Aug 2017 14:42:54 +0900
Subject: [RFC 0/3] add 64BIT_ATOMIC_ACCESS and 64BIT_ATOMIC_ALIGNED_ACCESS
Message-ID: <1503553377-3646-1-git-send-email-hoeun.ryu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On some 32-bit architectures, 64bit accesses are atomic when certain
conditions are satisfied.

 For example, on LPAE (Large Physical Address Extension) enabled ARM
architecture, 'ldrd/strd' (load/store doublewords) instructions are 64bit
atomic as long as the address is 64-bit aligned. This feature is to
guarantee atomic accesses on newly introduced 64bit wide descriptors in
the translation tables, and 's/u64' variables can be accessed atomically
when they are aligned(8) on LPAE enabled ARM architecture machines.

 Introducing 64BIT_ATOMIC_ACCESS and 64BIT_ATOMIC_ALIGNED_ACCESS, which
can be true for the 32bit architectures as well as 64bit architectures.

 we can optimize some kernel codes using seqlock (timekeeping) or mimics
of it (like in sched/cfq) simply to read or write 64bit variables.
 The existing codes depend on CONFIG_64BIT to determine whether the 64bit
variables can be directly accessed or need additional synchronization
primitives like seqlock. CONFIG_64BIT_ATOMIC_ACCESS can be used instead of
CONFIG_64BIT in the cases.

 64BIT_ATOMIC_ALIGNED_ACCESS can be used in the variable declaration to
indicate the alignment requirement to the compiler
(__attribute__((aligned(8)))) in the way of #ifdef.

 The last patch "sched: depend on 64BIT_ATOMIC_ACCESS to determine if to
use min_vruntime_copy" is an example of this approach.

 I'd like to know what the architecture maintainers and kernel maintainers
think about it. I think I can make more examples (mostly removing seqlock
to access the 64bit variables on the machines) if this approach is
accepted.

Hoeun Ryu (3):
  arch: add 64BIT_ATOMIC_ACCESS to support 64bit atomic access on 32bit
    machines
  arm: enable 64BIT_ATOMIC(_ALIGNED)_ACCESS on LPAE enabled machines
  sched: depend on 64BIT_ATOMIC_ACCESS to determine if to use
    min_vruntime_copy

 arch/Kconfig         | 20 ++++++++++++++++++++
 arch/arm/mm/Kconfig  |  2 ++
 kernel/sched/fair.c  |  6 +++---
 kernel/sched/sched.h |  6 +++++-
 4 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.7.4
