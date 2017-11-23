From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 23 Nov 2017 16:47:00 +0800
Subject: [PATCH 3/8] drm/mediatek: mt2701: switch to mfd probing.
In-Reply-To: <66be07f1-c084-8db1-c845-86b2057a0d5d@suse.com>
References: <20171114214114.15793-1-mbrugger@suse.com>
 <20171114214114.15793-4-mbrugger@suse.com>
 <1511416092.20405.4.camel@mtksdaap41>
 <66be07f1-c084-8db1-c845-86b2057a0d5d@suse.com>
Message-ID: <1511426820.8489.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Matthias:

On Thu, 2017-11-23 at 09:30 +0100, Matthias Brugger wrote:
> 
> On 11/23/2017 06:48 AM, CK Hu wrote:
> > Hi, Matthias:
> > 
> > On Tue, 2017-11-14 at 22:41 +0100, Matthias Brugger wrote:
> >> With the mtk-mmsys MFD device in place, we switch the probing for
> >> mt2701 from device-tree to mfd.
> >>
> >> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >> ---
> >>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 32 +++++++++++++++++++++++++-------
> >>  1 file changed, 25 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> >> index dd249cf5121e..5a263aa3ab6e 100644
> >> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> >> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> >> @@ -21,6 +21,7 @@
> >>  #include <drm/drm_of.h>
> >>  #include <linux/component.h>
> >>  #include <linux/iommu.h>
> >> +#include <linux/mfd/mmsys.h>
> >>  #include <linux/mfd/syscon.h>
> >>  #include <linux/of_address.h>
> >>  #include <linux/of_platform.h>
> >> @@ -392,9 +393,10 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
> >>  
> >>  static int mtk_drm_probe(struct platform_device *pdev)
> >>  {
> >> +	struct mmsys_dev *mmsys_private;
> >>  	struct device *dev = &pdev->dev;
> >>  	struct mtk_drm_private *private;
> >> -	struct device_node *node;
> >> +	struct device_node *node, *parent_node;
> >>  	struct component_match *match = NULL;
> >>  	int ret;
> >>  	int i;
> >> @@ -407,12 +409,23 @@ static int mtk_drm_probe(struct platform_device *pdev)
> >>  	INIT_WORK(&private->commit.work, mtk_atomic_work);
> >>  	private->data = of_device_get_match_data(dev);
> >>  
> >> -	private->config_regs = syscon_node_to_regmap(dev->of_node);
> >> -	if (IS_ERR(private->config_regs))
> >> -		return PTR_ERR(private->config_regs);
> >> +	/* Check if called from mfd */
> >> +	if (!dev->of_node) {
> >> +		mmsys_private = dev_get_drvdata(pdev->dev.parent);
> > 
> > Why do you directly access parent's driver data? You just need the
> > device node of mmsys, maybe you could refer to [1].
> > 
> > [1]
> > https://elixir.free-electrons.com/linux/latest/source/drivers/reset/reset-berlin.c#L78
> > 
> 
> The difference is, that the driver you mentioned gets probed via device tree
> matching, while we get invoked here through the id_table. So there is no device
> node (the if actually checkes for pdev->dev.of_node to identify exactly this case).
> 
> Regards,
> Matthias

Yes, you are right. So

Acked-by: CK Hu <ck.hu@mediatek.com>

Regards,
CK
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
