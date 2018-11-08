From: bp@alien8.de (Borislav Petkov)
Date: Thu, 8 Nov 2018 16:17:43 +0100
Subject: [PATCH v5 5/8] ARM: l2x0: add marvell,ecc-enable property for
 aurora
In-Reply-To: <20181029072535.31667-6-chris.packham@alliedtelesis.co.nz>
References: <20181029072535.31667-1-chris.packham@alliedtelesis.co.nz>
 <20181029072535.31667-6-chris.packham@alliedtelesis.co.nz>
Message-ID: <20181108151743.GE7543@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 08:25:32PM +1300, Chris Packham wrote:
> The aurora cache on the Marvell Armada-XP SoC supports ECC protection
> for the L2 data arrays. Add a "marvell,ecc-enable" device tree property
> which can be used to enable this.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> [jlu at pengutronix.de: use aurora specific define AURORA_ACR_ECC_EN]
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/l2c2x0.txt | 2 ++
>  arch/arm/mm/cache-l2x0.c                         | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> index fbe6cb21f4cf..15a84f0ba9f1 100644
> --- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
> +++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> @@ -76,6 +76,8 @@ Optional properties:
>    specified to indicate that such transforms are precluded.
>  - arm,parity-enable : enable parity checking on the L2 cache (L220 or PL310).
>  - arm,parity-disable : disable parity checking on the L2 cache (L220 or PL310).
> +- marvell,ecc-enable : enable ECC protection on the L2 cache
> +- marvell,ecc-disable : disable ECC protection on the L2 cache
>  - arm,outer-sync-disable : disable the outer sync operation on the L2 cache.
>    Some core tiles, especially ARM PB11MPCore have a faulty L220 cache that
>    will randomly hang unless outer sync operations are disabled.
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index b70bee74750d..644f786e4fa9 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -1505,6 +1505,13 @@ static void __init aurora_of_parse(const struct device_node *np,
>  		mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
>  	}
>  
> +	if (of_property_read_bool(np, "marvell,ecc-enable")) {
> +		mask |= AURORA_ACR_ECC_EN;
> +		val |= AURORA_ACR_ECC_EN;
> +	} else if (of_property_read_bool(np, "marvell,ecc-disable")) {
> +		mask |= AURORA_ACR_ECC_EN;
> +	}
> +
>  	if (of_property_read_bool(np, "arm,parity-enable")) {
>  		mask |= AURORA_ACR_PARITY_EN;
>  		val |= AURORA_ACR_PARITY_EN;
> -- 

checkpatch complains here:

WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.txt

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
