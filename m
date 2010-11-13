From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 12 Nov 2010 19:29:55 -0800
Subject: [PATCH 09/14] msm: iommu: Kconfig option for cacheable page tables
In-Reply-To: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
References: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <1289619000-13167-10-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Kconfig option to allow the IOMMU page tables to be
coherent in the L2 cache. This generally reduces TLB miss
latencies, but may lead to cache pollution if the
multimedia core's access pattern does not benefit from fast
handling of TLB misses.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index dbbcfeb..7781920 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -122,6 +122,21 @@ config MACH_MSM8X60_FFA
 
 endmenu
 
+config IOMMU_PGTABLES_L2
+	depends on ARCH_MSM8X60
+	depends on MMU
+	depends on CPU_DCACHE_DISABLE=n
+	depends on SMP
+	bool "Cacheable IOMMU page tables"
+	default y
+	help
+	  Allows the IOMMU page tables to be brought into the L2 cache. This
+	  improves the TLB miss latency at the expense of potential pollution
+	  of the L2 cache. This option has been shown to improve multimedia
+	  performance in some cases.
+
+	  If unsure, say Y here.
+
 config MSM_DEBUG_UART
 	int
 	default 1 if MSM_DEBUG_UART1
-- 
1.7.0.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
