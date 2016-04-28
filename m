From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 28 Apr 2016 14:03:58 +0100
Subject: [RFC PATCH] arm64: Make arch_randomize_brk avoid stack area
Message-ID: <1461848638.2848.19.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a process is created, various address randomisations may end up
colluding to place the address of brk in the stack memory.

One consequence of this, is that even for processes that make no use of
brk, the output of /proc/*/maps may show the stack area listed as
'[heap]' rather than '[stack]'. Apart from being misleading to this causes
fatal errors with the Android run-time like:
"No [stack] line found in /proc/self/task/*/maps"

To prevent this problem pick a limit for brk that allows for the stack's
memory. At the same time we remove randomize_base() as that was only
used by arch_randomize_brk().

Note, in practice, since commit d1fd836dcf00 ("mm: split ET_DYN ASLR
from mmap ASLR") this problem shouldn't occur because the address chosen
for loading binaries is well clear of the stack, however, prior to that
the problem does occur because of the following...

The memory layout of a task is determined by arch_pick_mmap_layout. If
address randomisation is enabled (task has flag PF_RANDOMIZE) this sets
mmap_base to a random address at the top of task memory just below a
region calculated to allow for a stack which itself may have a random
base address. Any mmap operations that then happen which require an
address allocating will use the topdown allocation method, i.e. the
first allocated memory will be at the top of memory, just below the
area set aside for the stack.

When a relocatable binary is loaded into a new process by
load_elf_binary and randomised address are enabled, it uses a
'load_bias' of zero, so that when mmap is called to create a memory
region for it, a new address is picked (address zero not being
available). As this is the first memory region in the task, it gets the
region just below the stack, as described previously.

The loader then set's brk to the end of the elf data section, which will
be near the end of the loaded binary and then it calls
arch_randomize_brk. As this currently stands, this adds a random amount
to brk, which unfortunately may take it into the address range where the
stack lies.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---

I don't know if a change like this is needed for the latest Linux
versions - where it's more like defensive coding than solving a current
issue.

For earlier versions, like 3.18 LTS where I diagnosed the problem, I
don't know if this is a suitable fix, of if the later ASLR changes
should be backported (seems somewhat more invasive).

Perhaps this issue isn't important enough for LTS and is just needed for
people maintaining Android trees.

 arch/arm64/kernel/process.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 8062482..7126a5a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -382,13 +382,24 @@ unsigned long arch_align_stack(unsigned long sp)
 	return sp & ~0xf;
 }
 
-static unsigned long randomize_base(unsigned long base)
+unsigned long arch_randomize_brk(struct mm_struct *mm)
 {
 	unsigned long range_end = base + (STACK_RND_MASK << PAGE_SHIFT) + 1;
-	return randomize_range(base, range_end, 0) ? : base;
-}
+	unsigned long max_stack, range_limit;
 
-unsigned long arch_randomize_brk(struct mm_struct *mm)
-{
-	return randomize_base(mm->brk);
+	/*
+	 * Determine how much room do we need to leave available for the stack.
+	 * We limit this to a reasonable value, because extremely large or
+	 * unlimited stacks are always going to bump up against brk at some
+	 * point and we don't want to fail to randomise brk in those cases.
+	 */
+	max_stack = rlimit(RLIMIT_STACK);
+	if (max_stack > SZ_128M)
+		max_stack = SZ_128M;
+
+	range_limit = mm->start_stack - max_stack - 1;
+	if (range_end > range_limit)
+		range_end > range_limit
+
+	return randomize_range(mm->brk, range_end, 0) ? : mm->brk;
 }
-- 
2.1.4
