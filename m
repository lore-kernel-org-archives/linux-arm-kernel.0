From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 29 Mar 2013 14:18:24 +0100
Subject: [PATCH] ARM: Fix typo "CONFIG_LPAE" twice
Message-ID: <1364563104.1345.74.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Untested.

1) This typo was first introduced in v3.4: commit
e5ab85800820edd907d3f43f285e1232f84d5a41 ("ARM: 7382/1: mm: truncate
memory banks to fit in 4GB space for classic MMU"). The second instance
was added in v3.9-rc2: commit d61947a164760ac520cb416768afdf38c33d60e7
(" ARM: 7657/1: head: fix swapper and idmap population with LPAE and
big-endian"). So testing is really needed here.

2) If this passes (review and) testing, this probably needs to go to
stable too.

 arch/arm/kernel/head.S  | 2 +-
 arch/arm/kernel/setup.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index e0eb9a1..8bac553 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -267,7 +267,7 @@ __create_page_tables:
 	addne	r6, r6, #1 << SECTION_SHIFT
 	strne	r6, [r3]
 
-#if defined(CONFIG_LPAE) && defined(CONFIG_CPU_ENDIAN_BE8)
+#if defined(CONFIG_ARM_LPAE) && defined(CONFIG_CPU_ENDIAN_BE8)
 	sub	r4, r4, #4			@ Fixup page table pointer
 						@ for 64-bit descriptors
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 3f6cbb2..62ead98 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -524,7 +524,7 @@ int __init arm_add_memory(phys_addr_t start, phys_addr_t size)
 	size -= start & ~PAGE_MASK;
 	bank->start = PAGE_ALIGN(start);
 
-#ifndef CONFIG_LPAE
+#ifndef CONFIG_ARM_LPAE
 	if (bank->start + size < bank->start) {
 		printk(KERN_CRIT "Truncating memory at 0x%08llx to fit in "
 			"32-bit physical address space\n", (long long)start);
-- 
1.7.11.7
