From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 22 Jun 2017 09:11:55 +0800
Subject: [xlnx:master 694/710] drivers//spi/spi-zynq-qspi.c:695:2: warning:
 this 'if' clause does not guard...
Message-ID: <201706220946.uTll8jD3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   ae4bbf82f4b9fdfc85b3fd112696e8bbefff07f2
commit: 1dda0d845db112e74eaedbbd9cea6e0ff455b390 [694/710] spi: zynq: fix style issues from checkpatch
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 1dda0d845db112e74eaedbbd9cea6e0ff455b390
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers//spi/spi-zynq-qspi.c: In function 'zynq_qspi_probe':
>> drivers//spi/spi-zynq-qspi.c:695:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     if (of_property_read_u32(pdev->dev.of_node, "is-dual", &xqspi->is_dual))
     ^~
   drivers//spi/spi-zynq-qspi.c:697:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
      dev_warn(&pdev->dev, "about dual memories. defaulting to single memory\n");
      ^~~~~~~~

vim +/if +695 drivers//spi/spi-zynq-qspi.c

306f05f5e drivers/spi/xqspipss.c       Sadanand M             2010-10-14  679  
6f8376304 drivers/spi/spi-xilinx-qps.c Michal Simek           2013-07-08  680  	master = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
306f05f5e drivers/spi/xqspipss.c       Sadanand M             2010-10-14  681  	if (master == NULL)
306f05f5e drivers/spi/xqspipss.c       Sadanand M             2010-10-14  682  		return -ENOMEM;
306f05f5e drivers/spi/xqspipss.c       Sadanand M             2010-10-14  683  
306f05f5e drivers/spi/xqspipss.c       Sadanand M             2010-10-14  684  	xqspi = spi_master_get_devdata(master);
6f8376304 drivers/spi/spi-xilinx-qps.c Michal Simek           2013-07-08  685  	master->dev.of_node = pdev->dev.of_node;
6f8376304 drivers/spi/spi-xilinx-qps.c Michal Simek           2013-07-08  686  	platform_set_drvdata(pdev, master);
306f05f5e drivers/spi/xqspipss.c       Sadanand M             2010-10-14  687  
47625be95 drivers/spi/spi-xilinx-qps.c Michal Simek           2013-07-08  688  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
47625be95 drivers/spi/spi-xilinx-qps.c Michal Simek           2013-07-08  689  	xqspi->regs = devm_ioremap_resource(&pdev->dev, res);
47625be95 drivers/spi/spi-xilinx-qps.c Michal Simek           2013-07-08  690  	if (IS_ERR(xqspi->regs)) {
47625be95 drivers/spi/spi-xilinx-qps.c Michal Simek           2013-07-08  691  		ret = PTR_ERR(xqspi->regs);
47625be95 drivers/spi/spi-xilinx-qps.c Michal Simek           2013-07-08  692  		goto remove_master;
306f05f5e drivers/spi/xqspipss.c       Sadanand M             2010-10-14  693  	}
306f05f5e drivers/spi/xqspipss.c       Sadanand M             2010-10-14  694  
6f8376304 drivers/spi/spi-xilinx-qps.c Michal Simek           2013-07-08 @695  	if (of_property_read_u32(pdev->dev.of_node, "is-dual", &xqspi->is_dual))
1dda0d845 drivers/spi/spi-zynq-qspi.c  Naga Sureshkumar Relli 2017-05-30  696  		dev_warn(&pdev->dev, "couldn't determine configuration info");
1dda0d845 drivers/spi/spi-zynq-qspi.c  Naga Sureshkumar Relli 2017-05-30  697  		dev_warn(&pdev->dev, "about dual memories. defaulting to single memory\n");
5285395dd drivers/spi/xilinx_qspips.c  Sadanand M             2011-09-09  698  
adbc53e5a drivers/spi/spi-zynq-qspi.c  Harini Katakam         2014-04-11  699  	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
adbc53e5a drivers/spi/spi-zynq-qspi.c  Harini Katakam         2014-04-11  700  	if (IS_ERR(xqspi->pclk)) {
adbc53e5a drivers/spi/spi-zynq-qspi.c  Harini Katakam         2014-04-11  701  		dev_err(&pdev->dev, "pclk clock not found.\n");
adbc53e5a drivers/spi/spi-zynq-qspi.c  Harini Katakam         2014-04-11  702  		ret = PTR_ERR(xqspi->pclk);
47625be95 drivers/spi/spi-xilinx-qps.c Michal Simek           2013-07-08  703  		goto remove_master;

:::::: The code at line 695 was first introduced by commit
:::::: 6f8376304378be494ca9b7518636fd3ecd52e716 spi: xilinx-qps: Use pdev instead of dev

:::::: TO: Michal Simek <michal.simek@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59817 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170622/375e946e/attachment-0001.gz>
