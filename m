From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 17 Jan 2018 12:04:42 +0000
Subject: [PATCH 0/3] arm_pmu: Use NMI for perf interrupt
Message-ID: <1516190685-20048-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is base on the "arm64: provide pseudo NMI with GICv3"
patchset [1].

The aim is just to use a Pseudo-NMI for the PMUv3 interrupt.

- Patch 1 and 2 ensure no locks are taken when handling a PMU interrupt
- Patch 3 sets the NMI property for the interrupt.

The series was tested with the perf fuzzer

Here are some results when running:
$ perf record -a hackbench 200 process 1000

Without NMI:

# Overhead  Command          Symbol
# ........  ...............  ...................................
#
    12.07%  hackbench        [k] _raw_spin_unlock_irqrestore
     6.34%  hackbench        [k] el0_svc_naked
     5.53%  hackbench        [k] unix_stream_read_generic
     4.61%  hackbench        [k] __arch_copy_to_user
     3.38%  hackbench        [k] kmem_cache_free
     3.30%  hackbench        [k] refcount_inc_not_zero
     3.22%  hackbench        [.] 0x0000000000005258
     3.11%  hackbench        [k] skb_release_data
     2.92%  hackbench        [k] __lock_text_start
     2.52%  hackbench        [.] 0x00000000000052c8
     2.40%  hackbench        [k] skb_set_owner_w
     2.29%  hackbench        [k] __slab_alloc.isra.24
     2.22%  hackbench        [k] kfree
     2.14%  hackbench        [k] _raw_spin_unlock_irq
     2.03%  hackbench        [k] get_mem_cgroup_from_mm
     2.01%  hackbench        [k] __ll_sc___cmpxchg_double_mb
     1.88%  hackbench        [k] __ll_sc___cmpxchg_case_4
     1.72%  hackbench        [k] sock_alloc_send_pskb
     1.66%  hackbench        [k] __ll_sc___cmpxchg_case_rel_4
     1.62%  hackbench        [k] unix_stream_sendmsg
     1.59%  hackbench        [k] __slab_free
     1.47%  hackbench        [k] _raw_spin_unlock
     1.35%  hackbench        [k] __fget_light
     1.34%  hackbench        [k] __ll_sc___cmpxchg_double
     1.30%  hackbench        [k] memcg_kmem_put_cache
     1.20%  hackbench        [k] __kmalloc_node_track_caller
     1.13%  hackbench        [k] fsnotify
     1.07%  hackbench        [k] kmem_cache_alloc_node
     1.03%  hackbench        [k] vfs_write


With NMI:

# Overhead  Command          Symbol
# ........  ...............  ...................................
#
     8.05%  hackbench	     [k] _raw_spin_unlock_irqrestore
     6.22%  hackbench        [k] el0_svc_naked
     5.42%  hackbench        [k] unix_stream_read_generic
     4.44%  hackbench        [k] __arch_copy_to_user
     3.26%  hackbench        [k] __lock_text_start
     3.20%  hackbench        [k] kmem_cache_free
     3.10%  hackbench        [k] refcount_inc_not_zero
     2.86%  hackbench        [.] 0x0000000000005258
     2.71%  hackbench        [k] __ll_sc___cmpxchg_double_mb
     2.61%  hackbench        [k] skb_release_data
     2.51%  hackbench        [k] _raw_spin_lock_irqsave
     2.45%  hackbench        [k] kfree
     2.24%  hackbench        [.] 0x00000000000052c8
     2.15%  hackbench        [k] skb_set_owner_w
     1.98%  hackbench        [k] get_mem_cgroup_from_mm
     1.97%  hackbench        [k] _raw_spin_unlock
     1.86%  hackbench        [k] __ll_sc___cmpxchg_case_4
     1.65%  hackbench        [k] sock_alloc_send_pskb
     1.62%  hackbench        [k] __ll_sc___cmpxchg_case_rel_4
     1.58%  hackbench        [k] unix_stream_sendmsg
     1.56%  hackbench        [k] __slab_free
     1.31%  hackbench        [k] __kmalloc_node_track_caller
     1.30%  hackbench        [k] memcg_kmem_put_cache
     1.25%  hackbench        [k] __ll_sc___cmpxchg_double
     1.23%  hackbench        [k] __fget_light
     1.15%  hackbench        [k] kmem_cache_alloc_node
     1.08%  hackbench        [k] fsnotify
     1.04%  hackbench        [k] sock_def_readable


Function _raw_spin_unlock_irqrestore gets a nice offload because perf
interrupts are less likely to be triggered right when that function
reenables interrupts. Also, interrupt handling code can now be profiled
(except for Pseudo-NMI handlers of course).

[1] https://www.spinics.net/lists/arm-kernel/msg629392.html

Cheers,

Julien

-->

Julien Thierry (3):
  arm64: perf: Make PMU interrupt NMI safe
  arm/arm64: kvm: pmu: Make overflow handler NMI safe
  arm64: perf: Set PMU interrupt as NMI

 arch/arm64/kernel/perf_event.c | 41 +++++++++--------------------------------
 drivers/perf/arm_pmu.c         |  9 +++++++--
 include/kvm/arm_pmu.h          |  1 +
 include/linux/perf/arm_pmu.h   |  6 ------
 virt/kvm/arm/pmu.c             | 37 +++++++++++++++++++++++++++++++++----
 5 files changed, 50 insertions(+), 44 deletions(-)

--
1.9.1
