From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Nov 2013 15:36:41 -0700
Subject: [PATCH 1/3] ARM: tegra: fix DEBUG_LL combined with LPAE
Message-ID: <1385419003-11348-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The DEBUG_LL UART address is mapped as an MMU section, hence, the
virtual address must be section-aligned. Sections are 1MB without LPAE
and 2MB with LPAE. Tegra's virtual address was only aligned to 1MB, and
hence the mapping was set up incorrectly with LPAE enabled, thus causing
a hang early during boot. Fix this by picking a different virtual address
that is aligned to 2MB.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/include/debug/tegra.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/debug/tegra.S b/arch/arm/include/debug/tegra.S
index be6a720dd183..a7b7cedef1a6 100644
--- a/arch/arm/include/debug/tegra.S
+++ b/arch/arm/include/debug/tegra.S
@@ -46,10 +46,10 @@
 #define TEGRA_APB_MISC_GP_HIDREV	(TEGRA_APB_MISC_BASE + 0x804)
 
 /*
- * Must be 1MB-aligned since a 1MB mapping is used early on.
+ * Must be section-aligned since a section mapping is used early on.
  * Must not overlap with regions in mach-tegra/io.c:tegra_io_desc[].
  */
-#define UART_VIRTUAL_BASE		0xfe100000
+#define UART_VIRTUAL_BASE		0xfe800000
 
 #define checkuart(rp, rv, lhu, bit, uart) \
 		/* Load address of CLK_RST register */ \
-- 
1.8.1.5
