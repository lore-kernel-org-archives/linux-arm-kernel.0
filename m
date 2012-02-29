From: mark.asselstine@windriver.com (Mark Asselstine)
Date: Wed, 29 Feb 2012 09:50:04 -0500
Subject: [PATCH] rpmsg: fix build warning when compiling 64-bit
Message-ID: <1330527004-12503-1-git-send-email-mark.asselstine@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dev_dbg() in rpmsg_probe() made use of the %x formatting
which expects an 'unsigned int' which dma_addr_t is not
when compiling for 64-bit. Casting to a 'void *' and
using %p will avoid this and not force an upcast to a
64-bit value for 32-bit builds.

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
CC: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 8980ac2..28558f6 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -891,8 +891,8 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	if (!bufs_va)
 		goto vqs_del;
 
-	dev_dbg(&vdev->dev, "buffers: va %p, dma 0x%x\n", bufs_va,
-						vrp->bufs_dma);
+	dev_dbg(&vdev->dev, "buffers: va %p, dma %p\n", bufs_va,
+						(void *)vrp->bufs_dma);
 
 	/* half of the buffers is dedicated for RX */
 	vrp->rbufs = bufs_va;
-- 
1.7.5.4
