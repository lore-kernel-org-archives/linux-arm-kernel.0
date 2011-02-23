From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 23 Feb 2011 11:53:41 +0000
Subject: [PATCH v2] ARM: Thumb-2: Reflect ARM/Thumb-2 configuration in module
	vermagic
Message-ID: <1298462021-22177-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Loading Thumb-2 modules into an ARM kernel or vice-versa isn't
guaranteed to work safely, since the kernel is not interworking-
aware everywhere.

This patch adds "thumb2" to the module vermagic when
CONFIG_THUMB2_KERNEL is enabled, to help avoid accidental loading
of modules into the wrong kernel.

v2: modified to apply consistently on top of rmk's p2v branch.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
KernelVersion: rmk/p2v

 arch/arm/include/asm/module.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index a2b775b..543b449 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -40,8 +40,16 @@ struct mod_arch_specific {
 #define MODULE_ARCH_VERMAGIC_P2V ""
 #endif
 
+/* Add instruction set architecture tag to distinguish ARM/Thumb kernels */
+#ifdef CONFIG_THUMB2_KERNEL
+#define MODULE_ARCH_VERMAGIC_ARMTHUMB "thumb2 "
+#else
+#define MODULE_ARCH_VERMAGIC_ARMTHUMB ""
+#endif
+
 #define MODULE_ARCH_VERMAGIC \
 	MODULE_ARCH_VERMAGIC_ARMVSN \
+	MODULE_ARCH_VERMAGIC_ARMTHUMB \
 	MODULE_ARCH_VERMAGIC_P2V
 
 #endif /* _ASM_ARM_MODULE_H */
-- 
1.7.1
