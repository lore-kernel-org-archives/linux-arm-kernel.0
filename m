From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  5 Sep 2013 19:39:42 +0200
Subject: [PATCH 6/6] RFC: video: drop code for ARCH_SHARK in cyber2000fb
Message-ID: <1378402782-16543-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cyber2000 frame buffer driver contains a block of code solely
for the Shark machine. As the machine is deleted, delete this
code as well.

Also remove the pointless #ifdef CONFIG_PCI as the Kconfig
clearly states PCI as a dependency anyway.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
NOTE: Do not apply this patch other than after removing the
RFC tag. I am collecting ACKs from subsystem maintainers to
take this through ARM SoC if we continue with the deletion.
---
 drivers/video/cyber2000fb.c | 70 ---------------------------------------------
 1 file changed, 70 deletions(-)

diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
index 5788678..1c446bc 100644
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -1641,67 +1641,6 @@ static void cyberpro_common_resume(struct cfb_info *cfb)
 	cyber2000fb_set_par(&cfb->fb);
 }
 
-#ifdef CONFIG_ARCH_SHARK
-
-#include <mach/framebuffer.h>
-
-static int cyberpro_vl_probe(void)
-{
-	struct cfb_info *cfb;
-	int err = -ENOMEM;
-
-	if (!request_mem_region(FB_START, FB_SIZE, "CyberPro2010"))
-		return err;
-
-	cfb = cyberpro_alloc_fb_info(ID_CYBERPRO_2010, "CyberPro2010");
-	if (!cfb)
-		goto failed_release;
-
-	cfb->irq = -1;
-	cfb->region = ioremap(FB_START, FB_SIZE);
-	if (!cfb->region)
-		goto failed_ioremap;
-
-	cfb->regs = cfb->region + MMIO_OFFSET;
-	cfb->fb.device = NULL;
-	cfb->fb.fix.mmio_start = FB_START + MMIO_OFFSET;
-	cfb->fb.fix.smem_start = FB_START;
-
-	/*
-	 * Bring up the hardware.  This is expected to enable access
-	 * to the linear memory region, and allow access to the memory
-	 * mapped registers.  Also, mem_ctl1 and mem_ctl2 must be
-	 * initialised.
-	 */
-	cyber2000fb_writeb(0x18, 0x46e8, cfb);
-	cyber2000fb_writeb(0x01, 0x102, cfb);
-	cyber2000fb_writeb(0x08, 0x46e8, cfb);
-	cyber2000fb_writeb(EXT_BIU_MISC, 0x3ce, cfb);
-	cyber2000fb_writeb(EXT_BIU_MISC_LIN_ENABLE, 0x3cf, cfb);
-
-	cfb->mclk_mult = 0xdb;
-	cfb->mclk_div  = 0x54;
-
-	err = cyberpro_common_probe(cfb);
-	if (err)
-		goto failed;
-
-	if (int_cfb_info == NULL)
-		int_cfb_info = cfb;
-
-	return 0;
-
-failed:
-	iounmap(cfb->region);
-failed_ioremap:
-	cyberpro_free_fb_info(cfb);
-failed_release:
-	release_mem_region(FB_START, FB_SIZE);
-
-	return err;
-}
-#endif /* CONFIG_ARCH_SHARK */
-
 /*
  * PCI specific support.
  */
@@ -1948,28 +1887,19 @@ static int __init cyber2000fb_init(void)
 	cyber2000fb_setup(option);
 #endif
 
-#ifdef CONFIG_ARCH_SHARK
-	err = cyberpro_vl_probe();
-	if (!err)
-		ret = 0;
-#endif
-#ifdef CONFIG_PCI
 	err = pci_register_driver(&cyberpro_driver);
 	if (!err)
 		ret = 0;
-#endif
 
 	return ret ? err : 0;
 }
 module_init(cyber2000fb_init);
 
-#ifndef CONFIG_ARCH_SHARK
 static void __exit cyberpro_exit(void)
 {
 	pci_unregister_driver(&cyberpro_driver);
 }
 module_exit(cyberpro_exit);
-#endif
 
 MODULE_AUTHOR("Russell King");
 MODULE_DESCRIPTION("CyberPro 2000, 2010 and 5000 framebuffer driver");
-- 
1.8.3.1
