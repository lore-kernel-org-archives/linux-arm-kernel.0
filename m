From: xieyisheng1@huawei.com (Xie Yisheng)
Date: Mon, 22 Aug 2016 21:20:03 +0800
Subject: [RFC PATCH v3 1/2] mm/hugetlb: Introduce ARCH_HAS_GIGANTIC_PAGE
In-Reply-To: <1471872004-59365-1-git-send-email-xieyisheng1@huawei.com>
References: <1471872004-59365-1-git-send-email-xieyisheng1@huawei.com>
Message-ID: <1471872004-59365-2-git-send-email-xieyisheng1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid making ifdef get pretty unwieldy if many ARCHs support gigantic page.
No functional change with this patch.

Signed-off-by: Xie Yisheng <xieyisheng1@huawei.com>
---
 arch/s390/Kconfig | 1 +
 arch/x86/Kconfig  | 1 +
 fs/Kconfig        | 3 +++
 mm/hugetlb.c      | 2 +-
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e751fe2..a8c8fa3 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -72,6 +72,7 @@ config S390
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c580d8c..2fdc300 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -29,6 +29,7 @@ config X86
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_GIGANTIC_PAGE		if X86_64
 	select ARCH_HAS_KCOV			if X86_64
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_MMIO_FLUSH
diff --git a/fs/Kconfig b/fs/Kconfig
index 2bc7ad7..b938205 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -199,6 +199,9 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config ARCH_HAS_GIGANTIC_PAGE
+	bool
+
 source "fs/configfs/Kconfig"
 source "fs/efivarfs/Kconfig"
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 87e11d8..8488dcc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1022,7 +1022,7 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
 		nr_nodes--)
 
-#if (defined(CONFIG_X86_64) || defined(CONFIG_S390)) && \
+#if defined(CONFIG_ARCH_HAS_GIGANTIC_PAGE) && \
 	((defined(CONFIG_MEMORY_ISOLATION) && defined(CONFIG_COMPACTION)) || \
 	defined(CONFIG_CMA))
 static void destroy_compound_gigantic_page(struct page *page,
-- 
1.7.12.4
