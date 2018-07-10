From: lkp@intel.com (kbuild test robot)
Date: Tue, 10 Jul 2018 21:20:00 +0800
Subject: [stericsson:ux500-mcde 3/3] drivers/gpu/drm/mcde/mcde_dsi.c:394:4:
 warning: format '%x' expects argument of type 'unsigned int', but argument 8
 has type 'size_t {aka long unsigned int}'
Message-ID: <201807102158.prmRvN5B%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-mcde
head:   ee7f210157e9d5a082751c1c1a556864d3e47892
commit: ee7f210157e9d5a082751c1c1a556864d3e47892 [3/3] MCDE hack
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ee7f210157e9d5a082751c1c1a556864d3e47892
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/mcde/mcde_dsi.c: In function 'mcde_dsi_host_detach':
   drivers/gpu/drm/mcde/mcde_dsi.c:371:19: warning: unused variable 'd' [-Wunused-variable]
     struct mcde_dsi *d = host_to_mcde_dsi(host);
                      ^
   In file included from include/linux/platform_device.h:14:0,
                    from drivers/gpu/drm/mcde/mcde_dsi.c:2:
   drivers/gpu/drm/mcde/mcde_dsi.c: In function 'mcde_dsi_host_transfer':
>> drivers/gpu/drm/mcde/mcde_dsi.c:394:4: warning: format '%x' expects argument of type 'unsigned int', but argument 8 has type 'size_t {aka long unsigned int}' [-Wformat=]
       "message to channel %d: %02x,%02x,%02x,%02x %02x bytes\n",
       ^
   drivers/gpu/drm/mcde/mcde_dsi.c:397:4:
       4 + packet.payload_length);
       ~~~~~~~~~~~~
   include/linux/device.h:1395:51: note: in definition of macro 'dev_info'
    #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                      ^~~

vim +394 drivers/gpu/drm/mcde/mcde_dsi.c

   367	
   368	static int mcde_dsi_host_detach(struct mipi_dsi_host *host,
   369					struct mipi_dsi_device *mdsi)
   370	{
 > 371		struct mcde_dsi *d = host_to_mcde_dsi(host);
   372	
   373		return 0;
   374	}
   375	
   376	static ssize_t mcde_dsi_host_transfer(struct mipi_dsi_host *host,
   377					      const struct mipi_dsi_msg *msg)
   378	{
   379		struct mcde_dsi *d = host_to_mcde_dsi(host);
   380		struct mipi_dsi_packet packet;
   381		const u32 loop_delay_us = 10; /* us */
   382		const u8 *header, *data;
   383		u32 loop_counter;
   384		u32 val;
   385		int ret;
   386	
   387		ret = mipi_dsi_create_packet(&packet, msg);
   388		if (ret < 0)
   389			return ret;
   390	
   391		header = packet.header;
   392		data = packet.payload;
   393		dev_info(d->dev,
 > 394			 "message to channel %d: %02x,%02x,%02x,%02x %02x bytes\n",
   395			 msg->channel,
   396			 header[0], header[1], header[2], header[3],
   397			 4 + packet.payload_length);
   398	
   399		if (packet.payload_length) {
   400			dev_err(d->dev,
   401				"dunno how to write more than 4 bytes yet\n");
   402			return -EIO;
   403		}
   404	
   405		val = DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_WRITE;
   406		if (packet.payload_length > 2)
   407			val |= DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LONGNOTSHORT;
   408		val |= 0 << DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_ID_SHIFT;
   409		val |= packet.payload_length
   410			<< DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_SIZE_SHIFT;
   411		val |= DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LP_EN;
   412	        val |= msg->type << DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_SHIFT;
   413		writel(val, d->regs + DSI_DIRECT_CMD_MAIN_SETTINGS);
   414	
   415		writel(header[0], d->regs + DSI_DIRECT_CMD_WRDAT0);
   416		writel(header[1], d->regs + DSI_DIRECT_CMD_WRDAT1);
   417		writel(header[2], d->regs + DSI_DIRECT_CMD_WRDAT2);
   418		writel(header[3], d->regs + DSI_DIRECT_CMD_WRDAT3);
   419	
   420		writel(~0, d->regs + DSI_DIRECT_CMD_STS_CLR);
   421		writel(~0, d->regs + DSI_CMD_MODE_STS_CLR);
   422		/* Send command */
   423		writel(1, d->regs + DSI_DIRECT_CMD_SEND);
   424	
   425		loop_counter = 1000 * 1000 / loop_delay_us;
   426		while (!(readl(d->regs + DSI_DIRECT_CMD_STS) &
   427			 DSI_DIRECT_CMD_STS_WRITE_COMPLETED)
   428		       && --loop_counter)
   429			usleep_range(loop_delay_us, (loop_delay_us * 3) / 2);
   430	
   431		if (!loop_counter) {
   432	                dev_err(d->dev, "DSI write timeout!\n");
   433	                return -ETIME;
   434	        } else {
   435	                dev_vdbg(d->dev, "DSI Write OK\n");
   436	        }
   437	
   438		writel(~0, d->regs + DSI_DIRECT_CMD_STS_CLR);
   439		writel(~0, d->regs + DSI_CMD_MODE_STS_CLR);
   440	
   441		return 4 + packet.payload_length;
   442	}
   443	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54403 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/08f6fcc2/attachment-0001.gz>
