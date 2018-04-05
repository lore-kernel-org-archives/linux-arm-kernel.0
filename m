From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu,  5 Apr 2018 20:17:55 +0300
Subject: [PATCH v2 0/2] smp: don't kick CPUs running idle or nohz_full tasks 
Message-ID: <20180405171800.5648-1-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kick_all_cpus_sync() is used to broadcast IPIs to all online CPUs to force
them synchronize caches, TLB etc. It is called only 3 times - from mm/slab
arm64 and powerpc code.

We can delay synchronization work for CPUs in extended quiescent state
(idle or nohz_full userspace). 

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

v2 is big rework to address comments in v1:
 - rcu_eqs_special() declaration in public header is dropped, it is not
   used in new implementation. Though, I hope Paul will pick it in his
   tree;
 - for arm64, few isb() added to ensure kernel text synchronization
   (patches 1-4);
 - rcu_get_eqs_cpus() introduced and used to mask EQS CPUs before 
   generating broadcast IPIs;
 - RCU_DYNTICK_CTRL_MASK is not touched because memory barrier is
   implicitly issued in EQS exit path;
 - powerpc is not an exception anymore. I think it's safe to delay
   synchronization for it as well, and I didn't get comments from ppc
   community.
v1:
  https://lkml.org/lkml/2018/3/25/109

Based on next-20180405

Yury Norov (5):
  arm64: entry: isb in el1_irq
  arm64: entry: introduce restore_syscall_args macro
  arm64: ISB early at exit from extended quiescent state
  rcu: arm64: add rcu_dynticks_eqs_exit_sync()
  smp: Lazy synchronization for EQS CPUs in kick_all_cpus_sync()

 arch/arm64/kernel/Makefile  |  2 ++
 arch/arm64/kernel/entry.S   | 52 +++++++++++++++++++++++++++++++--------------
 arch/arm64/kernel/process.c |  7 ++++++
 arch/arm64/kernel/rcu.c     |  8 +++++++
 include/linux/rcutiny.h     |  2 ++
 include/linux/rcutree.h     |  1 +
 kernel/rcu/tiny.c           |  9 ++++++++
 kernel/rcu/tree.c           | 27 +++++++++++++++++++++++
 kernel/smp.c                | 21 +++++++++++-------
 9 files changed, 105 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm64/kernel/rcu.c

-- 
2.14.1
