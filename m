From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Jul 2014 10:30:22 +0200
Subject: [PATCH 2/3] dmaengine: sun6i: Free the interrupt before killing the
 tasklet
In-Reply-To: <1406709023-7650-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1406709023-7650-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1406709023-7650-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's still a small window between the call to sun6i_kill_tasklet and the end
of the driver remove function where a spurious interrupt might trigger, and
start using deallocated resources.

Replace the call to synchronize_irq by a free_irq, so that we're sure that we
won't get any further interrupts when we're deallocating resources.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/sun6i-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 609c5d8cb947..63a1db38894e 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -836,8 +836,8 @@ static inline void sun6i_kill_tasklet(struct sun6i_dma_dev *sdev)
 	/* Prevent spurious interrupts from scheduling the tasklet */
 	atomic_inc(&sdev->tasklet_shutdown);
 
-	/* Make sure all interrupts are handled */
-	synchronize_irq(sdev->irq);
+	/* Make sure we won't have any further interrupts */
+	devm_free_irq(sdev->slave.dev, sdev->irq, sdev);
 
 	/* Actually prevent the tasklet from being scheduled */
 	tasklet_kill(&sdev->task);
-- 
2.0.2
