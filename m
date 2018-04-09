From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 09 Apr 2018 17:55:40 +0200
Subject: [PATCH v8 07/14] ARM: dts: rockchip: add clocks in iommu nodes
In-Reply-To: <df522a01-6f4a-bb96-4423-19965b078a1b@arm.com>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
 <10157755.JROavG9E9U@diego> <df522a01-6f4a-bb96-4423-19965b078a1b@arm.com>
Message-ID: <2255884.b1SkkUdh3X@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 9. April 2018, 17:53:01 CEST schrieb Robin Murphy:
> On 09/04/18 16:44, Heiko St?bner wrote:
> > Hi Tomeu,
> > 
> > Am Montag, 9. April 2018, 16:41:56 CEST schrieb Tomeu Vizoso:
> >> in today's linux-next, the DRM driver fails to probe because the iommu
> >> driver fails to find the aclk. I need to apply this patch for things
> >> to work again.
> > 
> > Thanks for catching that issue.
> > 
> > This seems to expose a backwards-compatibility issue, as this breaks
> > all old devicetrees, so should get a proper fix, apart from me applying
> > the dt-patch I missed.
> > 
> > Looking at the iommu-clock-handling patch, I imagine this part as
> > the culprit:
> > 
> > +	iommu->num_clocks = ARRAY_SIZE(rk_iommu_clocks);
> > +	iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
> > +				     sizeof(*iommu->clocks), GFP_KERNEL);
> > +	if (!iommu->clocks)
> > +		return -ENOMEM;
> > 
> > The clk-bulk functions seem to work with simple for loops and
> > should (as the other standard clock functions) just work fine with
> > an empty struct, so I guess a simple
> > 
> > 	if (!iommu->clocks && iommu->num_clocks > 0)
> > 	
> > 		return -ENOMEM;
> > 
> > should hopefully be enough. I'll try to give this a test later on
> > if nobody beats me to it :-)
> 
> But iommu->num_clocks is clearly set to a nonzero compile-time constant
> at this point ;)
> 
> I'd assume it's the return from devm_clk_bulk_get() which needs to
> special-case the "no clocks found" case from any other error, and *then*
> blat num_clocks to 0 if so.

you're right of course. Looking at it again, I now clearly see the ARRAY_SIZE
and am wondering what made me think num_clocks would be runtime-read.

Must be those 25?C today ;-)
