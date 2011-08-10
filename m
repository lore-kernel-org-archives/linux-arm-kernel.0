From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 10 Aug 2011 14:20:56 +0530
Subject: [PATCH V2 3/6] spi/spi-pl022: Don't allocate more sg than required.
In-Reply-To: <cover.1312965741.git.viresh.kumar@st.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
Message-ID: <94a975df64a78bb533c85774a5bbd052c73fa5ba.1312965741.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In routine configure_dma(), if transfer->len = PAGE_SIZE, then pages is one more
than required. While leads to one more sg getting allocated.

This is wrong. Correct this to allocate correct number of sg.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 80116be..1c8b9ec 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1016,7 +1016,8 @@ static int configure_dma(struct pl022 *pl022)
 	dmaengine_slave_config(txchan, &tx_conf);
 
 	/* Create sglists for the transfers */
-	pages = (pl022->cur_transfer->len >> PAGE_SHIFT) + 1;
+	pages = ((pl022->cur_transfer->len + (1 << PAGE_SHIFT) - 1)
+			>> PAGE_SHIFT);
 	dev_dbg(&pl022->adev->dev, "using %d pages for transfer\n", pages);
 
 	ret = sg_alloc_table(&pl022->sgt_rx, pages, GFP_ATOMIC);
-- 
1.7.2.2
