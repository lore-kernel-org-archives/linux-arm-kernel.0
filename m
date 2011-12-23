From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Dec 2011 16:03:12 -0800
Subject: [PATCH] arm/tegra: dma: fix buildbreak for !CONFIG_TEGRA_SYSTEM_DMA
Message-ID: <1324598592-9855-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to keep the DMA_REQ_SEL defines inside the ifdef.

Fixes the following build break with CONFIG_TEGRA_SYSTEM_DMA=n:

arch/arm/mach-tegra/devices.c:645: error: 'TEGRA_DMA_REQ_SEL_I2S_1' undeclared here (not in a function)
arch/arm/mach-tegra/devices.c:663: error: 'TEGRA_DMA_REQ_SEL_I2S2_1' undeclared here (not in a function)
arch/arm/mach-tegra/devices.c:663: error: initializer element is not constant
arch/arm/mach-tegra/devices.c:663: error: (near initialization for 'i2s_resource2[1].start')
arch/arm/mach-tegra/devices.c:664: error: initializer element is not constant
arch/arm/mach-tegra/devices.c:664: error: (near initialization for 'i2s_resource2[1].end')

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/include/mach/dma.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/dma.h b/arch/arm/mach-tegra/include/mach/dma.h
index d0132e8..3c9339058 100644
--- a/arch/arm/mach-tegra/include/mach/dma.h
+++ b/arch/arm/mach-tegra/include/mach/dma.h
@@ -23,11 +23,6 @@
 
 #include <linux/list.h>
 
-#if defined(CONFIG_TEGRA_SYSTEM_DMA)
-
-struct tegra_dma_req;
-struct tegra_dma_channel;
-
 #define TEGRA_DMA_REQ_SEL_CNTR			0
 #define TEGRA_DMA_REQ_SEL_I2S_2			1
 #define TEGRA_DMA_REQ_SEL_I2S_1			2
@@ -56,6 +51,11 @@ struct tegra_dma_channel;
 #define TEGRA_DMA_REQ_SEL_OWR			25
 #define TEGRA_DMA_REQ_SEL_INVALID		31
 
+#if defined(CONFIG_TEGRA_SYSTEM_DMA)
+
+struct tegra_dma_req;
+struct tegra_dma_channel;
+
 enum tegra_dma_mode {
 	TEGRA_DMA_SHARED = 1,
 	TEGRA_DMA_MODE_CONTINOUS = 2,
-- 
1.7.8.GIT
