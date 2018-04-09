From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 9 Apr 2018 16:53:01 +0100
Subject: [PATCH v8 07/14] ARM: dts: rockchip: add clocks in iommu nodes
In-Reply-To: <10157755.JROavG9E9U@diego>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
 <20180323073814.5802-8-jeffy.chen@rock-chips.com>
 <CAAObsKCkg4+Ji=HPXnHCoxF9g0=uBgx+f+p-ehZ_D4Ld5RVVgg@mail.gmail.com>
 <10157755.JROavG9E9U@diego>
Message-ID: <df522a01-6f4a-bb96-4423-19965b078a1b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/18 16:44, Heiko St?bner wrote:
> Hi Tomeu,
> 
> Am Montag, 9. April 2018, 16:41:56 CEST schrieb Tomeu Vizoso:
>> in today's linux-next, the DRM driver fails to probe because the iommu
>> driver fails to find the aclk. I need to apply this patch for things
>> to work again.
> 
> Thanks for catching that issue.
> 
> This seems to expose a backwards-compatibility issue, as this breaks
> all old devicetrees, so should get a proper fix, apart from me applying
> the dt-patch I missed.
> 
> Looking at the iommu-clock-handling patch, I imagine this part as
> the culprit:
> 
> +	iommu->num_clocks = ARRAY_SIZE(rk_iommu_clocks);
> +	iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
> +				     sizeof(*iommu->clocks), GFP_KERNEL);
> +	if (!iommu->clocks)
> +		return -ENOMEM;
> 
> The clk-bulk functions seem to work with simple for loops and
> should (as the other standard clock functions) just work fine with
> an empty struct, so I guess a simple
> 
> 	if (!iommu->clocks && iommu->num_clocks > 0)
> 		return -ENOMEM;
> 
> should hopefully be enough. I'll try to give this a test later on
> if nobody beats me to it :-)

But iommu->num_clocks is clearly set to a nonzero compile-time constant 
at this point ;)

I'd assume it's the return from devm_clk_bulk_get() which needs to 
special-case the "no clocks found" case from any other error, and *then* 
blat num_clocks to 0 if so.

Robin.
