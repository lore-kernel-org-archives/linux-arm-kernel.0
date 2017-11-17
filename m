From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Nov 2017 18:22:01 +0000
Subject: [PATCH 18/18] arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
In-Reply-To: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
Message-ID: <1510942921-12564-19-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Kconfig entry to control use of the entry trampoline, which allows
us to unmap the kernel whilst running in userspace and improve the
robustness of KASLR.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f0fcbfc2262e..f99ffb88843a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -796,6 +796,19 @@ config FORCE_MAX_ZONEORDER
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
2.1.4
