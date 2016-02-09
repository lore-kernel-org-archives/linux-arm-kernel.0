From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Tue, 9 Feb 2016 18:12:24 +0000
Subject: [PATCH] of/irq: Fix msi-map calculation for nonzero rid-base
In-Reply-To: <9f6845195d03b0e0b0d187bb510fbf7bd497e836.1455015344.git.robin.murphy@arm.com>
References: <9f6845195d03b0e0b0d187bb510fbf7bd497e836.1455015344.git.robin.murphy@arm.com>
Message-ID: <HE1PR04MB16413597FD97D47AFB9880D78DD60@HE1PR04MB1641.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Tuesday, February 09, 2016 5:05 AM
> To: robh+dt at kernel.org; frowand.list at gmail.com; grant.likely at linaro.org;
> devicetree at vger.kernel.org
> Cc: marc.zyngier at arm.com; mark.rutland at arm.com; david.daney at cavium.com; Stuart Yoder
> <stuart.yoder@nxp.com>; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; stable at vger.kernel.org
> Subject: [PATCH] of/irq: Fix msi-map calculation for nonzero rid-base
> 
> The existing msi-map code is fine for shifting the entire RID space
> upwards, but attempting finer-grained remapping reveals a bug. It turns
> out that we are mistakenly treating the msi-base part as an offset, not
> as a new base to remap onto, so things get squiffy when rid-base is
> nonzero. Fix this, and at the same time add a sanity check against
> having msi-map-mask clash with a nonzero rid-base, as that's another
> thing one can easily get wrong.
> 
> CC: <stable@vger.kernel.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/of/irq.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 7ee21ae..e7bfc17 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -635,6 +635,13 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node
> **np,
>  		msi_base = be32_to_cpup(msi_map + 2);
>  		rid_len = be32_to_cpup(msi_map + 3);
> 
> +		if (rid_base & ~map_mask) {
> +			dev_err(parent_dev,
> +				"Invalid msi-map translation - msi-map-mask (0x%x) ignores rid-
> base (0x%x)\n",
> +				map_mask, rid_base);
> +			return rid_out;
> +		}
> +
>  		msi_controller_node = of_find_node_by_phandle(phandle);
> 
>  		matched = (masked_rid >= rid_base &&
> @@ -654,7 +661,7 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node
> **np,
>  	if (!matched)
>  		return rid_out;
> 
> -	rid_out = masked_rid + msi_base;
> +	rid_out = masked_rid - rid_base + msi_base;
>  	dev_dbg(dev,
>  		"msi-map at: %s, using mask %08x, rid-base: %08x, msi-base: %08x, length:
> %08x, rid: %08x -> %08x\n",
>  		dev_name(parent_dev), map_mask, rid_base, msi_base,
> --
> 2.7.0.25.gfc10eb5.dirty

Tested-by: Stuart Yoder <stuart.yoder@nxp.com>
