From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 1 Nov 2012 17:05:27 +0530
Subject: [RFC PATCH] ARM: OMAP4: ID: Improve features detection and check
In-Reply-To: <1351765401-12487-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1351765401-12487-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <50925E7F.7080602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 November 2012 03:53 PM, Ivan Khoronzhuk wrote:
> Replaces several flags bearing the same meaning. There is no need
> to set flags due to different omap types here, it can be checked
> in appropriate places as well.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>   arch/arm/mach-omap2/id.c  |   25 +++++++------------------
>   arch/arm/mach-omap2/soc.h |    8 ++------
>   2 files changed, 9 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index cf2362c..3c47a19 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -28,6 +28,9 @@
>   #include "soc.h"
>   #include "control.h"
>
> +#define OMAP4_SILICON_TYPE_STANDARD		0x01
> +#define OMAP4_SILICON_TYPE_PERFORMANCE		0x02
> +
>   static unsigned int omap_revision;
>   static const char *cpu_rev;
>   u32 omap_features;
> @@ -273,25 +276,11 @@ void __init omap4xxx_check_features(void)
>   {
>   	u32 si_type;
>
> -	if (cpu_is_omap443x())
> -		omap_features |= OMAP4_HAS_MPU_1GHZ;
> -
> +	si_type =
> +	(read_tap_reg(OMAP4_CTRL_MODULE_CORE_STD_FUSE_PROD_ID_1) >> 16) & 0x03;
>
> -	if (cpu_is_omap446x()) {
> -		si_type =
> -			read_tap_reg(OMAP4_CTRL_MODULE_CORE_STD_FUSE_PROD_ID_1);
> -		switch ((si_type & (3 << 16)) >> 16) {
> -		case 2:
> -			/* High performance device */
> -			omap_features |= OMAP4_HAS_MPU_1_5GHZ;
> -			break;
> -		case 1:
> -		default:
> -			/* Standard device */
> -			omap_features |= OMAP4_HAS_MPU_1_2GHZ;
> -			break;
> -		}
> -	}
> +	if (si_type == OMAP4_SILICON_TYPE_PERFORMANCE)
> +		omap_features = OMAP4_HAS_PERF_SILICON;

Well the detection isn't for performance/standard but there are some
features depend on it. For example 1 GHz doesn't DPLL DCC enable feature
where as 1.2 GHz, 1.5 GHz doesn't need. This is the main reason this
information is also effused. Have you considered this aspect while
creating this patch ?

Regards
Santosh
