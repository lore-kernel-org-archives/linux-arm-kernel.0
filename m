From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 20 Jun 2018 19:22:25 +0200
Subject: [PATCH v8 25/26] arm64: kernel: Respect the hierarchical CPU topology
 in DT for PSCI
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Message-ID: <20180620172226.15012-26-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To let the PSCI driver to parse the CPU topology in DT, as to create CPU PM
domains in case the hierarchical layout is used, let's call
psci_dt_topology_init() from the existing topology_init() subsys_initcall.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 30ad2f085d1f..574a5045f2f0 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -331,6 +331,9 @@ static int __init topology_init(void)
 {
 	int i;
 
+	if (acpi_disabled)
+		psci_dt_topology_init();
+
 	for_each_online_node(i)
 		register_one_node(i);
 
-- 
2.17.1
