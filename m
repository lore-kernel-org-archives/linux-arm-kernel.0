From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:50 -0800
Subject: [PATCH 08/35] davinci: da850/omap-l138: create static map for SRAM
In-Reply-To: <1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Create static map for internal SRAM and populate SRAM base
and size in soc_info structure to allow SRAM allocation
functions from arch/arm/mach-davinci/sram.c to work.

On DA850 SRAM is used for suspend-to-RAM implementation
in places where DDR2 cannot be accessed as its clocks are
stopped.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/da850.c              |    8 ++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index fcfde2a..1ac8f63 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -771,6 +771,12 @@ static struct map_desc da850_io_desc[] = {
 		.length		= DA8XX_CP_INTC_SIZE,
 		.type		= MT_DEVICE
 	},
+	{
+		.virtual	= SRAM_VIRT,
+		.pfn		= __phys_to_pfn(DA8XX_ARM_RAM_BASE),
+		.length		= SZ_8K,
+		.type		= MT_DEVICE
+	},
 };
 
 static void __iomem *da850_psc_bases[] = {
@@ -1044,6 +1050,8 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
 	.serial_dev		= &da8xx_serial_device,
 	.emac_pdata		= &da8xx_emac_pdata,
+	.sram_dma		= DA8XX_ARM_RAM_BASE,
+	.sram_len		= SZ_8K,
 };
 
 void __init da850_init(void)
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index cab4a25..d43a4b6 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -57,6 +57,7 @@ extern void __iomem *da8xx_syscfg1_base;
 #define DA8XX_AEMIF_CS3_BASE	0x62000000
 #define DA8XX_AEMIF_CTL_BASE	0x68000000
 #define DA8XX_DDR2_CTL_BASE	0xb0000000
+#define DA8XX_ARM_RAM_BASE	0xffff0000
 
 #define PINMUX0			0x00
 #define PINMUX1			0x04
-- 
1.6.6.rc2.1.g42108
