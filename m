From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 09 Dec 2014 12:48:36 +0100
Subject: [PATCH] arm64: psci: Fix build breakage without PM_SLEEP
Message-ID: <1418125716-18528-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix build failure of defconfig when PM_SLEEP is disabled (e.g. by
disabling SUSPEND) and CPU_IDLE enabled:

arch/arm64/kernel/psci.c:543:2: error: unknown field ?cpu_suspend? specified in initializer
  .cpu_suspend = cpu_psci_cpu_suspend,
  ^
arch/arm64/kernel/psci.c:543:2: warning: initialization from incompatible pointer type [enabled by default]
arch/arm64/kernel/psci.c:543:2: warning: (near initialization for ?cpu_psci_ops.cpu_prepare?) [enabled by default]
make[1]: *** [arch/arm64/kernel/psci.o] Error 1

The cpu_operations.cpu_suspend field exists only if ARM64_CPU_SUSPEND is
defined, not CPU_IDLE.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm64/kernel/psci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 3425f311c49e..f1dbca7d5c96 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -540,6 +540,8 @@ const struct cpu_operations cpu_psci_ops = {
 	.name		= "psci",
 #ifdef CONFIG_CPU_IDLE
 	.cpu_init_idle	= cpu_psci_cpu_init_idle,
+#endif
+#ifdef CONFIG_ARM64_CPU_SUSPEND
 	.cpu_suspend	= cpu_psci_cpu_suspend,
 #endif
 #ifdef CONFIG_SMP
-- 
1.9.1
