From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue,  8 Apr 2014 22:58:51 -0700
Subject: [PATCH v2] ARM: uprobes need icache flush after xol write
Message-ID: <1397023132-10313-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

This second version of patch to flush icache and dcache after
uprobes xol write to make written instruction available in icache.
Please see [1] for initial discussion.

This patch follows Russell's suggestion, and function that does
cache flush after xol slot instruction write is shared/reused
with similar one implemented already for ptrace code.

In order to reuse common implementation but to avoid vma use
by xol_get_insn_slot I split flush_ptrace_access into two
functions. Where first part retrieves all required conditions
from vma and places them into flags variable and then calls 
second function which is common code.

Also I had to change xol_get_insn_slot function to map page
into kernel explicitly within function without use of 
copy_to_page helper because ARM cache flush code need both
kernel address through which instruction write happens and
virtual address of user-land process where instruction will
end up. I hope this call back is universal enough so other
CPU could implement their cache invalidation/sync after
uprobes xol instruction write logic based on provided
parameters.

I've tested it on Arndale board with my SystemTap test case
that had cache problem before. Disassemble of 
flush_uprobe_xol_access in case of Arndale shows that compiler
does good job and optimizes out all flags check effectively
leaving on this cpu call to flush_icache_alias or call to
v7_coherent_user_range (__cpuc_coherent_kern_range).

Also tested basic user-level debugging.

Wondering on what ARM boards/cpus could we test cache_is_vivt()
and cache_is_vipt_aliasing cases ...

Just to summarize, please note on [1] there were couple other
suggestions:

   Oleg suggested to use flush_icache_user_range but Russell
argument was that meaning of the function is lost and on ARM
it is not implemented in such way that it could address the
issue anyway. Please see [2] for details. Note it would has
vma problem use or not, that should be hacked.

   Dave Martin suggested to use flush_icache_range, which is
effectively better way to call 
__cpuc_coherent_[kern|user]_range(s,e), that was originally 
suggested. But Russell explained that it won't be enough in
case of user-land process pages and variety of cache types have
to be covered. Note for kernel pages it would be OK and it is
used in multiple places like kprobes, modules, etc.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/245595.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/245427.html

[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/245605.html

Victor Kamensky (1):
  ARM: uprobes need icache flush after xol write

 arch/arm/include/asm/cacheflush.h |  2 ++
 arch/arm/kernel/uprobes.c         |  6 ++++++
 arch/arm/mm/flush.c               | 41 +++++++++++++++++++++++++++++++++------
 include/linux/uprobes.h           |  3 +++
 kernel/events/uprobes.c           | 33 +++++++++++++++++++++++++------
 5 files changed, 73 insertions(+), 12 deletions(-)

-- 
1.8.1.4
