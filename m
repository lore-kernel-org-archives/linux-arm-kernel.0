From: swarren@nvidia.com (Stephen Warren)
Date: Fri,  4 Mar 2011 22:44:27 -0700
Subject: [PATCH 1/3] ARM: Tegra: Add devices.c entries for audio
In-Reply-To: <1299303869-7827-1-git-send-email-swarren@nvidia.com>
References: <1299303869-7827-1-git-send-email-swarren@nvidia.com>
Message-ID: <1299303869-7827-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For I2S, DAS, PCM devices

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/devices.c            |   70 ++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/devices.h            |    4 ++
 arch/arm/mach-tegra/include/mach/iomap.h |    3 +
 3 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/devices.c
index 682e6d3..1528f9d 100644
--- a/arch/arm/mach-tegra/devices.c
+++ b/arch/arm/mach-tegra/devices.c
@@ -503,3 +503,73 @@ struct platform_device tegra_uarte_device = {
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
+
+static struct resource i2s_resource1[] = {
+	[0] = {
+		.start	= INT_I2S1,
+		.end	= INT_I2S1,
+		.flags	= IORESOURCE_IRQ
+	},
+	[1] = {
+		.start	= TEGRA_DMA_REQ_SEL_I2S_1,
+		.end	= TEGRA_DMA_REQ_SEL_I2S_1,
+		.flags	= IORESOURCE_DMA
+	},
+	[2] = {
+		.start	= TEGRA_I2S1_BASE,
+		.end	= TEGRA_I2S1_BASE + TEGRA_I2S1_SIZE - 1,
+		.flags	= IORESOURCE_MEM
+	}
+};
+
+static struct resource i2s_resource2[] = {
+	[0] = {
+		.start	= INT_I2S2,
+		.end	= INT_I2S2,
+		.flags	= IORESOURCE_IRQ
+	},
+	[1] = {
+		.start	= TEGRA_DMA_REQ_SEL_I2S2_1,
+		.end	= TEGRA_DMA_REQ_SEL_I2S2_1,
+		.flags	= IORESOURCE_DMA
+	},
+	[2] = {
+		.start	= TEGRA_I2S2_BASE,
+		.end	= TEGRA_I2S2_BASE + TEGRA_I2S2_SIZE - 1,
+		.flags	= IORESOURCE_MEM
+	}
+};
+
+struct platform_device tegra_i2s_device1 = {
+	.name		= "tegra-i2s",
+	.id		= 0,
+	.resource	= i2s_resource1,
+	.num_resources	= ARRAY_SIZE(i2s_resource1),
+};
+
+struct platform_device tegra_i2s_device2 = {
+	.name		= "tegra-i2s",
+	.id		= 1,
+	.resource	= i2s_resource2,
+	.num_resources	= ARRAY_SIZE(i2s_resource2),
+};
+
+static struct resource tegra_das_resources[] = {
+	[0] = {
+		.start = TEGRA_APB_MISC_DAS_BASE,
+		.end = TEGRA_APB_MISC_DAS_BASE + TEGRA_APB_MISC_DAS_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device tegra_das_device = {
+	.name		= "tegra-das",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(tegra_das_resources),
+	.resource	= tegra_das_resources,
+};
+
+struct platform_device tegra_pcm_device = {
+	.name = "tegra-pcm-audio",
+	.id = -1,
+};
diff --git a/arch/arm/mach-tegra/devices.h b/arch/arm/mach-tegra/devices.h
index 888810c..4a7dc0a 100644
--- a/arch/arm/mach-tegra/devices.h
+++ b/arch/arm/mach-tegra/devices.h
@@ -42,5 +42,9 @@ extern struct platform_device tegra_uartc_device;
 extern struct platform_device tegra_uartd_device;
 extern struct platform_device tegra_uarte_device;
 extern struct platform_device tegra_pmu_device;
+extern struct platform_device tegra_i2s_device1;
+extern struct platform_device tegra_i2s_device2;
+extern struct platform_device tegra_das_device;
+extern struct platform_device tegra_pcm_device;
 
 #endif
diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h
index 691cdab..19dec3a 100644
--- a/arch/arm/mach-tegra/include/mach/iomap.h
+++ b/arch/arm/mach-tegra/include/mach/iomap.h
@@ -122,6 +122,9 @@
 #define TEGRA_APB_MISC_BASE		0x70000000
 #define TEGRA_APB_MISC_SIZE		SZ_4K
 
+#define TEGRA_APB_MISC_DAS_BASE		0x70000c00
+#define TEGRA_APB_MISC_DAS_SIZE		SZ_128
+
 #define TEGRA_AC97_BASE			0x70002000
 #define TEGRA_AC97_SIZE			SZ_512
 
-- 
1.7.1
