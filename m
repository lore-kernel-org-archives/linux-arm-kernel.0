From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 22 Nov 2012 18:32:25 +0100
Subject: [PATCH 5/5] dma: mv_xor: fix error handling path
In-Reply-To: <1353605545-7091-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353605545-7091-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353605545-7091-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ->probe() function of the mv_xor function contains in its error
handling code a loop to cleanup the XOR channels that had been
successfully initialized if some other XOR channel fails to be
initialized. It does that by traveling the list of XOR channels, and
cleanup those for which the pointer is not NULL.

However, since the mv_xor_channel_add() function return a PTR_ERR
style value, the pointer is not NULL on error. So, when handling the
error of a given channel initialization, we cleanup this channel
initialization and mark this channel entry as NULL in the array. This
allows the remaining of the cleanup (for other channels) to work
properly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index f2edd6a..9659e58 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1322,6 +1322,7 @@ static int __devinit mv_xor_probe(struct platform_device *pdev)
 						   cap_mask, irq);
 			if (IS_ERR(xordev->channels[i])) {
 				ret = PTR_ERR(xordev->channels[i]);
+				xordev->channels[i] = NULL;
 				irq_dispose_mapping(irq);
 				goto err_channel_add;
 			}
-- 
1.7.9.5
