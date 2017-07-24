From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 25 Jul 2017 05:57:14 +0800
Subject: [xlnx:master 789/812] drivers/mtd/nand/arasan_nand.c:355:16:
 warning: right shift count >= width of type
Message-ID: <201707250511.3YFzeXiG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   5a5db6231107b7dbf97af0ae9a451d79e9d38203
commit: c66ee9b2e7c09629a109e942e9fa03f1a1c8ea47 [789/812] mtd: nand: arasan_nand: Add 64bit dma support
config: blackfin-allyesconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c66ee9b2e7c09629a109e942e9fa03f1a1c8ea47
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All warnings (new ones prefixed by >>):

   drivers/mtd/nand/arasan_nand.c: In function 'anfc_rw_buf_dma':
>> drivers/mtd/nand/arasan_nand.c:355:16: warning: right shift count >= width of type [-Wshift-count-overflow]
     writel((paddr >> 32), nfc->base + DMA_ADDR1_OFST);
                   ^~

vim +355 drivers/mtd/nand/arasan_nand.c

   323	
   324	static void anfc_rw_buf_dma(struct mtd_info *mtd, uint8_t *buf, int len,
   325				    int operation, u32 prog)
   326	{
   327		dma_addr_t paddr;
   328		struct nand_chip *chip = mtd_to_nand(mtd);
   329		struct anfc *nfc = to_anfc(chip->controller);
   330		struct anfc_nand_chip *achip = to_anfc_nand(chip);
   331		u32 eccintr = 0, dir;
   332		u32 pktsize = len, pktcount = 1;
   333	
   334		if ((nfc->curr_cmd == NAND_CMD_READ0) ||
   335			((nfc->curr_cmd == NAND_CMD_SEQIN) && !nfc->iswriteoob)) {
   336			pktsize = achip->pktsize;
   337			pktcount = DIV_ROUND_UP(mtd->writesize, pktsize);
   338		}
   339		anfc_setpktszcnt(nfc, pktsize, pktcount);
   340	
   341		if (!achip->bch && (nfc->curr_cmd == NAND_CMD_READ0))
   342			eccintr = MBIT_ERROR;
   343	
   344		if (operation)
   345			dir = DMA_FROM_DEVICE;
   346		else
   347			dir = DMA_TO_DEVICE;
   348	
   349		paddr = dma_map_single(nfc->dev, buf, len, dir);
   350		if (dma_mapping_error(nfc->dev, paddr)) {
   351			dev_err(nfc->dev, "Read buffer mapping error");
   352			return;
   353		}
   354		writel(paddr, nfc->base + DMA_ADDR0_OFST);
 > 355		writel((paddr >> 32), nfc->base + DMA_ADDR1_OFST);
   356		anfc_enable_intrs(nfc, (XFER_COMPLETE | eccintr));
   357		writel(prog, nfc->base + PROG_OFST);
   358		anfc_wait_for_event(nfc);
   359		dma_unmap_single(nfc->dev, paddr, len, dir);
   360	}
   361	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 42461 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/c65d872e/attachment-0001.gz>
