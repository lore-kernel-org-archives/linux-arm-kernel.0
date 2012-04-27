From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 Apr 2012 14:21:59 -0700
Subject: [PATCH] arm: omap3: am35x: Don't mark missing features as present
In-Reply-To: <1334861927-1741-1-git-send-email-mgreer@animalcreek.com> (Mark
 A. Greer's message of "Thu, 19 Apr 2012 11:58:47 -0700")
References: <1334861927-1741-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <871un827m0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> The Chip Identification register on the am35x family of SoCs
> has bits 12, 7:5, and 3:2 marked as reserved and are read as
> zeroes.  Unfortunately, on other omap SoCs, a 0 bit means a
> feature is "Full Use" so the OMAP3_CHECK_FEATURE() macro
> called by omap3_check_features() will incorrectly interpret
> those zeroes to mean that a feature is present even though it
> isn't.  To fix that, the feature bits that are incorrectly
> set (namely, OMAP3_HAS_IVA and OMAP3_HAS_ISP) need to be
> cleared after all of the calls to OMAP3_CHECK_FEATURE() in
> omap3_check_features() are made.
>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---
>  arch/arm/mach-omap2/id.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 0e79b7b..9736049 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -248,6 +248,17 @@ void __init omap3xxx_check_features(void)
>  	omap_features |= OMAP3_HAS_SDRC;
>  
>  	/*
> +	 * am35x fixups:
> +	 * - The am35x Chip ID register has bits 12, 7:5, and 3:2 marked as
> +	 *   reserved and therefore return 0 when read.  Unfortunately,
> +	 *   OMAP3_CHECK_FEATURE() will interpret some of those zeroes to
> +	 *   mean that a feature is present even though it isn't so clear
> +	 *   the incorrectly set feature bits.
> +	 */
> +	if (cpu_is_omap3505() || cpu_is_omap3517())
> +		omap_features &= ~(OMAP3_HAS_IVA | OMAP3_HAS_ISP);

I just sent a series that removes these cpu_is macros:

   http://marc.info/?l=linux-omap&m=133548306205953&w=2

It looks like I can just replace the above with 'if (cpu_is_am35xx()', correct?

Since you have various AM35x devices, could you could give my series a
spin and make this change?  If it works, and acked-by/tested-by on my
series would be appreciated as well.

Thanks,

Kevin




> +	/*
>  	 * TODO: Get additional info (where applicable)
>  	 *       e.g. Size of L2 cache.
>  	 */
