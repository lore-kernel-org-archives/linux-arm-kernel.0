From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 15 Apr 2014 21:38:31 -0700
Subject: [RFC PATCH v3] ARM: uprobes need icache flush after xol write
Message-ID: <1397623112-3211-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As it was discussed on [1] today, here is potential ARM specific
fix for uprobes dcache/icache flush problem. I am aware that
other options are still under discussion. This patch is provided for
reference only as one of possible solutions.

The xol slot flush code shares code with ARM backend of
copy_to_user_page - flush_ptrace_access function. But code and new 
implementation of flush_uprobe_xol_access modified in such way that
xol flush does need vma.

Changes since V2 [2] version:

x) address Dave Long's comment about passing checkpatch

x) addressed Oleg's comment and instead of arch_uprobe_flush_xol_access
function use arch_uprobe_copy_ixol function that maps kernel pages, 
copies, and flush caches

x) removed FLAG_UA_BROADCAST, during discussion on [1] it was
elaborated that task executing xol single step could be 
migrated to another CPU, so we need to take care of remote
icaches if CPU does not support remote snooping. I.e
flush_uprobe_xol_access will check cache_ops_need_broadcast()
and perform smp_call_function on SMP CPUs that do not
support remote snooping.

x) added preempt_disable/preempt_enable in arch_uprobe_copy_ixol as
copy_to_user_page does. I admit that I have some guesses, but I 
don't completely understand why copy_to_user_page does that, so 
playing on safe side - added it similar to copy_to_user_page code.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/247611.html

[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/245743.html

Victor Kamensky (1):
  ARM: uprobes need icache flush after xol write

 arch/arm/include/asm/cacheflush.h |  2 ++
 arch/arm/kernel/uprobes.c         | 22 ++++++++++++++++++++++
 arch/arm/mm/flush.c               | 33 ++++++++++++++++++++++++++++-----
 include/linux/uprobes.h           |  3 +++
 kernel/events/uprobes.c           | 25 +++++++++++++++++--------
 5 files changed, 72 insertions(+), 13 deletions(-)

-- 
1.8.1.4
