From: slash.tmp@free.fr (Mason)
Date: Fri, 21 Apr 2017 10:43:20 +0200
Subject: [PATCH v2] dmaengine: sun4i: fix invalid argument
In-Reply-To: <20170421082417.7cqtevwuhjvfgjcx@lukather>
References: <20170421084033.5c987e13@canb.auug.org.au>
 <9858a4ed-bdd9-bd6c-d8a4-e9e6bd539904@free.fr>
 <584a2c53-100b-945b-d665-cef3fa856526@free.fr>
 <20170421082417.7cqtevwuhjvfgjcx@lukather>
Message-ID: <3e98596a-0322-e4f1-7cc2-9b0eaceb4465@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

The "pchans_used" field is an unsigned long array.

for_each_clear_bit_from() expects an unsigned long pointer,
not an array address.

$ make C=2 drivers/dma/sun4i-dma.o
  CHECK   drivers/dma/sun4i-dma.c
drivers/dma/sun4i-dma.c:241:9: warning: incorrect type in argument 1 (different base types)
drivers/dma/sun4i-dma.c:241:9:    expected unsigned long const *p
drivers/dma/sun4i-dma.c:241:9:    got unsigned long ( *<noident> )[1]

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/dma/sun4i-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 57aa227bfadb..f4ed3f17607c 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -238,7 +238,7 @@ static struct sun4i_dma_pchan *find_and_use_pchan(struct sun4i_dma_dev *priv,
 	}
 
 	spin_lock_irqsave(&priv->lock, flags);
-	for_each_clear_bit_from(i, &priv->pchans_used, max) {
+	for_each_clear_bit_from(i, priv->pchans_used, max) {
 		pchan = &pchans[i];
 		pchan->vchan = vchan;
 		set_bit(i, priv->pchans_used);
-- 
3.14159
