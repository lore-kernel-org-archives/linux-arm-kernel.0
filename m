From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jun 2017 16:00:14 +0100
Subject: [PATCH 3/8] ARM: l2x0: support parity-enable/disable on aurora
In-Reply-To: <20170630145106.29820-4-jlu@pengutronix.de>
References: <20170630145106.29820-1-jlu@pengutronix.de>
 <20170630145106.29820-4-jlu@pengutronix.de>
Message-ID: <20170630150013.GY4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 04:51:01PM +0200, Jan Luebbe wrote:
> From: Chris Packham <chris.packham@alliedtelesis.co.nz>
> 
> The aurora cache on the Marvell Armada-XP SoC supports the same tag
> parity features as the other l2x0 cache implementations.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> [jlu at pengutronix.de: use aurora specific define AURORA_ACR_PARITY_EN]

As far as I can see, there is no definition of AURORA_ACR_PARITY_EN in
mainline kernels at the moment, and your patch series (to this point)
does not add it.

The definition for this, and the ECC bit appears to be in patch 8.
This breaks bisection.  Please ensure that definitions are added in
patches either before or with the patch that makes use of the new
definition, never afterwards.

Thanks.

> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  arch/arm/mm/cache-l2x0.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 7d2d2a3c67d0..b70bee74750d 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -1505,6 +1505,13 @@ static void __init aurora_of_parse(const struct device_node *np,
>  		mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
>  	}
>  
> +	if (of_property_read_bool(np, "arm,parity-enable")) {
> +		mask |= AURORA_ACR_PARITY_EN;
> +		val |= AURORA_ACR_PARITY_EN;
> +	} else if (of_property_read_bool(np, "arm,parity-disable")) {
> +		mask |= AURORA_ACR_PARITY_EN;
> +	}
> +
>  	*aux_val &= ~mask;
>  	*aux_val |= val;
>  	*aux_mask &= ~mask;
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
