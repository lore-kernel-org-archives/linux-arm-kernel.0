From: lkp@intel.com (kbuild test robot)
Date: Mon, 5 Nov 2018 19:10:17 +0800
Subject: [stericsson:ux500-mcde 8/8] drivers/gpu/drm/mcde/mcde_dsi.c:571:4:
 warning: format '%u' expects argument of type 'unsigned int', but argument 4
 has type 'size_t {aka long unsigned int}'
Message-ID: <201811051913.66WOXnG4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-mcde
head:   bd2ef0e5589e833546c3f299bb394cf0ffc65f1d
commit: bd2ef0e5589e833546c3f299bb394cf0ffc65f1d [8/8] drm/mcde: Add new driver for ST-Ericsson MCDE
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout bd2ef0e5589e833546c3f299bb394cf0ffc65f1d
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/platform_device.h:14:0,
                    from drivers/gpu/drm/mcde/mcde_dsi.c:2:
   drivers/gpu/drm/mcde/mcde_dsi.c: In function 'mcde_dsi_host_transfer':
>> drivers/gpu/drm/mcde/mcde_dsi.c:571:4: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'size_t {aka long unsigned int}' [-Wformat=]
       "message to channel %d, %u bytes",
       ^
   include/linux/device.h:1370:22: note: in definition of macro 'dev_fmt'
    #define dev_fmt(fmt) fmt
                         ^~~
   drivers/gpu/drm/mcde/mcde_dsi.c:570:2: note: in expansion of macro 'dev_info'
     dev_info(d->dev,
     ^~~~~~~~

vim +571 drivers/gpu/drm/mcde/mcde_dsi.c

   544	
   545	#define MCDE_DSI_HOST_IS_READ(type)			    \
   546	        ((type == MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM) || \
   547		 (type == MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM) || \
   548		 (type == MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM) || \
   549		 (type == MIPI_DSI_DCS_READ))
   550	
   551	static ssize_t mcde_dsi_host_transfer(struct mipi_dsi_host *host,
   552					      const struct mipi_dsi_msg *msg)
   553	{
   554		struct mcde_dsi *d = host_to_mcde_dsi(host);
   555		const u32 loop_delay_us = 10; /* us */
   556		const u8 *tx = msg->tx_buf;
   557		u32 loop_counter;
   558		size_t txlen;
   559		u32 val;
   560		int ret;
   561		int i;
   562	
   563		txlen = msg->tx_len;
   564		if (txlen > 12) {
   565			dev_err(d->dev,
   566				"dunno how to write more than 12 bytes yet\n");
   567			return -EIO;
   568		}
   569	
   570		dev_info(d->dev,
 > 571			 "message to channel %d, %u bytes",
   572			 msg->channel,
   573			 txlen);
   574	
   575		/* Command "nature" */
   576		if (MCDE_DSI_HOST_IS_READ(msg->type))
   577			/* MCTL_MAIN_DATA_CTL already set up */
   578			val = DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_READ;
   579		else
   580			val = DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_WRITE;
   581		/*
   582		 * More than 2 bytes will not fit in a single packet, so it's
   583		 * time to set the "long not short" bit. One byte is used by
   584		 * the MIPI DCS command leaving just one byte for the payload
   585		 * in a short package.
   586		 */
   587		if (mipi_dsi_packet_format_is_long(msg->type))
   588			val |= DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LONGNOTSHORT;
   589		val |= 0 << DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_ID_SHIFT;
   590		/* Add one to the length for the MIPI DCS command */
   591		val |= txlen
   592			<< DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_SIZE_SHIFT;
   593		val |= DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LP_EN;
   594	        val |= msg->type << DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_SHIFT;
   595		writel(val, d->regs + DSI_DIRECT_CMD_MAIN_SETTINGS);
   596	
   597		/* MIPI DCS command is part of the data */
   598		if (txlen > 0) {
   599			val = 0;
   600			for (i = 0; i < 4 && i < txlen; i++)
   601				val |= tx[i] << (i & 3) * 8;
   602		}
   603		writel(val, d->regs + DSI_DIRECT_CMD_WRDAT0);
   604		if (txlen > 4) {
   605			val = 0;
   606			for (i = 0; i < 4 && (i + 4) < txlen; i++)
   607				val |= tx[i + 4] << (i & 3) * 8;
   608			writel(val, d->regs + DSI_DIRECT_CMD_WRDAT1);
   609		}
   610		if (txlen > 8) {
   611			val = 0;
   612			for (i = 0; i < 4 && (i + 8) < txlen; i++)
   613				val |= tx[i + 8] << (i & 3) * 8;
   614			writel(val, d->regs + DSI_DIRECT_CMD_WRDAT2);
   615		}
   616		if (txlen > 12) {
   617			val = 0;
   618			for (i = 0; i < 4 && (i + 12) < txlen; i++)
   619				val |= tx[i + 12] << (i & 3) * 8;
   620			writel(val, d->regs + DSI_DIRECT_CMD_WRDAT3);
   621		}
   622	
   623		writel(~0, d->regs + DSI_DIRECT_CMD_STS_CLR);
   624		writel(~0, d->regs + DSI_CMD_MODE_STS_CLR);
   625		/* Send command */
   626		writel(1, d->regs + DSI_DIRECT_CMD_SEND);
   627	
   628		loop_counter = 1000 * 1000 / loop_delay_us;
   629		while (!(readl(d->regs + DSI_DIRECT_CMD_STS) &
   630			 DSI_DIRECT_CMD_STS_WRITE_COMPLETED)
   631		       && --loop_counter)
   632			usleep_range(loop_delay_us, (loop_delay_us * 3) / 2);
   633	
   634		if (!loop_counter) {
   635	                dev_err(d->dev, "DSI write timeout!\n");
   636	                return -ETIME;
   637	        }
   638	
   639		val = readl(d->regs + DSI_DIRECT_CMD_STS);
   640		if (val & DSI_DIRECT_CMD_STS_ACKNOWLEDGE_WITH_ERR_RECEIVED) {
   641			val >>= DSI_DIRECT_CMD_STS_ACK_VAL_SHIFT;
   642			dev_err(d->dev, "error during transmission: %04x\n",
   643				val);
   644			return -EIO;
   645		}
   646	
   647		if (!MCDE_DSI_HOST_IS_READ(msg->type)) {
   648			/* Return number of bytes written */
   649			if (mipi_dsi_packet_format_is_long(msg->type))
   650				ret = 4 + txlen;
   651			else
   652				ret = 4;
   653		} else {
   654			/* OK this is a read command, get the response */
   655			u32 rdsz;
   656			u32 rddat;
   657			u8 *rx = msg->rx_buf;
   658	
   659			rdsz = readl(d->regs + DSI_DIRECT_CMD_RD_PROPERTY);
   660			rdsz &= DSI_DIRECT_CMD_RD_PROPERTY_RD_SIZE_MASK;
   661			rddat = readl(d->regs + DSI_DIRECT_CMD_RDDAT);
   662			for (i = 0; i < 4 && i < rdsz; i++)
   663				rx[i] = (rddat >> (i * 8)) & 0xff;
   664			ret = rdsz;
   665		}
   666	
   667		writel(~0, d->regs + DSI_DIRECT_CMD_STS_CLR);
   668		writel(~0, d->regs + DSI_CMD_MODE_STS_CLR);
   669	
   670		return ret;
   671	}
   672	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55846 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/3b53a2e3/attachment-0001.gz>
