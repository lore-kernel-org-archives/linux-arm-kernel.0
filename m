From: yong.wu@mediatek.com (Yong Wu)
Date: Sat, 12 Aug 2017 17:34:32 +0800
Subject: [PATCH 5/8] iommu/mediatek: Disable iommu clock when system
 suspend
In-Reply-To: <b451cb47-505e-c300-42fd-9cb73c09ef0b@gmail.com>
References: <1502445377-26936-1-git-send-email-yong.wu@mediatek.com>
 <1502445377-26936-6-git-send-email-yong.wu@mediatek.com>
 <b451cb47-505e-c300-42fd-9cb73c09ef0b@gmail.com>
Message-ID: <1502530472.11148.54.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-08-11 at 16:39 +0530, Arvind Yadav wrote:
> Hi Youn,
> 
> 
> On Friday 11 August 2017 03:26 PM, Yong Wu wrote:
> > When system suspend, infra power domain may be off, and the iommu's
> > clock must be disabled when system off, or the iommu's bclk clock maybe
> > disabled after system resume.
> >
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index e81ed9a..b7c8e52 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -675,6 +675,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
> >   	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
> >   	reg->int_control0 = readl_relaxed(base + REG_MMU_INT_CONTROL0);
> >   	reg->int_main_control = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
> > +	clk_disable_unprepare(data->bclk);
> >   	return 0;
> >   }
> >   
> > @@ -684,6 +685,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> >   	struct mtk_iommu_suspend_reg *reg = &data->reg;
> >   	void __iomem *base = data->base;
> >   
> > +	clk_prepare_enable(data->bclk);
> Please handle return value of clk_prepare_enable. It can fail

Thanks for the reminding. I will add it in next version.

> >   	writel_relaxed(reg->standard_axi_mode,
> >   		       base + REG_MMU_STANDARD_AXI_MODE);
> >   	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
> > @@ -699,7 +701,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> >   }
> >   
> >   static const struct dev_pm_ops mtk_iommu_pm_ops = {
> > -	SET_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
> > +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
> >   };
> >   
> >   static const struct of_device_id mtk_iommu_of_ids[] = {
> ~arvind
