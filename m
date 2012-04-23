From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Apr 2012 12:58:41 +0800
Subject: [PATCH 2/5] dma: mxs-dma: make platform_device_id more generic
In-Reply-To: <20120423035846.GB24843@shlinux2.ap.freescale.net>
References: <1334753197-12032-1-git-send-email-b29396@freescale.com>
 <1334753197-12032-3-git-send-email-b29396@freescale.com>
 <20120423030114.GI26306@S2101-09.ap.freescale.net>
 <20120423035846.GB24843@shlinux2.ap.freescale.net>
Message-ID: <20120423045838.GK26306@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 11:58:48AM +0800, Dong Aisheng wrote:
...
> Remove HW_APBH_VERSION_*?
> But i see the some other places in original code still need to use it.
> Like:
> #define apbh_is_old()	(mxs_dma->version < APBH_VERSION_LATEST)
> ..
> #define HW_APBHX_CHn_NXTCMDAR(n) \
>         (((dma_is_apbh() && apbh_is_old()) ? 0x050 : 0x110) + (n) * 0x70)
> #define HW_APBHX_CHn_SEMA(n) \
>         (((dma_is_apbh() && apbh_is_old()) ? 0x080 : 0x140) + (n) * 0x70)
> 
> Do you mean apbh_is_old represents the same as SoC type and can be replaced
> by mxs_dma_type?
> 
Yes.

>  >  #define HW_APBX_VERSION				0x800
> > >  #define BP_APBHX_VERSION_MAJOR			24
> > >  #define HW_APBHX_CHn_NXTCMDAR(n) \
> > > @@ -121,7 +122,8 @@ struct mxs_dma_chan {
> > >  #define MXS_DMA_CHANNELS_MASK		0xffff
> > >  
> > >  struct mxs_dma_engine {
> > > -	int				dev_id;
> > > +	unsigned int			type;
> > > +	unsigned int			dev_id;
> > >  	unsigned int			version;
> > >  	void __iomem			*base;
> > >  	struct clk			*clk;
> > > @@ -130,6 +132,74 @@ struct mxs_dma_engine {
> > >  	struct mxs_dma_chan		mxs_chans[MXS_DMA_CHANNELS];
> > >  };
> > >  
> > > +enum mxs_dma_devtype {
> > > +	IMX23_DMA,
> > > +	IMX28_DMA,
> > > +};
> > > +
> > > +struct mxs_dma_type {
> > > +	unsigned int type;
> > > +	unsigned int id;
> > > +};
> > > +
> > > +static struct mxs_dma_type mxs_dma_types[] = {
> > > +	{
> > > +		.type = IMX23_DMA,
> > > +		.id = MXS_DMA_APBH,
> > 
> > To me, IMX23_DMA is more like a id, while MXS_DMA_APBH is more like
> > a type.
> > 
> Well, i'm more like IMX23_DMA since they're different devices.
> Id to me is more like a same device but different id.
> And you see i already have enum mxs_dma_devtype.
> 
Ok, let me put more comment on this.  You have mxs_dma_devtype defined,
and then you should use it rather than "unsigned int" to define "type"
in struct mxs_dma_type.  And for better alignment, the MXS_DMA_APBH
and MXS_DMA_APBX should be changed to some enum type from the exsiting
macro.  Then, struct mxs_dma_type should probably look like the
following.

struct mxs_dma_type {
	enum mxs_dma_devtype type;
	enum mxs_dma_id id;
};

As you agreed below, we will have mxs_dma_ids for the platform_device_id
table, and mxs_dma_id here for another enum.

I think we really need a better semantics for "type" and "id" in this
driver.

> > > +	}, {
> > > +		.type = IMX23_DMA,
> > > +		.id = MXS_DMA_APBX,
> > > +	}, {
> > > +		.type = IMX28_DMA,
> > > +		.id = MXS_DMA_APBH,
> > > +	}, {
> > > +		.type = IMX28_DMA,
> > > +		.id = MXS_DMA_APBX,
> > > +	}, {
> > > +		/* end of list */
> > > +	}
> > 
> > This end sign is not needed, I think.
> > 
> Ok to me.
> btw i always had this question before,
> Can you tell what's purpose of adding a '/* end of list */'?
> 

The end sign I meant is "{ }".  It's needed for platform_device_id
and of_device_id table by driver core.  But I do not see why we need
it for mxs_dma_type table here.

> > > +};
> > > +
> > > +static struct platform_device_id mxs_dma_idt[] = {
> > 
> > s/mxs_dma_idt/mxs_dma_ids?
> > 
> Ok to me.
> 
> > > +	{
> > > +		.name = "imx23-dma-apbh",
> > > +		.driver_data = (kernel_ulong_t) &mxs_dma_types[0],
> > > +	}, {
> > > +		.name = "imx23-dma-apbx",
> > > +		.driver_data = (kernel_ulong_t) &mxs_dma_types[1],
> > > +	}, {
> > > +		.name = "imx28-dma-apbh",
> > > +		.driver_data = (kernel_ulong_t) &mxs_dma_types[2],
> > > +	}, {
> > > +		.name = "imx28-dma-apbx",
> > > +		.driver_data = (kernel_ulong_t) &mxs_dma_types[3],
> > > +	}, {
> > > +		/* end of list */
> > > +	}
> > > +};
> > > +

-- 
Regards,
Shawn
