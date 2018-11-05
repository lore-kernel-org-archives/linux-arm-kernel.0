From: ioana.ciornei@nxp.com (Ioana Ciornei)
Date: Mon, 5 Nov 2018 09:30:32 +0000
Subject: [PATCH 1/2] soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down
In-Reply-To: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com>
References: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com>
Message-ID: <1541410219-9943-2-git-send-email-ioana.ciornei@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dpio_by_cpu array should not contain a reference to a freed dpaa2_io
object. This patch adds the necessary cleanup in dpaa2_io_down.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-service.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 9b17f72..21c3e32 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -160,6 +160,11 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc)
  */
 void dpaa2_io_down(struct dpaa2_io *d)
 {
+	spin_lock(&dpio_list_lock);
+	dpio_by_cpu[d->dpio_desc.cpu] = NULL;
+	list_del(&d->node);
+	spin_unlock(&dpio_list_lock);
+
 	kfree(d);
 }
 
-- 
1.9.1
