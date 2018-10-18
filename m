From: lkp@intel.com (kbuild test robot)
Date: Thu, 18 Oct 2018 09:31:33 +0800
Subject: [PATCH 2/2] dmaengine: mediatek: Add MediaTek Command-Queue DMA
 controller for MT6765 SoC
In-Reply-To: <1539769019-32107-3-git-send-email-shun-chih.yu@mediatek.com>
References: <1539769019-32107-3-git-send-email-shun-chih.yu@mediatek.com>
Message-ID: <201810180946.E3RuWb5X%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shun-Chih,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux-sof-driver/master]
[also build test WARNING on v4.19-rc8 next-20181017]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/shun-chih-yu-mediatek-com/dt-bindings-dmaengine-Add-MediaTek-Command-Queue-DMA-controller-bindings/20181018-071645
base:   https://github.com/thesofproject/linux master
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/dma/mediatek/mtk-cqdma.c: In function 'mtk_cqdma_start':
>> drivers/dma/mediatek/mtk-cqdma.c:245:43: warning: right shift count >= width of type [-Wshift-count-overflow]
     mtk_dma_set(pc, MTK_CQDMA_SRC2, cvd->src >> MTK_CQDMA_ADDR2_SHFIT);
                                              ^~
   drivers/dma/mediatek/mtk-cqdma.c:249:44: warning: right shift count >= width of type [-Wshift-count-overflow]
     mtk_dma_set(pc, MTK_CQDMA_DST2, cvd->dest >> MTK_CQDMA_ADDR2_SHFIT);
                                               ^~

vim +245 drivers/dma/mediatek/mtk-cqdma.c

   230	
   231	static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc,
   232				    struct mtk_cqdma_vdesc *cvd)
   233	{
   234		/* wait for the previous transaction done */
   235		if (mtk_cqdma_poll_engine_done(pc, true) < 0)
   236			dev_err(cqdma2dev(to_cqdma_dev(cvd->ch)), "cqdma wait transaction timeout\n");
   237	
   238		/* warm reset the dma engine for the new transaction */
   239		mtk_dma_set(pc, MTK_CQDMA_RESET, MTK_CQDMA_WARM_RST_BIT);
   240		if (mtk_cqdma_poll_engine_done(pc, true) < 0)
   241			dev_err(cqdma2dev(to_cqdma_dev(cvd->ch)), "cqdma warm reset timeout\n");
   242	
   243		/* setup the source */
   244		mtk_dma_set(pc, MTK_CQDMA_SRC, cvd->src & MTK_CQDMA_ADDR_LIMIT);
 > 245		mtk_dma_set(pc, MTK_CQDMA_SRC2, cvd->src >> MTK_CQDMA_ADDR2_SHFIT);
   246	
   247		/* setup the destination */
   248		mtk_dma_set(pc, MTK_CQDMA_DST, cvd->dest & MTK_CQDMA_ADDR_LIMIT);
   249		mtk_dma_set(pc, MTK_CQDMA_DST2, cvd->dest >> MTK_CQDMA_ADDR2_SHFIT);
   250	
   251		/* setup the length */
   252		mtk_dma_set(pc, MTK_CQDMA_LEN1, cvd->len);
   253	
   254		/* start dma engine */
   255		mtk_dma_set(pc, MTK_CQDMA_EN, MTK_CQDMA_EN_BIT);
   256	}
   257	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62847 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181018/018f63cc/attachment-0001.gz>
