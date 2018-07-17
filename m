From: lkp@intel.com (kbuild test robot)
Date: Tue, 17 Jul 2018 22:34:44 +0800
Subject: [stericsson:ux500-mcde 5/5] drivers/gpu/drm/mcde/mcde_dsi.c:494:2:
 note: in expansion of macro 'dev_dbg'
Message-ID: <201807172242.qpUGR2mk%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-mcde
head:   1c2cef2895c1f98796d3f43b4fe8b40efe9ae694
commit: 1c2cef2895c1f98796d3f43b4fe8b40efe9ae694 [5/5] MCDE hack
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 1c2cef2895c1f98796d3f43b4fe8b40efe9ae694
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:332:0,
                    from include/linux/kernel.h:14,
                    from include/linux/list.h:9,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from include/linux/platform_device.h:14,
                    from drivers/gpu/drm/mcde/mcde_dsi.c:2:
   drivers/gpu/drm/mcde/mcde_dsi.c: In function 'mcde_dsi_host_transfer':
   drivers/gpu/drm/mcde/mcde_dsi.c:495:3: warning: format '%d' expects argument of type 'int', but argument 5 has type 'size_t {aka long unsigned int}' [-Wformat=]
      "message to channel %d, %d bytes: ",
      ^
   include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/gpu/drm/mcde/mcde_dsi.c:494:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(d->dev,
     ^~~~~~~
   At top level:
   drivers/gpu/drm/mcde/mcde_dsi.c:604:13: warning: 'mcde_dsi_te_request' defined but not used [-Wunused-function]
    static void mcde_dsi_te_request(struct mcde_dsi *d)
                ^~~~~~~~~~~~~~~~~~~

vim +/dev_dbg +494 drivers/gpu/drm/mcde/mcde_dsi.c

   468	
   469	#define MCDE_DSI_HOST_IS_READ(type)			    \
   470	        ((type == MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM) || \
   471		 (type == MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM) || \
   472		 (type == MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM) || \
   473		 (type == MIPI_DSI_DCS_READ))
   474	
   475	static ssize_t mcde_dsi_host_transfer(struct mipi_dsi_host *host,
   476					      const struct mipi_dsi_msg *msg)
   477	{
   478		struct mcde_dsi *d = host_to_mcde_dsi(host);
   479		const u32 loop_delay_us = 10; /* us */
   480		const u8 *tx = msg->tx_buf;
   481		u32 loop_counter;
   482		size_t txlen;
   483		u32 val;
   484		int ret;
   485		int i;
   486	
   487		txlen = msg->tx_len;
   488		if (txlen > 12) {
   489			dev_err(d->dev,
   490				"dunno how to write more than 12 bytes yet\n");
   491			return -EIO;
   492		}
   493	
 > 494		dev_dbg(d->dev,
   495			"message to channel %d, %d bytes: ",
   496			msg->channel,
   497			txlen);
   498	
   499		/* Command "nature" */
   500		if (MCDE_DSI_HOST_IS_READ(msg->type))
   501			/* MCTL_MAIN_DATA_CTL already set up */
   502			val = DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_READ;
   503		else
   504			val = DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_WRITE;
   505		/*
   506		 * More than 2 bytes will not fit in a single packet, so it's
   507		 * time to set the "long not short" bit. One byte is used by
   508		 * the MIPI DCS command leaving just one byte for the payload
   509		 * in a short package.
   510		 */
   511		if (mipi_dsi_packet_format_is_long(msg->type))
   512			val |= DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LONGNOTSHORT;
   513		val |= 0 << DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_ID_SHIFT;
   514		/* Add one to the length for the MIPI DCS command */
   515		val |= txlen
   516			<< DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_SIZE_SHIFT;
   517		val |= DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LP_EN;
   518	        val |= msg->type << DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_SHIFT;
   519		writel(val, d->regs + DSI_DIRECT_CMD_MAIN_SETTINGS);
   520	
   521		/* MIPI DCS command is part of the data */
   522		if (txlen > 0) {
   523			val = 0;
   524			for (i = 0; i < 4 && i < txlen; i++)
   525				val |= tx[i] << (i & 3) * 8;
   526		}
   527		writel(val, d->regs + DSI_DIRECT_CMD_WRDAT0);
   528		if (txlen > 4) {
   529			val = 0;
   530			for (i = 0; i < 4 && (i + 4) < txlen; i++)
   531				val |= tx[i + 4] << (i & 3) * 8;
   532			writel(val, d->regs + DSI_DIRECT_CMD_WRDAT1);
   533		}
   534		if (txlen > 8) {
   535			val = 0;
   536			for (i = 0; i < 4 && (i + 8) < txlen; i++)
   537				val |= tx[i + 8] << (i & 3) * 8;
   538			writel(val, d->regs + DSI_DIRECT_CMD_WRDAT2);
   539		}
   540		if (txlen > 12) {
   541			val = 0;
   542			for (i = 0; i < 4 && (i + 12) < txlen; i++)
   543				val |= tx[i + 12] << (i & 3) * 8;
   544			writel(val, d->regs + DSI_DIRECT_CMD_WRDAT3);
   545		}
   546	
   547		writel(~0, d->regs + DSI_DIRECT_CMD_STS_CLR);
   548		writel(~0, d->regs + DSI_CMD_MODE_STS_CLR);
   549		/* Send command */
   550		writel(1, d->regs + DSI_DIRECT_CMD_SEND);
   551	
   552		loop_counter = 1000 * 1000 / loop_delay_us;
   553		while (!(readl(d->regs + DSI_DIRECT_CMD_STS) &
   554			 DSI_DIRECT_CMD_STS_WRITE_COMPLETED)
   555		       && --loop_counter)
   556			usleep_range(loop_delay_us, (loop_delay_us * 3) / 2);
   557	
   558		if (!loop_counter) {
   559	                dev_err(d->dev, "DSI write timeout!\n");
   560	                return -ETIME;
   561	        }
   562	
   563		val = readl(d->regs + DSI_DIRECT_CMD_STS);
   564		if (val & DSI_DIRECT_CMD_STS_ACKNOWLEDGE_WITH_ERR_RECEIVED) {
   565			val >>= DSI_DIRECT_CMD_STS_ACK_VAL_SHIFT;
   566			dev_err(d->dev, "error during transmission: %04x\n",
   567				val);
   568			return -EIO;
   569		}
   570	
   571		if (!MCDE_DSI_HOST_IS_READ(msg->type)) {
   572			/* Return number of bytes written */
   573			if (mipi_dsi_packet_format_is_long(msg->type))
   574				ret = 4 + txlen;
   575			else
   576				ret = 4;
   577		} else {
   578			/* OK this is a read command, get the response */
   579			u32 rdsz;
   580			u32 rddat;
   581			u8 *rx = msg->rx_buf;
   582	
   583			rdsz = readl(d->regs + DSI_DIRECT_CMD_RD_PROPERTY);
   584			rdsz &= DSI_DIRECT_CMD_RD_PROPERTY_RD_SIZE_MASK;
   585			rddat = readl(d->regs + DSI_DIRECT_CMD_RDDAT);
   586			for (i = 0; i < 4 && i < rdsz; i++)
   587				rx[i] = (rddat >> (i * 8)) & 0xff;
   588			ret = rdsz;
   589		}
   590	
   591		writel(~0, d->regs + DSI_DIRECT_CMD_STS_CLR);
   592		writel(~0, d->regs + DSI_CMD_MODE_STS_CLR);
   593	
   594		return ret;
   595	}
   596	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54403 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/0afc045b/attachment-0001.gz>
