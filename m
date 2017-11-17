From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Fri, 17 Nov 2017 15:38:28 +0200
Subject: [PATCH 04/10] staging: fsl-mc/dpio: remove couple of unused functions
In-Reply-To: <20171117133834.4635-1-laurentiu.tudor@nxp.com>
References: <20171117133834.4635-1-laurentiu.tudor@nxp.com>
Message-ID: <20171117133834.4635-4-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

These couple of functions are not yet used so lets remove them
for now and add them back when/if needed.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c | 58 --------------------------
 drivers/staging/fsl-mc/include/dpaa2-io.h      |  4 --
 2 files changed, 62 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
index fca8c90dc..871078d 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
@@ -318,37 +318,6 @@ int dpaa2_io_service_rearm(struct dpaa2_io *d,
 EXPORT_SYMBOL(dpaa2_io_service_rearm);
 
 /**
- * dpaa2_io_service_pull_fq() - pull dequeue functions from a fq.
- * @d: the given DPIO service.
- * @fqid: the given frame queue id.
- * @s: the dpaa2_io_store object for the result.
- *
- * Return 0 for success, or error code for failure.
- */
-int dpaa2_io_service_pull_fq(struct dpaa2_io *d, u32 fqid,
-			     struct dpaa2_io_store *s)
-{
-	struct qbman_pull_desc pd;
-	int err;
-
-	qbman_pull_desc_clear(&pd);
-	qbman_pull_desc_set_storage(&pd, s->vaddr, s->paddr, 1);
-	qbman_pull_desc_set_numframes(&pd, (u8)s->max);
-	qbman_pull_desc_set_fq(&pd, fqid);
-
-	d = service_select(d);
-	if (!d)
-		return -ENODEV;
-	s->swp = d->swp;
-	err = qbman_swp_pull(d->swp, &pd);
-	if (err)
-		s->swp = NULL;
-
-	return err;
-}
-EXPORT_SYMBOL(dpaa2_io_service_pull_fq);
-
-/**
  * dpaa2_io_service_pull_channel() - pull dequeue functions from a channel.
  * @d: the given DPIO service.
  * @channelid: the given channel id.
@@ -381,33 +350,6 @@ int dpaa2_io_service_pull_channel(struct dpaa2_io *d, u32 channelid,
 EXPORT_SYMBOL(dpaa2_io_service_pull_channel);
 
 /**
- * dpaa2_io_service_enqueue_fq() - Enqueue a frame to a frame queue.
- * @d: the given DPIO service.
- * @fqid: the given frame queue id.
- * @fd: the frame descriptor which is enqueued.
- *
- * Return 0 for successful enqueue, -EBUSY if the enqueue ring is not ready,
- * or -ENODEV if there is no dpio service.
- */
-int dpaa2_io_service_enqueue_fq(struct dpaa2_io *d,
-				u32 fqid,
-				const struct dpaa2_fd *fd)
-{
-	struct qbman_eq_desc ed;
-
-	d = service_select(d);
-	if (!d)
-		return -ENODEV;
-
-	qbman_eq_desc_clear(&ed);
-	qbman_eq_desc_set_no_orp(&ed, 0);
-	qbman_eq_desc_set_fq(&ed, fqid);
-
-	return qbman_swp_enqueue(d->swp, &ed, fd);
-}
-EXPORT_SYMBOL(dpaa2_io_service_enqueue_fq);
-
-/**
  * dpaa2_io_service_enqueue_qd() - Enqueue a frame to a QD.
  * @d: the given DPIO service.
  * @qdid: the given queuing destination id.
diff --git a/drivers/staging/fsl-mc/include/dpaa2-io.h b/drivers/staging/fsl-mc/include/dpaa2-io.h
index afc2d06..07ad15a 100644
--- a/drivers/staging/fsl-mc/include/dpaa2-io.h
+++ b/drivers/staging/fsl-mc/include/dpaa2-io.h
@@ -120,13 +120,9 @@ void dpaa2_io_service_deregister(struct dpaa2_io *service,
 int dpaa2_io_service_rearm(struct dpaa2_io *service,
 			   struct dpaa2_io_notification_ctx *ctx);
 
-int dpaa2_io_service_pull_fq(struct dpaa2_io *d, u32 fqid,
-			     struct dpaa2_io_store *s);
 int dpaa2_io_service_pull_channel(struct dpaa2_io *d, u32 channelid,
 				  struct dpaa2_io_store *s);
 
-int dpaa2_io_service_enqueue_fq(struct dpaa2_io *d, u32 fqid,
-				const struct dpaa2_fd *fd);
 int dpaa2_io_service_enqueue_qd(struct dpaa2_io *d, u32 qdid, u8 prio,
 				u16 qdbin, const struct dpaa2_fd *fd);
 int dpaa2_io_service_release(struct dpaa2_io *d, u32 bpid,
-- 
2.9.4
