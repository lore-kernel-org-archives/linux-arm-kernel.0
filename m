From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 5 Sep 2018 19:45:13 +0200
Subject: [PATCH] mini2440 MMC correct write protect detection
In-Reply-To: <85dac0df-2b75-9cc4-fde1-f62136974a1e@free.fr>
References: <85dac0df-2b75-9cc4-fde1-f62136974a1e@free.fr>
Message-ID: <20180905174513.6w7z5jsc2e6ndntv@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 10:36:35PM +0200, Cedric Roux wrote:
> mini2440 MMC correct write protect detection
> 
> The mini2440 computer uses "active high" to signal that the "write protect"
> of the inserted MMC is set. The current code uses the opposite, leading to
> a wrong detection of write protection. The solution is simply to use
> ".wprotect_invert = 1" in the description of the MMC.

I looked at Mini2440 schematics found on the net and it looks like the
pin (just like CD) is active low. However I might be looking at wrong
schematics or missing some things.

This is really an old code so I am just quite surprised that it was not
reported before. Not able to write to SD card (for example if it is
rootfs) should be spotted quite early.

Best regards,
Krzysztof


> 
> Signed-off-by: Cedric Roux <sed@free.fr>
> 
> --- arch/arm/mach-s3c24xx/mach-mini2440.c.orig	2018-09-04 22:15:20.696087528 +0200
> +++ arch/arm/mach-s3c24xx/mach-mini2440.c	2018-09-04 22:15:32.708088023 +0200
> @@ -232,6 +232,7 @@ static struct s3c2410fb_mach_info mini24
>  /* MMC/SD  */
>  
>  static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
> +   .wprotect_invert = 1,
>     .gpio_detect   = S3C2410_GPG(8),
>     .gpio_wprotect = S3C2410_GPH(8),
>     .set_power     = NULL,
