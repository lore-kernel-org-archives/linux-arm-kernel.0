From: lkp@intel.com (kbuild test robot)
Date: Tue, 17 Jul 2018 09:06:50 +0800
Subject: [stericsson:ux500-mcde 4/5] drivers/gpu//drm/mcde/mcde_dsi.c:495:4:
 warning: format '%d' expects argument of type 'int', but argument 4 has type
 'size_t {aka long unsigned int}'
Message-ID: <20180717010650.GJ10593@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-mcde
head:   0aa285c8ac0871db70d37e6f658cd3327ae06a84
commit: dfc457803b349a0c0e0625070db87dbdfa7d452c [4/5] MCDE hack
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout dfc457803b349a0c0e0625070db87dbdfa7d452c
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 
:::::: branch date: 18 hours ago
:::::: commit date: 3 days ago

All warnings (new ones prefixed by >>):

   In file included from include/linux/platform_device.h:14:0,
                    from drivers/gpu//drm/mcde/mcde_dsi.c:2:
   drivers/gpu//drm/mcde/mcde_dsi.c: In function 'mcde_dsi_host_transfer':
>> drivers/gpu//drm/mcde/mcde_dsi.c:495:4: warning: format '%d' expects argument of type 'int', but argument 4 has type 'size_t {aka long unsigned int}' [-Wformat=]
       "message to channel %d, %d bytes: ",
       ^
   include/linux/device.h:1395:51: note: in definition of macro 'dev_info'
    #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                      ^~~
   At top level:
   drivers/gpu//drm/mcde/mcde_dsi.c:609:13: warning: 'mcde_dsi_te_request' defined but not used [-Wunused-function]
    static void mcde_dsi_te_request(struct mcde_dsi *d)
                ^~~~~~~~~~~~~~~~~~~

# https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git/commit/?id=dfc457803b349a0c0e0625070db87dbdfa7d452c
git remote add stericsson https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
git remote update stericsson
git checkout dfc457803b349a0c0e0625070db87dbdfa7d452c
vim +495 drivers/gpu//drm/mcde/mcde_dsi.c

dfc45780 Linus Walleij 2018-05-29  468  
dfc45780 Linus Walleij 2018-05-29  469  #define MCDE_DSI_HOST_IS_READ(type)			    \
dfc45780 Linus Walleij 2018-05-29  470          ((type == MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM) || \
dfc45780 Linus Walleij 2018-05-29  471  	 (type == MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM) || \
dfc45780 Linus Walleij 2018-05-29  472  	 (type == MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM) || \
dfc45780 Linus Walleij 2018-05-29  473  	 (type == MIPI_DSI_DCS_READ))
dfc45780 Linus Walleij 2018-05-29  474  
dfc45780 Linus Walleij 2018-05-29  475  static ssize_t mcde_dsi_host_transfer(struct mipi_dsi_host *host,
dfc45780 Linus Walleij 2018-05-29  476  				      const struct mipi_dsi_msg *msg)
dfc45780 Linus Walleij 2018-05-29  477  {
dfc45780 Linus Walleij 2018-05-29  478  	struct mcde_dsi *d = host_to_mcde_dsi(host);
dfc45780 Linus Walleij 2018-05-29  479  	const u32 loop_delay_us = 10; /* us */
dfc45780 Linus Walleij 2018-05-29  480  	const u8 *tx = msg->tx_buf;
dfc45780 Linus Walleij 2018-05-29  481  	u32 loop_counter;
dfc45780 Linus Walleij 2018-05-29  482  	size_t txlen;
dfc45780 Linus Walleij 2018-05-29  483  	u32 val;
dfc45780 Linus Walleij 2018-05-29  484  	int ret;
dfc45780 Linus Walleij 2018-05-29  485  	int i;
dfc45780 Linus Walleij 2018-05-29  486  
dfc45780 Linus Walleij 2018-05-29  487  	txlen = msg->tx_len;
dfc45780 Linus Walleij 2018-05-29  488  	if (txlen > 12) {
dfc45780 Linus Walleij 2018-05-29  489  		dev_err(d->dev,
dfc45780 Linus Walleij 2018-05-29  490  			"dunno how to write more than 12 bytes yet\n");
dfc45780 Linus Walleij 2018-05-29  491  		return -EIO;
dfc45780 Linus Walleij 2018-05-29  492  	}
dfc45780 Linus Walleij 2018-05-29  493  
dfc45780 Linus Walleij 2018-05-29  494  	dev_info(d->dev,
dfc45780 Linus Walleij 2018-05-29 @495  		 "message to channel %d, %d bytes: ",
dfc45780 Linus Walleij 2018-05-29  496  		 msg->channel,
dfc45780 Linus Walleij 2018-05-29  497  		 txlen);
dfc45780 Linus Walleij 2018-05-29  498  	for (i = 0; i < txlen; i++)
dfc45780 Linus Walleij 2018-05-29  499  		pr_cont(" %02x", tx[i]);
dfc45780 Linus Walleij 2018-05-29  500  	pr_cont("\n");
dfc45780 Linus Walleij 2018-05-29  501  
dfc45780 Linus Walleij 2018-05-29  502  	/* Command "nature" */
dfc45780 Linus Walleij 2018-05-29  503  	if (MCDE_DSI_HOST_IS_READ(msg->type))
dfc45780 Linus Walleij 2018-05-29  504  		/* MCTL_MAIN_DATA_CTL already set up */
dfc45780 Linus Walleij 2018-05-29  505  		val = DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_READ;
dfc45780 Linus Walleij 2018-05-29  506  	else
dfc45780 Linus Walleij 2018-05-29  507  		val = DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_WRITE;
dfc45780 Linus Walleij 2018-05-29  508  	/*
dfc45780 Linus Walleij 2018-05-29  509  	 * More than 2 bytes will not fit in a single packet, so it's
dfc45780 Linus Walleij 2018-05-29  510  	 * time to set the "long not short" bit. One byte is used by
dfc45780 Linus Walleij 2018-05-29  511  	 * the MIPI DCS command leaving just one byte for the payload
dfc45780 Linus Walleij 2018-05-29  512  	 * in a short package.
dfc45780 Linus Walleij 2018-05-29  513  	 */
dfc45780 Linus Walleij 2018-05-29  514  	if (mipi_dsi_packet_format_is_long(msg->type))
dfc45780 Linus Walleij 2018-05-29  515  		val |= DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LONGNOTSHORT;
dfc45780 Linus Walleij 2018-05-29  516  	val |= 0 << DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_ID_SHIFT;
dfc45780 Linus Walleij 2018-05-29  517  	/* Add one to the length for the MIPI DCS command */
dfc45780 Linus Walleij 2018-05-29  518  	val |= txlen
dfc45780 Linus Walleij 2018-05-29  519  		<< DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_SIZE_SHIFT;
dfc45780 Linus Walleij 2018-05-29  520  	val |= DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LP_EN;
dfc45780 Linus Walleij 2018-05-29  521          val |= msg->type << DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_SHIFT;
dfc45780 Linus Walleij 2018-05-29  522  	writel(val, d->regs + DSI_DIRECT_CMD_MAIN_SETTINGS);
dfc45780 Linus Walleij 2018-05-29  523  
dfc45780 Linus Walleij 2018-05-29  524  	/* MIPI DCS command is part of the data */
dfc45780 Linus Walleij 2018-05-29  525  	if (txlen > 0) {
dfc45780 Linus Walleij 2018-05-29  526  		val = 0;
dfc45780 Linus Walleij 2018-05-29  527  		for (i = 0; i < 4 && i < txlen; i++)
dfc45780 Linus Walleij 2018-05-29  528  			val |= tx[i] << (i & 3) * 8;
dfc45780 Linus Walleij 2018-05-29  529  	}
dfc45780 Linus Walleij 2018-05-29  530  	writel(val, d->regs + DSI_DIRECT_CMD_WRDAT0);
dfc45780 Linus Walleij 2018-05-29  531  	if (txlen > 4) {
dfc45780 Linus Walleij 2018-05-29  532  		val = 0;
dfc45780 Linus Walleij 2018-05-29  533  		for (i = 0; i < 4 && (i + 4) < txlen; i++)
dfc45780 Linus Walleij 2018-05-29  534  			val |= tx[i + 4] << (i & 3) * 8;
dfc45780 Linus Walleij 2018-05-29  535  		writel(val, d->regs + DSI_DIRECT_CMD_WRDAT1);
dfc45780 Linus Walleij 2018-05-29  536  	}
dfc45780 Linus Walleij 2018-05-29  537  	if (txlen > 8) {
dfc45780 Linus Walleij 2018-05-29  538  		val = 0;
dfc45780 Linus Walleij 2018-05-29  539  		for (i = 0; i < 4 && (i + 8) < txlen; i++)
dfc45780 Linus Walleij 2018-05-29  540  			val |= tx[i + 8] << (i & 3) * 8;
dfc45780 Linus Walleij 2018-05-29  541  		writel(val, d->regs + DSI_DIRECT_CMD_WRDAT2);
dfc45780 Linus Walleij 2018-05-29  542  	}
dfc45780 Linus Walleij 2018-05-29  543  	if (txlen > 12) {
dfc45780 Linus Walleij 2018-05-29  544  		val = 0;
dfc45780 Linus Walleij 2018-05-29  545  		for (i = 0; i < 4 && (i + 12) < txlen; i++)
dfc45780 Linus Walleij 2018-05-29  546  			val |= tx[i + 12] << (i & 3) * 8;
dfc45780 Linus Walleij 2018-05-29  547  		writel(val, d->regs + DSI_DIRECT_CMD_WRDAT3);
dfc45780 Linus Walleij 2018-05-29  548  	}
dfc45780 Linus Walleij 2018-05-29  549  
dfc45780 Linus Walleij 2018-05-29  550  	writel(~0, d->regs + DSI_DIRECT_CMD_STS_CLR);
dfc45780 Linus Walleij 2018-05-29  551  	writel(~0, d->regs + DSI_CMD_MODE_STS_CLR);
dfc45780 Linus Walleij 2018-05-29  552  	/* Send command */
dfc45780 Linus Walleij 2018-05-29  553  	writel(1, d->regs + DSI_DIRECT_CMD_SEND);
dfc45780 Linus Walleij 2018-05-29  554  
dfc45780 Linus Walleij 2018-05-29  555  	loop_counter = 1000 * 1000 / loop_delay_us;
dfc45780 Linus Walleij 2018-05-29  556  	while (!(readl(d->regs + DSI_DIRECT_CMD_STS) &
dfc45780 Linus Walleij 2018-05-29  557  		 DSI_DIRECT_CMD_STS_WRITE_COMPLETED)
dfc45780 Linus Walleij 2018-05-29  558  	       && --loop_counter)
dfc45780 Linus Walleij 2018-05-29  559  		usleep_range(loop_delay_us, (loop_delay_us * 3) / 2);
dfc45780 Linus Walleij 2018-05-29  560  
dfc45780 Linus Walleij 2018-05-29  561  	if (!loop_counter) {
dfc45780 Linus Walleij 2018-05-29  562                  dev_err(d->dev, "DSI write timeout!\n");
dfc45780 Linus Walleij 2018-05-29  563                  return -ETIME;
dfc45780 Linus Walleij 2018-05-29  564          } else {
dfc45780 Linus Walleij 2018-05-29  565                  dev_info(d->dev, "DSI Write OK\n");
dfc45780 Linus Walleij 2018-05-29  566          }
dfc45780 Linus Walleij 2018-05-29  567  
dfc45780 Linus Walleij 2018-05-29  568  	val = readl(d->regs + DSI_DIRECT_CMD_STS);
dfc45780 Linus Walleij 2018-05-29  569  	if (val & DSI_DIRECT_CMD_STS_ACKNOWLEDGE_WITH_ERR_RECEIVED) {
dfc45780 Linus Walleij 2018-05-29  570  		val >>= DSI_DIRECT_CMD_STS_ACK_VAL_SHIFT;
dfc45780 Linus Walleij 2018-05-29  571  		dev_err(d->dev, "error during transmission: %04x\n",
dfc45780 Linus Walleij 2018-05-29  572  			val);
dfc45780 Linus Walleij 2018-05-29  573  		return -EIO;
dfc45780 Linus Walleij 2018-05-29  574  	}
dfc45780 Linus Walleij 2018-05-29  575  
dfc45780 Linus Walleij 2018-05-29  576  	if (!MCDE_DSI_HOST_IS_READ(msg->type)) {
dfc45780 Linus Walleij 2018-05-29  577  		/* Return number of bytes written */
dfc45780 Linus Walleij 2018-05-29  578  		if (mipi_dsi_packet_format_is_long(msg->type))
dfc45780 Linus Walleij 2018-05-29  579  			ret = 4 + txlen;
dfc45780 Linus Walleij 2018-05-29  580  		else
dfc45780 Linus Walleij 2018-05-29  581  			ret = 4;
dfc45780 Linus Walleij 2018-05-29  582  	} else {
dfc45780 Linus Walleij 2018-05-29  583  		/* OK this is a read command, get the response */
dfc45780 Linus Walleij 2018-05-29  584  		u32 rdsz;
dfc45780 Linus Walleij 2018-05-29  585  		u32 rddat;
dfc45780 Linus Walleij 2018-05-29  586  		u8 *rx = msg->rx_buf;
dfc45780 Linus Walleij 2018-05-29  587  
dfc45780 Linus Walleij 2018-05-29  588  		rdsz = readl(d->regs + DSI_DIRECT_CMD_RD_PROPERTY);
dfc45780 Linus Walleij 2018-05-29  589  		rdsz &= DSI_DIRECT_CMD_RD_PROPERTY_RD_SIZE_MASK;
dfc45780 Linus Walleij 2018-05-29  590  		rddat = readl(d->regs + DSI_DIRECT_CMD_RDDAT);
dfc45780 Linus Walleij 2018-05-29  591  		for (i = 0; i < 4 && i < rdsz; i++)
dfc45780 Linus Walleij 2018-05-29  592  			rx[i] = (rddat >> (i * 8)) & 0xff;
dfc45780 Linus Walleij 2018-05-29  593  		ret = rdsz;
dfc45780 Linus Walleij 2018-05-29  594  	}
dfc45780 Linus Walleij 2018-05-29  595  
dfc45780 Linus Walleij 2018-05-29  596  	writel(~0, d->regs + DSI_DIRECT_CMD_STS_CLR);
dfc45780 Linus Walleij 2018-05-29  597  	writel(~0, d->regs + DSI_CMD_MODE_STS_CLR);
dfc45780 Linus Walleij 2018-05-29  598  
dfc45780 Linus Walleij 2018-05-29  599  	return ret;
dfc45780 Linus Walleij 2018-05-29  600  }
dfc45780 Linus Walleij 2018-05-29  601  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60458 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/18804e78/attachment-0001.gz>
