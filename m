From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 1 Sep 2016 14:54:56 +0800
Subject: [PATCH v8 05/16] arm64/numa: avoid inconsistent information to be
 printed
In-Reply-To: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472712907-12700-6-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

numa_init may return error because of numa configuration error. So "No
NUMA configuration found" is inaccurate. In fact, specific configuration
error information should be immediately printed by the testing branch.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/kernel/acpi_numa.c | 4 +++-
 arch/arm64/mm/numa.c          | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index f85149c..f01fab6 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -105,8 +105,10 @@ int __init arm64_acpi_numa_init(void)
 	int ret;

 	ret = acpi_numa_init();
-	if (ret)
+	if (ret) {
+		pr_info("Failed to initialise from firmware\n");
 		return ret;
+	}

 	return srat_disabled() ? -EINVAL : 0;
 }
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
