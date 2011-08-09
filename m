From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 9 Aug 2011 16:35:20 +0530
Subject: [PATCH 3/6] spi/spi-pl022: Don't allocate more sg than required.
In-Reply-To: <cover.1312887860.git.viresh.kumar@st.com>
References: <cover.1312887860.git.viresh.kumar@st.com>
Message-ID: <5796146a77035a0dadefd2fb430e87156c6c2114.1312887860.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In routine configure_dma(), if transfer->len = PAGE_SIZE, then pages is one more
than required. While leads to one more sg getting allocated.

This is wrong. Correct this to allocate correct number of sg.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/spi/spi-pl022.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index cbd9afe..452952b 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1016,7 +1016,8 @@ static int configure_dma(struct pl022 *pl022)
 	dmaengine_slave_config(txchan, &tx_conf);
 
 	/* Create sglists for the transfers */
-	pages = (pl022->cur_transfer->len >> PAGE_SHIFT) + 1;
+	pages = ((pl022->cur_transfer->len + (1 << PAGE_SHIFT) - 1)
+			>> PAGE_SHIFT);
 	dev_dbg(&pl022->adev->dev, "using %d pages for transfer\n", pages);
 
 	ret = sg_alloc_table(&pl022->sgt_rx, pages, GFP_NOWAIT);
-- 
1.7.2.2
