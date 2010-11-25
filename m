From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 25 Nov 2010 17:01:08 +0900
Subject: [PATCH] ARM: s3c2440: fix AC97 and camera clock registration
In-Reply-To: <1289989343-28816-1-git-send-email-fg@emlix.com>
References: <1289989343-28816-1-git-send-email-fg@emlix.com>
Message-ID: <00b501cb8c76$edb20e90$c9162bb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabian Godehardt wrote:
> 
> This patch fixes 2 problems:
>  - it sets the correct bitmask of the AC97 flag on the control-bit field
>  - it increases the usage counter of both clocks because they get
decreased
>    on clock registration (a few lines later)
> 
> Maybe it is a better idea to check the usage counter on clk_disable() so
> it can not reach values <0.
> 
> Signed-off-by: Fabian Godehardt <fg@emlix.com>
> ---
>  arch/arm/mach-s3c2440/clock.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2440/clock.c b/arch/arm/mach-s3c2440/clock.c
> index 3dc2426..0fc8461 100644
> --- a/arch/arm/mach-s3c2440/clock.c
> +++ b/arch/arm/mach-s3c2440/clock.c
> @@ -93,6 +93,7 @@ static struct clk s3c2440_clk_cam = {
>  	.id		= -1,
>  	.enable		= s3c2410_clkcon_enable,
>  	.ctrlbit	= S3C2440_CLKCON_CAMERA,
> +	.usage		= 1,
>  };
> 
>  static struct clk s3c2440_clk_cam_upll = {
> @@ -108,7 +109,8 @@ static struct clk s3c2440_clk_ac97 = {
>  	.name		= "ac97",
>  	.id		= -1,
>  	.enable		= s3c2410_clkcon_enable,
> -	.ctrlbit	= S3C2440_CLKCON_CAMERA,
> +	.ctrlbit	= S3C2440_CLKCON_AC97,

Ok.

> +	.usage		= 1,
>  };
> 
>  static int s3c2440_clk_add(struct sys_device *sysdev)
> --
> 1.6.6.1

How about following for fix usage field?

diff --git a/arch/arm/mach-s3c2440/clock.c b/arch/arm/mach-s3c2440/clock.c
index 3dc2426..2f393cb 100644
--- a/arch/arm/mach-s3c2440/clock.c
+++ b/arch/arm/mach-s3c2440/clock.c
@@ -108,11 +108,12 @@ static struct clk s3c2440_clk_ac97 = {
        .name           = "ac97",
        .id             = -1,
        .enable         = s3c2410_clkcon_enable,
-       .ctrlbit        = S3C2440_CLKCON_CAMERA,
+       .ctrlbit        = S3C2440_CLKCON_AC97,
 };

 static int s3c2440_clk_add(struct sys_device *sysdev)
 {
+       unsigned long clkcon  = __raw_readl(S3C2410_CLKCON);
        struct clk *clock_upll;
        struct clk *clock_h;
        struct clk *clock_p;
@@ -130,6 +131,9 @@ static int s3c2440_clk_add(struct sys_device *sysdev)
        s3c2440_clk_ac97.parent = clock_p;
        s3c2440_clk_cam_upll.parent = clock_upll;

+       s3c2440_clk_cam.usage = clkcon & s3c2440_clk_cam.ctrlbit ? 1 : 0;
+       s3c2440_clk_ac97.usage = clkcon & s3c2440_clk_ac97.ctrlbit ? 1 : 0;
+
        s3c24xx_register_clock(&s3c2440_clk_ac97);
        s3c24xx_register_clock(&s3c2440_clk_cam);
        s3c24xx_register_clock(&s3c2440_clk_cam_upll);

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
