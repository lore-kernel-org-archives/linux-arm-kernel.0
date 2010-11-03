From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 3 Nov 2010 18:29:03 +0530
Subject: [PATCH v3 06/13] OMAP3: DMA: hwmod: add system DMA
In-Reply-To: <1288099513-1854-7-git-send-email-manjugk@ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-7-git-send-email-manjugk@ti.com>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC03B4C3@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin/Benoit, 

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of G, 
> Manjunath Kondaiah
> Sent: Tuesday, October 26, 2010 6:55 PM
> To: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; Cousson, Benoit; 
> Kevin Hilman; Shilimkar, Santosh
> Subject: [PATCH v3 06/13] OMAP3: DMA: hwmod: add system DMA
> 
> Add OMAP3 DMA hwmod structures.
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   93 
> ++++++++++++++++++++++++++++
>  1 files changed, 93 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c 
> b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index ed6bf4a..4a5231c 100644
[...]
> +	.prcm = {
> +		.omap2 = {
> +			.prcm_reg_id		= 1,
> +			.module_bit		= 
> OMAP3430_ST_SDMA_SHIFT,
> +			.idlest_reg_id		= 1,
> +			.idlest_idle_bit	= 
> OMAP3430_ST_SDMA_SHIFT,

Looks like the .module_offs field is missing here. Since
ST_SDMA bit belongs to CM_IDLEST1_CORE register, .module_offs should
be CORE_MOD.

But, it is observed that, using .module_offs results in warning dump 
during bootup. This is due to, ST_SDMA bit in standby mode. Since
there is no fclk for DMA, this bit will never change till DMA channel
is requested for data transfer.

We might have to bypass calling "omap2_cm_wait_module_ready" in 
"_wait_target_ready" in omap_hwmod.c

With exising flags, we can use "HWMOD_NO_IDLEST" flag, but this
flag has different meaning. How about using new flag like
"HWMOD_NO_FCLK_OPCLK" and if it is set, return without calling 
"omap2_cm_wait_module_ready"

Any better suggestion to handle this issue?

-Manjunath
