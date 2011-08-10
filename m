From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 10 Aug 2011 14:20:55 +0530
Subject: [PATCH V2 2/6] spi/spi-pl022: Use GFP_ATOMIC for allocation from
	tasklet
In-Reply-To: <cover.1312965741.git.viresh.kumar@st.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
Message-ID: <5157daeea68df2ba15a0b2e35e70dca53597c59a.1312965741.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tasklets don't allow invocation to sleeping routines. In configure_dma()
routine, sg_alloc_table() was called with GFP_KERNEL flag and so this causes
crash when called from tasklet.

Replace GFP_KERNEL with GFP_ATOMIC to get this fixed.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f600d00..80116be 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1019,11 +1019,11 @@ static int configure_dma(struct pl022 *pl022)
 	pages = (pl022->cur_transfer->len >> PAGE_SHIFT) + 1;
 	dev_dbg(&pl022->adev->dev, "using %d pages for transfer\n", pages);
 
-	ret = sg_alloc_table(&pl022->sgt_rx, pages, GFP_KERNEL);
+	ret = sg_alloc_table(&pl022->sgt_rx, pages, GFP_ATOMIC);
 	if (ret)
 		goto err_alloc_rx_sg;
 
-	ret = sg_alloc_table(&pl022->sgt_tx, pages, GFP_KERNEL);
+	ret = sg_alloc_table(&pl022->sgt_tx, pages, GFP_ATOMIC);
 	if (ret)
 		goto err_alloc_tx_sg;
 
-- 
1.7.2.2
