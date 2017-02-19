From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 20 Feb 2017 07:09:50 +0800
Subject: [xlnx:master 93/356] drivers/spi/spi-zynqmp-gqspi.c:285: undefined
 reference to `zynqmp_pm_mmio_read'
Message-ID: <201702200746.Zkw6zoiq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   330ed0834e0eb0745a7111c2a21bbbf839024ad6
commit: 061577cf00d48e8d7e5501cb3bae88ee82ce8eb9 [93/356] ARM64: zynqmp: Fix i2c node's compatible string
config: i386-randconfig-i0-201708+CONFIG_DEBUG_INFO_REDUCED (attached as .config)
compiler: gcc-4.8 (Debian 4.8.4-1) 4.8.4
reproduce:
        git checkout 061577cf00d48e8d7e5501cb3bae88ee82ce8eb9
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the xlnx/master HEAD 330ed0834e0eb0745a7111c2a21bbbf839024ad6 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `zynqmp_qspi_set_tapdelay':
>> drivers/spi/spi-zynqmp-gqspi.c:285: undefined reference to `zynqmp_pm_mmio_read'
   drivers/spi/spi-zynqmp-gqspi.c:289: undefined reference to `zynqmp_pm_mmio_read'
>> drivers/spi/spi-zynqmp-gqspi.c:304: undefined reference to `zynqmp_pm_mmio_write'

vim +285 drivers/spi/spi-zynqmp-gqspi.c

8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  279  	u32 reqhz = 0;
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  280  
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  281  	clk_rate = clk_get_rate(xqspi->refclk);
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  282  	reqhz = (clk_rate / (GQSPI_BAUD_DIV_SHIFT << baudrateval));
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  283  
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  284  	if (reqhz < GQSPI_FREQ_40MHZ) {
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18 @285  		zynqmp_pm_mmio_read(IOU_TAPDLY_BYPASS_OFST, &tapdlybypass);
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  286  		tapdlybypass |= (TAP_DLY_BYPASS_LQSPI_RX_VALUE <<
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  287  				TAP_DLY_BYPASS_LQSPI_RX_SHIFT);
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  288  	} else if (reqhz < GQSPI_FREQ_100MHZ) {
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  289  		zynqmp_pm_mmio_read(IOU_TAPDLY_BYPASS_OFST, &tapdlybypass);
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  290  		tapdlybypass |= (TAP_DLY_BYPASS_LQSPI_RX_VALUE <<
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  291  				TAP_DLY_BYPASS_LQSPI_RX_SHIFT);
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  292  		lpbkdlyadj = zynqmp_gqspi_read(xqspi, GQSPI_LPBK_DLY_ADJ_OFST);
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  293  		lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  294  		datadlyadj = zynqmp_gqspi_read(xqspi, GQSPI_DATA_DLY_ADJ_OFST);
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  295  		datadlyadj |= ((GQSPI_USE_DATA_DLY << GQSPI_USE_DATA_DLY_SHIFT)
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  296  				| (GQSPI_DATA_DLY_ADJ_VALUE <<
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  297  					GQSPI_DATA_DLY_ADJ_SHIFT));
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  298  	} else if (reqhz < GQSPI_FREQ_150MHZ) {
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  299  		lpbkdlyadj = zynqmp_gqspi_read(xqspi, GQSPI_LPBK_DLY_ADJ_OFST);
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  300  		lpbkdlyadj |= ((GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK) |
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  301  				GQSPI_LPBK_DLY_ADJ_DLY_0);
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  302  	}
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  303  
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18 @304  	zynqmp_pm_mmio_write(IOU_TAPDLY_BYPASS_OFST, IOU_TAPDLY_BYPASS_MASK,
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  305  			tapdlybypass);
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  306  	zynqmp_gqspi_write(xqspi, GQSPI_LPBK_DLY_ADJ_OFST, lpbkdlyadj);
8f0c7fe9 Naga Sureshkumar Relli 2016-08-18  307  	zynqmp_gqspi_write(xqspi, GQSPI_DATA_DLY_ADJ_OFST, datadlyadj);

:::::: The code at line 285 was first introduced by commit
:::::: 8f0c7fe90b9fde8a17df65c6c6829afb5e3b323f spi: zynqmp: Add tapdelay support

:::::: TO: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20922 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170220/044cb5d9/attachment-0001.gz>
