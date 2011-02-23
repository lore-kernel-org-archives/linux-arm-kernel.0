From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Feb 2011 14:49:30 -0700
Subject: [PATCH v3] ARM: Tegra: DMA: Fail safe if initialization fails
Message-ID: <1298497770-8859-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tegra_dma_init currently simply bails out early if any initialization fails.
This skips various data-structure initialization. In turn, this means that
tegra_dma_allocate_channel can still hand out channels. In this case, when
tegra_dma_free_channel is called, which calls tegra_dma_cancel, the walking
on ch->list will OOPS since the list's next/prev pointers may still be
NULL.

To solve this, add an explicit "initialized" flag, only set this once _init
has fully completed successfully, and have _allocate_channel refuse to hand
out channels if this is not set.

While at it, simplify _init:
* Remove redundant memsets
* Use bitmap_fill to mark all channels as in-use up-front, and remove
  some now-redundant bitmap initialization loops.
* Only mark a channel as free once all channel-related initialization has
  completed.

Finally, the successful exit path from _init always has ret==0, so just
hard-code that return. The error path still returns ret.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v3:
s/initialized/tegra_dma_initialized/
Change type to bool, assign true not 1
Add WARN_ON
Revert whitespace cleanup

 arch/arm/mach-tegra/dma.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-tegra/dma.c b/arch/arm/mach-tegra/dma.c
index bd4f62a..e945ae2 100644
--- a/arch/arm/mach-tegra/dma.c
+++ b/arch/arm/mach-tegra/dma.c
@@ -127,6 +127,7 @@ struct tegra_dma_channel {
 
 #define  NV_DMA_MAX_CHANNELS  32
 
+static bool tegra_dma_initialized;
 static DEFINE_MUTEX(tegra_dma_lock);
 
 static DECLARE_BITMAP(channel_usage, NV_DMA_MAX_CHANNELS);
@@ -352,6 +353,9 @@ struct tegra_dma_channel *tegra_dma_allocate_channel(int mode)
 	int channel;
 	struct tegra_dma_channel *ch = NULL;
 
+	if (WARN_ON(!tegra_dma_initialized))
+		return NULL;
+
 	mutex_lock(&tegra_dma_lock);
 
 	/* first channel is the shared channel */
@@ -678,6 +682,8 @@ int __init tegra_dma_init(void)
 	void __iomem *addr;
 	struct clk *c;
 
+	bitmap_fill(channel_usage, NV_DMA_MAX_CHANNELS);
+
 	c = clk_get_sys("tegra-dma", NULL);
 	if (IS_ERR(c)) {
 		pr_err("Unable to get clock for APB DMA\n");
@@ -696,18 +702,9 @@ int __init tegra_dma_init(void)
 	writel(0xFFFFFFFFul >> (31 - TEGRA_SYSTEM_DMA_CH_MAX),
 	       addr + APB_DMA_IRQ_MASK_SET);
 
-	memset(channel_usage, 0, sizeof(channel_usage));
-	memset(dma_channels, 0, sizeof(dma_channels));
-
-	/* Reserve all the channels we are not supposed to touch */
-	for (i = 0; i < TEGRA_SYSTEM_DMA_CH_MIN; i++)
-		__set_bit(i, channel_usage);
-
 	for (i = TEGRA_SYSTEM_DMA_CH_MIN; i <= TEGRA_SYSTEM_DMA_CH_MAX; i++) {
 		struct tegra_dma_channel *ch = &dma_channels[i];
 
-		__clear_bit(i, channel_usage);
-
 		ch->id = i;
 		snprintf(ch->name, TEGRA_DMA_NAME_SIZE, "dma_channel_%d", i);
 
@@ -726,14 +723,15 @@ int __init tegra_dma_init(void)
 			goto fail;
 		}
 		ch->irq = irq;
+
+		__clear_bit(i, channel_usage);
 	}
 	/* mark the shared channel allocated */
 	__set_bit(TEGRA_SYSTEM_DMA_CH_MIN, channel_usage);
 
-	for (i = TEGRA_SYSTEM_DMA_CH_MAX+1; i < NV_DMA_MAX_CHANNELS; i++)
-		__set_bit(i, channel_usage);
+	tegra_dma_initialized = true;
 
-	return ret;
+	return 0;
 fail:
 	writel(0, addr + APB_DMA_GEN);
 	for (i = TEGRA_SYSTEM_DMA_CH_MIN; i <= TEGRA_SYSTEM_DMA_CH_MAX; i++) {
-- 
1.7.1
