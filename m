From: lkp@intel.com (kbuild test robot)
Date: Tue, 8 Dec 2015 06:48:53 +0800
Subject: [PATCH 12/23] mtd: use mtd_eccpos() and mtd_oobfree() where
 appropriate
In-Reply-To: <1449527178-5930-13-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <201512080642.2MUjuxx4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

[auto build test ERROR on next-20151207]
[cannot apply to staging/staging-testing v4.4-rc4 v4.4-rc3 v4.4-rc2 v4.4-rc4]

url:    https://github.com/0day-ci/linux/commits/Boris-Brezillon/mtd-rework-ECC-layout-definition/20151208-063127
config: i386-randconfig-x006-12070758 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from drivers/mtd/mtdswap.c:27:
   drivers/mtd/mtdswap.c: In function 'mtdswap_add_mtd':
>> drivers/mtd/mtdswap.c:1449:6: error: too few arguments to function 'mtd_oobfree'
     if (mtd_oobfree(mtd, 0) < 0) {
         ^
   include/linux/compiler.h:147:28: note: in definition of macro '__trace_if'
     if (__builtin_constant_p((cond)) ? !!(cond) :   \
                               ^
>> drivers/mtd/mtdswap.c:1449:2: note: in expansion of macro 'if'
     if (mtd_oobfree(mtd, 0) < 0) {
     ^
   In file included from drivers/mtd/mtdswap.c:29:0:
   include/linux/mtd/mtd.h:267:19: note: declared here
    static inline int mtd_oobfree(struct mtd_info *mtd, int section,
                      ^
   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from drivers/mtd/mtdswap.c:27:
>> drivers/mtd/mtdswap.c:1449:6: error: too few arguments to function 'mtd_oobfree'
     if (mtd_oobfree(mtd, 0) < 0) {
         ^
   include/linux/compiler.h:147:40: note: in definition of macro '__trace_if'
     if (__builtin_constant_p((cond)) ? !!(cond) :   \
                                           ^
>> drivers/mtd/mtdswap.c:1449:2: note: in expansion of macro 'if'
     if (mtd_oobfree(mtd, 0) < 0) {
     ^
   In file included from drivers/mtd/mtdswap.c:29:0:
   include/linux/mtd/mtd.h:267:19: note: declared here
    static inline int mtd_oobfree(struct mtd_info *mtd, int section,
                      ^
   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from drivers/mtd/mtdswap.c:27:
>> drivers/mtd/mtdswap.c:1449:6: error: too few arguments to function 'mtd_oobfree'
     if (mtd_oobfree(mtd, 0) < 0) {
         ^
   include/linux/compiler.h:158:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^
>> drivers/mtd/mtdswap.c:1449:2: note: in expansion of macro 'if'
     if (mtd_oobfree(mtd, 0) < 0) {
     ^
   In file included from drivers/mtd/mtdswap.c:29:0:
   include/linux/mtd/mtd.h:267:19: note: declared here
    static inline int mtd_oobfree(struct mtd_info *mtd, int section,
                      ^

vim +/mtd_oobfree +1449 drivers/mtd/mtdswap.c

  1443		if (PAGE_SIZE % mtd->writesize || mtd->writesize > PAGE_SIZE) {
  1444			printk(KERN_ERR "%s: PAGE_SIZE %lu not multiple of write size"
  1445				" %u\n", MTDSWAP_PREFIX, PAGE_SIZE, mtd->writesize);
  1446			return;
  1447		}
  1448	
> 1449		if (mtd_oobfree(mtd, 0) < 0) {
  1450			printk(KERN_ERR "%s: mtd%d does not have OOB\n",
  1451				MTDSWAP_PREFIX, mtd->index);
  1452			return;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 26343 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151208/5488955d/attachment-0001.obj>
