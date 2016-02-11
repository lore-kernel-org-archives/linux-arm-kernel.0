From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Feb 2016 18:39:46 +0000
Subject: [PATCH v4 05/23] arm64: Add ARM64_HAS_VIRT_HOST_EXTN feature
In-Reply-To: <1455216004-19499-1-git-send-email-marc.zyngier@arm.com>
References: <1455216004-19499-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1455216004-19499-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new ARM64_HAS_VIRT_HOST_EXTN features to indicate that the
CPU has the ARMv8.1 VHE capability.

This will be used to trigger kernel patching in KVM.

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  3 ++-
 arch/arm64/kernel/cpufeature.c      | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8f271b8..c705d6a 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -30,8 +30,9 @@
 #define ARM64_HAS_LSE_ATOMICS			5
 #define ARM64_WORKAROUND_CAVIUM_23154		6
 #define ARM64_WORKAROUND_834220			7
+#define ARM64_HAS_VIRT_HOST_EXTN		8
 
-#define ARM64_NCAPS				8
+#define ARM64_NCAPS				9
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5c90aa4..ba74519 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -26,6 +26,7 @@
 #include <asm/cpu_ops.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
+#include <asm/virt.h>
 
 unsigned long elf_hwcap __read_mostly;
 EXPORT_SYMBOL_GPL(elf_hwcap);
@@ -621,6 +622,11 @@ static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry)
 	return has_sre;
 }
 
+static bool runs_at_el2(const struct arm64_cpu_capabilities *entry)
+{
+	return is_kernel_in_hyp_mode();
+}
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -651,6 +657,11 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_field_value = 2,
 	},
 #endif /* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
+	{
+		.desc = "Virtualization Host Extensions",
+		.capability = ARM64_HAS_VIRT_HOST_EXTN,
+		.matches = runs_at_el2,
+	},
 	{},
 };
 
-- 
2.1.4
