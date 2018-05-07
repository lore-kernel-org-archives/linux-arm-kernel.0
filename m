From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Mon,  7 May 2018 11:58:41 +0200
Subject: [PATCH] tee: shm: fix use-after-free via temporarily dropped reference
Message-ID: <20180507095841.6452-1-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jann Horn <jannh@google.com>

Bump the file's refcount before moving the reference into the fd table,
not afterwards. The old code could drop the file's refcount to zero for a
short moment before calling get_file() via get_dma_buf().

This code can only be triggered on ARM systems that use Linaro's OP-TEE.

Fixes: 967c9cca2cc5 ("tee: generic TEE subsystem")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 556960a1bab3..07d3be6f0780 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -360,9 +360,10 @@ int tee_shm_get_fd(struct tee_shm *shm)
 	if (!(shm->flags & TEE_SHM_DMA_BUF))
 		return -EINVAL;
 
+	get_dma_buf(shm->dmabuf);
 	fd = dma_buf_fd(shm->dmabuf, O_CLOEXEC);
-	if (fd >= 0)
-		get_dma_buf(shm->dmabuf);
+	if (fd < 0)
+		dma_buf_put(shm->dmabuf);
 	return fd;
 }
 
-- 
2.17.0
