From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 10 Aug 2011 17:12:11 +0530
Subject: [PATCH V3 3/6] spi/spi-pl022: Don't allocate more sg than required.
In-Reply-To: <cover.1312965741.git.viresh.kumar@st.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
Message-ID: <2c858c49e0f854dd45c4489056ba2625683686b1.1312965741.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In routine configure_dma(), if transfer->len = PAGE_SIZE, then pages is one more
than required. While leads to one more sg getting allocated.

This is wrong. Correct this to allocate correct number of sg.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 80116be..832361e3a 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1016,7 +1016,7 @@ static int configure_dma(struct pl022 *pl022)
 	dmaengine_slave_config(txchan, &tx_conf);
 
 	/* Create sglists for the transfers */
-	pages = (pl022->cur_transfer->len >> PAGE_SHIFT) + 1;
+	pages = DIV_ROUND_UP(pl022->cur_transfer->len, PAGE_SIZE);
 	dev_dbg(&pl022->adev->dev, "using %d pages for transfer\n", pages);
 
 	ret = sg_alloc_table(&pl022->sgt_rx, pages, GFP_ATOMIC);
-- 
1.7.2.2
