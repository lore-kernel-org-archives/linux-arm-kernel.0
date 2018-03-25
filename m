From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sun, 25 Mar 2018 20:50:02 +0300
Subject: [PATCH 0/2] smp: don't kick CPUs running idle or nohz_full tasks 
Message-ID: <20180325175004.28162-1-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kick_all_cpus_sync() is used to broadcast IPIs to all online CPUs to force
them sync caches, TLB etc. It is is called only 3 times - from mm/slab,
arm64 and powerpc code.

With framework introduced in patch b8c17e6664c46 ("rcu: Maintain special
bits at bottom of ->dynticks counter") we can delay synchrosization work
for CPUs in extended quiescent state (idle or nohz_full userspace). 

As Paul E. McKenney wrote: 

--

Currently, IPIs are used to force other CPUs to invalidate their TLBs
in response to a kernel virtual-memory mapping change.  This works, but 
degrades both battery lifetime (for idle CPUs) and real-time response
(for nohz_full CPUs), and in addition results in unnecessary IPIs due to
the fact that CPUs executing in usermode are unaffected by stale kernel
mappings.  It would be better to cause a CPU executing in usermode to
wait until it is entering kernel mode to do the flush, first to avoid
interrupting usemode tasks and second to handle multiple flush requests
with a single flush in the case of a long-running user task.

--

For mm/slab and arm64 it looks safe to delay synchronization. This is done
in patch #2 by introducing kick_active_cpus_sync() function. For powerpc -
I'm not sure, and I'd like to ask powerpc people, is it safe to do same
also for that code? If so, we can completely drop kick_all_cpus_sync().

Yury Norov (2):
  rcu: declare rcu_eqs_special_set() in public header
  smp: introduce kick_active_cpus_sync()

 arch/arm64/kernel/insn.c |  2 +-
 include/linux/rcutree.h  |  1 +
 include/linux/smp.h      |  2 ++
 kernel/smp.c             | 24 ++++++++++++++++++++++++
 mm/slab.c                |  2 +-
 5 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.14.1
