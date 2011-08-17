From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 17 Aug 2011 10:17:06 +0900
Subject: [PATCH 1/3] ARM: EXYNOS4: use dma-pl330 device name for clock
In-Reply-To: <1313530266-14939-2-git-send-email-vz@mleia.com>
References: <1313530266-14939-1-git-send-email-vz@mleia.com>
	<1313530266-14939-2-git-send-email-vz@mleia.com>
Message-ID: <000b01cc5c7b$6184fce0$248ef6a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vladimir Zapolskiy wrote:
> Sent: Wednesday, August 17, 2011 6:31 AM
> To: Kukjin Kim
> Cc: linux-samsung-soc at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Vladimir Zapolskiy; Boojin Kim
> Subject: [PATCH 1/3] ARM: EXYNOS4: use dma-pl330 device name for clock
>
> This change replaces s3c-pl330.x clock device names with dma-pl330.x,
> otherwise there won't be a correspondence between clock device name
> and amba device name, thus clocks can't be enabled.
>
> Fixes runtime errors on clk_get() from drivers/dma/pl330.c:
>   dma-pl330 dma-pl330.0: Cannot get operation clock.
>   dma-pl330: probe of dma-pl330.0 failed with error -22
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Boojin Kim <boojin.kim@samsung.com>
> ---
>  arch/arm/mach-exynos4/clock.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-
> exynos4/clock.c
> index fee2dd8..04c997a 100644
> --- a/arch/arm/mach-exynos4/clock.c
> +++ b/arch/arm/mach-exynos4/clock.c
> @@ -460,12 +460,12 @@ static struct clk init_clocks_off[] = {
>  		.ctrlbit	= (1 << 10),
>  	}, {
>  		.name		= "dma",
> -		.devname	= "s3c-pl330.0",
> +		.devname	= "dma-pl330.0",
>  		.enable		= exynos4_clk_ip_fsys_ctrl,
>  		.ctrlbit	= (1 << 0),
>  	}, {
>  		.name		= "dma",
> -		.devname	= "s3c-pl330.1",
> +		.devname	= "dma-pl330.1",
>  		.enable		= exynos4_clk_ip_fsys_ctrl,
>  		.ctrlbit	= (1 << 1),
>  	}, {
> --
> 1.7.5.1

I checked this patch just now.
This patch looks good to me. but this missed regarding s5p64x0 dma-pl330
clock.
So, need to following.

diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c
b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index c1f548f..c54c65d 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -147,6 +147,7 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "dma",
+		.devname	= "dma-pl330",
 		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p64x0_hclk0_ctrl,
 		.ctrlbit	= (1 << 12),
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c
b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index 3d9b609..2d04abf 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -180,6 +180,7 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "dma",
+		.devname	= "dma-pl330",
 		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p64x0_hclk0_ctrl,
 		.ctrlbit	= (1 << 12),

Ohters, looks ok to me
Acked-by: Boojin Kim <boojin.kim@samsung.com>
