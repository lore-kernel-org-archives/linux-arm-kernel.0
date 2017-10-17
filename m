From: rfranz@cavium.com (Roy Franz)
Date: Tue, 17 Oct 2017 13:56:42 -0700
Subject: [PATCH] mdt: slram: use memremap() instead of ioremap()
Message-ID: <20171017205642.1791-1-roy.franz@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert slram to use memremap() to map the memory it uses to back an MTD
device, as this is the proper interface for mapping memory. This change
enables normal memory to be used to back an MTD device on arm64, as arm64
prevents ioremap() being used on normal memory.

Signed-off-by: Roy Franz <roy.franz@cavium.com>
---
Tested on arm64 simulation, using simulator to preload filesystem image into RAM,
and also tested on x86_64 using video card memory.  This is useful for speeding
up booting on (very slow) emulation environments by avoiding any processing of
an initramfs.

 drivers/mtd/devices/slram.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/slram.c b/drivers/mtd/devices/slram.c
index 8087c36dc693..0ec85f316d24 100644
--- a/drivers/mtd/devices/slram.c
+++ b/drivers/mtd/devices/slram.c
@@ -163,8 +163,9 @@ static int register_device(char *name, unsigned long start, unsigned long length
 	}
 
 	if (!(((slram_priv_t *)(*curmtd)->mtdinfo->priv)->start =
-				ioremap(start, length))) {
-		E("slram: ioremap failed\n");
+		memremap(start, length,
+			 MEMREMAP_WB | MEMREMAP_WT | MEMREMAP_WC))) {
+		E("slram: memremap failed\n");
 		return -EIO;
 	}
 	((slram_priv_t *)(*curmtd)->mtdinfo->priv)->end =
@@ -186,7 +187,7 @@ static int register_device(char *name, unsigned long start, unsigned long length
 
 	if (mtd_device_register((*curmtd)->mtdinfo, NULL, 0))	{
 		E("slram: Failed to register new device\n");
-		iounmap(((slram_priv_t *)(*curmtd)->mtdinfo->priv)->start);
+		memunmap(((slram_priv_t *)(*curmtd)->mtdinfo->priv)->start);
 		kfree((*curmtd)->mtdinfo->priv);
 		kfree((*curmtd)->mtdinfo);
 		return(-EAGAIN);
@@ -206,7 +207,7 @@ static void unregister_devices(void)
 	while (slram_mtdlist) {
 		nextitem = slram_mtdlist->next;
 		mtd_device_unregister(slram_mtdlist->mtdinfo);
-		iounmap(((slram_priv_t *)slram_mtdlist->mtdinfo->priv)->start);
+		memunmap(((slram_priv_t *)slram_mtdlist->mtdinfo->priv)->start);
 		kfree(slram_mtdlist->mtdinfo->priv);
 		kfree(slram_mtdlist->mtdinfo);
 		kfree(slram_mtdlist);
-- 
2.11.0
