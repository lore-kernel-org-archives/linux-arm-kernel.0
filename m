From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Sep 2015 17:02:19 -0400
Subject: [PATCH] musb: sunxi: Make sunxi musb glue work without MUSB_PIO_ONLY
In-Reply-To: <1442782939-25455-1-git-send-email-hdegoede@redhat.com>
References: <1442782939-25455-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1442782939-25455-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that it is possible to build in multiple dma engines, we can no longer
require MUSB_PIO_ONLY to be set when using the sunxi musb glue.

This patch adds dummy dma hooks to make the musb glue work without
MUSB_PIO_ONLY. This hooks are fake because we do not support dma with
musb on sunxi. The Allwinnner Android kernels have some dma code, but it
is disabled as Allwinner never managed to get it to work.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/musb/sunxi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index 34ce5df..7b572f9 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -345,6 +345,16 @@ static void sunxi_musb_disable(struct musb *musb)
 	clear_bit(SUNXI_MUSB_FL_ENABLED, &glue->flags);
 }
 
+struct dma_controller *sunxi_musb_dma_controller_create(struct musb *musb,
+						    void __iomem *base)
+{
+	return NULL;
+}
+
+void sunxi_musb_dma_controller_destroy(struct dma_controller *c)
+{
+}
+
 /*
  * sunxi musb register layout
  * 0x00 - 0x17	fifo regs, 1 long per fifo
@@ -570,6 +580,8 @@ static const struct musb_platform_ops sunxi_musb_ops = {
 	.writeb		= sunxi_musb_writeb,
 	.readw		= sunxi_musb_readw,
 	.writew		= sunxi_musb_writew,
+	.dma_init	= sunxi_musb_dma_controller_create,
+	.dma_exit	= sunxi_musb_dma_controller_destroy,
 	.set_vbus	= sunxi_musb_set_vbus,
 	.pre_root_reset_end = sunxi_musb_pre_root_reset_end,
 	.post_root_reset_end = sunxi_musb_post_root_reset_end,
-- 
2.4.3
