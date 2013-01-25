From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 22:44:03 +0000
Subject: [PATCH 04/19] oss/dmabuf: use dma_map_single
In-Reply-To: <1359153858-31992-1-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
Message-ID: <1359153858-31992-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The virt_to_bus/bus_to_virt functions have been deprecated
for as long as I can remember, and they are used in very
few remaining instances, usually in obscure ISA device
drivers. The OSS sound drivers are the only ones that are
still used on the ARM architecture, and only on some of
the earliest StrongARM machines.

The problem for converting the OSS subsystem to use
dma_map_single instead is that the caller of virt_to_bus
does not have a device pointer, since the subsystem has
never been ported to use the common device infrastructure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel at alsa-project.org
---
 sound/oss/dmabuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/oss/dmabuf.c b/sound/oss/dmabuf.c
index bcc3e8e..a59c888 100644
--- a/sound/oss/dmabuf.c
+++ b/sound/oss/dmabuf.c
@@ -114,7 +114,7 @@ static int sound_alloc_dmap(struct dma_buffparms *dmap)
 		}
 	}
 	dmap->raw_buf = start_addr;
-	dmap->raw_buf_phys = virt_to_bus(start_addr);
+	dmap->raw_buf_phys = dma_map_single(NULL, start_addr, dmap->buffsize, DMA_BIDIRECTIONAL);
 
 	for (page = virt_to_page(start_addr); page <= virt_to_page(end_addr); page++)
 		SetPageReserved(page);
@@ -139,6 +139,7 @@ static void sound_free_dmap(struct dma_buffparms *dmap)
 	for (page = virt_to_page(start_addr); page <= virt_to_page(end_addr); page++)
 		ClearPageReserved(page);
 
+	dma_unmap_single(NULL, dmap->raw_buf_phys, dmap->buffsize, DMA_BIDIRECTIONAL);
 	free_pages((unsigned long) dmap->raw_buf, sz);
 	dmap->raw_buf = NULL;
 }
-- 
1.8.0
