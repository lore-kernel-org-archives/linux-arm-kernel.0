From: sean.wang@mediatek.com (Sean Wang)
Date: Wed, 18 Jul 2018 17:16:22 +0800
Subject: [resend PATCH v4 4/5] drm/mediatek: Add support for mmsys
 through a pdev
In-Reply-To: <50c93f6d-c546-1479-62c1-adc0b40d5dab@gmail.com>
References: <20180717220328.792-1-matthias.bgg@kernel.org>
 <20180717220328.792-5-matthias.bgg@kernel.org>
 <1531882655.8953.83.camel@mtkswgap22>
 <50c93f6d-c546-1479-62c1-adc0b40d5dab@gmail.com>
Message-ID: <1531905382.8953.113.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-07-18 at 09:27 +0200, Matthias Brugger wrote:
> Hi Sean,
> 
> On 18/07/18 04:57, Sean Wang wrote:
> > On Wed, 2018-07-18 at 00:03 +0200, matthias.bgg at kernel.org wrote:
> >> From: Matthias Brugger <mbrugger@suse.com>
> >>
> >> The MMSYS subsystem includes clocks and drm components.
> >> This patch adds an initailization path through a platform device
> >> for the clock part, so that both drivers get probed from the same
> >> device tree compatible.
> >>
> > 
> > Sorry for that I should have a response earlier for the series.
> > 
> > Some points I felt they're not exactly right and should be fixed up
> > before we're moving on
> > 
> > Currently, drm driver have a wrong reference to the dt-binding,
> > "mediatek,mt2701-mmsys" or "mediatek,mt8173-mmsys", they should be all
> > for the subsystem exporting clock and reset line such common resource to
> > its sub-devices. Every subsystem has a similar shape. I hope mmsys
> > shouldn't be an exception.
> 
> I'm not sure if I understand what you mean. You proposed to use a platform
> device [1] and now you say we should change the DTS?
> 

Yes, my initial thought is that I would like to embed drm platform
device into mmsys. It is the easiest way to solve problems caused by
compatible string conflict we met here in short term.


> What do you mean by "drm driver has a wrong reference to the dt-binding"? How

But for long-term goal, device has to define its own dt-binding before
the driver is being implemented. Currently, drm driver uses wrong
compatible string,  "mediatek,mt2701-mmsys" or "mediatek,mt8173-mmsys",
that are owned by mmsys device [1], not by drm device.

[1]
https://elixir.bootlin.com/linux/v4.18-rc5/source/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt


> would you want to name it and most important, what would be your approach to
> have backwards compatibility to older device tree bindings?
> 

We can use embed a platform device into mmsys for solving issue caused
by the older device tree binding.

But for long-term, it's neccessary to have a drm device dt-binding
document allowing drm driver and its components driver to follow. 



> > 
> > DRM device needs to have its own dt-binding show how connections between
> > DRM components being made and its node should be put under mmsys node.
> > > In this way, it becomes easy to see how the topology of the subsystem is
> > and grows, like a tree "device tree", instead of hiding the details in
> > the implementation.
> > 
> > The similar example we already did for audsys on mt2701 and mt7623 as
> > below
> > 
> > 	audsys: clock-controller at 11220000 {
> > 		compatible = "mediatek,mt7623-audsys",
> > 			     "mediatek,mt2701-audsys",
> > 			     "syscon";
> > 			...
> > 
> > 		afe: audio-controller {
> > 			compatible = "mediatek,mt7623-audio",
> > 				     "mediatek,mt2701-audio";
> > 			
> > 			...
> > 		};
> > 	};
> > 
> 
> I think this approach is not working as, due to backwards compatibility, we have
> to make sure that the DRM driver gets probed with the mmsys binding.
> 
> Regards,
> Matthias
> 
> > 	
> > 	Sean
> > 
> > 
> >> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >> ---
> >>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 18 ++++++++++++++++++
> >>  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
> >>  2 files changed, 20 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> >> index dd249cf5121e..c946aea722e5 100644
> >> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> >> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> >> @@ -173,6 +173,7 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
> >>  	.ext_path = mt2701_mtk_ddp_ext,
> >>  	.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
> >>  	.shadow_register = true,
> >> +	.clk_drv_name = "clk-mt2701-mm",
> >>  };
> >>  
> >>  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
> >> @@ -180,6 +181,7 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
> >>  	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
> >>  	.ext_path = mt8173_mtk_ddp_ext,
> >>  	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
> >> +	.clk_drv_name = "clk-mt8173-mm",
> >>  };
> >>  
> >>  static int mtk_drm_kms_init(struct drm_device *drm)
> >> @@ -411,6 +413,19 @@ static int mtk_drm_probe(struct platform_device *pdev)
> >>  	if (IS_ERR(private->config_regs))
> >>  		return PTR_ERR(private->config_regs);
> >>  
> >> +	if (private->data->clk_drv_name) {
> >> +		private->clk_dev = platform_device_register_data(dev,
> >> +						private->data->clk_drv_name, -1,
> >> +						NULL, 0);
> >> +
> >> +		if (IS_ERR(private->clk_dev)) {
> >> +			pr_err("failed to register %s platform device\n",
> >> +						private->data->clk_drv_name);
> >> +
> >> +			return PTR_ERR(private->clk_dev);
> >> +		}
> >> +	}
> >> +
> >>  	/* Iterate over sibling DISP function blocks */
> >>  	for_each_child_of_node(dev->of_node->parent, node) {
> >>  		const struct of_device_id *of_id;
> >> @@ -515,6 +530,9 @@ static int mtk_drm_remove(struct platform_device *pdev)
> >>  	for (i = 0; i < DDP_COMPONENT_ID_MAX; i++)
> >>  		of_node_put(private->comp_node[i]);
> >>  
> >> +	if (private->clk_dev)
> >> +		platform_device_unregister(private->clk_dev);
> >> +
> >>  	return 0;
> >>  }
> >>  
> >> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> >> index 86cec19193c4..200eee5de419 100644
> >> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> >> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> >> @@ -34,11 +34,13 @@ struct mtk_mmsys_driver_data {
> >>  	const enum mtk_ddp_comp_id *ext_path;
> >>  	unsigned int ext_len;
> >>  	bool shadow_register;
> >> +	const char *clk_drv_name;
> >>  };
> >>  
> >>  struct mtk_drm_private {
> >>  	struct drm_device *drm;
> >>  	struct device *dma_dev;
> >> +	struct platform_device *clk_dev;
> >>  
> >>  	unsigned int num_pipes;
> >>  
> > 
> > 
