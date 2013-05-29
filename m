From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 29 May 2013 12:38:12 -0400
Subject: [PATCH 12/14] ARM: OMAP5: Enable build and frameowrk initialisations
In-Reply-To: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1369845494-30231-13-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include the OMAP5 data files in build. Initialise the voltage, power,
clock domains.

Cc: Paul Walmsley <paul@pwsan.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Makefile |    4 ++++
 arch/arm/mach-omap2/io.c     |    7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 55a9d67..27448ab 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -127,6 +127,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= voltagedomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(voltagedomain-common)
 obj-$(CONFIG_SOC_AM33XX)                += voltagedomains33xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(voltagedomain-common)
+obj-$(CONFIG_SOC_OMAP5)                += voltagedomains54xx_data.o
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
@@ -141,6 +142,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(powerdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= powerdomains33xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(powerdomain-common)
+obj-$(CONFIG_SOC_OMAP5)			+= powerdomains54xx_data.o
 
 # PRCM clockdomain control
 clockdomain-common			+= clockdomain.o
@@ -156,6 +158,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= clockdomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clockdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= clockdomains33xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(clockdomain-common)
+obj-$(CONFIG_SOC_OMAP5)			+= clockdomains54xx_data.o
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o
@@ -198,6 +201,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_interconnect_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= omap_hwmod_33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
+obj-$(CONFIG_SOC_OMAP5)			+= omap_hwmod_54xx_data.o
 
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)			+= emu.o
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 09abf99..a0cc2bb 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -631,7 +631,14 @@ void __init omap5_init_early(void)
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap_prm_base_init();
 	omap_cm_base_init();
+	omap44xx_prm_init();
 	omap5xxx_check_revision();
+	omap54xx_voltagedomains_init();
+	omap54xx_powerdomains_init();
+	omap54xx_clockdomains_init();
+	omap54xx_hwmod_init();
+	omap_hwmod_init_postsetup();
+
 }
 #endif
 
-- 
1.7.9.5
