From: lkp@intel.com (kbuild test robot)
Date: Wed, 13 Sep 2017 09:20:23 +0800
Subject: [PATCH 1/2] mtd: nand: introduce NAND_ROW_ADDR_3 flag
In-Reply-To: <1505183851-29355-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <201709130930.GFsddrbW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

[auto build test ERROR on l2-mtd-boris/nand/next]
[also build test ERROR on v4.13 next-20170912]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/mtd-nand-introduce-NAND_ROW_ADDR_3-flag-and-improve-Denali-driver/20170913-084354
base:   git://git.infradead.org/l2-mtd.git nand/next
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/mtd/nand/hisi504_nand.c: In function 'set_addr':
>> drivers/mtd/nand/hisi504_nand.c:435:13: error: expected identifier before '->' token
      if (chip->->options & NAND_ROW_ADDR_3) {
                ^

vim +435 drivers/mtd/nand/hisi504_nand.c

   410	
   411	static void set_addr(struct mtd_info *mtd, int column, int page_addr)
   412	{
   413		struct nand_chip *chip = mtd_to_nand(mtd);
   414		struct hinfc_host *host = nand_get_controller_data(chip);
   415		unsigned int command = host->command;
   416	
   417		host->addr_cycle    = 0;
   418		host->addr_value[0] = 0;
   419		host->addr_value[1] = 0;
   420	
   421		/* Serially input address */
   422		if (column != -1) {
   423			/* Adjust columns for 16 bit buswidth */
   424			if (chip->options & NAND_BUSWIDTH_16 &&
   425					!nand_opcode_8bits(command))
   426				column >>= 1;
   427	
   428			host->addr_value[0] = column & 0xffff;
   429			host->addr_cycle    = 2;
   430		}
   431		if (page_addr != -1) {
   432			host->addr_value[0] |= (page_addr & 0xffff)
   433				<< (host->addr_cycle * 8);
   434			host->addr_cycle    += 2;
 > 435			if (chip->->options & NAND_ROW_ADDR_3) {
   436				host->addr_cycle += 1;
   437				if (host->command == NAND_CMD_ERASE1)
   438					host->addr_value[0] |= ((page_addr >> 16) & 0xff) << 16;
   439				else
   440					host->addr_value[1] |= ((page_addr >> 16) & 0xff);
   441			}
   442		}
   443	}
   444	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51034 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170913/25860ab6/attachment-0001.gz>
