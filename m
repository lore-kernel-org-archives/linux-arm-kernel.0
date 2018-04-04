From: lkp@intel.com (kbuild test robot)
Date: Wed, 4 Apr 2018 09:32:53 +0800
Subject: [PATCH v3 5/6] spi: sun6i: introduce register set/unset helpers
In-Reply-To: <20180403154449.2443-6-ssuloev@orpaltech.com>
References: <20180403154449.2443-6-ssuloev@orpaltech.com>
Message-ID: <201804040917.NjWkgZGY%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on spi/for-next]
[also build test ERROR on v4.16 next-20180403]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sergey-Suloev/spi-Add-support-for-DMA-transfers-in-sun6i-SPI-driver/20180404-053231
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

Note: the linux-review/Sergey-Suloev/spi-Add-support-for-DMA-transfers-in-sun6i-SPI-driver/20180404-053231 HEAD a0c010a285d830f07bb81ea59eaea8773d78b74c builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers//spi/spi-sun6i.c: In function 'sun6i_spi_transfer_one':
>> drivers//spi/spi-sun6i.c:371:2: error: implicit declaration of function 'sun6i_spi_enable_interrupt'; did you mean 'sun6i_spi_transfer_one'? [-Werror=implicit-function-declaration]
     sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC |
     ^~~~~~~~~~~~~~~~~~~~~~~~~~
     sun6i_spi_transfer_one
   drivers//spi/spi-sun6i.c:277:27: warning: unused variable 'tx_time' [-Wunused-variable]
     unsigned int start, end, tx_time;
                              ^~~~~~~
   drivers//spi/spi-sun6i.c:277:22: warning: unused variable 'end' [-Wunused-variable]
     unsigned int start, end, tx_time;
                         ^~~
   drivers//spi/spi-sun6i.c:277:15: warning: unused variable 'start' [-Wunused-variable]
     unsigned int start, end, tx_time;
                  ^~~~~
   drivers//spi/spi-sun6i.c:276:31: warning: unused variable 'timeout' [-Wunused-variable]
     unsigned int mclk_rate, div, timeout;
                                  ^~~~~~~
   cc1: some warnings being treated as errors

vim +371 drivers//spi/spi-sun6i.c

43836daab Sergey Suloev   2018-04-03  270  
3558fe900 Maxime Ripard   2014-02-05  271  static int sun6i_spi_transfer_one(struct spi_master *master,
3558fe900 Maxime Ripard   2014-02-05  272  				  struct spi_device *spi,
3558fe900 Maxime Ripard   2014-02-05  273  				  struct spi_transfer *tfr)
3558fe900 Maxime Ripard   2014-02-05  274  {
3558fe900 Maxime Ripard   2014-02-05  275  	struct sun6i_spi *sspi = spi_master_get_devdata(master);
3558fe900 Maxime Ripard   2014-02-05  276  	unsigned int mclk_rate, div, timeout;
719bd6542 Michal Suchanek 2016-06-13  277  	unsigned int start, end, tx_time;
913f536c6 Icenowy Zheng   2017-03-06  278  	unsigned int trig_level;
3558fe900 Maxime Ripard   2014-02-05  279  	unsigned int tx_len = 0;
3558fe900 Maxime Ripard   2014-02-05  280  	int ret = 0;
3558fe900 Maxime Ripard   2014-02-05  281  	u32 reg;
3558fe900 Maxime Ripard   2014-02-05  282  
e31cf0250 Sergey Suloev   2018-04-03  283  	/* A zero length transfer never finishes if programmed
e31cf0250 Sergey Suloev   2018-04-03  284  	   in the hardware */
e31cf0250 Sergey Suloev   2018-04-03  285  	if (!tfr->len)
e31cf0250 Sergey Suloev   2018-04-03  286  		return 0;
e31cf0250 Sergey Suloev   2018-04-03  287  
e31cf0250 Sergey Suloev   2018-04-03  288  	/* Don't support transfer larger than the FIFO */
e31cf0250 Sergey Suloev   2018-04-03  289  	if (tfr->len > sspi->fifo_depth)
e31cf0250 Sergey Suloev   2018-04-03  290  		return -EMSGSIZE;
3558fe900 Maxime Ripard   2014-02-05  291  
3558fe900 Maxime Ripard   2014-02-05  292  	sspi->tx_buf = tfr->tx_buf;
3558fe900 Maxime Ripard   2014-02-05  293  	sspi->rx_buf = tfr->rx_buf;
3558fe900 Maxime Ripard   2014-02-05  294  	sspi->len = tfr->len;
3558fe900 Maxime Ripard   2014-02-05  295  
3558fe900 Maxime Ripard   2014-02-05  296  	/* Clear pending interrupts */
3558fe900 Maxime Ripard   2014-02-05  297  	sun6i_spi_write(sspi, SUN6I_INT_STA_REG, ~0);
3558fe900 Maxime Ripard   2014-02-05  298  
3558fe900 Maxime Ripard   2014-02-05  299  	/* Reset FIFO */
3558fe900 Maxime Ripard   2014-02-05  300  	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
3558fe900 Maxime Ripard   2014-02-05  301  			SUN6I_FIFO_CTL_RF_RST | SUN6I_FIFO_CTL_TF_RST);
3558fe900 Maxime Ripard   2014-02-05  302  
3558fe900 Maxime Ripard   2014-02-05  303  	/*
913f536c6 Icenowy Zheng   2017-03-06  304  	 * Setup FIFO interrupt trigger level
913f536c6 Icenowy Zheng   2017-03-06  305  	 * Here we choose 3/4 of the full fifo depth, as it's the hardcoded
913f536c6 Icenowy Zheng   2017-03-06  306  	 * value used in old generation of Allwinner SPI controller.
913f536c6 Icenowy Zheng   2017-03-06  307  	 * (See spi-sun4i.c)
913f536c6 Icenowy Zheng   2017-03-06  308  	 */
913f536c6 Icenowy Zheng   2017-03-06  309  	trig_level = sspi->fifo_depth / 4 * 3;
913f536c6 Icenowy Zheng   2017-03-06  310  	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
e31cf0250 Sergey Suloev   2018-04-03  311  			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS));
913f536c6 Icenowy Zheng   2017-03-06  312  
3558fe900 Maxime Ripard   2014-02-05  313  	/*
3558fe900 Maxime Ripard   2014-02-05  314  	 * If it's a TX only transfer, we don't want to fill the RX
3558fe900 Maxime Ripard   2014-02-05  315  	 * FIFO with bogus data
3558fe900 Maxime Ripard   2014-02-05  316  	 */
3558fe900 Maxime Ripard   2014-02-05  317  	if (sspi->rx_buf)
2c98d976c Sergey Suloev   2018-04-03  318  		sun6i_spi_unset(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_DHB);
3558fe900 Maxime Ripard   2014-02-05  319  	else
2c98d976c Sergey Suloev   2018-04-03  320  		sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_DHB);
3558fe900 Maxime Ripard   2014-02-05  321  
09d186f3c Sergey Suloev   2018-04-03  322  
3558fe900 Maxime Ripard   2014-02-05  323  	/* Ensure that we have a parent clock fast enough */
3558fe900 Maxime Ripard   2014-02-05  324  	mclk_rate = clk_get_rate(sspi->mclk);
47284e3e0 Marcus Weseloh  2015-11-08  325  	if (mclk_rate < (2 * tfr->speed_hz)) {
47284e3e0 Marcus Weseloh  2015-11-08  326  		clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
3558fe900 Maxime Ripard   2014-02-05  327  		mclk_rate = clk_get_rate(sspi->mclk);
3558fe900 Maxime Ripard   2014-02-05  328  	}
3558fe900 Maxime Ripard   2014-02-05  329  
3558fe900 Maxime Ripard   2014-02-05  330  	/*
3558fe900 Maxime Ripard   2014-02-05  331  	 * Setup clock divider.
3558fe900 Maxime Ripard   2014-02-05  332  	 *
3558fe900 Maxime Ripard   2014-02-05  333  	 * We have two choices there. Either we can use the clock
3558fe900 Maxime Ripard   2014-02-05  334  	 * divide rate 1, which is calculated thanks to this formula:
3558fe900 Maxime Ripard   2014-02-05  335  	 * SPI_CLK = MOD_CLK / (2 ^ cdr)
3558fe900 Maxime Ripard   2014-02-05  336  	 * Or we can use CDR2, which is calculated with the formula:
3558fe900 Maxime Ripard   2014-02-05  337  	 * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
3558fe900 Maxime Ripard   2014-02-05  338  	 * Wether we use the former or the latter is set through the
3558fe900 Maxime Ripard   2014-02-05  339  	 * DRS bit.
3558fe900 Maxime Ripard   2014-02-05  340  	 *
3558fe900 Maxime Ripard   2014-02-05  341  	 * First try CDR2, and if we can't reach the expected
3558fe900 Maxime Ripard   2014-02-05  342  	 * frequency, fall back to CDR1.
3558fe900 Maxime Ripard   2014-02-05  343  	 */
47284e3e0 Marcus Weseloh  2015-11-08  344  	div = mclk_rate / (2 * tfr->speed_hz);
3558fe900 Maxime Ripard   2014-02-05  345  	if (div <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
3558fe900 Maxime Ripard   2014-02-05  346  		if (div > 0)
3558fe900 Maxime Ripard   2014-02-05  347  			div--;
3558fe900 Maxime Ripard   2014-02-05  348  
3558fe900 Maxime Ripard   2014-02-05  349  		reg = SUN6I_CLK_CTL_CDR2(div) | SUN6I_CLK_CTL_DRS;
3558fe900 Maxime Ripard   2014-02-05  350  	} else {
47284e3e0 Marcus Weseloh  2015-11-08  351  		div = ilog2(mclk_rate) - ilog2(tfr->speed_hz);
3558fe900 Maxime Ripard   2014-02-05  352  		reg = SUN6I_CLK_CTL_CDR1(div);
3558fe900 Maxime Ripard   2014-02-05  353  	}
3558fe900 Maxime Ripard   2014-02-05  354  
3558fe900 Maxime Ripard   2014-02-05  355  	sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
3558fe900 Maxime Ripard   2014-02-05  356  
3558fe900 Maxime Ripard   2014-02-05  357  	/* Setup the transfer now... */
3558fe900 Maxime Ripard   2014-02-05  358  	if (sspi->tx_buf)
3558fe900 Maxime Ripard   2014-02-05  359  		tx_len = tfr->len;
3558fe900 Maxime Ripard   2014-02-05  360  
3558fe900 Maxime Ripard   2014-02-05  361  	/* Setup the counters */
3558fe900 Maxime Ripard   2014-02-05  362  	sun6i_spi_write(sspi, SUN6I_BURST_CNT_REG, SUN6I_BURST_CNT(tfr->len));
3558fe900 Maxime Ripard   2014-02-05  363  	sun6i_spi_write(sspi, SUN6I_XMIT_CNT_REG, SUN6I_XMIT_CNT(tx_len));
3558fe900 Maxime Ripard   2014-02-05  364  	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG,
3558fe900 Maxime Ripard   2014-02-05  365  			SUN6I_BURST_CTL_CNT_STC(tx_len));
3558fe900 Maxime Ripard   2014-02-05  366  
3558fe900 Maxime Ripard   2014-02-05  367  	/* Fill the TX FIFO */
10565dfd3 Milo Kim        2016-10-28  368  	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
3558fe900 Maxime Ripard   2014-02-05  369  
3558fe900 Maxime Ripard   2014-02-05  370  	/* Enable the interrupts */
913f536c6 Icenowy Zheng   2017-03-06 @371  	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC |
913f536c6 Icenowy Zheng   2017-03-06  372  					 SUN6I_INT_CTL_RF_RDY);
3558fe900 Maxime Ripard   2014-02-05  373  
3558fe900 Maxime Ripard   2014-02-05  374  	/* Start the transfer */
2c98d976c Sergey Suloev   2018-04-03  375  	sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_XCH);
3558fe900 Maxime Ripard   2014-02-05  376  
43836daab Sergey Suloev   2018-04-03  377  	/* Wait for completion */
43836daab Sergey Suloev   2018-04-03  378  	ret = sun6i_spi_wait_for_transfer(spi, tfr);
3558fe900 Maxime Ripard   2014-02-05  379  
3558fe900 Maxime Ripard   2014-02-05  380  	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
3558fe900 Maxime Ripard   2014-02-05  381  
3558fe900 Maxime Ripard   2014-02-05  382  	return ret;
3558fe900 Maxime Ripard   2014-02-05  383  }
3558fe900 Maxime Ripard   2014-02-05  384  

:::::: The code at line 371 was first introduced by commit
:::::: 913f536c6c18a2e19e32f06971101c1d0ae3739c spi: sun6i: Allow transfers larger than FIFO size

:::::: TO: Icenowy Zheng <icenowy@aosc.xyz>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/c9e4b061/attachment-0001.gz>
