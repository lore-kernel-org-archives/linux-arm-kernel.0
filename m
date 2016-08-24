From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Wed, 24 Aug 2016 15:44:44 +0800
Subject: [PATCH v7 05/14] arm64/numa: avoid inconsistent information to be
 printed
In-Reply-To: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472024693-12912-6-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

numa_init(of_numa_init) may returned error because of numa configuration
error. So "No NUMA configuration found" is inaccurate. In fact, specific
configuration error information should be immediately printed by the
testing branch.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/numa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 5bb15ea..d97c6e2 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -335,8 +335,10 @@ static int __init numa_init(int (*init_func)(void))
 	if (ret < 0)
 		return ret;

-	if (nodes_empty(numa_nodes_parsed))
+	if (nodes_empty(numa_nodes_parsed)) {
+		pr_info("No NUMA configuration found\n");
 		return -EINVAL;
+	}

 	ret = numa_register_nodes();
 	if (ret < 0)
@@ -367,8 +369,6 @@ static int __init dummy_numa_init(void)

 	if (numa_off)
 		pr_info("NUMA disabled\n"); /* Forced off on command line. */
-	else
-		pr_info("No NUMA configuration found\n");
 	pr_info("NUMA: Faking a node@[mem %#018Lx-%#018Lx]\n",
 	       0LLU, PFN_PHYS(max_pfn) - 1);

--
2.5.0
