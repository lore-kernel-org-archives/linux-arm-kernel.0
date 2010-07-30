From: ccross@google.com (Colin Cross)
Date: Thu, 29 Jul 2010 17:29:22 -0700
Subject: [PATCH 1/9] [ARM] tegra: update iomap
In-Reply-To: <1280449771-24043-1-git-send-email-ccross@google.com>
References: <1280449771-24043-1-git-send-email-ccross@google.com>
Message-ID: <1280449771-24043-2-git-send-email-ccross@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

Add missing io address map entries from datasheet.
Add the IRAM area to the statically mapped io regions.
Correct the onewire, USB, and statmon addresses

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/include/mach/io.h    |    6 +++++
 arch/arm/mach-tegra/include/mach/iomap.h |   33 ++++++++++++++++++++++++-----
 arch/arm/mach-tegra/io.c                 |    6 +++++
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/io.h b/arch/arm/mach-tegra/include/mach/io.h
index 35edfc3..16f1618 100644
--- a/arch/arm/mach-tegra/include/mach/io.h
+++ b/arch/arm/mach-tegra/include/mach/io.h
@@ -33,6 +33,10 @@
  *
  */
 
+#define IO_IRAM_PHYS	0x40000000
+#define IO_IRAM_VIRT	0xFE400000
+#define IO_IRAM_SIZE	SZ_256K
+
 #define IO_CPU_PHYS     0x50040000
 #define IO_CPU_VIRT     0xFE000000
 #define IO_CPU_SIZE	SZ_16K
@@ -55,6 +59,8 @@
 		IO_TO_VIRT_XLATE((n), IO_APB_PHYS, IO_APB_VIRT) :	\
 	IO_TO_VIRT_BETWEEN((n), IO_CPU_PHYS, IO_CPU_SIZE) ?		\
 		IO_TO_VIRT_XLATE((n), IO_CPU_PHYS, IO_CPU_VIRT) :	\
+	IO_TO_VIRT_BETWEEN((n), IO_IRAM_PHYS, IO_IRAM_SIZE) ?		\
+		IO_TO_VIRT_XLATE((n), IO_IRAM_PHYS, IO_IRAM_VIRT) :	\
 	0)
 
 #ifndef __ASSEMBLER__
diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h
index 1741f7d..44a4f4b 100644
--- a/arch/arm/mach-tegra/include/mach/iomap.h
+++ b/arch/arm/mach-tegra/include/mach/iomap.h
@@ -23,9 +23,15 @@
 
 #include <asm/sizes.h>
 
+#define TEGRA_IRAM_BASE			0x40000000
+#define TEGRA_IRAM_SIZE			SZ_256K
+
 #define TEGRA_ARM_PERIF_BASE		0x50040000
 #define TEGRA_ARM_PERIF_SIZE		SZ_8K
 
+#define TEGRA_ARM_PL310_BASE		0x50043000
+#define TEGRA_ARM_PL310_SIZE		SZ_4K
+
 #define TEGRA_ARM_INT_DIST_BASE		0x50041000
 #define TEGRA_ARM_INT_DIST_SIZE		SZ_4K
 
@@ -68,7 +74,22 @@
 #define TEGRA_FLOW_CTRL_BASE		0x60007000
 #define TEGRA_FLOW_CTRL_SIZE		20
 
-#define TEGRA_STATMON_BASE		0x6000C4000
+#define TEGRA_AHB_DMA_BASE		0x60008000
+#define TEGRA_AHB_DMA_SIZE		SZ_4K
+
+#define TEGRA_AHB_DMA_CH0_BASE		0x60009000
+#define TEGRA_AHB_DMA_CH0_SIZE		32
+
+#define TEGRA_APB_DMA_BASE		0x6000A000
+#define TEGRA_APB_DMA_SIZE		SZ_4K
+
+#define TEGRA_APB_DMA_CH0_BASE		0x6000B000
+#define TEGRA_APB_DMA_CH0_SIZE		32
+
+#define TEGRA_AHB_GIZMO_BASE		0x6000C004
+#define TEGRA_AHB_GIZMO_SIZE		0x10C
+
+#define TEGRA_STATMON_BASE		0x6000C400
 #define TEGRA_STATMON_SIZE		SZ_1K
 
 #define TEGRA_GPIO_BASE			0x6000D000
@@ -137,7 +158,7 @@
 #define TEGRA_I2C3_BASE			0x7000C500
 #define TEGRA_I2C3_SIZE			SZ_256
 
-#define TEGRA_OWR_BASE			0x7000D000
+#define TEGRA_OWR_BASE			0x7000C600
 #define TEGRA_OWR_SIZE			80
 
 #define TEGRA_DVC_BASE			0x7000D000
@@ -182,12 +203,12 @@
 #define TEGRA_USB_BASE			0xC5000000
 #define TEGRA_USB_SIZE			SZ_16K
 
-#define TEGRA_USB1_BASE			0xC5004000
-#define TEGRA_USB1_SIZE			SZ_16K
-
-#define TEGRA_USB2_BASE			0xC5008000
+#define TEGRA_USB2_BASE			0xC5004000
 #define TEGRA_USB2_SIZE			SZ_16K
 
+#define TEGRA_USB3_BASE			0xC5008000
+#define TEGRA_USB3_SIZE			SZ_16K
+
 #define TEGRA_SDMMC1_BASE		0xC8000000
 #define TEGRA_SDMMC1_SIZE		SZ_512
 
diff --git a/arch/arm/mach-tegra/io.c b/arch/arm/mach-tegra/io.c
index 9fe2c5c..31848a9 100644
--- a/arch/arm/mach-tegra/io.c
+++ b/arch/arm/mach-tegra/io.c
@@ -49,6 +49,12 @@ static struct map_desc tegra_io_desc[] __initdata = {
 		.length = IO_CPU_SIZE,
 		.type = MT_DEVICE,
 	},
+	{
+		.virtual = IO_IRAM_VIRT,
+		.pfn = __phys_to_pfn(IO_IRAM_PHYS),
+		.length = IO_IRAM_SIZE,
+		.type = MT_DEVICE,
+	},
 };
 
 void __init tegra_map_common_io(void)
-- 
1.7.1
