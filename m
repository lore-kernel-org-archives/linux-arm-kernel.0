From: s-anna@ti.com (Suman Anna)
Date: Tue, 16 May 2017 17:13:47 -0500
Subject: [PATCH 3/3] ARM: davinci: da8xx: Add DSP internal RAM memories as
 IOMEM resources
In-Reply-To: <20170516221347.37990-1-s-anna@ti.com>
References: <20170516221347.37990-1-s-anna@ti.com>
Message-ID: <20170516221347.37990-4-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DSP subsystem on DA8xx has various internal RAM memories that can
accessed from the ARM side. These memories can be configured to be
used as either RAM or Cache. Add these memories as IOMEM resources
to the DSP device so that the driver can support loading of images
into internal memories.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c      | 18 ++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 74c76538cda3..22440c05d66a 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -800,6 +800,24 @@ static struct resource da8xx_rproc_resources[] = {
 		.end		= DA8XX_SYSCFG0_BASE + DA8XX_CHIPSIG_REG + 7,
 		.flags		= IORESOURCE_MEM,
 	},
+	{ /* DSP L2 RAM */
+		.name		= "l2sram",
+		.start		= DA8XX_DSP_L2_RAM_BASE,
+		.end		= DA8XX_DSP_L2_RAM_BASE + SZ_256K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	{ /* DSP L1P RAM */
+		.name		= "l1pram",
+		.start		= DA8XX_DSP_L1P_RAM_BASE,
+		.end		= DA8XX_DSP_L1P_RAM_BASE + SZ_32K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	{ /* DSP L1D RAM */
+		.name		= "l1dram",
+		.start		= DA8XX_DSP_L1D_RAM_BASE,
+		.end		= DA8XX_DSP_L1D_RAM_BASE + SZ_32K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
 	{ /* dsp irq */
 		.start		= IRQ_DA8XX_CHIPINT0,
 		.end		= IRQ_DA8XX_CHIPINT0,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 7e464228948b..93ff1569cee5 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -75,6 +75,11 @@ extern unsigned int da850_max_speed;
 #define DA8XX_VPIF_BASE		0x01e17000
 #define DA8XX_GPIO_BASE		0x01e26000
 #define DA8XX_PSC1_BASE		0x01e27000
+
+#define DA8XX_DSP_L2_RAM_BASE	0x11800000
+#define DA8XX_DSP_L1P_RAM_BASE	(DA8XX_DSP_L2_RAM_BASE + 0x600000)
+#define DA8XX_DSP_L1D_RAM_BASE	(DA8XX_DSP_L2_RAM_BASE + 0x700000)
+
 #define DA8XX_AEMIF_CS2_BASE	0x60000000
 #define DA8XX_AEMIF_CS3_BASE	0x62000000
 #define DA8XX_AEMIF_CTL_BASE	0x68000000
-- 
2.12.0
