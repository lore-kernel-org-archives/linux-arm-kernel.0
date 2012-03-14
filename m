From: khilman@ti.com (Kevin Hilman)
Date: Wed, 14 Mar 2012 14:15:56 -0700
Subject: [PATCH] OMAP3: OPP: Test for IVA subsystem before attempting to
 add IVA OPP
In-Reply-To: <1331746695-24372-1-git-send-email-mvs@tigris.de> (Maximilian
 Schwerin's message of "Wed, 14 Mar 2012 18:38:15 +0100")
References: <1331746695-24372-1-git-send-email-mvs@tigris.de>
Message-ID: <874ntqg9yr.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maximilian Schwerin <mvs@tigris.de> writes:

> From: Steve Sakoman <steve@sakoman.com>
>
> Don't try to add IVA OPPs for OMAP3 versions not containing an IVA
> subsystem, as this would make omap_init_opp_table fail.
>
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> Signed-off-by: Maximilian Schwerin <mvs@tigris.de>

Minor: patch subjects for arch/arm/* core code need to have the ARM:
prefix also.

Also, please run scripts/checkpatch.pl on your patch and fix the
warnings.

> ---
>  arch/arm/mach-omap2/opp.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
> index 9262a6b..414f2ec 100644
> --- a/arch/arm/mach-omap2/opp.c
> +++ b/arch/arm/mach-omap2/opp.c
> @@ -62,6 +62,10 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
>  				__func__, i);
>  			return -EINVAL;
>  		}
> +
> +		if ((strcmp(opp_def->hwmod_name,"iva") == 0) && !omap3_has_iva())
> +			continue;
> +
>  		oh = omap_hwmod_lookup(opp_def->hwmod_name);
>  		if (!oh || !oh->od) {
>  			pr_warn("%s: no hwmod or odev for %s, [%d] "

Wouldn't the one-liner below do the same thing?

Actually, your patch makes it less noisy at boot time, avoiding the
pr_warn(), so is probably better.

Kevin

diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
index 9262a6b..d3d4fa2 100644
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@ -67,7 +67,7 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 			pr_warn("%s: no hwmod or odev for %s, [%d] "
 				"cannot add OPPs.\n", __func__,
 				opp_def->hwmod_name, i);
-			return -EINVAL;
+			continue;
 		}
 		dev = &oh->od->pdev->dev;
