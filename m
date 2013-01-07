From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon,  7 Jan 2013 12:21:55 +0100
Subject: [PATCH 13/16] dmaengine: ste_dma40: minor code readability fixes
In-Reply-To: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
References: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1357557718-15676-14-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use internal variables to the cycles to improve code readability, no
functional changes.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/dma/ste_dma40.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 623779e..e317deb 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -639,19 +639,18 @@ static int d40_lcla_alloc_one(struct d40_chan *d40c,
 	unsigned long flags;
 	int i;
 	int ret = -EINVAL;
-	int p;
 
 	spin_lock_irqsave(&d40c->base->lcla_pool.lock, flags);
 
-	p = d40c->phy_chan->num * D40_LCLA_LINK_PER_EVENT_GRP;
-
 	/*
 	 * Allocate both src and dst at the same time, therefore the half
 	 * start on 1 since 0 can't be used since zero is used as end marker.
 	 */
 	for (i = 1 ; i < D40_LCLA_LINK_PER_EVENT_GRP / 2; i++) {
-		if (!d40c->base->lcla_pool.alloc_map[p + i]) {
-			d40c->base->lcla_pool.alloc_map[p + i] = d40d;
+		int idx = d40c->phy_chan->num * D40_LCLA_LINK_PER_EVENT_GRP + i;
+
+		if (!d40c->base->lcla_pool.alloc_map[idx]) {
+			d40c->base->lcla_pool.alloc_map[idx] = d40d;
 			d40d->lcla_alloc++;
 			ret = i;
 			break;
@@ -676,10 +675,10 @@ static int d40_lcla_free_all(struct d40_chan *d40c,
 	spin_lock_irqsave(&d40c->base->lcla_pool.lock, flags);
 
 	for (i = 1 ; i < D40_LCLA_LINK_PER_EVENT_GRP / 2; i++) {
-		if (d40c->base->lcla_pool.alloc_map[d40c->phy_chan->num *
-						    D40_LCLA_LINK_PER_EVENT_GRP + i] == d40d) {
-			d40c->base->lcla_pool.alloc_map[d40c->phy_chan->num *
-							D40_LCLA_LINK_PER_EVENT_GRP + i] = NULL;
+		int idx = d40c->phy_chan->num * D40_LCLA_LINK_PER_EVENT_GRP + i;
+
+		if (d40c->base->lcla_pool.alloc_map[idx] == d40d) {
+			d40c->base->lcla_pool.alloc_map[idx] = NULL;
 			d40d->lcla_alloc--;
 			if (d40d->lcla_alloc == 0) {
 				ret = 0;
-- 
1.7.12.1
