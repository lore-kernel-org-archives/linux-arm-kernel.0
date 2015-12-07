From: lkp@intel.com (kbuild test robot)
Date: Tue, 8 Dec 2015 07:36:44 +0800
Subject: [PATCH 12/23] mtd: use mtd_eccpos() and mtd_oobfree() where
 appropriate
In-Reply-To: <1449527178-5930-13-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <201512080741.Ff54iWvd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

[auto build test WARNING on next-20151207]
[cannot apply to staging/staging-testing v4.4-rc4 v4.4-rc3 v4.4-rc2 v4.4-rc4]

url:    https://github.com/0day-ci/linux/commits/Boris-Brezillon/mtd-rework-ECC-layout-definition/20151208-063127
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/nand_base.c:1607: warning: No description found for parameter 'mtd'
>> drivers/mtd/nand/nand_base.c:1607: warning: Excess function parameter 'chip' description in 'nand_transfer_oob'
>> drivers/mtd/nand/nand_base.c:1607: warning: No description found for parameter 'mtd'
>> drivers/mtd/nand/nand_base.c:1607: warning: Excess function parameter 'chip' description in 'nand_transfer_oob'

vim +/mtd +1607 drivers/mtd/nand/nand_base.c

7e4178f9 Vitaly Wool     2006-06-07  1591  	i = mtd->oobsize - (oob - chip->oob_poi);
f5bbdacc Thomas Gleixner 2006-05-25  1592  	if (i)
f5bbdacc Thomas Gleixner 2006-05-25  1593  		chip->read_buf(mtd, oob, i);
f5bbdacc Thomas Gleixner 2006-05-25  1594  
3f91e94f Mike Dunn       2012-04-25  1595  	return max_bitflips;
^1da177e Linus Torvalds  2005-04-16  1596  }
^1da177e Linus Torvalds  2005-04-16  1597  
f5bbdacc Thomas Gleixner 2006-05-25  1598  /**
7854d3f7 Brian Norris    2011-06-23  1599   * nand_transfer_oob - [INTERN] Transfer oob to client buffer
8593fbc6 Thomas Gleixner 2006-05-29  1600   * @chip: nand chip structure
844d3b42 Randy Dunlap    2006-06-28  1601   * @oob: oob destination address
8593fbc6 Thomas Gleixner 2006-05-29  1602   * @ops: oob ops structure
7014568b Vitaly Wool     2006-11-03  1603   * @len: size of oob to transfer
8593fbc6 Thomas Gleixner 2006-05-29  1604   */
64456fac Boris Brezillon 2015-12-07  1605  static uint8_t *nand_transfer_oob(struct mtd_info *mtd, uint8_t *oob,
7014568b Vitaly Wool     2006-11-03  1606  				  struct mtd_oob_ops *ops, size_t len)
8593fbc6 Thomas Gleixner 2006-05-29 @1607  {
64456fac Boris Brezillon 2015-12-07  1608  	struct nand_chip *chip = mtd->priv;
64456fac Boris Brezillon 2015-12-07  1609  
8593fbc6 Thomas Gleixner 2006-05-29  1610  	switch (ops->mode) {
8593fbc6 Thomas Gleixner 2006-05-29  1611  
0612b9dd Brian Norris    2011-08-30  1612  	case MTD_OPS_PLACE_OOB:
0612b9dd Brian Norris    2011-08-30  1613  	case MTD_OPS_RAW:
8593fbc6 Thomas Gleixner 2006-05-29  1614  		memcpy(oob, chip->oob_poi + ops->ooboffs, len);
8593fbc6 Thomas Gleixner 2006-05-29  1615  		return oob + len;

:::::: The code at line 1607 was first introduced by commit
:::::: 8593fbc68b0df1168995de76d1af38eb62fd6b62 [MTD] Rework the out of band handling completely

:::::: TO: Thomas Gleixner <tglx@cruncher.tec.linutronix.de>
:::::: CC: Thomas Gleixner <tglx@cruncher.tec.linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 6169 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151208/01d98f1a/attachment-0001.obj>
