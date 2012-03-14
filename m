From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 14 Mar 2012 16:23:52 +0800
Subject: [PATCH v1 4/5] dma: mxs-dma: add dt probe support
In-Reply-To: <4F604EBD.7060400@freescale.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-5-git-send-email-b29396@freescale.com>
 <4F604EBD.7060400@freescale.com>
Message-ID: <20120314082352.GC1180@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 03:54:37PM +0800, Huang Shijie-B32955 wrote:
> Hi Aisheng:
> > From: Dong Aisheng<dong.aisheng@linaro.org>
> >
> > Signed-off-by: Dong Aisheng<dong.aisheng@linaro.org>
> > ---
> >   .../devicetree/bindings/dma/fsl-mxs-dma.txt        |   17 ++++++++
> >   drivers/dma/mxs-dma.c                              |   44 +++++++++++++------
> >   2 files changed, 47 insertions(+), 14 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt b/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
> > new file mode 100644
> > index 0000000..cfa1730
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
> > @@ -0,0 +1,17 @@
> > +* Freescale MXS DMA
> > +
> > +Required properties:
> > +- compatible : Should be "fsl,mxs-dma-apbh" or "fsl,mxs-dma-apbx"
> > +- reg : Should contain registers location and length
> > +
> > +Examples:
> > +
> > +dma-apbh at 80004000 {
> > +	compatible = "fsl,mxs-dma-apbh";
> > +	reg =<0x80004000 2000>;
> > +};
> > +
> > +dma-apbx at 80024000 {
> > +	compatible = "fsl,mxs-dma-apbx";
> > +	reg =<0x80024000 2000>;
> > +};
> > diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> > index b06cd4c..45e8d46 100644
> > --- a/drivers/dma/mxs-dma.c
> > +++ b/drivers/dma/mxs-dma.c
> > @@ -22,6 +22,9 @@
> >   #include<linux/platform_device.h>
> >   #include<linux/dmaengine.h>
> >   #include<linux/delay.h>
> > +#include<linux/module.h>
> > +#include<linux/of.h>
> > +#include<linux/of_device.h>
> >
> >   #include<asm/irq.h>
> >   #include<mach/mxs.h>
> > @@ -130,6 +133,25 @@ struct mxs_dma_engine {
> >   	struct mxs_dma_chan		mxs_chans[MXS_DMA_CHANNELS];
> >   };
> >
> > +static struct platform_device_id mxs_dma_type[] = {
> > +	{
> > +		.name = "mxs-dma-apbh",
> > +		.driver_data = MXS_DMA_APBH,
> > +	}, {
> > +		.name = "mxs-dma-apbx",
> > +		.driver_data = MXS_DMA_APBX,
> > +	}, {
> > +		/* end of list */
> > +	}
> > +};
> > +
> I think you should use the platform_device_id to distinguish different 
> archs.
> In the mx6q,  you will meet some compiler error for the macro cpu_is_mx23().
> 
Yes, i will remove cpu_is_*() in mxs-mmc driver by using device id.

Regards
Dong Aisheng
