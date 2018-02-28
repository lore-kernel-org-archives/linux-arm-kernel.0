From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:39 +0800
Subject: [PATCH 17/29] arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-18-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit 084eb77cd3a8 upstream.

Add a Kconfig entry to control use of the entry trampoline, which allows
us to unmap the kernel whilst running in userspace and improve the
robustness of KASLR.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7769c2e..6b6e9f8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -733,6 +733,19 @@ config FORCE_MAX_ZONEORDER
 	  However for 4K, we choose a higher default value, 11 as opposed to 10, giving us
 	  4M allocations matching the default size used by generic code.
 
+config UNMAP_KERNEL_AT_EL0
+	bool "Unmap kernel when running in userspace (aka \"KAISER\")"
+	default y
+	help
+	  Some attacks against KASLR make use of the timing difference between
+	  a permission fault which could arise from a page table entry that is
+	  present in the TLB, and a translation fault which always requires a
+	  page table walk. This option defends against these attacks by unmapping
+	  the kernel whilst running in userspace, therefore forcing translation
+	  faults for all of kernel space.
+
+	  If unsure, say Y.
+
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on COMPAT
-- 
2.7.4
