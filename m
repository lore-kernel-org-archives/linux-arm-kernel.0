From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 15 Oct 2016 02:19:14 +0800
Subject: [arm-soc:to-build 18/18] drivers/spi/spi-fsl-espi.c:462:4: warning:
 'rx_data' may be used uninitialized in this function
Message-ID: <201610150256.aVfqdtgA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git to-build
head:   9f700f316330ee9341e1e817468bd272a4535291
commit: 9f700f316330ee9341e1e817468bd272a4535291 [18/18] Revert "Disable "maybe-uninitialized" warning globally"
config: powerpc-kmp204x_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9f700f316330ee9341e1e817468bd272a4535291
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/spi/spi-fsl-espi.c: In function 'fsl_espi_irq':
>> drivers/spi/spi-fsl-espi.c:462:4: warning: 'rx_data' may be used uninitialized in this function [-Wmaybe-uninitialized]
       mspi->get_rx(rx_data, mspi);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-fsl-espi.c:421:7: note: 'rx_data' was declared here
      u32 rx_data, tmp;
          ^~~~~~~

vim +/rx_data +462 drivers/spi/spi-fsl-espi.c

e6289d63 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-12-21  446  		} else {
6319a680 drivers/spi/spi-fsl-espi.c Nobuteru Hayashi 2016-03-18  447  			rx_nr_bytes = mspi->len;
e6289d63 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-12-21  448  			tmp = mspi->len;
e6289d63 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-12-21  449  			rx_data = 0;
e6289d63 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-12-21  450  			while (tmp--) {
46afd38b drivers/spi/spi-fsl-espi.c Heiner Kallweit  2016-09-13  451  				rx_data_8 = fsl_espi_read_reg8(mspi,
46afd38b drivers/spi/spi-fsl-espi.c Heiner Kallweit  2016-09-13  452  							       ESPI_SPIRF);
e6289d63 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-12-21  453  				rx_data |= (rx_data_8 << (tmp * 8));
e6289d63 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-12-21  454  			}
e6289d63 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-12-21  455  
e6289d63 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-12-21  456  			rx_data <<= (4 - mspi->len) * 8;
e6289d63 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-12-21  457  		}
e6289d63 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-12-21  458  
6319a680 drivers/spi/spi-fsl-espi.c Nobuteru Hayashi 2016-03-18  459  		mspi->len -= rx_nr_bytes;
8b60d6c2 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-10-12  460  
8b60d6c2 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-10-12  461  		if (mspi->rx)
8b60d6c2 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-10-12 @462  			mspi->get_rx(rx_data, mspi);
8b60d6c2 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-10-12  463  	}
8b60d6c2 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-10-12  464  
81abc2ec drivers/spi/spi-fsl-espi.c Heiner Kallweit  2016-09-13  465  	if (!(events & SPIE_TNF)) {
8b60d6c2 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-10-12  466  		int ret;
8b60d6c2 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-10-12  467  
8b60d6c2 drivers/spi/spi_fsl_espi.c Mingkai Hu       2010-10-12  468  		/* spin until TX is done */
46afd38b drivers/spi/spi-fsl-espi.c Heiner Kallweit  2016-09-13  469  		ret = spin_event_timeout(((events = fsl_espi_read_reg(
81abc2ec drivers/spi/spi-fsl-espi.c Heiner Kallweit  2016-09-13  470  				mspi, ESPI_SPIE)) & SPIE_TNF), 1000, 0);

:::::: The code at line 462 was first introduced by commit
:::::: 8b60d6c25b2a2d3525d5322de856c3ca408e5783 spi/fsl_spi: add eSPI controller support

:::::: TO: Mingkai Hu <Mingkai.hu@freescale.com>
:::::: CC: Grant Likely <grant.likely@secretlab.ca>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 16547 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161015/0ed9d6a0/attachment-0001.gz>
