From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 22 Nov 2016 09:26:08 +0000
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected for
 NOMMU
In-Reply-To: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this patch applied potentially any platform can be built in NOMMU
configurations if CONFIG_EXPERT is selected. However, there is no
guaranty that platform can successfully run such Image. So the main
motivation behind of this patch:
- bring build coverage for NOMMU configurations
- allow known working NOMMU platforms (like R-class) to be used
- pave a way to add support for single address space (aka 1:1 mapping)
  for MMU platforms, so they can be usable in NOMMU configurations

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f9ff570..8e7496c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -327,9 +327,9 @@ choice
 
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
-	depends on MMU
+	depends on MMU || EXPERT
 	select ARM_HAS_SG_CHAIN
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if MMU
 	select AUTO_ZRELADDR
 	select CLKSRC_OF
 	select COMMON_CLK
-- 
1.7.9.5
