From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 25 May 2017 08:17:47 +0200
Subject: pxa3xx-nand failing to find device on linux-next
In-Reply-To: <69dfc0d5ca774efb8c92e9ec635f68ec@svr-chch-ex1.atlnz.lc>
References: <b36366e358904310aee4970b77f57dba@svr-chch-ex1.atlnz.lc>
 <2a79405e219b4c37ba00defbe4a0dfe4@svr-chch-ex1.atlnz.lc>
 <20170524132301.12ad33d8@bbrezillon>
 <20170524132508.420614c7@bbrezillon>
 <ebe9d9bca4754d1ba920295f2fdd1359@svr-chch-ex1.atlnz.lc>
 <20170525003646.276516d0@bbrezillon>
 <69dfc0d5ca774efb8c92e9ec635f68ec@svr-chch-ex1.atlnz.lc>
Message-ID: <20170525081747.4c86164c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 24 May 2017 22:58:53 +0000,
Chris Packham <Chris.Packham@alliedtelesis.co.nz> a ?crit :

> On 25/05/17 10:36, Boris Brezillon wrote:
> > Le Wed, 24 May 2017 22:03:52 +0000,
> > Chris Packham <Chris.Packham@alliedtelesis.co.nz> a ?crit :
> >   
> >> On 24/05/17 23:25, Boris Brezillon wrote:  
> >>> On Wed, 24 May 2017 13:23:01 +0200
> >>> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> >>>      
> >>>> Hi Chris,
> >>>>
> >>>> On Wed, 24 May 2017 09:36:56 +0000
> >>>> Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:
> >>>>     
> >>>>> On 23/05/17 17:27, Chris Packham wrote:  
> >>>>>> Hi,
> >>>>>>
> >>>>>> I'm doing some testing on linux-next and I'm finding that my nand flash
> >>>>>> has disappeared.
> >>>>>>
> >>>>>> pxa3xx-nand f10d0000.flash: This platform can't do DMA on this device
> >>>>>> pxa3xx-nand f10d0000.flash: non-supported command ef
> >>>>>> pxa3xx-nand f10d0000.flash: non-supported command ee
> >>>>>> pxa3xx-nand f10d0000.flash: non-supported command ef
> >>>>>> pxa3xx-nand f10d0000.flash: non-supported command ee
> >>>>>> On-die ECC forcefully enabled, not supported
> >>>>>> nand: No NAND device found
> >>>>>> pxa3xx-nand f10d0000.flash: failed to scan nand at cs 0
> >>>>>>
> >>>>>> This was working around 4.11. I'll try to do some more digging tomorrow
> >>>>>> to narrow down a failure point but I thought I'd send this out now just
> >>>>>> in case it rings any bells.
> >>>>>>
> >>>>>> The board I'm using (DB-88F6820-AMC) is unfortunately out-of tree but it
> >>>>>> should be pretty close to the armada-388-db. I can make my dts available
> >>>>>> if it's helpful.  
> >>>>>
> >>>>> Still works on 4.12-rc2. Fails on next-20170524.
> >>>>>
> >>>>> This appears to be due to commit b566d9c055de ("mtd: nand: add support
> >>>>> for Micron on-die ECC"). Which based on the description seems intentional.
> >>>>>
> >>>>> Since I have access to a hardware platform that has a micron flash with
> >>>>> ECC forcefully enabled how can I help to get this implemented.  
> >>>>
> >>>> Can you try with this patch applied [1]?  
> >>>
> >>> Sorry, wrong patch. Can you try this one [1] instead?
> >>>
> >>> [1]http://code.bulix.org/pkfhmi-135875
> >>>      
> >>
> >> With the patch above the chip is detected but ubifs is unhappy  
> > 
> > Hm, weird. And if you revert my both Thomas patch and mine, what do you
> > get?  
> 
> Seems to work just fine.

Okay. Let's try with something simpler then. Can you test the following
patch?

--->8---
>From 0a0eaa39ea9b19191ae0c31ff3625c224a8a55f2 Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Thu, 25 May 2017 08:15:15 +0200
Subject: [PATCH] mtd: nand: pxa3xx: Implement failing
 ->onfi_{set,get}_features() stubs

Implement stubs returning -ENOTSUPP for ->onfi_{set,get}_features() so
that we don't let the core think we are supporting the GET/SET FEATURES
operation.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 649ba8200832..341a229046f5 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1649,6 +1649,13 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 	return 0;
 }
 
+static int pxa3xx_nand_get_set_features(struct mtd_info *mtd,
+					struct nand_chip *chip,
+					int feature_addr, u8 *subfeature_para)
+{
+	return -ENOTSUPP;
+}
+
 static int pxa3xx_nand_scan(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
@@ -1812,6 +1819,8 @@ static int alloc_nand_resource(struct platform_device *pdev)
 		chip->write_buf		= pxa3xx_nand_write_buf;
 		chip->options		|= NAND_NO_SUBPAGE_WRITE;
 		chip->cmdfunc		= nand_cmdfunc;
+		chip->onfi_set_features	= pxa3xx_nand_get_set_features;
+		chip->onfi_get_features	= pxa3xx_nand_get_set_features;
 	}
 
 	nand_hw_control_init(chip->controller);
-- 
2.11.0
