From: lkp@intel.com (kbuild test robot)
Date: Wed, 27 Sep 2017 05:08:30 +0800
Subject: [PATCH v3 02/10] dmaengine: sun6i: Correct burst length field
 offsets for H3
In-Reply-To: <8ffbdd23-6bf0-4da0-8ce0-4b0e8dc1281d@rwthex-w2-a.rwth-ad.de>
Message-ID: <201709270534.SbrcoyL1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

[auto build test WARNING on next-20170926]
[also build test WARNING on v4.14-rc2]
[cannot apply to linus/master robh/for-next v4.14-rc2 v4.14-rc1 v4.13]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stefan-Br-ns/dmaengine-sun6i-Correct-setting-of-clock-autogating-register-for-A83T-H3/20170927-021533
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   drivers/dma/sun6i-dma.c:119:2: error: function declaration isn't a prototype [-Werror=strict-prototypes]
     void (*clock_autogate_enable)();
     ^
   drivers/dma/sun6i-dma.c: In function 'sun6i_dma_prep_dma_memcpy':
>> drivers/dma/sun6i-dma.c:627:2: warning: passing argument 1 of 'sdev->cfg->set_burst_length' makes pointer from integer without a cast
     sdev->cfg->set_burst_length(v_lli->cfg, burst, burst);
     ^
   drivers/dma/sun6i-dma.c:627:2: note: expected 'u32 *' but argument is of type 'u32'
   drivers/dma/sun6i-dma.c: At top level:
   drivers/dma/sun6i-dma.c:1040:48: error: expected '}' before ';' token
     .set_burst_length = sun6i_set_burst_length_a31;
                                                   ^
   drivers/dma/sun6i-dma.c:1052:58: error: expected '}' before ';' token
     .clock_autogate_enable = sun6i_enable_clock_autogate_a23;
                                                             ^
   drivers/dma/sun6i-dma.c:1060:58: error: expected '}' before ';' token
     .clock_autogate_enable = sun6i_enable_clock_autogate_a23;
                                                             ^
   drivers/dma/sun6i-dma.c:1073:57: error: expected '}' before ';' token
     .clock_autogate_enable = sun6i_enable_clock_autogate_h3;
                                                            ^
   drivers/dma/sun6i-dma.c:1086:58: error: expected '}' before ';' token
     .clock_autogate_enable = sun6i_enable_clock_autogate_a23;
                                                             ^
   drivers/dma/sun6i-dma.c:292:13: warning: 'sun6i_set_burst_length_h3' defined but not used [-Wunused-function]
    static void sun6i_set_burst_length_h3(u32 *p_cfg, s8 src_burst, s8 dst_burst)
                ^
   cc1: some warnings being treated as errors

vim +627 drivers/dma/sun6i-dma.c

   584	
   585	static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
   586			struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
   587			size_t len, unsigned long flags)
   588	{
   589		struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(chan->device);
   590		struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
   591		struct sun6i_dma_lli *v_lli;
   592		struct sun6i_desc *txd;
   593		dma_addr_t p_lli;
   594		s8 burst, width;
   595	
   596		dev_dbg(chan2dev(chan),
   597			"%s; chan: %d, dest: %pad, src: %pad, len: %zu. flags: 0x%08lx\n",
   598			__func__, vchan->vc.chan.chan_id, &dest, &src, len, flags);
   599	
   600		if (!len)
   601			return NULL;
   602	
   603		txd = kzalloc(sizeof(*txd), GFP_NOWAIT);
   604		if (!txd)
   605			return NULL;
   606	
   607		v_lli = dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
   608		if (!v_lli) {
   609			dev_err(sdev->slave.dev, "Failed to alloc lli memory\n");
   610			goto err_txd_free;
   611		}
   612	
   613		v_lli->src = src;
   614		v_lli->dst = dest;
   615		v_lli->len = len;
   616		v_lli->para = NORMAL_WAIT;
   617	
   618		burst = convert_burst(8);
   619		width = convert_buswidth(DMA_SLAVE_BUSWIDTH_4_BYTES);
   620		v_lli->cfg = DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
   621			DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
   622			DMA_CHAN_CFG_DST_LINEAR_MODE |
   623			DMA_CHAN_CFG_SRC_LINEAR_MODE |
   624			DMA_CHAN_CFG_SRC_WIDTH(width) |
   625			DMA_CHAN_CFG_DST_WIDTH(width);
   626	
 > 627		sdev->cfg->set_burst_length(v_lli->cfg, burst, burst);
   628	
   629		sun6i_dma_lli_add(NULL, v_lli, p_lli, txd);
   630	
   631		sun6i_dma_dump_lli(vchan, v_lli);
   632	
   633		return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
   634	
   635	err_txd_free:
   636		kfree(txd);
   637		return NULL;
   638	}
   639	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51625 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170927/9cc9219b/attachment-0001.gz>
