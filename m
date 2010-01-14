From: andreas.fenkart@streamunlimited.com (Andreas Fenkart)
Date: Thu, 14 Jan 2010 11:36:09 +0100
Subject: [PATCH 4/5] Add checks to detect overlap of memory regions.
In-Reply-To: <1263465370-4192-4-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
	<1263465370-4192-1-git-send-email-andreas.fenkart@streamunlimited.com>
	<1263465370-4192-2-git-send-email-andreas.fenkart@streamunlimited.com>
	<1263465370-4192-3-git-send-email-andreas.fenkart@streamunlimited.com>
	<1263465370-4192-4-git-send-email-andreas.fenkart@streamunlimited.com>
Message-ID: <1263465370-4192-5-git-send-email-andreas.fenkart@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 arch/arm/mm/init.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index f4d67bf..3e73724 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -684,6 +684,23 @@ void __init mem_init(void)
 #undef MLM
 #undef MLK_ROUNDUP
 
+	/*
+	 * Check boundaries twice: Some fundamental inconsistencies can
+	 * be detected at build time already.
+	 */
+#ifdef CONFIG_MMU
+	BUILD_BUG_ON(VMALLOC_END			> CONSISTENT_BASE);
+	BUG_ON(VMALLOC_END				> CONSISTENT_BASE);
+
+	BUILD_BUG_ON(TASK_SIZE				> MODULES_VADDR);
+	BUG_ON(TASK_SIZE 				> MODULES_VADDR);
+#endif
+
+#ifdef CONFIG_HIGHMEM
+	BUILD_BUG_ON(PKMAP_BASE + LAST_PKMAP * PAGE_SIZE > PAGE_OFFSET);
+	BUG_ON(PKMAP_BASE + LAST_PKMAP * PAGE_SIZE	> PAGE_OFFSET);
+#endif
+
 	if (PAGE_SIZE >= 16384 && num_physpages <= 128) {
 		extern int sysctl_overcommit_memory;
 		/*
-- 
1.6.6
