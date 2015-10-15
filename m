From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Oct 2015 17:12:18 +0800
Subject: [PATCH v3 1/4] mtd: nand: allow compile test of MTD_NAND_PXA3xx
In-Reply-To: <1444893451-16610-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <201510151736.7t9qDlAe%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

[auto build test ERROR on mtd/master -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Antoine-Tenart/mtd-pxa3xx_nand-rework-the-timing-setup/20151015-152337
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/mtd/nand/pxa3xx_nand.c: In function 'drain_fifo':
>> drivers/mtd/nand/pxa3xx_nand.c:507:4: error: implicit declaration of function 'readsl' [-Werror=implicit-function-declaration]
       readsl(info->mmio_base + NDDB, data, 8);
       ^
   drivers/mtd/nand/pxa3xx_nand.c: In function 'handle_data_pio':
>> drivers/mtd/nand/pxa3xx_nand.c:531:3: error: implicit declaration of function 'writesl' [-Werror=implicit-function-declaration]
      writesl(info->mmio_base + NDDB,
      ^
   cc1: some warnings being treated as errors

vim +/readsl +507 drivers/mtd/nand/pxa3xx_nand.c

8dad0386 Maxime Ripard   2015-02-18  501  		 * have to make sure that the NDSR.RDDREQ bit is set.
8dad0386 Maxime Ripard   2015-02-18  502  		 *
8dad0386 Maxime Ripard   2015-02-18  503  		 * Drain the FIFO 8 32 bits reads at a time, and skip
8dad0386 Maxime Ripard   2015-02-18  504  		 * the polling on the last read.
8dad0386 Maxime Ripard   2015-02-18  505  		 */
8dad0386 Maxime Ripard   2015-02-18  506  		while (len > 8) {
ce914e6b Rob Herring     2015-04-30 @507  			readsl(info->mmio_base + NDDB, data, 8);
8dad0386 Maxime Ripard   2015-02-18  508  
afca11ec Maxime Ripard   2015-04-07  509  			ret = readl_relaxed_poll_timeout(info->mmio_base + NDSR, val,
afca11ec Maxime Ripard   2015-04-07  510  							 val & NDSR_RDDREQ, 1000, 5000);
afca11ec Maxime Ripard   2015-04-07  511  			if (ret) {
8dad0386 Maxime Ripard   2015-02-18  512  				dev_err(&info->pdev->dev,
8dad0386 Maxime Ripard   2015-02-18  513  					"Timeout on RDDREQ while draining the FIFO\n");
8dad0386 Maxime Ripard   2015-02-18  514  				return;
8dad0386 Maxime Ripard   2015-02-18  515  			}
8dad0386 Maxime Ripard   2015-02-18  516  
8dad0386 Maxime Ripard   2015-02-18  517  			data += 32;
8dad0386 Maxime Ripard   2015-02-18  518  			len -= 8;
8dad0386 Maxime Ripard   2015-02-18  519  		}
8dad0386 Maxime Ripard   2015-02-18  520  	}
8dad0386 Maxime Ripard   2015-02-18  521  
ce914e6b Rob Herring     2015-04-30  522  	readsl(info->mmio_base + NDDB, data, len);
8dad0386 Maxime Ripard   2015-02-18  523  }
8dad0386 Maxime Ripard   2015-02-18  524  
f8155a40 Lei Wen         2011-02-28  525  static void handle_data_pio(struct pxa3xx_nand_info *info)
fe69af00 eric miao       2008-02-14  526  {
70ed8523 Ezequiel Garcia 2013-11-14  527  	unsigned int do_bytes = min(info->data_size, info->chunk_size);
fa543bef Ezequiel Garcia 2013-11-14  528  
fe69af00 eric miao       2008-02-14  529  	switch (info->state) {
fe69af00 eric miao       2008-02-14  530  	case STATE_PIO_WRITING:
ce914e6b Rob Herring     2015-04-30 @531  		writesl(info->mmio_base + NDDB,
fa543bef Ezequiel Garcia 2013-11-14  532  			info->data_buff + info->data_buff_pos,
fa543bef Ezequiel Garcia 2013-11-14  533  			DIV_ROUND_UP(do_bytes, 4));
fa543bef Ezequiel Garcia 2013-11-14  534  

:::::: The code at line 507 was first introduced by commit
:::::: ce914e6b2658b9f1773ff57b3d45682a7ca4552f mtd: nand: pxa3xx: fix build on ARM64

:::::: TO: Rob Herring <robh@kernel.org>
:::::: CC: Brian Norris <computersforpeace@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51507 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151015/4b9e0ca9/attachment-0001.obj>
