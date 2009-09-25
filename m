From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 25 Sep 2009 15:25:03 -0400
Subject: [PATCH] [MTD] [ONENAND] add pxa3xx onenand
Message-ID: <mailman.29.1253880112.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support Marvell PXA3xx bad block management, add pxa3xx onenand
device driver. Since there's some specific operation in it.

Either pxa3xx onenand or generic onenand device driver can be supported.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/onenand/Kconfig  |    7 +
 drivers/mtd/onenand/Makefile |    1 +
 drivers/mtd/onenand/pxa3xx.c |  248
++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/pxa3xx_bbm.c     |    4 +
 4 files changed, 260 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/onenand/pxa3xx.c

diff --git a/drivers/mtd/onenand/Kconfig b/drivers/mtd/onenand/Kconfig
index 79fa79e..d2878ac 100644
--- a/drivers/mtd/onenand/Kconfig
+++ b/drivers/mtd/onenand/Kconfig
@@ -34,6 +34,13 @@ config MTD_ONENAND_OMAP2
       Support for a OneNAND flash device connected to an OMAP2/OMAP3 CPU
       via the GPMC memory controller.

+config MTD_ONENAND_PXA3xx
+    tristate "OneNAND on PXA3xx/MMP support"
+    depends on MTD_ONENAND && (ARCH_PXA || ARCH_MMP)
+    help
+      Support for a OneNAND flash device connected to an PXA3xx CPU
+      via the static memory controller.
+
 config MTD_ONENAND_OTP
     bool "OneNAND OTP Support"
     select HAVE_MTD_OTP
diff --git a/drivers/mtd/onenand/Makefile b/drivers/mtd/onenand/Makefile
index 64b6cc6..66cc1fb 100644
--- a/drivers/mtd/onenand/Makefile
+++ b/drivers/mtd/onenand/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_MTD_ONENAND)        += onenand.o
 # Board specific.
 obj-$(CONFIG_MTD_ONENAND_GENERIC)    += generic.o
 obj-$(CONFIG_MTD_ONENAND_OMAP2)        += omap2.o
+obj-$(CONFIG_MTD_ONENAND_PXA3xx)    += pxa3xx.o

 # Simulator
 obj-$(CONFIG_MTD_ONENAND_SIM)        += onenand_sim.o
diff --git a/drivers/mtd/onenand/pxa3xx.c b/drivers/mtd/onenand/pxa3xx.c
new file mode 100644
index 0000000..d97ec15
--- /dev/null
+++ b/drivers/mtd/onenand/pxa3xx.c
@@ -0,0 +1,248 @@
+/*
+ *  linux/drivers/mtd/onenand/onenand_base.c
+ *
+ *  Copyright (C) 2007 Marvell Internal Ltd.
+ *
+ *  Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/onenand.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/io.h>
+#include <asm/mach/flash.h>
+
+#ifdef CONFIG_PXA3xx_BBM
+#include <plat/pxa3xx_bbm.h>
+#endif
+
+#define DRIVER_NAME    "pxa3xx-onenand"
+
+
+#ifdef CONFIG_MTD_PARTITIONS
+static const char *part_probes[] = { "cmdlinepart", NULL,  };
+#endif
+
+struct pxa3xx_onenand_info {
+    struct onenand_chip    onenand;
+#ifdef CONFIG_PXA3xx_BBM
+    /*
+     * Restriction: onenand_chip should be the first one of
+     * pxa3xx_onenand_info.
+     * bbm should be the second one of pxa3xx_nand_info.
+     * Marvell PXA3xx BBM always access this field to get bbm.
+     */
+    struct pxa3xx_bbm    *bbm;
+#endif
+    struct mtd_info        mtd;
+    struct mtd_partition    *parts;
+};
+
+#ifdef CONFIG_PXA3xx_BBM
+static int pxa3xx_onenand_block_markbad(struct mtd_info *mtd, loff_t ofs)
+{
+    struct pxa3xx_onenand_info *info = mtd->priv;
+    struct pxa3xx_bbm *bbm = info->bbm;
+    struct onenand_chip *this = mtd->priv;
+    unsigned char buf[2] = {0, 0};
+    struct mtd_oob_ops ops = {
+        .mode = MTD_OOB_PLACE,
+        .ooblen = 2,
+        .oobbuf = buf,
+        .ooboffs = 0,
+    };
+    int block, ret;
+
+    /* Get block number */
+    block = onenand_block(this, ofs);
+
+        /* We write two bytes, so we dont have to mess with 16 bit access
*/
+        ofs += mtd->oobsize + (ONENAND_BADBLOCK_POS & ~0x01);
+    /* FIXME : What to do when marking SLC block in partition
+     *        with MLC erasesize? For now, it is not advisable to
+     *       create partitions containing both SLC and MLC regions.
+     */
+    ret = mtd->write_oob(mtd, ofs, &ops);
+    if (ret)
+        return ret;
+
+    return bbm->block_markbad(mtd, block);
+}
+
+int verify_onenand_bbm(struct mtd_info *mtd, struct pxa3xx_bbm **bbm)
+{
+    struct onenand_chip *chip = mtd->priv;
+    struct pxa3xx_bbm **nbbm = NULL;
+
+    /* check whether current flash is onenand */
+    nbbm = (struct pxa3xx_bbm **)(++chip);
+    if (((unsigned int)nbbm < PAGE_OFFSET)
+        || ((unsigned int)*nbbm < PAGE_OFFSET))
+        return PXA3xx_BBM_INVALID;
+
+    if ((*nbbm)->magic == PXA_BBM_MAGIC) {
+        pr_debug("%s:Found Onenand flash.\n", __func__);
+        *bbm = *nbbm;
+        return PXA3xx_BBM_ONENAND;
+    }
+    return PXA3xx_BBM_INVALID;
+}
+
+/**
+ * pxa3xx_onenand_command - Send command to OneNAND device
+ * @param mtd        MTD device structure
+ * @param cmd        the command to be sent
+ * @param addr        offset to read from or write to
+ * @param len        number of bytes to read or write
+ *
+ * Send command to OneNAND device. This function is used for middle/large
page
+ * devices (1KB/2KB Bytes per page)
+ */
+static int pxa3xx_onenand_command(struct mtd_info *mtd, int cmd,
+                  loff_t addr, size_t len)
+{
+    struct pxa3xx_onenand_info *info = mtd->priv;
+    struct pxa3xx_bbm *bbm = info->bbm;
+
+    /* Get reolocated address */
+    addr = bbm->search(mtd, addr);
+    return onenand_command(mtd, cmd, addr, len);
+}
+
+static void pxa3xx_onenand_init_chip(struct pxa3xx_onenand_info *info)
+{
+    struct onenand_chip *this = &info->onenand;
+    struct pxa3xx_bbm *bbm = NULL;
+
+    bbm = pxa3xx_query_bbm();
+    if (bbm) {
+        /* Marvell PXA3xx BBM is initialized successfully */
+        info->bbm = bbm;
+        this->scan_bbt = bbm->scan_bbt;
+        this->block_markbad = pxa3xx_onenand_block_markbad;
+        this->command = pxa3xx_onenand_command;
+    }
+}
+#else
+static void pxa3xx_onenand_init_chip(struct pxa3xx_onenand_info *info) {}
+#endif
+
+static int __devinit pxa3xx_onenand_probe(struct platform_device *pdev)
+{
+    struct pxa3xx_onenand_info *info = NULL;
+    struct flash_platform_data *pdata = pdev->dev.platform_data;
+    struct resource *res = pdev->resource;
+    unsigned long size = res->end - res->start + 1;
+    int err;
+
+    info = kzalloc(sizeof(struct pxa3xx_onenand_info), GFP_KERNEL);
+    if (!info)
+        return -ENOMEM;
+
+    if (!request_mem_region(res->start, size, pdev->dev.driver->name)) {
+        err = -EBUSY;
+        goto out_free_info;
+    }
+
+    info->onenand.base = ioremap(res->start, size);
+    if (!info->onenand.base) {
+        err = -ENOMEM;
+        goto out_release_mem_region;
+    }
+
+    info->onenand.mmcontrol = pdata->mmcontrol;
+    info->onenand.irq = platform_get_irq(pdev, 0);
+
+    pxa3xx_onenand_init_chip(info);
+
+    info->mtd.name = dev_name(&pdev->dev);
+    info->mtd.priv = &info->onenand;
+    info->mtd.owner = THIS_MODULE;
+
+    if (onenand_scan(&info->mtd, 1)) {
+        err = -ENXIO;
+        goto out_iounmap;
+    }
+
+#ifdef CONFIG_MTD_PARTITIONS
+    err = parse_mtd_partitions(&info->mtd, part_probes, &info->parts, 0);
+    if (err > 0)
+        add_mtd_partitions(&info->mtd, info->parts, err);
+    else if (err <= 0 && pdata->parts)
+        add_mtd_partitions(&info->mtd, pdata->parts, pdata->nr_parts);
+    else
+#endif
+        err = add_mtd_device(&info->mtd);
+
+    platform_set_drvdata(pdev, info);
+
+    return 0;
+
+out_iounmap:
+    iounmap(info->onenand.base);
+out_release_mem_region:
+    release_mem_region(res->start, size);
+out_free_info:
+    kfree(info);
+
+    return err;
+}
+
+static int __devexit pxa3xx_onenand_remove(struct platform_device *pdev)
+{
+    struct pxa3xx_onenand_info *info = platform_get_drvdata(pdev);
+    struct resource *res = pdev->resource;
+    unsigned long size = res->end - res->start + 1;
+
+    platform_set_drvdata(pdev, NULL);
+
+    if (info) {
+        if (info->parts)
+            del_mtd_partitions(&info->mtd);
+        else
+            del_mtd_device(&info->mtd);
+
+        onenand_release(&info->mtd);
+        release_mem_region(res->start, size);
+        iounmap(info->onenand.base);
+        kfree(info);
+    }
+
+    return 0;
+}
+
+static struct platform_driver pxa3xx_onenand_driver = {
+    .driver = {
+        .name        = DRIVER_NAME,
+        .owner        = THIS_MODULE,
+    },
+    .probe        = pxa3xx_onenand_probe,
+    .remove        = __devexit_p(pxa3xx_onenand_remove),
+};
+
+MODULE_ALIAS(DRIVER_NAME);
+
+static int __init pxa3xx_onenand_init(void)
+{
+    return platform_driver_register(&pxa3xx_onenand_driver);
+}
+
+static void __exit pxa3xx_onenand_exit(void)
+{
+    platform_driver_unregister(&pxa3xx_onenand_driver);
+}
+
+module_init(pxa3xx_onenand_init);
+module_exit(pxa3xx_onenand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_DESCRIPTION("Glue layer for OneNAND flash on Marvell PXA3xx");
diff --git a/drivers/mtd/pxa3xx_bbm.c b/drivers/mtd/pxa3xx_bbm.c
index bcc9a35..070e5d1 100644
--- a/drivers/mtd/pxa3xx_bbm.c
+++ b/drivers/mtd/pxa3xx_bbm.c
@@ -27,6 +27,10 @@ static int verify_bbm_magic(struct mtd_info *mtd, struct
pxa3xx_bbm **bbm)
     int ret;

     ret = verify_nand_bbm(mtd, bbm);
+    if (ret >= 0)
+        return ret;
+
+    ret = verify_onenand_bbm(mtd, bbm);
     return ret;
 }

-- 
1.5.6.5

--0016e644c18e3e1667047465b6ab
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
