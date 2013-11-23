From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 18:41:12 -0500
Subject: [PATCH 1/5] ARM: keystone: enable DMA zone for LPAE
In-Reply-To: <1385250076-9596-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385250076-9596-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1385250076-9596-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone II peripheral devices support 32-bit DMA and hence can access only
first 2GB of the memory address space. So set the platform dma_zone_size
to handle that case.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/Kconfig    |    1 +
 arch/arm/mach-keystone/keystone.c |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 8a9e943..dabc5ee 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -12,6 +12,7 @@ config ARCH_KEYSTONE
 	select COMMON_CLK_KEYSTONE
 	select TI_EDMA
 	select ARCH_SUPPORTS_BIG_ENDIAN
+	select ZONE_DMA if ARM_LPAE
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
 	  SoCs.
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index b661c5c..2fe4dd0 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -68,6 +68,9 @@ void keystone_restart(enum reboot_mode mode, const char *cmd)
 }
 
 DT_MACHINE_START(KEYSTONE, "Keystone")
+#if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ARM_LPAE)
+	.dma_zone_size	= SZ_2G,
+#endif
 	.smp		= smp_ops(keystone_smp_ops),
 	.init_machine	= keystone_init,
 	.dt_compat	= keystone_match,
-- 
1.7.9.5
