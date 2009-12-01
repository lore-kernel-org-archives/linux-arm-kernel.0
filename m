From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 1 Dec 2009 21:42:01 +0000
Subject: [PATCH 4/7] S3C64XX: Declare IISv4 PCLK for S3C6410
In-Reply-To: <1259340239-12067-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20091127164312.GA11913@rakim.wolfsonmicro.main>
	<1259340239-12067-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20091201214201.GP4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2009 at 04:43:56PM +0000, Mark Brown wrote:
> From: Jassi <jassi.brar@samsung.com>
> 
> [Updated the device ID to -1 since there's only one IISv4 device but the
> S3C clock API tries to match based on the ID of the requesting device
> (and not the name) -- broonie.]

I had a quick look at the other clock changes and there are a couple
of questions that have come up:

1) If changing the .id field of the iisv4 device really a good idea,
   especially if there might be more than one of them in the future?

2) The clock name for the current audio bus clock for the iisv4 unit
   is wrong as we're using it for both the iis and iisv4 blocks. It
   might be worth renaming the clock for the iisv4 audio bus before
   looking at changing the usage of the clock support (once the current
   changes have been sorted)

As such is the #ifdef of the clock code when the S3C6410 support
really necesary?
 
> Signed-Off-by: Jassi <jassi.brar@samsung.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/plat-s3c64xx/clock.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/clock.c b/arch/arm/plat-s3c64xx/clock.c
> index 7a36e89..2f1548e 100644
> --- a/arch/arm/plat-s3c64xx/clock.c
> +++ b/arch/arm/plat-s3c64xx/clock.c
> @@ -129,6 +129,14 @@ static struct clk init_clocks_disable[] = {
>  		.enable		= s3c64xx_pclk_ctrl,
>  		.ctrlbit	= S3C_CLKCON_PCLK_IIS1,
>  	}, {
> +#ifdef CONFIG_CPU_S3C6410
> +		.name		= "iis",
> +		.id		= -1,  /* There's only one IISv4 port */
> +		.parent		= &clk_p,
> +		.enable		= s3c64xx_pclk_ctrl,
> +		.ctrlbit	= S3C6410_CLKCON_PCLK_IIS2,
> +	}, {
> +#endif
>  		.name		= "spi",
>  		.id		= 0,
>  		.parent		= &clk_p,
> -- 
> 1.6.5.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
