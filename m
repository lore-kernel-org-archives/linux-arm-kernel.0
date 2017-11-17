From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Fri, 17 Nov 2017 15:38:26 +0200
Subject: [PATCH 02/10] staging: fsl-mc/dpio: remove incomplete refcount
 implementation
In-Reply-To: <20171117133834.4635-1-laurentiu.tudor@nxp.com>
References: <20171117133834.4635-1-laurentiu.tudor@nxp.com>
Message-ID: <20171117133834.4635-2-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

There's an unfinished implementation of reference counting for dpaa2_io
structure using atomics. Since it's unused lets remove it for now and,
if needed at a later time, make use of krefs instead of rolling our
own refcounting.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
index a609ec8..591d8b7 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
@@ -43,7 +43,6 @@
 #include "qbman-portal.h"
 
 struct dpaa2_io {
-	atomic_t refs;
 	struct dpaa2_io_desc dpio_desc;
 	struct qbman_swp_desc swp_desc;
 	struct qbman_swp *swp;
@@ -126,7 +125,6 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc)
 		return NULL;
 	}
 
-	atomic_set(&obj->refs, 1);
 	obj->dpio_desc = *desc;
 	obj->swp_desc.cena_bar = obj->dpio_desc.regs_cena;
 	obj->swp_desc.cinh_bar = obj->dpio_desc.regs_cinh;
@@ -171,8 +169,6 @@ EXPORT_SYMBOL(dpaa2_io_create);
  */
 void dpaa2_io_down(struct dpaa2_io *d)
 {
-	if (!atomic_dec_and_test(&d->refs))
-		return;
 	kfree(d);
 }
 EXPORT_SYMBOL(dpaa2_io_down);
-- 
2.9.4
