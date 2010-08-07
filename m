From: norris@broadcom.com (Brian Norris)
Date: Fri, 6 Aug 2010 17:11:13 -0700
Subject: [PATCH] mtd: Expand nand_ecc_layout, deprecate ioctl
 ECCGETLAYOUT
In-Reply-To: <1281032284.1175.45.camel@localhost.localdomain>
References: <4C5AFA88.3040009@broadcom.com>
	<1281032284.1175.45.camel@localhost.localdomain>
Message-ID: <4C5CA4A1.1040000@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have addressed this patch to two mailing lists (and several other
"maintainers") because, although this primarily deals with the MTD
subsystem, it affects drivers, etc. from the ARM architecture at least.

Refer to the following page if you want the "full" conversation:
http://lists.infradead.org/pipermail/linux-mtd/2010-August/031337.html

On 08/05/2010 11:18 AM, Artem Bityutskiy wrote:
> On Thu, 2010-08-05 at 10:53 -0700, Brian Norris wrote:
>> I'm trying to replace the following structure (in mtd-abi.h) and its
>> corresponding ioctl with a larger, dynamic form exported via sysfs.
>> We're running out of room in the eccpos and oobfree arrays on larger chips:
> 
> I personally hate that internal information like eccpos is exposed to
> user-space. I think a good an not error-prone SW should be written in a
> way the ECC is completely hidden and handled by driver. And it is better
> not to use OOB.
> 
> Do you really need to know ECC layout? What for? Would be nice if
> everything but the above mode of working with OOB / ECC would be
> considered as legacy and died...

Well, we actually only needed the larger struct for the kernel space, so
maybe we can ignore most of the new sysfs/ioctl ideas for now.

>> struct nand_ecclayout {
>>           __u32 eccbytes;
>>           __u32 eccpos[64];
>>           __u32 oobavail;
>>           struct nand_oobfree oobfree[MTD_MAX_OOBFREE_ENTRIES];
>> };

> If you really have to do this, I think a new ioctl with some extra space
> for future extentions is better. sysfs is not good choice, imo.

After some work, I agree; sysfs isn't a good choice. Perhaps we don't even
need full user-space access to the kernel struct; instead, we can deprecate
the ECCGETLAYOUT ioctl, expand the nand_ecclayout as follows, and possibly
add different user-space functions to access the ECC/OOB info in a uniform
fashion in the future.

Let me know if I have over-/under-commented the code or if there are better
ways to accomplish the objectives mentioned. The patch/commit message follows.

Thanks,
Brian

-----------------------------------------------------------------------------

struct nand_ecclayout is too small for many new chips; OOB regions can be as
large as 448 bytes and may increase more in the future. Thus, copying that
struct to user-space with the ECCGETLAYOUT ioctl is not a good idea; the ioctl
would have to be updated every time there's a change to the current largest
size.

Instead, the whole NAND system should switch over to using a struct that is
entirely private to the kernel (i.e., the larger struct nand_ecclayout_l).
A new function is provided to convert from the new to the old in order to
allow the deprecated ioctl to continue to work with truncated data. Perhaps
the ioctl, the conversion process, and the struct nand_ecclayout can be
removed altogether in the future.

Note: There are comments in nand/davinci_nand.c::nand_davinci_probe()
regarding this issue; this driver (and maybe others) can be updated
to account for extra space. As far as I can tell, though, all kernel drivers
*can* use nand_ecclayout_l as a drop-in replacement and ignore its benefits.

Signed-off-by: Brian Norris <norris@broadcom.com>
---
 arch/arm/mach-pxa/spitz.c                 |    2 +-
 arch/arm/plat-samsung/dev-nand.c          |    2 +-
 arch/arm/plat-samsung/include/plat/nand.h |    2 +-
 drivers/mtd/mtdchar.c                     |   48 +++++++++++++++++++++++++++--
 drivers/mtd/nand/atmel_nand.c             |    4 +-
 drivers/mtd/nand/bcm_umi_bch.c            |    6 ++--
 drivers/mtd/nand/bf5xx_nand.c             |    2 +-
 drivers/mtd/nand/cafe_nand.c              |    4 +-
 drivers/mtd/nand/davinci_nand.c           |   11 ++++--
 drivers/mtd/nand/diskonchip.c             |    2 +-
 drivers/mtd/nand/fsl_elbc_nand.c          |    8 ++--
 drivers/mtd/nand/mxc_nand.c               |   10 +++---
 drivers/mtd/nand/nand_base.c              |    8 ++--
 drivers/mtd/nand/nomadik_nand.c           |    2 +-
 drivers/mtd/nand/pxa3xx_nand.c            |    4 +-
 drivers/mtd/nand/rtc_from4.c              |    2 +-
 drivers/mtd/nand/s3c2410.c                |    2 +-
 drivers/mtd/nand/sh_flctl.c               |    4 +-
 drivers/mtd/onenand/onenand_base.c        |    6 ++--
 fs/jffs2/wbuf.c                           |    2 +-
 include/linux/mtd/inftl.h                 |    2 +-
 include/linux/mtd/mtd.h                   |   17 +++++++++-
 include/linux/mtd/nand.h                  |    6 ++--
 include/linux/mtd/nftl.h                  |    2 +-
 include/linux/mtd/onenand.h               |    2 +-
 include/linux/mtd/partitions.h            |    2 +-
 include/linux/mtd/sharpsl.h               |    2 +-
 27 files changed, 112 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 4d2413e..6542aaf 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -775,7 +775,7 @@ static struct nand_bbt_descr sharpsl_akita_bbt = {
 	.pattern = scan_ff_pattern
 };
 
-static struct nand_ecclayout akita_oobinfo = {
+static struct nand_ecclayout_l akita_oobinfo = {
 	.eccbytes = 24,
 	.eccpos = {
 		   0x5, 0x1, 0x2, 0x3, 0x6, 0x7, 0x15, 0x11,
diff --git a/arch/arm/plat-samsung/dev-nand.c b/arch/arm/plat-samsung/dev-nand.c
index 3a7b889..0109307 100644
--- a/arch/arm/plat-samsung/dev-nand.c
+++ b/arch/arm/plat-samsung/dev-nand.c
@@ -70,7 +70,7 @@ static int __init s3c_nand_copy_set(struct s3c2410_nand_set *set)
 
 	if (set->ecc_layout) {
 		ptr = kmemdup(set->ecc_layout,
-			      sizeof(struct nand_ecclayout), GFP_KERNEL);
+			      sizeof(*set->ecc_layout), GFP_KERNEL);
 		set->ecc_layout = ptr;
 
 		if (!ptr)
diff --git a/arch/arm/plat-samsung/include/plat/nand.h b/arch/arm/plat-samsung/include/plat/nand.h
index b64115f..49dedc9 100644
--- a/arch/arm/plat-samsung/include/plat/nand.h
+++ b/arch/arm/plat-samsung/include/plat/nand.h
@@ -38,7 +38,7 @@ struct s3c2410_nand_set {
 	char			*name;
 	int			*nr_map;
 	struct mtd_partition	*partitions;
-	struct nand_ecclayout	*ecc_layout;
+	struct nand_ecclayout_l	*ecc_layout;
 };
 
 struct s3c2410_platform_nand {
diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index c27e65e..992efa3 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -464,6 +464,39 @@ static int mtd_do_readoob(struct mtd_info *mtd, uint64_t start,
 	return ret;
 }
 
+/*
+ * Copies (and truncates, if necessary) data from the larger struct,
+ * nand_ecclayout_l, to the smaller, deprecated layout struct,
+ * nand_ecclayout. This is necessary only to suppport the deprecated
+ * API ioctl ECCGETLAYOUT while allowing all new functionality to use
+ * nand_ecclayout_l flexibly (i.e. the struct may change size in new
+ * releases without requiring major rewrites).
+ */
+static int shrink_ecclayout(const struct nand_ecclayout_l *from,
+		struct nand_ecclayout *to)
+{
+	int i;
+
+	if (!from || !to)
+		return -EINVAL;
+
+	memset(to, 0, sizeof(*to));
+
+	to->eccbytes = min((int)from->eccbytes, MTD_MAX_ECCPOS_ENTRIES_OLD);
+	for (i = 0; i < to->eccbytes; i++)
+		to->eccpos[i] = from->eccpos[i];
+
+	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES; i++) {
+		if (from->oobfree[i].length == 0 &&
+				from->oobfree[i].offset == 0)
+			break;
+		to->oobavail += from->oobfree[i].length;
+		to->oobfree[i] = from->oobfree[i];
+	}
+
+	return 0;
+}
+
 static int mtd_ioctl(struct inode *inode, struct file *file,
 		     u_int cmd, u_long arg)
 {
@@ -800,14 +833,23 @@ static int mtd_ioctl(struct inode *inode, struct file *file,
 	}
 #endif
 
+	/* This ioctl is being deprecated - it truncates the ecc layout */
 	case ECCGETLAYOUT:
 	{
+		struct nand_ecclayout *usrlay;
+
 		if (!mtd->ecclayout)
 			return -EOPNOTSUPP;
 
-		if (copy_to_user(argp, mtd->ecclayout,
-				 sizeof(struct nand_ecclayout)))
-			return -EFAULT;
+		usrlay = kmalloc(sizeof(*usrlay), GFP_KERNEL);
+		if (!usrlay)
+			return -ENOMEM;
+
+		shrink_ecclayout(mtd->ecclayout, usrlay);
+
+		if (copy_to_user(argp, usrlay, sizeof(struct nand_ecclayout)))
+			ret = -EFAULT;
+		kfree(usrlay);
 		break;
 	}
 
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index ccce0f0..6d856d9 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -64,7 +64,7 @@ module_param(on_flash_bbt, int, 0);
  * the bytes have to be consecutives to avoid
  * several NAND_CMD_RNDOUT during read
  */
-static struct nand_ecclayout atmel_oobinfo_large = {
+static struct nand_ecclayout_l atmel_oobinfo_large = {
 	.eccbytes = 4,
 	.eccpos = {60, 61, 62, 63},
 	.oobfree = {
@@ -77,7 +77,7 @@ static struct nand_ecclayout atmel_oobinfo_large = {
  * the bytes have to be consecutives to avoid
  * several NAND_CMD_RNDOUT during read
  */
-static struct nand_ecclayout atmel_oobinfo_small = {
+static struct nand_ecclayout_l atmel_oobinfo_small = {
 	.eccbytes = 4,
 	.eccpos = {0, 1, 2, 3},
 	.oobfree = {
diff --git a/drivers/mtd/nand/bcm_umi_bch.c b/drivers/mtd/nand/bcm_umi_bch.c
index a930666..63be36a 100644
--- a/drivers/mtd/nand/bcm_umi_bch.c
+++ b/drivers/mtd/nand/bcm_umi_bch.c
@@ -32,7 +32,7 @@ static void bcm_umi_bch_write_page_hwecc(struct mtd_info *mtd,
 ** nand_hw_eccoob
 ** New oob placement block for use with hardware ecc generation.
 */
-static struct nand_ecclayout nand_hw_eccoob_512 = {
+static struct nand_ecclayout_l nand_hw_eccoob_512 = {
 	/* Reserve 5 for BI indicator */
 	.oobfree = {
 #if (NAND_ECC_NUM_BYTES > 3)
@@ -48,7 +48,7 @@ static struct nand_ecclayout nand_hw_eccoob_512 = {
 ** We treat the OOB for a 2K page as if it were 4 512 byte oobs,
 ** except the BI is at byte 0.
 */
-static struct nand_ecclayout nand_hw_eccoob_2048 = {
+static struct nand_ecclayout_l nand_hw_eccoob_2048 = {
 	/* Reserve 0 as BI indicator */
 	.oobfree = {
 #if (NAND_ECC_NUM_BYTES > 10)
@@ -69,7 +69,7 @@ static struct nand_ecclayout nand_hw_eccoob_2048 = {
 
 /* We treat the OOB for a 4K page as if it were 8 512 byte oobs,
  * except the BI is at byte 0. */
-static struct nand_ecclayout nand_hw_eccoob_4096 = {
+static struct nand_ecclayout_l nand_hw_eccoob_4096 = {
 	/* Reserve 0 as BI indicator */
 	.oobfree = {
 #if (NAND_ECC_NUM_BYTES > 10)
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index a382e3d..3752541 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -119,7 +119,7 @@ static struct nand_bbt_descr bootrom_bbt = {
 	.pattern = bbt_pattern,
 };
 
-static struct nand_ecclayout bootrom_ecclayout = {
+static struct nand_ecclayout_l bootrom_ecclayout = {
 	.eccbytes = 24,
 	.eccpos = {
 		0x8 * 0, 0x8 * 0 + 1, 0x8 * 0 + 2,
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index db1dfc5..d989627 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -457,7 +457,7 @@ static int cafe_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	return 0;
 }
 
-static struct nand_ecclayout cafe_oobinfo_2048 = {
+static struct nand_ecclayout_l cafe_oobinfo_2048 = {
 	.eccbytes = 14,
 	.eccpos = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13},
 	.oobfree = {{14, 50}}
@@ -492,7 +492,7 @@ static struct nand_bbt_descr cafe_bbt_mirror_descr_2048 = {
 	.pattern = cafe_mirror_pattern_2048
 };
 
-static struct nand_ecclayout cafe_oobinfo_512 = {
+static struct nand_ecclayout_l cafe_oobinfo_512 = {
 	.eccbytes = 14,
 	.eccpos = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13},
 	.oobfree = {{14, 2}}
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 2ac7367..c0141b1 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -55,7 +55,7 @@
 struct davinci_nand_info {
 	struct mtd_info		mtd;
 	struct nand_chip	chip;
-	struct nand_ecclayout	ecclayout;
+	struct nand_ecclayout_l	ecclayout;
 
 	struct device		*dev;
 	struct clk		*clk;
@@ -514,7 +514,7 @@ static void __init nand_dm6446evm_flash_init(struct davinci_nand_info *info)
  * ten ECC bytes plus the manufacturer's bad block marker byte, and
  * and not overlapping the default BBT markers.
  */
-static struct nand_ecclayout hwecc4_small __initconst = {
+static struct nand_ecclayout_l hwecc4_small __initconst = {
 	.eccbytes = 10,
 	.eccpos = { 0, 1, 2, 3, 4,
 		/* offset 5 holds the badblock marker */
@@ -530,7 +530,7 @@ static struct nand_ecclayout hwecc4_small __initconst = {
  * storing ten ECC bytes plus the manufacturer's bad block marker byte,
  * and not overlapping the default BBT markers.
  */
-static struct nand_ecclayout hwecc4_2048 __initconst = {
+static struct nand_ecclayout_l hwecc4_2048 __initconst = {
 	.eccbytes = 40,
 	.eccpos = {
 		/* at the end of spare sector */
@@ -745,10 +745,13 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
 		}
 
 		/* 4KiB page chips are not yet supported. The eccpos from
-		 * nand_ecclayout cannot hold 80 bytes and change to eccpos[]
+		 * nand_ecclayout_l cannot hold 80 bytes and change to eccpos[]
 		 * breaks userspace ioctl interface with mtd-utils. Once we
 		 * resolve this issue, NAND_ECC_HW_OOB_FIRST mode can be used
 		 * for the 4KiB page chips.
+		 *
+		 * TODO: Note that nand_ecclayout_l has been introduced to
+		 *   replace nand_ecclayout and can hold plenty of OOB entries.
 		 */
 		dev_warn(&pdev->dev, "no 4-bit ECC support yet "
 				"for 4KiB-page NAND\n");
diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index 51315f5..5d29d6a 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -1051,7 +1051,7 @@ static int doc200x_correct_data(struct mtd_info *mtd, u_char *dat,
  * safer.  The only problem with it is that any code that parses oobfree must
  * be able to handle out-of-order segments.
  */
-static struct nand_ecclayout doc200x_oobinfo = {
+static struct nand_ecclayout_l doc200x_oobinfo = {
 	.eccbytes = 6,
 	.eccpos = {0, 1, 2, 3, 4, 5},
 	.oobfree = {{8, 8}, {6, 2}}
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 3f38fb8..b88a078 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -85,28 +85,28 @@ struct fsl_elbc_ctrl {
 /* These map to the positions used by the FCM hardware ECC generator */
 
 /* Small Page FLASH with FMR[ECCM] = 0 */
-static struct nand_ecclayout fsl_elbc_oob_sp_eccm0 = {
+static struct nand_ecclayout_l fsl_elbc_oob_sp_eccm0 = {
 	.eccbytes = 3,
 	.eccpos = {6, 7, 8},
 	.oobfree = { {0, 5}, {9, 7} },
 };
 
 /* Small Page FLASH with FMR[ECCM] = 1 */
-static struct nand_ecclayout fsl_elbc_oob_sp_eccm1 = {
+static struct nand_ecclayout_l fsl_elbc_oob_sp_eccm1 = {
 	.eccbytes = 3,
 	.eccpos = {8, 9, 10},
 	.oobfree = { {0, 5}, {6, 2}, {11, 5} },
 };
 
 /* Large Page FLASH with FMR[ECCM] = 0 */
-static struct nand_ecclayout fsl_elbc_oob_lp_eccm0 = {
+static struct nand_ecclayout_l fsl_elbc_oob_lp_eccm0 = {
 	.eccbytes = 12,
 	.eccpos = {6, 7, 8, 22, 23, 24, 38, 39, 40, 54, 55, 56},
 	.oobfree = { {1, 5}, {9, 13}, {25, 13}, {41, 13}, {57, 7} },
 };
 
 /* Large Page FLASH with FMR[ECCM] = 1 */
-static struct nand_ecclayout fsl_elbc_oob_lp_eccm1 = {
+static struct nand_ecclayout_l fsl_elbc_oob_lp_eccm1 = {
 	.eccbytes = 12,
 	.eccpos = {8, 9, 10, 24, 25, 26, 40, 41, 42, 56, 57, 58},
 	.oobfree = { {1, 7}, {11, 13}, {27, 13}, {43, 13}, {59, 5} },
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 3657a6e..fddddaa 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -165,13 +165,13 @@ struct mxc_nand_host {
 };
 
 /* OOB placement block for use with hardware ecc generation */
-static struct nand_ecclayout nandv1_hw_eccoob_smallpage = {
+static struct nand_ecclayout_l nandv1_hw_eccoob_smallpage = {
 	.eccbytes = 5,
 	.eccpos = {6, 7, 8, 9, 10},
 	.oobfree = {{0, 5}, {12, 4}, }
 };
 
-static struct nand_ecclayout nandv1_hw_eccoob_largepage = {
+static struct nand_ecclayout_l nandv1_hw_eccoob_largepage = {
 	.eccbytes = 20,
 	.eccpos = {6, 7, 8, 9, 10, 22, 23, 24, 25, 26,
 		   38, 39, 40, 41, 42, 54, 55, 56, 57, 58},
@@ -179,7 +179,7 @@ static struct nand_ecclayout nandv1_hw_eccoob_largepage = {
 };
 
 /* OOB description for 512 byte pages with 16 byte OOB */
-static struct nand_ecclayout nandv2_hw_eccoob_smallpage = {
+static struct nand_ecclayout_l nandv2_hw_eccoob_smallpage = {
 	.eccbytes = 1 * 9,
 	.eccpos = {
 		 7,  8,  9, 10, 11, 12, 13, 14, 15
@@ -190,7 +190,7 @@ static struct nand_ecclayout nandv2_hw_eccoob_smallpage = {
 };
 
 /* OOB description for 2048 byte pages with 64 byte OOB */
-static struct nand_ecclayout nandv2_hw_eccoob_largepage = {
+static struct nand_ecclayout_l nandv2_hw_eccoob_largepage = {
 	.eccbytes = 4 * 9,
 	.eccpos = {
 		 7,  8,  9, 10, 11, 12, 13, 14, 15,
@@ -956,7 +956,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	struct mxc_nand_host *host;
 	struct resource *res;
 	int err = 0, nr_parts = 0;
-	struct nand_ecclayout *oob_smallpage, *oob_largepage;
+	struct nand_ecclayout_l *oob_smallpage, *oob_largepage;
 
 	/* Allocate memory for MTD device structure and private data */
 	host = kzalloc(sizeof(struct mxc_nand_host) + NAND_MAX_PAGESIZE +
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index ee6a6f8..a7bfaa4 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -53,7 +53,7 @@
 #endif
 
 /* Define default oob placement schemes for large and small page devices */
-static struct nand_ecclayout nand_oob_8 = {
+static struct nand_ecclayout_l nand_oob_8 = {
 	.eccbytes = 3,
 	.eccpos = {0, 1, 2},
 	.oobfree = {
@@ -63,7 +63,7 @@ static struct nand_ecclayout nand_oob_8 = {
 		 .length = 2}}
 };
 
-static struct nand_ecclayout nand_oob_16 = {
+static struct nand_ecclayout_l nand_oob_16 = {
 	.eccbytes = 6,
 	.eccpos = {0, 1, 2, 3, 6, 7},
 	.oobfree = {
@@ -71,7 +71,7 @@ static struct nand_ecclayout nand_oob_16 = {
 		 . length = 8}}
 };
 
-static struct nand_ecclayout nand_oob_64 = {
+static struct nand_ecclayout_l nand_oob_64 = {
 	.eccbytes = 24,
 	.eccpos = {
 		   40, 41, 42, 43, 44, 45, 46, 47,
@@ -82,7 +82,7 @@ static struct nand_ecclayout nand_oob_64 = {
 		 .length = 38}}
 };
 
-static struct nand_ecclayout nand_oob_128 = {
+static struct nand_ecclayout_l nand_oob_128 = {
 	.eccbytes = 48,
 	.eccpos = {
 		   80, 81, 82, 83, 84, 85, 86, 87,
diff --git a/drivers/mtd/nand/nomadik_nand.c b/drivers/mtd/nand/nomadik_nand.c
index 8c0b693..ed5f2ba 100644
--- a/drivers/mtd/nand/nomadik_nand.c
+++ b/drivers/mtd/nand/nomadik_nand.c
@@ -45,7 +45,7 @@ struct nomadik_nand_host {
 	struct nand_bbt_descr *bbt_desc;
 };
 
-static struct nand_ecclayout nomadik_ecc_layout = {
+static struct nand_ecclayout_l nomadik_ecc_layout = {
 	.eccbytes = 3 * 4,
 	.eccpos = { /* each subpage has 16 bytes: pos 2,3,4 hosts ECC */
 		0x02, 0x03, 0x04,
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index e02fa4f..ecb3742 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1159,13 +1159,13 @@ static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
 	return 0;
 }
 
-static struct nand_ecclayout hw_smallpage_ecclayout = {
+static struct nand_ecclayout_l hw_smallpage_ecclayout = {
 	.eccbytes = 6,
 	.eccpos = {8, 9, 10, 11, 12, 13 },
 	.oobfree = { {2, 6} }
 };
 
-static struct nand_ecclayout hw_largepage_ecclayout = {
+static struct nand_ecclayout_l hw_largepage_ecclayout = {
 	.eccbytes = 24,
 	.eccpos = {
 		40, 41, 42, 43, 44, 45, 46, 47,
diff --git a/drivers/mtd/nand/rtc_from4.c b/drivers/mtd/nand/rtc_from4.c
index a033c4c..0c28637 100644
--- a/drivers/mtd/nand/rtc_from4.c
+++ b/drivers/mtd/nand/rtc_from4.c
@@ -141,7 +141,7 @@ static struct rs_control *rs_decoder;
 /*
  *      hardware specific Out Of Band information
  */
-static struct nand_ecclayout rtc_from4_nand_oobinfo = {
+static struct nand_ecclayout_l rtc_from4_nand_oobinfo = {
 	.eccbytes = 32,
 	.eccpos = {
 		   0, 1, 2, 3, 4, 5, 6, 7,
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 33d832d..d18fc6d 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -64,7 +64,7 @@ static const int clock_stop = 0;
 /* new oob placement block for use with hardware ecc generation
  */
 
-static struct nand_ecclayout nand_hw_eccoob = {
+static struct nand_ecclayout_l nand_hw_eccoob = {
 	.eccbytes = 3,
 	.eccpos = {0, 1, 2},
 	.oobfree = {{8, 8}}
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 546c2f0..91d67bc 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -33,7 +33,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/sh_flctl.h>
 
-static struct nand_ecclayout flctl_4secc_oob_16 = {
+static struct nand_ecclayout_l flctl_4secc_oob_16 = {
 	.eccbytes = 10,
 	.eccpos = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
 	.oobfree = {
@@ -41,7 +41,7 @@ static struct nand_ecclayout flctl_4secc_oob_16 = {
 		. length = 4} },
 };
 
-static struct nand_ecclayout flctl_4secc_oob_64 = {
+static struct nand_ecclayout_l flctl_4secc_oob_64 = {
 	.eccbytes = 10,
 	.eccpos = {48, 49, 50, 51, 52, 53, 54, 55, 56, 57},
 	.oobfree = {
diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index a2bb520..dcb9683 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -69,7 +69,7 @@ MODULE_PARM_DESC(otp,	"Corresponding behaviour of OneNAND in OTP"
  *  onenand_oob_128 - oob info for Flex-Onenand with 4KB page
  *  For now, we expose only 64 out of 80 ecc bytes
  */
-static struct nand_ecclayout onenand_oob_128 = {
+static struct nand_ecclayout_l onenand_oob_128 = {
 	.eccbytes	= 64,
 	.eccpos		= {
 		6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
@@ -89,7 +89,7 @@ static struct nand_ecclayout onenand_oob_128 = {
 /**
  * onenand_oob_64 - oob info for large (2KB) page
  */
-static struct nand_ecclayout onenand_oob_64 = {
+static struct nand_ecclayout_l onenand_oob_64 = {
 	.eccbytes	= 20,
 	.eccpos		= {
 		8, 9, 10, 11, 12,
@@ -106,7 +106,7 @@ static struct nand_ecclayout onenand_oob_64 = {
 /**
  * onenand_oob_32 - oob info for middle (1KB) page
  */
-static struct nand_ecclayout onenand_oob_32 = {
+static struct nand_ecclayout_l onenand_oob_32 = {
 	.eccbytes	= 10,
 	.eccpos		= {
 		8, 9, 10, 11, 12,
diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index 07ee154..e639133 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -1145,7 +1145,7 @@ int jffs2_write_nand_badblock(struct jffs2_sb_info *c, struct jffs2_eraseblock *
 
 int jffs2_nand_flash_setup(struct jffs2_sb_info *c)
 {
-	struct nand_ecclayout *oinfo = c->mtd->ecclayout;
+	struct nand_ecclayout_l *oinfo = c->mtd->ecclayout;
 
 	if (!c->mtd->oobsize)
 		return 0;
diff --git a/include/linux/mtd/inftl.h b/include/linux/mtd/inftl.h
index 64ee53c..9e3a43e 100644
--- a/include/linux/mtd/inftl.h
+++ b/include/linux/mtd/inftl.h
@@ -44,7 +44,7 @@ struct INFTLrecord {
         unsigned int nb_blocks;		/* number of physical blocks */
         unsigned int nb_boot_blocks;	/* number of blocks used by the bios */
         struct erase_info instr;
-        struct nand_ecclayout oobinfo;
+	struct nand_ecclayout_l oobinfo;
 };
 
 int INFTL_mount(struct INFTLrecord *s);
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 43b7d72..b60da00 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -98,6 +98,21 @@ struct mtd_oob_ops {
 	uint8_t		*oobbuf;
 };
 
+#define MTD_MAX_OOBFREE_ENTRIES_LARGE	32
+#define MTD_MAX_ECCPOS_ENTRIES_LARGE	448
+#define MTD_MAX_ECCPOS_ENTRIES_OLD	64	/* Previous maximum */
+/*
+ * Correct ECC layout control structure. This replaces old nand_ecclayout
+ * that is exported via ECCGETLAYOUT ioctll. It should be expandable in the
+ * future simply by the above macros.
+ */
+struct nand_ecclayout_l {
+	__u32 eccbytes;
+	__u32 eccpos[MTD_MAX_ECCPOS_ENTRIES_LARGE];
+	__u32 oobavail;
+	struct nand_oobfree oobfree[MTD_MAX_OOBFREE_ENTRIES_LARGE];
+};
+
 struct mtd_info {
 	u_char type;
 	uint32_t flags;
@@ -135,7 +150,7 @@ struct mtd_info {
 	int index;
 
 	/* ecc layout structure pointer - read only ! */
-	struct nand_ecclayout *ecclayout;
+	struct nand_ecclayout_l *ecclayout;
 
 	/* Data for variable erase regions. If numeraseregions is zero,
 	 * it means that the whole device has erasesize as given above.
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 50f3aa0..adc081f 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -270,7 +270,7 @@ struct nand_ecc_ctrl {
 	int			total;
 	int			prepad;
 	int			postpad;
-	struct nand_ecclayout	*layout;
+	struct nand_ecclayout_l	*layout;
 	void			(*hwctl)(struct mtd_info *mtd, int mode);
 	int			(*calculate)(struct mtd_info *mtd,
 					     const uint8_t *dat,
@@ -415,7 +415,7 @@ struct nand_chip {
 
 	uint8_t		*oob_poi;
 	struct nand_hw_control  *controller;
-	struct nand_ecclayout	*ecclayout;
+	struct nand_ecclayout_l	*ecclayout;
 
 	struct nand_ecc_ctrl ecc;
 	struct nand_buffers *buffers;
@@ -506,7 +506,7 @@ struct platform_nand_chip {
 	int			chip_offset;
 	int			nr_partitions;
 	struct mtd_partition	*partitions;
-	struct nand_ecclayout	*ecclayout;
+	struct nand_ecclayout_l	*ecclayout;
 	int			chip_delay;
 	unsigned int		options;
 	const char		**part_probe_types;
diff --git a/include/linux/mtd/nftl.h b/include/linux/mtd/nftl.h
index dcaf611..1d0839f 100644
--- a/include/linux/mtd/nftl.h
+++ b/include/linux/mtd/nftl.h
@@ -35,7 +35,7 @@ struct NFTLrecord {
         unsigned int nb_blocks;		/* number of physical blocks */
         unsigned int nb_boot_blocks;	/* number of blocks used by the bios */
         struct erase_info instr;
-	struct nand_ecclayout oobinfo;
+	struct nand_ecclayout_l oobinfo;
 };
 
 int NFTL_mount(struct NFTLrecord *s);
diff --git a/include/linux/mtd/onenand.h b/include/linux/mtd/onenand.h
index 0c8815b..c946ec6 100644
--- a/include/linux/mtd/onenand.h
+++ b/include/linux/mtd/onenand.h
@@ -132,7 +132,7 @@ struct onenand_chip {
 #endif
 
 	int			subpagesize;
-	struct nand_ecclayout	*ecclayout;
+	struct nand_ecclayout_l	*ecclayout;
 
 	void			*bbm;
 
diff --git a/include/linux/mtd/partitions.h b/include/linux/mtd/partitions.h
index 274b619..ae390d5 100644
--- a/include/linux/mtd/partitions.h
+++ b/include/linux/mtd/partitions.h
@@ -39,7 +39,7 @@ struct mtd_partition {
 	uint64_t size;			/* partition size */
 	uint64_t offset;		/* offset within the master MTD space */
 	uint32_t mask_flags;		/* master MTD flags to mask out for this partition */
-	struct nand_ecclayout *ecclayout;	/* out of band layout for this partition (NAND only)*/
+	struct nand_ecclayout_l *ecclayout;	/* out of band layout for this partition (NAND only) */
 };
 
 #define MTDPART_OFS_NXTBLK	(-2)
diff --git a/include/linux/mtd/sharpsl.h b/include/linux/mtd/sharpsl.h
index 25f4d2a..15fa381 100644
--- a/include/linux/mtd/sharpsl.h
+++ b/include/linux/mtd/sharpsl.h
@@ -14,7 +14,7 @@
 
 struct sharpsl_nand_platform_data {
 	struct nand_bbt_descr	*badblock_pattern;
-	struct nand_ecclayout	*ecc_layout;
+	struct nand_ecclayout_l	*ecc_layout;
 	struct mtd_partition	*partitions;
 	unsigned int		nr_partitions;
 };
-- 
1.7.0.4
