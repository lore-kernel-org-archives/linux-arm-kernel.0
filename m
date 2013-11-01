From: b42378@freescale.com (Nicolin Chen)
Date: Fri, 1 Nov 2013 19:48:19 +0800
Subject: [PATCH][RESEND 6/8] ALSA: memalloc: use gen_pool_dma_alloc() to
 allocate iram buffer
In-Reply-To: <cover.1383306365.git.b42378@freescale.com>
References: <cover.1383306365.git.b42378@freescale.com>
Message-ID: <db9e59951cdcf55b4903c0358ebe220e58155bc1.1383306365.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gen_pool_dma_alloc() is introduced, we implement it to simplify code.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/core/memalloc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 9d93f02..5e1c7bc 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -184,11 +184,7 @@ static void snd_malloc_dev_iram(struct snd_dma_buffer *dmab, size_t size)
 	/* Assign the pool into private_data field */
 	dmab->private_data = pool;
 
-	dmab->area = (void *)gen_pool_alloc(pool, size);
-	if (!dmab->area)
-		return;
-
-	dmab->addr = gen_pool_virt_to_phys(pool, (unsigned long)dmab->area);
+	dmab->area = gen_pool_dma_alloc(pool, size, &dmab->addr);
 }
 
 /**
-- 
1.8.4
