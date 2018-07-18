From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 18 Jul 2018 11:05:49 +0300
Subject: [resend PATCH v4 4/5] drm/mediatek: Add support for mmsys through
 a pdev
In-Reply-To: <1531882655.8953.83.camel@mtkswgap22>
References: <20180717220328.792-1-matthias.bgg@kernel.org>
 <20180717220328.792-5-matthias.bgg@kernel.org>
 <1531882655.8953.83.camel@mtkswgap22>
Message-ID: <51066716.k5MkZnrqCl@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On Wednesday, 18 July 2018 05:57:35 EEST Sean Wang wrote:
> On Wed, 2018-07-18 at 00:03 +0200, matthias.bgg at kernel.org wrote:
> > From: Matthias Brugger <mbrugger@suse.com>
> > 
> > The MMSYS subsystem includes clocks and drm components.
> > This patch adds an initailization path through a platform device
> > for the clock part, so that both drivers get probed from the same
> > device tree compatible.
> 
> Sorry for that I should have a response earlier for the series.
> 
> Some points I felt they're not exactly right and should be fixed up
> before we're moving on
> 
> Currently, drm driver have a wrong reference to the dt-binding,
> "mediatek,mt2701-mmsys" or "mediatek,mt8173-mmsys", they should be all
> for the subsystem exporting clock and reset line such common resource to
> its sub-devices. Every subsystem has a similar shape. I hope mmsys
> shouldn't be an exception.
> 
> DRM device needs to have its own dt-binding show how connections between
> DRM components being made and its node should be put under mmsys node.
> 
> In this way, it becomes easy to see how the topology of the subsystem is
> and grows, like a tree "device tree", instead of hiding the details in
> the implementation.
> 
> The similar example we already did for audsys on mt2701 and mt7623 as
> below
> 
> 	audsys: clock-controller at 11220000 {
> 		
compatible = "mediatek,mt7623-audsys",
> 		
	     "mediatek,mt2701-audsys",
> 		
	     "syscon";
> 		
	...
> 
> 		
afe: audio-controller {
> 		
	compatible = "mediatek,mt7623-audio",
> 		
		
     "mediatek,mt2701-audio";
> 
> 		
	...
> 		
};
> 	};

This looks very strange to me. I'm not familiar with the hardware 
architecture, but a clock controller that includes an audio controller seems 
like a very weird design. It's usually the other way around, you have an audio 
controller, and it also contains hardware that produces clocks, and possibly 
handles miscellaneous audio-related routing tasks. I would thus expect the 
reverse in the device tree:

	afe: audio-controller at 11220000 {
		
compatible = "mediatek,mt7623-audio",
		
	     "mediatek,mt2701-audio";
		
..

		
audsys: clock-controller {
		
	compatible = "mediatek,mt7623-audsys",
		
		
     "mediatek,mt2701-audsys",
		
		
     "syscon";
		
	...
		
};
	};

And if audsys only exposes clocks, you don't even need a subnode to represent 
it, the audio controller itself can be a clock provider.

	afe: audio-controller at 11220000 {
		
compatible = "mediatek,mt7623-audio",
		
	     "mediatek,mt2701-audio";
		
#clock-cells = <1>;
		
..
	};

> > Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> > ---
> > 
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 18 ++++++++++++++++++
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
> >  2 files changed, 20 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > b/drivers/gpu/drm/mediatek/mtk_drm_drv.c index dd249cf5121e..c946aea722e5
> > 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -173,6 +173,7 @@ static const struct mtk_mmsys_driver_data
> > mt2701_mmsys_driver_data = {> 
> >  	.ext_path = mt2701_mtk_ddp_ext,
> >  	.ext_len = 
ARRAY_SIZE(mt2701_mtk_ddp_ext),
> >  	.shadow_register = true,
> > 
> > +	.clk_drv_name = "clk-mt2701-mm",
> > 
> >  };
> >  
> >  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
> > 
> > @@ -180,6 +181,7 @@ static const struct mtk_mmsys_driver_data
> > mt8173_mmsys_driver_data = {> 
> >  	.main_len = 
ARRAY_SIZE(mt8173_mtk_ddp_main),
> >  	.ext_path = mt8173_mtk_ddp_ext,
> >  	.ext_len = 
ARRAY_SIZE(mt8173_mtk_ddp_ext),
> > 
> > +	.clk_drv_name = "clk-mt8173-mm",
> > 
> >  };
> >  
> >  static int mtk_drm_kms_init(struct drm_device *drm)
> > 
> > @@ -411,6 +413,19 @@ static int mtk_drm_probe(struct platform_device
> > *pdev)
> > 
> >  	if (IS_ERR(private->config_regs))
> >  	
> >  		
return PTR_ERR(private->config_regs);
> > 
> > +	if (private->data->clk_drv_name) {
> > +		
private->clk_dev = platform_device_register_data(dev,
> > +		
		
		
private->data->clk_drv_name, -1,
> > +		
		
		
NULL, 0);
> > +
> > +		
if (IS_ERR(private->clk_dev)) {
> > +		
	pr_err("failed to register %s platform 
device\n",
> > +		
		
		
private->data->clk_drv_name);
> > +
> > +		
	return PTR_ERR(private->clk_dev);
> > +		
}
> > +	}
> > +
> > 
> >  	/* Iterate over sibling DISP 
function blocks */
> >  	for_each_child_of_node(dev->of_node-
>parent, node) {
> >  	
> >  		
const struct of_device_id *of_id;
> > 
> > @@ -515,6 +530,9 @@ static int mtk_drm_remove(struct platform_device
> > *pdev)
> > 
> >  	for (i = 0; i < 
DDP_COMPONENT_ID_MAX; i++)
> >  	
> >  		
of_node_put(private->comp_node[i]);
> > 
> > +	if (private->clk_dev)
> > +		
platform_device_unregister(private->clk_dev);
> > +
> > 
> >  	return 0;
> >  
> >  }
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > b/drivers/gpu/drm/mediatek/mtk_drm_drv.h index 86cec19193c4..200eee5de419
> > 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > @@ -34,11 +34,13 @@ struct mtk_mmsys_driver_data {
> > 
> >  	const enum mtk_ddp_comp_id 
*ext_path;
> >  	unsigned int ext_len;
> >  	bool shadow_register;
> > 
> > +	const char *clk_drv_name;
> > 
> >  };
> >  
> >  struct mtk_drm_private {
> >  
> >  	struct drm_device *drm;
> >  	struct device *dma_dev;
> > 
> > +	struct platform_device *clk_dev;
> > 
> >  	unsigned int num_pipes;


-- 
Regards,

Laurent Pinchart
