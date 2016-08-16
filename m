From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 16 Aug 2016 15:40:32 +0200
Subject: [PATCH v2] ARM: Add missing newline terminators to kernel messages
Message-ID: <1471354832-18456-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Before commit 874f9c7da9a4acbc ("printk: create pr_<level> functions"),
pr_*() calls without a trailing newline characters would be printed with
a newline character appended, both on the console and in the output of
the dmesg command.

After that commit, no new line character is appended, and the output of
the next pr_*() call of the same type may be appended:

    - Truncating RAM at 0x0000000040000000-0x00000000c0000000 to -0x0000000070000000
    - Ignoring RAM at 0x0000000200000000-0x0000000240000000 (!CONFIG_HIGHMEM)
    + Truncating RAM at 0x0000000040000000-0x00000000c0000000 to -0x0000000070000000Ignoring RAM at 0x0000000200000000-0x0000000240000000 (!CONFIG_HIGHMEM)

and:

    -No ATAGs?
    -hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
    +No ATAGs?hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.

While this commit has been reverted in commit a0cba2179ea4c182 ("Revert
"printk: create pr_<level> functions""), it's still good practice to
terminate kernel messages with newlines.

v2:
  - Rebased
---
 arch/arm/kernel/atags_proc.c | 2 +-
 arch/arm/mm/mmu.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
index 5a3379055f553167..d7af7b84a4ca32c5 100644
--- a/arch/arm/kernel/atags_proc.c
+++ b/arch/arm/kernel/atags_proc.c
@@ -41,7 +41,7 @@ static int __init init_atags_procfs(void)
 	size_t size;
 
 	if (tag->hdr.tag != ATAG_CORE) {
-		pr_info("No ATAGs?");
+		pr_info("No ATAGs?\n");
 		return -EINVAL;
 	}
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 724d6be4b83225ee..7dbdad64a1ac5fd3 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1196,7 +1196,7 @@ void __init sanity_check_meminfo(void)
 				pr_notice("Truncating RAM at %pa-%pa",
 					  &block_start, &block_end);
 				block_end = vmalloc_limit;
-				pr_cont(" to -%pa", &block_end);
+				pr_cont(" to -%pa\n", &block_end);
 				memblock_remove(vmalloc_limit, overlap_size);
 				should_use_highmem = true;
 			}
-- 
1.9.1
