From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Dec 2012 14:20:43 +0100
Subject: [PATCH 2/2] dma: mv_xor: fix error handling for clocks
In-Reply-To: <1355404843-4587-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355404843-4587-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1355404843-4587-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a channel fails to initialize, we release all ressources,
including clocks. However, a XOR unit is not necessarily associated to
a clock (some variants of Marvell SoCs have a clock for XOR units,
some don't), so we shouldn't unconditionally be releasing the clock.

Instead, just like we do in the mv_xor_remove() function, we should
check if one clock was found before releasing it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
This is a bug fix for a change introduced in 3.8, so it should be
applied to 3.8.
---
 drivers/dma/mv_xor.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 79fde35..11f1a65 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1366,8 +1366,11 @@ err_channel_add:
 				irq_dispose_mapping(xordev->channels[i]->irq);
 		}
 
-	clk_disable_unprepare(xordev->clk);
-	clk_put(xordev->clk);
+	if (!IS_ERR(xordev->clk)) {
+		clk_disable_unprepare(xordev->clk);
+		clk_put(xordev->clk);
+	}
+
 	return ret;
 }
 
-- 
1.7.9.5
