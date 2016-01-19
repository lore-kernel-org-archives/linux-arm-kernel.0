From: yong.wu@mediatek.com (Yong Wu)
Date: Tue, 19 Jan 2016 17:43:29 +0800
Subject: [PATCH v7 3/5] memory: mediatek: Add SMI driver
In-Reply-To: <569CBA50.7000400@gmail.com>
References: <1450426183-1571-1-git-send-email-yong.wu@mediatek.com>
 <1450426183-1571-4-git-send-email-yong.wu@mediatek.com>
 <569CBA50.7000400@gmail.com>
Message-ID: <1453196609.17894.39.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-01-18 at 11:11 +0100, Matthias Brugger wrote:
> 
> On 18/12/15 09:09, Yong Wu wrote:
> > This patch add SMI(Smart Multimedia Interface) driver. This driver
> > is responsible to enable/disable iommu and control the power domain
> > and clocks of each local arbiter.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>

[...]

> > +int mtk_smi_larb_get(struct device *larbdev)
> > +{
> > +	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> > +	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
> > +	int ret;
> > +
> > +	/* Enable the smi-common's power and clocks */
> > +	ret = mtk_smi_enable(common);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable the larb's power and clocks */
> > +	ret = mtk_smi_enable(&larb->smi);
> > +	if (ret) {
> > +		mtk_smi_disable(common);
> > +		return ret;
> > +	}
> > +
> > +	/* Configure the iommu info */
> > +	if (larb->mmu)
> > +		writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
> 
> Can there be a larb that does not have a mmu id defined?
> Phandles for the iommu need always to have a mtk_m4u_id defined, so I 
> don't see the case where this can happen?

  No. In current IC(mt8173), All the larbs have the mmu info register.

> Why did you changed this value to a pointer and added the if?

  I changed it to a pointer in order to support
iommu_attach_device/iommu_detach_device dynamically.

  In our v6, there is a interface called mtk_smi_config_port in which
the iommu(M4U) could tell SMI which ports should enable iommu.
  In this version, we use the additional data of component to finish
this job(the third parameter of the mtk_smi_larb_bind). then we could
delete that interface.

  larb->mmu is a pointer that point to the mmu in "struct mtk_smi_iommu
smi_imu" of "struct mtk_iommu_data". This "smi_imu" is used to record
that which ports has already enabled iommu for each larb and it will be
updated during the iommu_attach_device/iommu_detach_device.
 
   Why add the if?
  -> This pointer may be null in the mtk_smi_larb_unbind.
  I'm also not sure when it will enter mtk_smi_larb_unbind, maybe while
the iommu device is removed, then it call component_master_del, or the
larb device itself is removed, or some other error case in component.
but there really is a path it will be null, so I add this *if*.
   If you think it is unnecessary, I can delete it.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +void mtk_smi_larb_put(struct device *larbdev)
> > +{
> > +	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> > +	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
> > +
> 
> Would it make sense to write SMI_LARB_MMU_EN here again to eventually 
> turn off mmus?

I think no. As you know, there may be some modules in one larb, so we
cann't write 0 in SMI_LARB_MMU_EN here to turn off mmus for all modules.

mtk_smi_larb_get/mtk_smi_larb_put mainly enable/disable the power domain
and clocks for this local arbiter. And the larb is a unit here, SMI
cann?t detect which module calls mtk_smi_larb_put and disable his
special iommu bits. so do mtk_smi_larb_get.
 
I know that the module?s special iommu bit wasn?t wrote to 0 here, but
if this module would like to work again, he have to call
mtk_smi_larb_get again, and currently all the multimedia modules always
works via iommu, we don?t need to write 0 here.


> Other then this, the driver looks fine to me.

Thanks very much for your reply. I could send the new version if we get
a conclusion for the two issue above here, like you really don't like
that *if*.

> 
> Regards,
> Matthias
> 
> > +	mtk_smi_disable(&larb->smi);
> > +	mtk_smi_disable(common);
> > +}
> > +
> > +static int
> > +mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
> > +{
> > +	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> > +	struct mtk_smi_iommu *smi_iommu = data;
> > +	unsigned int         i;
> > +
> > +	for (i = 0; i < smi_iommu->larb_nr; i++) {
> > +		if (dev == smi_iommu->larb_imu[i].dev) {
> > +			larb->mmu = &smi_iommu->larb_imu[i].mmu;
> > +			return 0;
> > +		}
> > +	}
> > +	return -ENODEV;
> > +}
> > +
> > +static void
> > +mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
> > +{
> > +	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> > +
> > +	larb->mmu = NULL;
> > +}
> > +
> > +static const struct component_ops mtk_smi_larb_component_ops = {
> > +	.bind = mtk_smi_larb_bind,
> > +	.unbind = mtk_smi_larb_unbind,
> > +};

[...]
