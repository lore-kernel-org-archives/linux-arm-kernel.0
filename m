From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Thu, 15 Jun 2017 03:55:06 -0500
Subject: [PATCH] staging: fsl-mc/dpio: Propagate error code
Message-ID: <20170615085506.31784-1-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dpaa2_io_service_register() returns zero even if
qbman_swp_CDAN_set() encountered an error. Fix this
by propagating the error code so the caller is informed
data availability notifications are not properly set
for a channel.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
index e5d66749614c..762f045f53f7 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
@@ -260,9 +260,9 @@ int dpaa2_io_service_register(struct dpaa2_io *d,
 
 	/* Enable the generation of CDAN notifications */
 	if (ctx->is_cdan)
-		qbman_swp_CDAN_set_context_enable(d->swp,
-						  (u16)ctx->id,
-						  ctx->qman64);
+		return qbman_swp_CDAN_set_context_enable(d->swp,
+							 (u16)ctx->id,
+							 ctx->qman64);
 	return 0;
 }
 EXPORT_SYMBOL(dpaa2_io_service_register);
-- 
2.11.0
