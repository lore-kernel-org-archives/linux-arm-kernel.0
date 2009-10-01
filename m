From: andreas.fenkart@streamunlimited.com (Andreas Fenkart)
Date: Thu,  1 Oct 2009 12:49:00 +0200
Subject: [PATCH 5/6] Add checks to detect overlap of memory regions.
In-Reply-To: <1254394141-26673-5-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
	<1254394141-26673-1-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-2-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-3-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-4-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-5-git-send-email-andreas.fenkart@streamunlimited.com>
Message-ID: <1254394141-26673-6-git-send-email-andreas.fenkart@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 arch/arm/mm/init.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 4685611..5c1a69c 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -666,6 +666,26 @@ void __init mem_init(void)
 #undef MLM
 #undef MLK_ROUNDUP
 
+	/*
+	 * Check boundaries twice: Some fundamental inconsistencies can
+	 * be detected at build time already.
+	 */
+	BUILD_BUG_ON(VMALLOC_START			>= VMALLOC_END);
+	BUG_ON(VMALLOC_START				>= VMALLOC_END);
+
+#ifdef CONFIG_MMU
+	BUILD_BUG_ON(VMALLOC_END			> CONSISTENT_BASE);
+	BUG_ON(VMALLOC_END				> CONSISTENT_BASE);
+
+	BUILD_BUG_ON(TASK_SIZE 			> MODULES_VADDR);
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
1.6.4.3
