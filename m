From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 25 Sep 2009 15:00:28 -0400
Subject: [PATCH] [MTD] [NAND] pxa3xx_nand: enable PXA3xx bad block
Message-ID: <mailman.17.1253879884.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

management

There's a custom bad block management in PXA3xx series.

This BBM needs to allocate a reserved area at the bottom of NAND chip.
The reserved area should be protected from normal usage. The first block
of NAND is also reserved in order to storing the relocation information.

When NAND controller finds a bad block, it marks the block as bad and
allocate a unused block from reserved area in bottom. The new block is
used to replace the original bad one. From OS view, there's no bad block
at the time. It's handled by NAND driver. Then driver records the
replacement
in the first block.

The reserved area is also called as relocation area. It occupies 2% of
the whole NAND space.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/plat-pxa/include/plat/pxa3xx_bbm.h |   62 ++++
 drivers/mtd/Kconfig                         |    6 +
 drivers/mtd/Makefile                        |    1 +
 drivers/mtd/nand/pxa3xx_nand.c              |  124 ++++++++
 drivers/mtd/pxa3xx_bbm.c                    |  427
+++++++++++++++++++++++++++
 5 files changed, 620 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-pxa/include/plat/pxa3xx_bbm.h
 create mode 100644 drivers/mtd/pxa3xx_bbm.c

diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_bbm.h
b/arch/arm/plat-pxa/include/plat/pxa3xx_bbm.h
new file mode 100644
index 0000000..8508547
--- /dev/null
+++ b/arch/arm/plat-pxa/include/plat/pxa3xx_bbm.h
@@ -0,0 +1,62 @@
+#ifndef    __PXA3XX_BBT_H__
+#define    __PXA3XX_BBT_H__
+
+#include <linux/types.h>
+
+#define PXA_RLTABLE_HEADER        (0x524e)
+#define PXA_MAX_RLENTRY            (127)
+#define PXA_MAX_SLOT            (40)
+#define PXA_BEGIN_SLOT            (2)
+#define PXA_BBM_MAGIC            (0x4c56524d)    /* MRVL */
+
+enum {
+    PXA3xx_BBM_NAND = 0,
+    PXA3xx_BBM_ONENAND,
+    PXA3xx_BBM_INVALID = -1,
+};
+
+struct relocate_entry {
+    unsigned short from;
+    unsigned short to;
+};
+
+struct relocate_table {
+    unsigned short header;
+    unsigned short total;
+};
+
+struct pxa3xx_bbm {
+    int            magic;
+    /*
+     * NOTES: this field impact the partition table. Please make sure
+     * that this value align with partitions definition.
+     */
+    int            max_relocate_entry;
+    int            max_slots;
+    int            current_slot;
+
+    void            *data_buf;
+
+    /*
+     * These two fields should be in (one)nand_chip. Add here to handle
+     * onenand_chip and nand_chip at the same time.
+     */
+    int            page_shift;
+    int            erase_shift;
+
+    struct relocate_table    *table;
+    struct relocate_entry    *entry;
+
+    void    (*uninit)(struct mtd_info *mtd);
+    loff_t    (*search)(struct mtd_info *mtd,    loff_t ofs);
+    int    (*block_markbad)(struct mtd_info *mtd, int block);
+    int    (*scan_bbt)(struct mtd_info *mtd);
+};
+
+extern int verify_nand_bbm(struct mtd_info *mtd, struct pxa3xx_bbm **bbm);
+extern int verify_onenand_bbm(struct mtd_info *mtd, struct pxa3xx_bbm
**bbm);
+extern int nand_badblockpos(struct mtd_info *mtd);
+extern int onenand_badblockpos(struct mtd_info *mtd);
+extern struct pxa3xx_bbm *pxa3xx_query_bbm(void);
+#endif
+
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index b8e35a0..3cdf7bf 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -315,6 +315,12 @@ config MTD_OOPS
       To use, add console=ttyMTDx to the kernel command line,
       where x is the MTD device number to use.

+config PXA3xx_BBM
+    bool "Marvell PXA3xx Bad Block Management"
+    depends on MTD && (MTD_NAND || MTD_ONENAND)
+    help
+      This enables Marvell Bad block management on NAND/ONENAND on PXA3xx.
+
 source "drivers/mtd/chips/Kconfig"

 source "drivers/mtd/maps/Kconfig"
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 82d1e4d..e637fa0 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_INFTL)        += inftl.o
 obj-$(CONFIG_RFD_FTL)        += rfd_ftl.o
 obj-$(CONFIG_SSFDC)        += ssfdc.o
 obj-$(CONFIG_MTD_OOPS)        += mtdoops.o
+obj-$(CONFIG_PXA3xx_BBM)    += pxa3xx_bbm.o

 nftl-objs        := nftlcore.o nftlmount.o
 inftl-objs        := inftlcore.o inftlmount.o
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 134bfbc..d6c9524 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -24,6 +24,10 @@
 #include <mach/dma.h>
 #include <plat/pxa3xx_nand.h>

+#ifdef CONFIG_PXA3xx_BBM
+#include <plat/pxa3xx_bbm.h>
+#endif
+
 #define    CHIP_DELAY_TIMEOUT    (2 * HZ/10)

 /* registers and bit definitions */
@@ -112,6 +116,14 @@ enum {

 struct pxa3xx_nand_info {
     struct nand_chip    nand_chip;
+#ifdef CONFIG_PXA3xx_BBM
+    /*
+     * Restriction: nand_chip should be the first one of pxa3xx_nand_info.
+     * bbm should be the second one of pxa3xx_nand_info.
+     * Marvell PXA3xx BBM always access this field to get bbm.
+     */
+    struct pxa3xx_bbm    *bbm;
+#endif

     struct platform_device     *pdev;
     const struct pxa3xx_nand_flash *flash_info;
@@ -365,6 +377,8 @@ static struct pxa3xx_nand_flash *builtin_flash_types[] =
{
 /* convert nand flash controller clock cycles to nano-seconds */
 #define cycle2ns(c, clk)    ((((c) + 1) * 1000000 + clk / 500) / (clk /
1000))

+static int pxa3xx_nand_relocate_addr(struct mtd_info *mtd, int page_addr);
+
 static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,
                    const struct pxa3xx_nand_timing *t)
 {
@@ -706,6 +720,8 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd,
unsigned command,

     init_completion(&info->cmd_complete);

+    page_addr = pxa3xx_nand_relocate_addr(mtd, page_addr);
+
     switch (command) {
     case NAND_CMD_READOOB:
         /* disable HW ECC to get all the OOB data */
@@ -1165,6 +1181,113 @@ static struct nand_ecclayout hw_largepage_ecclayout
= {
     .oobfree = { {2, 38} }
 };

+#ifdef CONFIG_PXA3xx_BBM
+int verify_nand_bbm(struct mtd_info *mtd, struct pxa3xx_bbm **bbm)
+{
+    struct nand_chip *info = mtd->priv;
+    struct pxa3xx_bbm **nbbm = NULL;
+
+    /* check whether current flash is nand */
+    nbbm = (struct pxa3xx_bbm **)(++info);
+    if (((unsigned int)nbbm < PAGE_OFFSET)
+        || ((unsigned int)*nbbm < PAGE_OFFSET))
+        return PXA3xx_BBM_INVALID;
+
+    if ((*nbbm)->magic == PXA_BBM_MAGIC) {
+        pr_debug("%s:Found Nand flash.\n", __func__);
+        *bbm = *nbbm;
+        return PXA3xx_BBM_NAND;
+    }
+    return PXA3xx_BBM_INVALID;
+}
+
+static int pxa3xx_nand_relocate_addr(struct mtd_info *mtd, int page_addr)
+{
+    struct pxa3xx_nand_info *info = mtd->priv;
+    struct pxa3xx_bbm *bbm = info->bbm;
+    loff_t addr;
+    int ret;
+
+    addr = page_addr << bbm->page_shift;
+    addr = bbm->search(mtd, addr);
+    ret = addr >> bbm->page_shift;
+    return ret;
+}
+
+static int pxa3xx_nand_block_markbad(struct mtd_info *mtd, loff_t ofs)
+{
+    struct pxa3xx_nand_info *info = mtd->priv;
+    struct pxa3xx_bbm *bbm = info->bbm;
+    struct nand_chip *chip = mtd->priv;
+    uint8_t buf[2] = { 0, 0 };
+    int block, ret;
+
+    /* Get block number */
+    block = (int)(ofs >> chip->bbt_erase_shift);
+
+    /* We write two bytes, so we dont have to mess with 16 bit
+     * access
+     */
+    ofs += mtd->oobsize;
+    chip->ops.len = chip->ops.ooblen = 2;
+    chip->ops.datbuf = NULL;
+    chip->ops.oobbuf = buf;
+    chip->ops.ooboffs = chip->badblockpos & ~0x01;
+
+    ret = mtd->write_oob(mtd, ofs, &chip->ops);
+
+    if (!ret)
+        mtd->ecc_stats.badblocks++;
+
+    return bbm->block_markbad(mtd, block);
+}
+
+static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
+                 struct pxa3xx_nand_info *info)
+{
+    const struct pxa3xx_nand_flash *f = info->flash_info;
+    struct nand_chip *this = &info->nand_chip;
+    struct pxa3xx_bbm *bbm = NULL;
+
+    this->options = (f->flash_width == 16) ? NAND_BUSWIDTH_16: 0;
+
+    this->waitfunc        = pxa3xx_nand_waitfunc;
+    this->select_chip    = pxa3xx_nand_select_chip;
+    this->dev_ready        = pxa3xx_nand_dev_ready;
+    this->cmdfunc        = pxa3xx_nand_cmdfunc;
+    this->read_word        = pxa3xx_nand_read_word;
+    this->read_byte        = pxa3xx_nand_read_byte;
+    this->read_buf        = pxa3xx_nand_read_buf;
+    this->write_buf        = pxa3xx_nand_write_buf;
+    this->verify_buf    = pxa3xx_nand_verify_buf;
+
+    this->ecc.mode        = NAND_ECC_HW;
+    this->ecc.hwctl        = pxa3xx_nand_ecc_hwctl;
+    this->ecc.calculate    = pxa3xx_nand_ecc_calculate;
+    this->ecc.correct    = pxa3xx_nand_ecc_correct;
+    this->ecc.size        = f->page_size;
+
+    if (f->page_size == 2048)
+        this->ecc.layout = &hw_largepage_ecclayout;
+    else
+        this->ecc.layout = &hw_smallpage_ecclayout;
+
+    this->chip_delay = 25;
+
+    bbm = pxa3xx_query_bbm();
+    if (bbm) {
+        /* Marvell PXA3xx BBM is initialized successfully */
+        info->bbm = bbm;
+        this->scan_bbt = bbm->scan_bbt;
+        this->block_markbad = pxa3xx_nand_block_markbad;
+    }
+}
+#else
+static int pxa3xx_nand_relocate_addr(struct mtd_info *mtd, int page_addr)
+{
+    return page_addr;
+}
+
 static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
                  struct pxa3xx_nand_info *info)
 {
@@ -1196,6 +1319,7 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,

     this->chip_delay = 25;
 }
+#endif

 static int pxa3xx_nand_probe(struct platform_device *pdev)
 {
diff --git a/drivers/mtd/pxa3xx_bbm.c b/drivers/mtd/pxa3xx_bbm.c
new file mode 100644
index 0000000..bcc9a35
--- /dev/null
+++ b/drivers/mtd/pxa3xx_bbm.c
@@ -0,0 +1,427 @@
+/*
+ * linux/drivers/mtd/pxa3xx_bbm.c
+ *
+ * Support bad block management on PXA3xx.
+ * Copyright (C) 2007 Marvell International Ltd.
+ *
+ * Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <plat/pxa3xx_bbm.h>
+#include <asm/errno.h>
+
+static struct pxa3xx_bbm *pxa3xx_bbm = NULL;
+
+/*
+ * bbm should be the next field of nand_chip or onenand_chip.
+ */
+static int verify_bbm_magic(struct mtd_info *mtd, struct pxa3xx_bbm **bbm)
+{
+    int ret;
+
+    ret = verify_nand_bbm(mtd, bbm);
+    return ret;
+}
+
+static void dump_rltable(struct pxa3xx_bbm *bbm)
+{
+    int i;
+
+    if (bbm->table->total == 0) {
+        pr_info("The relocation table is empty now\n");
+        return;
+    }
+    for (i = 0; i < bbm->table->total; i++) {
+        if (bbm->entry[i].from == (unsigned short)(-1))
+            continue;
+        if (bbm->entry[i].to == (unsigned short)(-1))
+            pr_info("(%4d): block #%d is bad in relocation area\n",
+                i, bbm->entry[i].from);
+        else
+            pr_info("(%4d): block #%d is relocated to #%d\n",
+                i, bbm->entry[i].from, bbm->entry[i].to);
+    }
+}
+
+/* Initialize the relocation table */
+static int pxa3xx_init_rltable(struct mtd_info *mtd)
+{
+    struct pxa3xx_bbm *bbm = NULL;
+    int size = mtd->writesize + mtd->oobsize;
+    int pages, entries;
+
+    if (verify_bbm_magic(mtd, &bbm) < 0) {
+        /* BBM don't support this type of flash */
+        return -EINVAL;
+    }
+
+    bbm->page_shift = ffs(mtd->writesize) - 1;
+    bbm->erase_shift = ffs(mtd->erasesize) - 1;
+
+    pages = mtd->erasesize >> bbm->page_shift;
+
+    entries = mtd->size >> bbm->erase_shift;
+    entries = (entries * 2) / 100;
+    if (mtd->writesize == 512)
+        entries = (entries < PXA_MAX_RLENTRY) ? entries
+              : PXA_MAX_RLENTRY;
+
+    bbm->max_slots    = PXA_MAX_SLOT;
+    bbm->max_relocate_entry = entries;
+    bbm->current_slot = -1;
+
+    bbm->data_buf = kzalloc(size, GFP_KERNEL);
+    if (bbm->data_buf == NULL)
+        return -ENOMEM;
+
+    bbm->table = (struct relocate_table *)bbm->data_buf;
+    memset(bbm->table, 0, sizeof(struct relocate_table));
+
+    bbm->entry = (struct relocate_entry *)((uint8_t *)bbm->data_buf +
+            sizeof(struct relocate_entry));
+    memset(bbm->entry, 0, sizeof(struct relocate_entry)
+        * bbm->max_relocate_entry);
+
+    return 0;
+}
+
+/* Uninitialize the relocation table */
+static void pxa3xx_uninit_rltable(struct mtd_info *mtd)
+{
+    struct pxa3xx_bbm *bbm = NULL;
+
+    if (verify_bbm_magic(mtd, &bbm) < 0) {
+        /* BBM don't support this flash type */
+        return;
+    }
+
+    if (bbm) {
+        kfree(bbm->data_buf);
+        bbm = NULL;
+    }
+}
+
+/*
+ * Move larger data to left of pivot, and move smaller data to right of
+ * pivot.
+ */
+static int partition(unsigned short *array, int left, int right, int
pivot_idx)
+{
+    int i, pivot, base_idx;
+
+    pivot = array[pivot_idx];
+    swap(array[left], array[right]);
+    base_idx = left;
+
+    for (i = left; i < right; i++) {
+        if (array[i] > pivot) {
+            swap(array[i], array[base_idx]);
+            base_idx++;
+        }
+    }
+    if (base_idx < right)
+        swap(array[base_idx], array[right]);
+    return base_idx;
+}
+
+static int quick_sort(unsigned short *array, int left, int right)
+{
+    int pivot_idx, new_idx;
+    if (right > left) {
+        pivot_idx = left;
+        new_idx = partition(array, left, right, pivot_idx);
+        quick_sort(array, left, new_idx - 1);
+        quick_sort(array, new_idx + 1, right);
+    }
+    return 0;
+}
+
+/*
+ * Add the relocation entry into the relocation table. If the relocated
block
+ * is bad, an new entry will be added into the bottom of the relocation
table.
+ */
+int update_rltable(struct mtd_info *mtd, int block)
+{
+    struct pxa3xx_bbm *bbm = NULL;
+    struct relocate_table *table = NULL;
+    struct relocate_entry *entry = NULL;
+    struct erase_info instr;
+    unsigned short array[PXA_MAX_RLENTRY], addr;
+    int i, idx, ret, relocated_idx = -1;
+
+    if (verify_bbm_magic(mtd, &bbm) < 0) {
+        /* BBM don't support this type of flash */
+        return -EINVAL;
+    }
+
+    table = bbm->table;
+    entry = bbm->entry;
+
+    /* identify whether the block has been relocated */
+    for (i = 0; i < table->total; i++) {
+        if (entry[i].from == (unsigned short)(-1))
+            continue;
+        if (block == entry[i].from) {
+            relocated_idx = i;
+            break;
+        }
+    }
+
+scan:
+    if (table->total > bbm->max_relocate_entry) {
+        pr_warning("Relocation entries exceed max num. Can't relocate");
+        pr_warning(" block 0x%x\n", block);
+        return -ENOSPC;
+    }
+
+    memset(array, 0, PXA_MAX_RLENTRY);
+    /* Get all index of relocated blocks */
+    for (i = 0, idx = 0; i < table->total; i++) {
+        array[idx] = (entry[i].to != (unsigned short)(-1)) ? entry[i].to
+                : entry[i].from;
+        idx++;
+    }
+    /* sort array with descending order */
+    quick_sort(array, 0, idx - 1);
+    /*
+     * find the available block with the largest number in reservered
+     * area
+     */
+    addr = (unsigned short)((mtd->size >> bbm->erase_shift) - 1);
+    for (i = 0; i < bbm->max_relocate_entry; i++, addr--) {
+        if (addr < ((mtd->size >> bbm->erase_shift)
+            - bbm->max_relocate_entry)) {
+            pr_warning("Relocation area is already full!\n");
+            return -ENOSPC;
+        }
+        if (array[i] < addr) {
+            memset(&instr, 0, sizeof(struct erase_info));
+            instr.mtd = mtd;
+            instr.addr = addr << bbm->erase_shift;
+            instr.len = 1 << bbm->erase_shift;
+            ret = mtd->erase(mtd, &instr);
+            if (ret == 0) {
+                /* fill the recorder into relocation table */
+                if (relocated_idx == -1) {
+                    /* new entry in relocation table */
+                    entry[table->total].from = block;
+                    entry[table->total].to = addr;
+                    table->total++;
+                    goto done;
+                } else {
+                    /* update entry in relocation table */
+                    entry[table->total].from
+                        = entry[relocated_idx].to;
+                    entry[table->total].to
+                        = (unsigned short)(-1);
+                    table->total++;
+                    entry[relocated_idx].to = addr;
+                    goto done;
+                }
+            } else {
+                /* append new bad entry */
+                entry[table->total].from = addr;
+                entry[table->total].to = (unsigned short)(-1);
+                table->total++;
+                goto scan;
+            }
+        }
+    }
+
+done:
+    return 0;
+}
+
+/* Write the relocation table back to device, if there's room. */
+static int sync_rltable(struct mtd_info *mtd, int *idx)
+{
+    struct pxa3xx_bbm *bbm = NULL;
+    unsigned char *tmp;
+    size_t retlen;
+    int len, pages;
+
+    if (verify_bbm_magic(mtd, &bbm) < 0) {
+        /* BBM don't support this type of flash */
+        return -EINVAL;
+    }
+
+    pages = mtd->erasesize >> bbm->page_shift;
+    if ((*idx >= pages) || (*idx <= (pages - bbm->max_slots))) {
+        printk(KERN_ERR "Wrong Slot is specified.\n");
+        return -EINVAL;
+    }
+
+    /* should write to the next slot*/
+    (*idx)--;
+
+    len = 4;        /* table header */
+    len += bbm->table->total << 2;
+
+    tmp = (unsigned char *)bbm->data_buf;
+    mtd->write(mtd, (*idx) << bbm->page_shift,
+           1 << bbm->page_shift, &retlen, tmp);
+
+    return 0;
+}
+
+static int pxa3xx_scan_rltable(struct mtd_info *mtd)
+{
+    struct pxa3xx_bbm *bbm = NULL;
+    struct relocate_table *table;
+    int page, max_page;
+    size_t retlen;
+    int ret, retry_count = 3;
+
+    if (verify_bbm_magic(mtd, &bbm) < 0) {
+        /* BBM don't support this type of flash */
+        return -EINVAL;
+    }
+
+    pxa3xx_init_rltable(mtd);
+
+    table = bbm->table;
+
+    bbm->current_slot = -1;
+    page = (mtd->erasesize >> bbm->page_shift) - bbm->max_slots;
+    max_page = mtd->erasesize >> bbm->page_shift;
+    for (; page < max_page; page++, retry_count = 3) {
+retry:
+        memset(bbm->data_buf, 0, mtd->writesize + mtd->oobsize);
+        ret = mtd->read(mtd, (page << bbm->page_shift),
+                mtd->writesize, &retlen, bbm->data_buf);
+        if (ret == 0) {
+            if (table->header == PXA_RLTABLE_HEADER) {
+                bbm->current_slot = page;
+                break;
+            }
+        } else {
+            if (retry_count--)
+                goto retry;
+        }
+    }
+    if (bbm->current_slot != -1) {
+        pr_debug("Found relocation table at page:%d\n",
+            bbm->current_slot);
+        dump_rltable(bbm);
+    } else {
+        pr_err("Can't recognize relocation table.\n");
+        pr_err("CAUTION: It may cause unpredicated error\n");
+        pr_err("Please re-initialize the flash.\n");
+        memset((unsigned char *)bbm->table, 0,
+            sizeof(struct relocate_table));
+        return -EFAULT;
+    }
+    return 0;
+}
+
+/*
+ * Find the relocated block of the bad one.
+ * If it's a good block, return 0. Otherwise, return a relocated one.
+ * idx points to the next relocation entry
+ * If the relocated block is bad, an new entry will be added into the
+ * bottom of the relocation table.
+ */
+static loff_t pxa3xx_search_rlentry(struct mtd_info *mtd, loff_t ofs)
+{
+    struct pxa3xx_bbm *bbm = NULL;
+    struct relocate_table *table = NULL;
+    struct relocate_entry *entry = NULL;
+    int i, block;
+
+    /*
+     * In SLC, block 0 shouldn't be broken.
+     * In some command, address is assigned to 0 if it doesn't need
+     * to operate address. So just skip it.
+     */
+    if (ofs <= 0)
+        return ofs;
+
+    if (verify_bbm_magic(mtd, &bbm) < 0)
+        return ofs;
+
+    table = bbm->table;
+    entry = bbm->entry;
+
+    block = ofs >> bbm->erase_shift;
+
+    if ((bbm->current_slot == -1) || (table->total <= 0)
+        || (block >= (mtd->size >> bbm->erase_shift)))
+        return ofs;
+
+    ofs = ofs - (block << bbm->erase_shift);    /* save offset */
+
+    for (i = 0; i < table->total; i++) {
+        if (block == entry[i].from) {
+            block = entry[i].to;
+            break;
+        }
+    }
+    ofs += block << bbm->erase_shift;
+    return ofs;
+}
+
+static int pxa3xx_mark_rlentry(struct mtd_info *mtd, int block)
+{
+    struct pxa3xx_bbm *bbm = NULL;
+    int ret = 0;
+
+    ret = verify_bbm_magic(mtd, &bbm);
+    if (ret < 0) {
+        /* BBM don't support this type of flash */
+        return -EINVAL;
+    }
+
+    ret = update_rltable(mtd, block);
+    if (ret)
+        return ret;
+
+    return sync_rltable(mtd, &(bbm->current_slot));
+}
+
+/* If Marvell BBM is used, return 0. Otherwise, return negative value. */
+struct pxa3xx_bbm *pxa3xx_query_bbm(void)
+{
+    if (pxa3xx_bbm)
+        return pxa3xx_bbm;
+    return NULL;
+}
+EXPORT_SYMBOL(pxa3xx_query_bbm);
+
+static int __init pxa3xx_bbm_init(void)
+{
+    struct pxa3xx_bbm *bbm;
+
+    bbm = kzalloc(sizeof(struct pxa3xx_bbm), GFP_KERNEL);
+    if (!bbm)
+        return -ENOMEM;
+
+    bbm->magic        = PXA_BBM_MAGIC;
+    bbm->uninit        = pxa3xx_uninit_rltable;
+    bbm->search        = pxa3xx_search_rlentry;
+    bbm->block_markbad    = pxa3xx_mark_rlentry;
+    bbm->scan_bbt        = pxa3xx_scan_rltable;
+
+    pxa3xx_bbm = bbm;
+
+    return 0;
+}
+subsys_initcall(pxa3xx_bbm_init);
+
+static void pxa3xx_bbm_exit(void)
+{
+    if (pxa3xx_bbm) {
+        kfree(pxa3xx_bbm);
+        pxa3xx_bbm = NULL;
+    }
+}
+module_exit(pxa3xx_bbm_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Marvell PXA3xx Bad Block Management");
-- 
1.5.6.5

--001517741a149782ca047465a8bd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
