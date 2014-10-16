From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 11:00:53 +0200
Subject: [PATCH 01/11] dmaengine: pl08x: Remove chancnt affectations
In-Reply-To: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413450063-23829-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

chanctnt is already filled by dma_async_device_register, which uses the channel
list to know how much channels there is.

Since it's already filled, we can safely remove it from the drivers' probe
function.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/amba-pl08x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index e34024b000a4..1364d00881dd 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2164,7 +2164,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 			 __func__, ret);
 		goto out_no_memcpy;
 	}
-	pl08x->memcpy.chancnt = ret;
 
 	/* Register slave channels */
 	ret = pl08x_dma_init_virtual_channels(pl08x, &pl08x->slave,
@@ -2175,7 +2174,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 				__func__, ret);
 		goto out_no_slave;
 	}
-	pl08x->slave.chancnt = ret;
 
 	ret = dma_async_device_register(&pl08x->memcpy);
 	if (ret) {
-- 
2.1.1
