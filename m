From: anup.patel@linaro.org (Anup Patel)
Date: Sat, 14 Sep 2013 16:24:41 +0530
Subject: [PATCH] arm64: KVM: Add Kconfig option for max VCPUs per-Guest
Message-ID: <1379156081-16508-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current max VCPUs per-Guest is set to 4 which is preventing
us from creating a Guest (or VM) with 8 VCPUs on Host (e.g.
X-Gene Storm SOC) with 8 Host CPUs.

The correct value of max VCPUs per-Guest should be same as
the max CPUs supported by GICv2 which is 8 but, increasing
value of max VCPUs per-Guest can make things slower hence
we add Kconfig option to let KVM users select appropriate
max VCPUs per-Guest.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h |    7 ++++++-
 arch/arm64/kvm/Kconfig            |   11 +++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 0859a4d..f318c43 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -26,7 +26,12 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmio.h>
 
-#define KVM_MAX_VCPUS 4
+#if defined(CONFIG_KVM_ARM_MAX_VCPUS)
+#define KVM_MAX_VCPUS CONFIG_KVM_ARM_MAX_VCPUS
+#else
+#define KVM_MAX_VCPUS 0
+#endif
+
 #define KVM_USER_MEM_SLOTS 32
 #define KVM_PRIVATE_MEM_SLOTS 4
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 21e9082..0c99deb 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -35,6 +35,17 @@ config KVM_ARM_HOST
 	---help---
 	  Provides host support for ARM processors.
 
+config KVM_ARM_MAX_VCPUS
+	int "Number maximum supported virtual CPUs per VM"
+	depends on KVM_ARM_HOST
+	default 4
+	help
+	  Static number of max supported virtual CPUs per VM.
+
+	  If you choose a high number, the vcpu structures will be quite
+	  large, so only choose a reasonable number that you expect to
+	  actually use.
+
 config KVM_ARM_VGIC
 	bool
 	depends on KVM_ARM_HOST && OF
-- 
1.7.9.5
