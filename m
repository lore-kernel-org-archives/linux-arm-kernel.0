From: lkp@intel.com (kbuild test robot)
Date: Mon, 5 Oct 2015 16:59:38 +0800
Subject: Regression: at24 eeprom writing
In-Reply-To: <561238A9.1060406@lysator.liu.se>
Message-ID: <201510051612.StykC5b6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

[auto build test WARNING on v4.3-rc4 -- if it's inappropriate base, please ignore]

config: arm-at91_dt_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/i2c/busses/i2c-at91.c: In function 'at91_twi_read_data_dma_callback':
>> drivers/i2c/busses/i2c-at91.c:378:11: warning: unused variable 'ier' [-Wunused-variable]
     unsigned ier = AT91_TWI_TXCOMP;
              ^

vim +/ier +378 drivers/i2c/busses/i2c-at91.c

75b81f33 Marek Roszko      2014-08-20  362  			dev->buf_len = 1;
75b81f33 Marek Roszko      2014-08-20  363  		}
fac368a0 Nikolaus Voss     2011-11-08  364  	}
fac368a0 Nikolaus Voss     2011-11-08  365  
fac368a0 Nikolaus Voss     2011-11-08  366  	/* send stop if second but last byte has been read */
0ef6f321 Cyrille Pitchen   2015-06-09  367  	if (!dev->pdata->has_alt_cmd && dev->buf_len == 1)
fac368a0 Nikolaus Voss     2011-11-08  368  		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
fac368a0 Nikolaus Voss     2011-11-08  369  
fac368a0 Nikolaus Voss     2011-11-08  370  	dev_dbg(dev->dev, "read 0x%x, to go %d\n", *dev->buf, dev->buf_len);
fac368a0 Nikolaus Voss     2011-11-08  371  
fac368a0 Nikolaus Voss     2011-11-08  372  	++dev->buf;
fac368a0 Nikolaus Voss     2011-11-08  373  }
fac368a0 Nikolaus Voss     2011-11-08  374  
60937b2c Ludovic Desroches 2012-11-23  375  static void at91_twi_read_data_dma_callback(void *data)
60937b2c Ludovic Desroches 2012-11-23  376  {
60937b2c Ludovic Desroches 2012-11-23  377  	struct at91_twi_dev *dev = (struct at91_twi_dev *)data;
0ef6f321 Cyrille Pitchen   2015-06-09 @378  	unsigned ier = AT91_TWI_TXCOMP;
60937b2c Ludovic Desroches 2012-11-23  379  
5e3cfc6c Cyrille Pitchen   2015-06-09  380  	dma_unmap_single(dev->dev, sg_dma_address(&dev->dma.sg[0]),
28772ac8 Wolfram Sang      2014-07-21  381  			 dev->buf_len, DMA_FROM_DEVICE);
60937b2c Ludovic Desroches 2012-11-23  382  
60937b2c Ludovic Desroches 2012-11-23  383  	/* The last two bytes have to be read without using dma */
60937b2c Ludovic Desroches 2012-11-23  384  	dev->buf += dev->buf_len - 2;
60937b2c Ludovic Desroches 2012-11-23  385  	dev->buf_len = 2;
e0b440c7 Peter Rosin       2015-10-05  386  	at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_RXRDY);

:::::: The code at line 378 was first introduced by commit
:::::: 0ef6f3213dac48bbc71c98b5a2752db556f3e649 i2c: at91: add support for new alternative command mode

:::::: TO: Cyrille Pitchen <cyrille.pitchen@atmel.com>
:::::: CC: Wolfram Sang <wsa@the-dreams.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 20006 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/3dfd1f31/attachment-0001.obj>
