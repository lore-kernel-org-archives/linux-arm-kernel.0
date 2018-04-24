From: lkp@intel.com (kbuild test robot)
Date: Tue, 24 Apr 2018 13:29:20 +0800
Subject: [PATCH] mmc: mediatek: add 64G DRAM DMA support
In-Reply-To: <1524475610-22079-2-git-send-email-chaotian.jing@mediatek.com>
References: <1524475610-22079-2-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <201804241105.EZI8Ml1m%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chaotian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc2 next-20180423]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chaotian-Jing/mmc-mediatek-add-64G-DRAM-DMA-support/20180423-231743
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/mmc/host/mtk-sd.c: In function 'msdc_dma_setup':
>> drivers/mmc/host/mtk-sd.c:573:35: warning: right shift count >= width of type [-Wshift-count-overflow]
       bd[j].bd_info |= ((dma_address >> 32) & 0xf) << 28;
                                      ^~
   drivers/mmc/host/mtk-sd.c: In function 'msdc_init_gpd_bd':
   drivers/mmc/host/mtk-sd.c:1440:31: warning: right shift count >= width of type [-Wshift-count-overflow]
      gpd->gpd_info |= ((dma_addr >> 32) & 0xf) << 24;
                                  ^~
   drivers/mmc/host/mtk-sd.c:1445:31: warning: right shift count >= width of type [-Wshift-count-overflow]
      gpd->gpd_info |= ((dma_addr >> 32) & 0xf) << 28;
                                  ^~
   drivers/mmc/host/mtk-sd.c:1452:32: warning: right shift count >= width of type [-Wshift-count-overflow]
       bd[i].bd_info |= ((dma_addr >> 32) & 0xf) << 24;
                                   ^~

vim +573 drivers/mmc/host/mtk-sd.c

   539	
   540	static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
   541			struct mmc_data *data)
   542	{
   543		unsigned int j, dma_len;
   544		dma_addr_t dma_address;
   545		u32 dma_ctrl;
   546		struct scatterlist *sg;
   547		struct mt_gpdma_desc *gpd;
   548		struct mt_bdma_desc *bd;
   549	
   550		sg = data->sg;
   551	
   552		gpd = dma->gpd;
   553		bd = dma->bd;
   554	
   555		/* modify gpd */
   556		gpd->gpd_info |= GPDMA_DESC_HWO;
   557		gpd->gpd_info |= GPDMA_DESC_BDP;
   558		/* need to clear first. use these bits to calc checksum */
   559		gpd->gpd_info &= ~GPDMA_DESC_CHECKSUM;
   560		gpd->gpd_info |= msdc_dma_calcs((u8 *) gpd, 16) << 8;
   561	
   562		/* modify bd */
   563		for_each_sg(data->sg, sg, data->sg_count, j) {
   564			dma_address = sg_dma_address(sg);
   565			dma_len = sg_dma_len(sg);
   566	
   567			/* init bd */
   568			bd[j].bd_info &= ~BDMA_DESC_BLKPAD;
   569			bd[j].bd_info &= ~BDMA_DESC_DWPAD;
   570			bd[j].ptr = (u32)dma_address;
   571			if (host->dev_comp->support_64g) {
   572				bd[j].bd_info &= ~BDMA_DESC_PTR_H4;
 > 573				bd[j].bd_info |= ((dma_address >> 32) & 0xf) << 28;
   574			}
   575			bd[j].bd_data_len &= ~BDMA_DESC_BUFLEN;
   576			bd[j].bd_data_len |= (dma_len & BDMA_DESC_BUFLEN);
   577	
   578			if (j == data->sg_count - 1) /* the last bd */
   579				bd[j].bd_info |= BDMA_DESC_EOL;
   580			else
   581				bd[j].bd_info &= ~BDMA_DESC_EOL;
   582	
   583			/* checksume need to clear first */
   584			bd[j].bd_info &= ~BDMA_DESC_CHECKSUM;
   585			bd[j].bd_info |= msdc_dma_calcs((u8 *)(&bd[j]), 16) << 8;
   586		}
   587	
   588		sdr_set_field(host->base + MSDC_DMA_CFG, MSDC_DMA_CFG_DECSEN, 1);
   589		dma_ctrl = readl_relaxed(host->base + MSDC_DMA_CTRL);
   590		dma_ctrl &= ~(MSDC_DMA_CTRL_BRUSTSZ | MSDC_DMA_CTRL_MODE);
   591		dma_ctrl |= (MSDC_BURST_64B << 12 | 1 << 8);
   592		writel_relaxed(dma_ctrl, host->base + MSDC_DMA_CTRL);
   593		writel((u32)dma->gpd_addr, host->base + MSDC_DMA_SA);
   594	}
   595	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65221 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/63d658e9/attachment-0001.gz>
