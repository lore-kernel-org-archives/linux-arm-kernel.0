From: mark.asselstine@windriver.com (Mark Asselstine)
Date: Wed, 29 Feb 2012 10:41:06 -0500
Subject: [PATCH V2] rpmsg: fix build warning when dma_addr_t is 64-bit
In-Reply-To: <201202291455.20688.arnd@arndb.de>
References: <201202291455.20688.arnd@arndb.de>
Message-ID: <1330530066-17461-1-git-send-email-mark.asselstine@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dev_dbg() in rpmsg_probe() made use of the %x formatting that
expects an 'unsigned int' which dma_addr_t is not in cases where
dma_addr_t is 64-bit (CONFIG_ARCH_DMA_ADDR_T_64BIT). Casting to
a 'unsigned long long' and using %llx will avoid this.

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
CC: Ohad Ben-Cohen <ohad@wizery.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rpmsg/virtio_rpmsg_bus.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 8980ac2..c142e7b 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -891,8 +891,8 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	if (!bufs_va)
 		goto vqs_del;
 
-	dev_dbg(&vdev->dev, "buffers: va %p, dma 0x%x\n", bufs_va,
-						vrp->bufs_dma);
+	dev_dbg(&vdev->dev, "buffers: va %p, dma 0x%llx\n", bufs_va,
+					(unsigned long long)vrp->bufs_dma);
 
 	/* half of the buffers is dedicated for RX */
 	vrp->rbufs = bufs_va;
-- 
1.7.5.4
