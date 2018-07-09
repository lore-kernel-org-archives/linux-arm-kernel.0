From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon,  9 Jul 2018 10:50:58 +0100
Subject: [PATCH 2/2] ARM: NOMMU: Allow enter in Hyp mode
In-Reply-To: <1531129858-8341-1-git-send-email-vladimir.murzin@arm.com>
References: <1531129858-8341-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1531129858-8341-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8R adds support for virtualisation extension (with some deviation
from v8A). With this patch hyp-unaware boot code can offload to kernel
setting up HYP stuff in a sane state.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/head-nommu.S | 12 ++++++++++--
 arch/arm/mm/Kconfig          |  1 -
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index dd546d6..7247340 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -53,7 +53,11 @@ ENTRY(stext)
  THUMB(1:			)
 #endif
 
-	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
+#ifdef CONFIG_ARM_VIRT_EXT
+	bl	__hyp_stub_install
+#endif
+	@ ensure svc mode and all interrupts masked
+	safe_svcmode_maskall r9
 						@ and irqs disabled
 #if defined(CONFIG_CPU_CP15)
 	mrc	p15, 0, r9, c0, c0		@ get processor id
@@ -89,7 +93,11 @@ ENTRY(secondary_startup)
 	 * the processor type - there is no need to check the machine type
 	 * as it has already been validated by the primary processor.
 	 */
-	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9
+#ifdef CONFIG_ARM_VIRT_EXT
+	bl	__hyp_stub_install_secondary
+#endif
+	safe_svcmode_maskall r9
+
 #ifndef CONFIG_CPU_CP15
 	ldr	r9, =CONFIG_PROCESSOR_ID
 #else
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 96a7b6c..b169e58 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -702,7 +702,6 @@ config ARM_THUMBEE
 
 config ARM_VIRT_EXT
 	bool
-	depends on MMU
 	default y if CPU_V7
 	help
 	  Enable the kernel to make use of the ARM Virtualization
-- 
2.0.0
