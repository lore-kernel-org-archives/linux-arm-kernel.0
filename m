From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 4 Dec 2013 11:41:47 -0300
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <20131204142009.GB2486@localhost>
References: <87zjopd240.fsf@natisbad.org> <87wqjtbm8r.fsf@natisbad.org>
 <20131128185040.GA13182@localhost> <87bo12kcyt.fsf@natisbad.org>
 <20131202103305.GB2466@localhost> <87siubneuf.fsf@natisbad.org>
 <20131203002225.GA5333@localhost> <87ob4xbs8l.fsf@natisbad.org>
 <87iov5aapx.fsf@natisbad.org> <20131204142009.GB2486@localhost>
Message-ID: <20131204144146.GC2486@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 11:20:09AM -0300, Ezequiel Garcia wrote:
> On Tue, Dec 03, 2013 at 10:25:14PM +0100, Arnaud Ebalard wrote:
[..]
> > Erasing failed write from 0x0a0000 to 0x0bffff
> > Writing data to block 6 at offset 0xc0000
> > [  451.115171] pxa3xx-nand d00d0000.nand: Ready time out!!!
> > libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 6, offset 2048)
> >         error 5 (Input/output error)
> > Erasing failed write from 0x0c0000 to 0x0dffff
> > Writing data to block 7 at offset 0xe0000
> > 
> > 
> 
> So, let me confirm this: you have systematically obtained a "Ready
> timeout" when writing to the device, on every single write to a page,
> correct?
> 
> I'll prepare a patch against the branch we're working that adds lots of
> pr_info(). It'll be very annoying for you, but it's the only way I can
> think of, to get the driver's dirty inner sequence and to see *where*
> is failing.
> 
[..]

And here's the patch, along with instructions...

commit cc7999a922bf3c09ddc65effb11de6fc5ea88b1c
Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date:   Wed Dec 4 11:27:04 2013 -0300

    mtd: nand: pxa3xx: Add debug messages
    
    Need CONFIG_DYNAMIC_DEBUG=y and then:
    
    $ mount -t debugfs debugfs /sys/kernel/debug/
    $ cd /sys/kernel/debug/dynamic_debug/
    $ echo "file drivers/mtd/nand/pxa3xx_nand.c +p" > control
    
    Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 038cf5d..1744599 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -616,6 +616,7 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	if (status & ready) {
 		info->state = STATE_READY;
 		is_ready = 1;
+		pr_debug("Status: ready\n");
 	}
 
 	if (status & NDSR_WRCMDREQ) {
@@ -631,6 +632,11 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 		 * Direct write access to NDCB1, NDCB2 and NDCB3 is ignored
 		 * but each NDCBx register can be read.
 		 */
+		pr_debug("Command0 0x%x\n", info->ndcb0);
+		pr_debug("Command1 0x%x\n", info->ndcb1);
+		pr_debug("Command2 0x%x\n", info->ndcb2);
+		pr_debug("Command3 0x%x\n", info->ndcb3);
+
 		nand_writel(info, NDCB0, info->ndcb0);
 		nand_writel(info, NDCB0, info->ndcb1);
 		nand_writel(info, NDCB0, info->ndcb2);
@@ -1154,6 +1160,7 @@ static int pxa3xx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
 	int ret;
 
 	if (info->need_wait) {
+		pr_debug("Waiting for device to be ready\n");
 		ret = wait_for_completion_timeout(&info->dev_ready,
 				CHIP_DELAY_TIMEOUT);
 		info->need_wait = 0;
@@ -1161,6 +1168,7 @@ static int pxa3xx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
 			dev_err(&info->pdev->dev, "Ready time out!!!\n");
 			return NAND_STATUS_FAIL;
 		}
+		pr_debug("Device is ready\n");
 	}
 
 	/* pxa3xx_nand_send_command has waited for command complete */
@@ -1468,6 +1476,10 @@ KEEP_CONFIG:
 	if (nand_scan_ident(mtd, 1, def))
 		return -ENODEV;
 
+	pr_info("Control  register dump 0x%x\n", info->reg_ndcr);
+	pr_info("Timing 0 register dump 0x%x\n", info->ndtr0cs0);
+	pr_info("Timing 1 register dump 0x%x\n", info->ndtr1cs0);
+
 	if (pdata->flash_bbt) {
 		/*
 		 * We'll use a bad block table stored in-flash and don't

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
