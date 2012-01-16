From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jan 2012 18:54:56 +0000
Subject: [PATCH] ARM: cortex-a7: move proc_info out of !CONFIG_ARM_LPAE block
Message-ID: <1326740096-6409-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The merging of commits 1b6ba46b ("ARM: LPAE: MMU setup for the 3-level
page table format") and b4244738 ("ARM: 7202/1: Add Cortex-A7 proc info")
during the merge window ended up putting the Cortex-A7 proc_info into a
code block guarded by !CONFIG_ARM_LPAE. This makes Cortex-A7 platforms
unbootable when LPAE is enabled.

This patch moves the proc_info structure for Cortex-A7 outside of the
guarded block.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-v7.S |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 7e9b5bf..b155974 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -330,16 +330,6 @@ __v7_ca5mp_proc_info:
 	.size	__v7_ca5mp_proc_info, . - __v7_ca5mp_proc_info
 
 	/*
-	 * ARM Ltd. Cortex A7 processor.
-	 */
-	.type	__v7_ca7mp_proc_info, #object
-__v7_ca7mp_proc_info:
-	.long	0x410fc070
-	.long	0xff0ffff0
-	__v7_proc __v7_ca7mp_setup, hwcaps = HWCAP_IDIV
-	.size	__v7_ca7mp_proc_info, . - __v7_ca7mp_proc_info
-
-	/*
 	 * ARM Ltd. Cortex A9 processor.
 	 */
 	.type   __v7_ca9mp_proc_info, #object
@@ -351,6 +341,16 @@ __v7_ca9mp_proc_info:
 #endif	/* CONFIG_ARM_LPAE */
 
 	/*
+	 * ARM Ltd. Cortex A7 processor.
+	 */
+	.type	__v7_ca7mp_proc_info, #object
+__v7_ca7mp_proc_info:
+	.long	0x410fc070
+	.long	0xff0ffff0
+	__v7_proc __v7_ca7mp_setup, hwcaps = HWCAP_IDIV
+	.size	__v7_ca7mp_proc_info, . - __v7_ca7mp_proc_info
+
+	/*
 	 * ARM Ltd. Cortex A15 processor.
 	 */
 	.type	__v7_ca15mp_proc_info, #object
-- 
1.7.4.1
