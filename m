From: lkp@intel.com (kbuild test robot)
Date: Thu, 24 Aug 2017 01:55:56 +0800
Subject: [PATCH v2 7/8] iommu/mediatek: Enlarge the validate PA range for
 4GB mode
In-Reply-To: <1503313221-26453-8-git-send-email-yong.wu@mediatek.com>
Message-ID: <201708240138.15owgVAa%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

[auto build test ERROR on iommu/next]
[also build test ERROR on next-20170823]
[cannot apply to v4.13-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yong-Wu/MT2712-IOMMU-SUPPORT/20170824-074750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_hw_init':
>> drivers/iommu/mtk_iommu.c:536:30: error: 'const struct mtk_iommu_data' has no member named 'm4u_type'; did you mean 'm4u_dom'?
     if (data->enable_4GB && data->m4u_type != M4U_MT8173) {
                                 ^~

vim +536 drivers/iommu/mtk_iommu.c

   500	
   501	static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
   502	{
   503		u32 regval;
   504		int ret;
   505	
   506		ret = clk_prepare_enable(data->bclk);
   507		if (ret) {
   508			dev_err(data->dev, "Failed to enable iommu bclk(%d)\n", ret);
   509			return ret;
   510		}
   511	
   512		regval = F_MMU_TF_PROTECT_SEL(2, data);
   513		if (data->m4u_plat == M4U_MT8173)
   514			regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
   515		writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
   516	
   517		regval = F_L2_MULIT_HIT_EN |
   518			F_TABLE_WALK_FAULT_INT_EN |
   519			F_PREETCH_FIFO_OVERFLOW_INT_EN |
   520			F_MISS_FIFO_OVERFLOW_INT_EN |
   521			F_PREFETCH_FIFO_ERR_INT_EN |
   522			F_MISS_FIFO_ERR_INT_EN;
   523		writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);
   524	
   525		regval = F_INT_TRANSLATION_FAULT |
   526			F_INT_MAIN_MULTI_HIT_FAULT |
   527			F_INT_INVALID_PA_FAULT |
   528			F_INT_ENTRY_REPLACEMENT_FAULT |
   529			F_INT_TLB_MISS_FAULT |
   530			F_INT_MISS_TRANSACTION_FIFO_FAULT |
   531			F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
   532		writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
   533	
   534		writel_relaxed(F_MMU_IVRP_PA_SET(data->protect_base, data->enable_4GB),
   535			       data->base + REG_MMU_IVRP_PADDR);
 > 536		if (data->enable_4GB && data->m4u_type != M4U_MT8173) {
   537			/*
   538			 * If 4GB mode is enabled, the validate PA range is from
   539			 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
   540			 */
   541			regval = F_MMU_VLD_PA_RNG(7, 4);
   542			writel_relaxed(regval, data->base + REG_MMU_VLD_PA_RNG);
   543		}
   544		writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
   545	
   546		/* It's MISC control register whose default value is ok except mt8173.*/
   547		if (data->m4u_plat == M4U_MT8173)
   548			writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
   549	
   550		if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
   551				     dev_name(data->dev), (void *)data)) {
   552			writel_relaxed(0, data->base + REG_MMU_PT_BASE_ADDR);
   553			clk_disable_unprepare(data->bclk);
   554			dev_err(data->dev, "Failed @ IRQ-%d Request\n", data->irq);
   555			return -ENODEV;
   556		}
   557	
   558		return 0;
   559	}
   560	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56235 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170824/31abbd16/attachment-0001.gz>
