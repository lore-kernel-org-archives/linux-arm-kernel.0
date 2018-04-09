From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 09 Apr 2018 23:49:58 +0200
Subject: [PATCH v8 07/14] ARM: dts: rockchip: add clocks in iommu nodes
In-Reply-To: <2255884.b1SkkUdh3X@diego>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
 <df522a01-6f4a-bb96-4423-19965b078a1b@arm.com> <2255884.b1SkkUdh3X@diego>
Message-ID: <5686492.Vgpi8vPSL1@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 9. April 2018, 17:55:40 CEST schrieb Heiko St?bner:
> Am Montag, 9. April 2018, 17:53:01 CEST schrieb Robin Murphy:
> > On 09/04/18 16:44, Heiko St?bner wrote:
> > > Hi Tomeu,
> > > 
> > > Am Montag, 9. April 2018, 16:41:56 CEST schrieb Tomeu Vizoso:
> > >> in today's linux-next, the DRM driver fails to probe because the iommu
> > >> driver fails to find the aclk. I need to apply this patch for things
> > >> to work again.
> > > 
> > > Thanks for catching that issue.
> > > 
> > > This seems to expose a backwards-compatibility issue, as this breaks
> > > all old devicetrees, so should get a proper fix, apart from me applying
> > > the dt-patch I missed.
> > > 
> > > Looking at the iommu-clock-handling patch, I imagine this part as
> > > the culprit:
> > > 
> > > +	iommu->num_clocks = ARRAY_SIZE(rk_iommu_clocks);
> > > +	iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
> > > +				     sizeof(*iommu->clocks), GFP_KERNEL);
> > > +	if (!iommu->clocks)
> > > +		return -ENOMEM;
> > > 
> > > The clk-bulk functions seem to work with simple for loops and
> > > should (as the other standard clock functions) just work fine with
> > > an empty struct, so I guess a simple
> > > 
> > > 	if (!iommu->clocks && iommu->num_clocks > 0)
> > > 	
> > > 		return -ENOMEM;
> > > 
> > > should hopefully be enough. I'll try to give this a test later on
> > > if nobody beats me to it :-)
> > 
> > But iommu->num_clocks is clearly set to a nonzero compile-time constant
> > at this point ;)
> > 
> > I'd assume it's the return from devm_clk_bulk_get() which needs to
> > special-case the "no clocks found" case from any other error, and *then*
> > blat num_clocks to 0 if so.
> 
> you're right of course. Looking at it again, I now clearly see the
> ARRAY_SIZE and am wondering what made me think num_clocks would be
> runtime-read.
> 
> Must be those 25?C today ;-)

In any case, this does not seem to fully fix the issue ... or be more exact 
seems to be the only issue.

- With 4.16 both pinky and kevin have working displays.
- When I was merging display patches to drm-misc, I did boot-tests on
  both pinky and kevin, keeping their displays in a working state.

- With current torvalds head (iommu not merged yet)
e9092d0d9796 ("Fix subtle macro variable shadowing in min_not_zero()")

I get display output on rk3399-kevin (edp), but not on
rk3288-pinky (edp + hdmi). [components + hdmi device+modes get
recognized correctly though]

- With iommu changes merged I end up with the failing clock issue
  which can be countered by making the iommu-clocks optional.

- After that I get working display output again on kevin but not pinky.

Looks like this needs bisecting.
