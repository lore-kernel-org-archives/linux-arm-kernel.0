From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Dec 2012 14:20:42 +0100
Subject: [PATCH 1/2] dma: mv_xor: fix error handling of mv_xor_channel_add()
In-Reply-To: <1355404843-4587-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355404843-4587-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1355404843-4587-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When mv_xor_channel_add() fails for one XOR channel, we jump to the
err_channel_add label to clean up all previous channels that had been
initialized correctly. Unfortunately, while handling this error
condition, we were disposing the IRQ mapping before calling
mv_xor_channel_remove() (which does the free_irq()), which is
incorrect.

Instead, do things properly in the reverse order of the
initialization: first remove the XOR channel (so that free_irq() is
done), and then dispose the IRQ mapping.

This avoids ugly warnings when for some reason one of the XOR channel
fails to initialize.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
This is a bug fix for a change introduced in 3.8, so it should be
applied to 3.8.
---
 drivers/dma/mv_xor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 9659e58..79fde35 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1361,9 +1361,9 @@ static int __devinit mv_xor_probe(struct platform_device *pdev)
 err_channel_add:
 	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++)
 		if (xordev->channels[i]) {
+			mv_xor_channel_remove(xordev->channels[i]);
 			if (pdev->dev.of_node)
 				irq_dispose_mapping(xordev->channels[i]->irq);
-			mv_xor_channel_remove(xordev->channels[i]);
 		}
 
 	clk_disable_unprepare(xordev->clk);
-- 
1.7.9.5
