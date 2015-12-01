From: lkp@intel.com (kbuild test robot)
Date: Tue, 1 Dec 2015 20:28:44 +0800
Subject: [PATCH v2 12/25] mtd: nand: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1448967802-25796-13-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <201512012058.JdJjJKAX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

[auto build test ERROR on next-20151127]
[cannot apply to mtd/master v4.4-rc3 v4.4-rc2 v4.4-rc1 v4.4-rc3]

url:    https://github.com/0day-ci/linux/commits/Boris-Brezillon/mtd-nand-refactor-the-NAND-subsystem-part-1/20151201-190822
config: arm-imx_v6_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/mtd/nand/gpmi-nand/gpmi-nand.c: In function 'set_geometry_by_ecc_info':
>> drivers/mtd/nand/gpmi-nand/gpmi-nand.c:142:39: error: 'mtd' undeclared (first use in this function)
     struct nand_chip *chip = mtd_to_nand(mtd);
                                          ^
   drivers/mtd/nand/gpmi-nand/gpmi-nand.c:142:39: note: each undeclared identifier is reported only once for each function it appears in
   drivers/mtd/nand/gpmi-nand/gpmi-nand.c: In function 'gpmi_init_last':
   drivers/mtd/nand/gpmi-nand/gpmi-nand.c:1840:39: error: 'mtd' undeclared (first use in this function)
     struct nand_chip *chip = mtd_to_nand(mtd);
                                          ^
   drivers/mtd/nand/gpmi-nand/gpmi-nand.c:1841:19: warning: unused variable 'mtd' [-Wunused-variable]
     struct mtd_info *mtd = nand_to_mtd(chip);
                      ^

vim +/mtd +142 drivers/mtd/nand/gpmi-nand/gpmi-nand.c

2febcdf84 Huang Shijie    2013-05-17  136   *
2febcdf84 Huang Shijie    2013-05-17  137   * We may have available oob space in this case.
2febcdf84 Huang Shijie    2013-05-17  138   */
2febcdf84 Huang Shijie    2013-05-17  139  static bool set_geometry_by_ecc_info(struct gpmi_nand_data *this)
2febcdf84 Huang Shijie    2013-05-17  140  {
2febcdf84 Huang Shijie    2013-05-17  141  	struct bch_geometry *geo = &this->bch_geometry;
6bdedcfa5 Boris Brezillon 2015-12-01 @142  	struct nand_chip *chip = mtd_to_nand(mtd);
4864cfd67 Boris Brezillon 2015-12-01  143  	struct mtd_info *mtd = nand_to_mtd(chip);
2febcdf84 Huang Shijie    2013-05-17  144  	struct nand_oobfree *of = gpmi_hw_ecclayout.oobfree;
2febcdf84 Huang Shijie    2013-05-17  145  	unsigned int block_mark_bit_offset;

:::::: The code at line 142 was first introduced by commit
:::::: 6bdedcfa57b52f471682054a599855677b1b132c mtd: nand: make use of mtd_to_nand() in NAND drivers

:::::: TO: Boris Brezillon <boris.brezillon@free-electrons.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 28779 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/2e0d2169/attachment-0001.obj>
