From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 25 Jan 2012 16:49:38 +0530
Subject: [PATCH V1] ARM: tegra: dma: Support variable transfer sizes
Message-ID: <1327490378-10904-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the transfer size to vary in each DMA request,
rather than assuming all requests to be the same size
as the first request made.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/mach-tegra/dma.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/dma.c b/arch/arm/mach-tegra/dma.c
index abea4f6..81a7459 100644
--- a/arch/arm/mach-tegra/dma.c
+++ b/arch/arm/mach-tegra/dma.c
@@ -423,6 +423,7 @@ static void tegra_dma_update_hw_partial(struct tegra_dma_channel *ch,
 {
 	u32 apb_ptr;
 	u32 ahb_ptr;
+	u32 csr;
 
 	if (req->to_memory) {
 		apb_ptr = req->source_addr;
@@ -434,6 +435,15 @@ static void tegra_dma_update_hw_partial(struct tegra_dma_channel *ch,
 	writel(apb_ptr, ch->addr + APB_DMA_CHAN_APB_PTR);
 	writel(ahb_ptr, ch->addr + APB_DMA_CHAN_AHB_PTR);
 
+	if (ch->mode & TEGRA_DMA_MODE_CONTINOUS)
+		ch->req_transfer_count = (req->size >> 3) - 1;
+	else
+		ch->req_transfer_count = (req->size >> 2) - 1;
+	csr = readl(ch->addr + APB_DMA_CHAN_CSR);
+	csr &= ~CSR_WCOUNT_MASK;
+	csr |= ch->req_transfer_count << CSR_WCOUNT_SHIFT;
+	writel(csr, ch->addr + APB_DMA_CHAN_CSR);
+
 	req->status = TEGRA_DMA_REQ_INFLIGHT;
 	return;
 }
-- 
1.7.1.1
