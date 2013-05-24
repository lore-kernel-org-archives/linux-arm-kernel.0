From: horms@verge.net.au (Simon Horman)
Date: Fri, 24 May 2013 11:59:44 +0900
Subject: [PATCH] ARM: mach-shmobile: r8a7790: add SATA support
In-Reply-To: <878v352kb4.wl%kuninori.morimoto.gx@renesas.com>
References: <1369361184-20862-1-git-send-email-horms+renesas@verge.net.au>
 <878v352kb4.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130524025940.GA10536@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 07:17:22PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > Add SATA clock for r8a7790 SoC (for both device tree and usual cases).
> > Register SATA controller as a "late" platform device on r8a7790 SoC.
> > 
> > Based on "ARM: mach-shmobile: r8a7779: add SATA support" by
> > Vladimir Barinov.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> 
> > +	CLKDEV_DEV_ID("sata_rcar.1", &mstp_clks[MSTP814]),
> (snip)
> > +static __init void r8a7790_register_sata1(void)
> > +{
> > +
> > +	struct resource res[] = {
> > +		DEFINE_RES_MEM_NAMED(0xee300000, 0x200000, "rcar-sata"),
> > +		DEFINE_RES_IRQ(gic_iid(106)),
> > +	};
> > +
> > +	struct platform_device_info pdevinfo = {
> > +		.name = "sata_rcar",
> > +		.id = 1,
> > +		.res = res,
> > +		.num_res = ARRAY_SIZE(res),
> > +		.dma_mask = DMA_BIT_MASK(32),
> > +	};
> > +
> > +	platform_device_register_full(&pdevinfo);
> > +}
> 
> This is a little bit strange for me.
> Why you don't care SATA0 ?

Because the lager board only seems to expose SATA1 and I was
interested in something I could test.

I am happy to start caring about SATA0 if you think it is
a good idea.

> Can you use like this ?
> 
> static __init void r8a7790_register_sata(int id);

Sure, but I'm unsure how you want r8a7790_register_sata to handle id.

Is it just for the id field of struct platform_device_info pdevinfo?
Or also to switch between resources somehow?

> BTW, we need to decide "driver registration function naming" ?
> In r8a7778 case, it is using 
> 
> 	r8a7778_add_xxx_device()
> 	r8a7778_add_xxx_devices()
> 
> but r8a7778_register_xxx seems nice naming :)

I chose register as it seemed to be consistent with the
existing contents of r8a7790_add_standard_devices().
