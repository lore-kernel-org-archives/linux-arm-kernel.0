From: yong.wu@mediatek.com (Yong Wu)
Date: Tue, 15 Dec 2015 10:38:23 +0800
Subject: [PATCH v6 3/5] memory: mediatek: Add SMI driver
In-Reply-To: <24171857.0SPpBlzoZl@linux-gy6r.site>
References: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com>
 <1449568153-15643-4-git-send-email-yong.wu@mediatek.com>
 <24171857.0SPpBlzoZl@linux-gy6r.site>
Message-ID: <1450147103.22854.23.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-12-14 at 19:18 +0100, Matthias Brugger wrote:
> On Tuesday 08 Dec 2015 17:49:11 Yong Wu wrote:
> > This patch add SMI(Smart Multimedia Interface) driver. This driver
> > is responsible to enable/disable iommu and control the power domain
> > and clocks of each local arbiter.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   Currently SMI offer mtk_smi_larb_get/put to enable the power-domain
> > ,clocks and initialize the iommu configuration register for each a local
> > arbiter, The reason is:
> >   a) If a device would like to disable iommu, it also need call
> > mtk_smi_larb_get/put to enable its power and clocks.
> >   b) The iommu core don't support attach/detach a device within a
> > iommu-group. So we cann't use iommu_attach_device(iommu_detach_device)
> > instead
> > of mtk_smi_larb_get/put.
> > 
[..]
> > +static int
> > +mtk_smi_enable(struct device *dev, struct clk *apb, struct clk *smi)
> > +{
> > +	int ret;
> > +
> > +	ret = pm_runtime_get_sync(dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = clk_prepare_enable(apb);
> > +	if (ret)
> > +		goto err_put_pm;
> > +
> > +	ret = clk_prepare_enable(smi);
> > +	if (ret)
> > +		goto err_disable_apb;
> > +
> > +	return 0;
> > +
> > +err_disable_apb:
> > +	clk_disable_unprepare(apb);
> > +err_put_pm:
> > +	pm_runtime_put_sync(dev);
> > +	return ret;
> > +}
> > +
> > +static void
> > +mtk_smi_disable(struct device *dev, struct clk *apb, struct clk *smi)
> > +{
> > +	clk_disable_unprepare(smi);
> > +	clk_disable_unprepare(apb);
> > +	pm_runtime_put_sync(dev);
> > +}
> > +
> > +static int mtk_smi_common_enable(struct mtk_smi_common *common)
> > +{
> > +	return mtk_smi_enable(common->dev, common->clk_apb, common->clk_smi);
> > +}
> > +
> > +static void mtk_smi_common_disable(struct mtk_smi_common *common)
> > +{
> > +	mtk_smi_disable(common->dev, common->clk_apb, common->clk_smi);
> > +}
> > +
> > +static int mtk_smi_larb_enable(struct mtk_smi_larb *larb)
> > +{
> > +	return mtk_smi_enable(larb->dev, larb->clk_apb, larb->clk_smi);
> > +}
> > +
> > +static void mtk_smi_larb_disable(struct mtk_smi_larb *larb)
> > +{
> > +	mtk_smi_disable(larb->dev, larb->clk_apb, larb->clk_smi);
> > +}
> > +
> 
> This is somehow over-engineered. Just use mtk_smi_enable and mtk_smi_disable 
> instead of adding an extra indirection.

I added this only for readable...then the code in mtk_smi_larb_get below
may looks simple and readable.

If I use mtk_smi_enable/disable directly, the code will be like our
v5[1], is it OK?
Maybe I don't need these help function here, and only add more comment
based on v5.

[1] 
http://lists.linuxfoundation.org/pipermail/iommu/2015-October/014590.html

> 
> > +int mtk_smi_larb_get(struct device *larbdev)
> > +{
> > +	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> > +	struct mtk_smi_common *common = dev_get_drvdata(larb->smi_common_dev);
> > +	int ret;
> > +
> > +	ret = mtk_smi_common_enable(common);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = mtk_smi_larb_enable(larb);
> > +	if (ret)
> > +		goto err_put_smi;
> > +
> > +	/* Configure the iommu info */
> > +	writel_relaxed(larb->mmu, larb->base + SMI_LARB_MMU_EN);
> > +
> > +	return 0;
> > +
> > +err_put_smi:
> > +	mtk_smi_common_disable(common);
> > +	return ret;
> > +}
> > +
> > +void mtk_smi_larb_put(struct device *larbdev)
> > +{
> > +	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> > +	struct mtk_smi_common *common = dev_get_drvdata(larb->smi_common_dev);
> > +
> > +	writel_relaxed(0, larb->base + SMI_LARB_MMU_EN);
> > +	mtk_smi_larb_disable(larb);
> > +	mtk_smi_common_disable(common);
> > +}
> > +
> 
> Looks strange that you just disable all MMUs while you only enable some of 
> them at runtime. Unfortunately the datasheet I have lacks the SMI part, so I 
> can just guess how the HW is working.
> From the DTS it looks like as if a larb can be used by two different 
> components (e.g. larb0 from ovl0 and rdma0). Wouldn't that produce a conflict?

Thanks. It's really a problem.

There are OVL0 and MDP in larb0, Both will call mtk_smi_larb_get/put, we
cann't disable all the MMUs in whole the larb0 here.  This register
should be reset to zero while the larb power domain turning off(rely on
the power-domain ref count).
I will delete this(keep this in our V5.)

> 
> Regards,
> Matthias
