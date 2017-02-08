From: chris.brandt@renesas.com (Chris Brandt)
Date: Wed,  8 Feb 2017 12:22:09 -0500
Subject: [PATCH] ARM: xip: disable PATCH_PHYS_VIRT for ARCH_MULTIPLATFORM when
 XIP
Message-ID: <20170208172209.31673-1-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ARCH_MULTIPLATFORM explicitly selects ARM_PATCH_PHYS_VIRT, even
though ARCH_MULTIPLATFORM has 'depends on !XIP_KERNEL', ARM_PATCH_PHYS_VIRT
is still forcibly selected. The result is that PHYS_OFFSET depends on
!ARM_PATCH_PHYS_VIRT. This means you cannot enter a physical RAM address
for an XIP kernel and you cannot build.

Given that it is already clear in the Kconfig that ARM_PATCH_PHYS_VIRT and
XIP_KERNEL do not go well together (read the help for ARM_PATCH_PHYS_VIRT),
adding this condition to ARCH_MULTIPLATFORM is logical and will fix this
build issue.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bf8d86d..c97bd2c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -330,7 +330,7 @@ config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
 	depends on MMU
 	select ARM_HAS_SG_CHAIN
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL
 	select AUTO_ZRELADDR
 	select CLKSRC_OF
 	select COMMON_CLK
-- 
2.10.1
