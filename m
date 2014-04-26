From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Fri, 25 Apr 2014 23:34:55 -0700
Subject: [PATCH v5] ARM: uprobes need icache flush after xol write
Message-ID: <1398494096-11311-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is proposal for ARM uprobes icache flush issue. David
Long and I believe that it is the best option as short/medium
term fix. Ideally it would be good to find common arch solution,
but it looks it is hard goal to achieve.

arch_uprobe_copy_ixol function is introduced that implements
arch specific way of handling xol slot copy. In default case
we have the same code as we have now for x86 and ppc. In case of
ARM the xol slot flush code shares code with ARM backend of
copy_to_user_page - flush_ptrace_access function. Code and new 
implementation of flush_uprobe_xol_access ware modified in such
way that xol flush does need vma.

Code was tested on Pandaboard ES with 3.15-rc2 and latest
SystemTap code from git. Tested both SMP and non SMP cases.

Changes since V3 [1] version (previous version):

x) Propose patch as suggested solution (dropped RFC)

x) Dropped "ifdef CONFIG_SMP" around preempt_enable, preempt_disable
calls

x) Note V4 was RFC and contained version that explored different
approach.

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

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/247793.html

[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/245743.html


Victor Kamensky (1):
  ARM: uprobes need icache flush after xol write

 arch/arm/include/asm/cacheflush.h |  2 ++
 arch/arm/kernel/uprobes.c         | 20 ++++++++++++++++++++
 arch/arm/mm/flush.c               | 33 ++++++++++++++++++++++++++++-----
 include/linux/uprobes.h           |  3 +++
 kernel/events/uprobes.c           | 25 +++++++++++++++++--------
 5 files changed, 70 insertions(+), 13 deletions(-)

-- 
1.8.1.4
