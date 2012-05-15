From: kassey1216@gmail.com (Kassey Lee)
Date: Tue, 15 May 2012 18:19:36 +0800
Subject: [PATCH V2] dmaengine/amba-pl08x: check slave_channels to avoid kernel
 panic
Message-ID: <CAKwPUoyYaXk3DjY8WGHZtM8j3CB2q94RQvEhD-b6FEP5W+7KFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 58baed44d52f5e0d87aca575318d71fe3937544c
Author: Kassey Lee <kassey1216@gmail.com>
Date:   Wed Apr 11 02:22:26 2012 +0800

    dmaengine/amba-pl08x: check slave_channels to avoid kernel panic

    slave_channels is platform dependent, it should
    be initialized by board.c, and here we need to check it
    to avoid a NULL panic.

    Signed-off-by: Kassey,Lee <kassey1216@gmail.com>

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 3d704ab..350e1fa 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1688,6 +1688,12 @@ static int
pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
                chan->state = PL08X_CHAN_IDLE;

                if (slave) {
+                       if (!pl08x->pd->slave_channels) {
+                               dev_err(&pl08x->adev->dev,
+                                       "%s slave_channels is not
initialized\n", __func__);
+                               kfree(chan);
+                               return -EINVAL;
+                       }
                        chan->cd = &pl08x->pd->slave_channels[i];
                        pl08x_dma_slave_init(chan);
                } else {


-- 
Best regards
Kassey
