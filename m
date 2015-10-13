From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Oct 2015 16:13:20 -0700
Subject: [PATCH] ARM: OMAP2+: Fix oops with LPAE and more than 2GB of memory
Message-ID: <1444778000-22537-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On boards with more than 2GB of RAM booting goes wrong with things not working
and we're getting lots of l3 warnings:

WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x260/0x384()
44000000.ocp:L3 Custom Error: MASTER MMC6 TARGET DMM1 (Idle): Data Access in User mode during Functional access
...
[<c044e158>] (scsi_add_host_with_dma) from [<c04705c8>] (ata_scsi_add_hosts+0x5c/0x18c)
[<c04705c8>] (ata_scsi_add_hosts) from [<c046b13c>] (ata_host_register+0x150/0x2cc)
[<c046b13c>] (ata_host_register) from [<c046b38c>] (ata_host_activate+0xd4/0x124)
[<c046b38c>] (ata_host_activate) from [<c047f42c>] (ahci_host_activate+0x5c/0x194)
[<c047f42c>] (ahci_host_activate) from [<c0480854>] (ahci_platform_init_host+0x1f0/0x3f0)
[<c0480854>] (ahci_platform_init_host) from [<c047c9dc>] (ahci_probe+0x70/0x98)
[<c047c9dc>] (ahci_probe) from [<c04220cc>] (platform_drv_probe+0x54/0xb4)

Let's fix the issue by enabling ZONE_DMA for LPAE.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b3a0dff..33d1460 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -49,6 +49,7 @@ config SOC_OMAP5
 	select OMAP_INTERCONNECT
 	select OMAP_INTERCONNECT_BARRIER
 	select PM_OPP if PM
+	select ZONE_DMA if ARM_LPAE
 
 config SOC_AM33XX
 	bool "TI AM33XX"
@@ -78,6 +79,7 @@ config SOC_DRA7XX
 	select OMAP_INTERCONNECT
 	select OMAP_INTERCONNECT_BARRIER
 	select PM_OPP if PM
+	select ZONE_DMA if ARM_LPAE
 
 config ARCH_OMAP2PLUS
 	bool
-- 
2.1.4
