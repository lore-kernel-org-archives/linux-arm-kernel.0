From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 31 Aug 2011 08:48:03 +0900
Subject: [PATCH] ARM: S3C64XX: Fix clkdev device names for I2C clocks
In-Reply-To: <1314739841-13522-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1314739841-13522-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <CAH9JG2UEZVQ+5AJbbtXQhuVzvDp_8-wJdNgOjwHs14Zj7_KP+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 6:30 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> When the S3C64xx CPUs were converted to clkdev mappings were added for the
> I2C controllers on them but there's a couple of issues with these mappings:
>
> - We're randomly using a device name for controller 1 but not controller 0
> ?which is odd.
> - The controller type for controller 1 is s3c2440, not s3c2410 which is
> ?what the device is actually registered as so dev_name() based lookups
> ?fail.
>
> The end result is that only controller 0 has a good mapping, though for
> some reason this did used to work.
>
> Something in recent -next appears to have triggered this but I can't for
> the life of me figure out how it ever worked.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> ?arch/arm/mach-s3c64xx/clock.c | ? ?3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
> index 872e683..3f2bb26 100644
> --- a/arch/arm/mach-s3c64xx/clock.c
> +++ b/arch/arm/mach-s3c64xx/clock.c
> @@ -138,12 +138,13 @@ static struct clk init_clocks_off[] = {
> ? ? ? ? ? ? ? ?.ctrlbit ? ? ? ?= S3C_CLKCON_PCLK_TSADC,
> ? ? ? ?}, {
> ? ? ? ? ? ? ? ?.name ? ? ? ? ? = "i2c",
> + ? ? ? ? ? ? ? .devname ? ? ? ?= "s3c2440-i2c.0",
> ? ? ? ? ? ? ? ?.parent ? ? ? ? = &clk_p,
> ? ? ? ? ? ? ? ?.enable ? ? ? ? = s3c64xx_pclk_ctrl,
> ? ? ? ? ? ? ? ?.ctrlbit ? ? ? ?= S3C_CLKCON_PCLK_IIC,
> ? ? ? ?}, {
> ? ? ? ? ? ? ? ?.name ? ? ? ? ? = "i2c",
> - ? ? ? ? ? ? ? .devname ? ? ? ?= "s3c2440-i2c.1",
> + ? ? ? ? ? ? ? .devname ? ? ? ?= "s3c2410-i2c.1",
It's not matched with your description. and also not matched with
codes at "arch/arm/mach-s3c64xx/s3c6410.c"

       /* the i2c devices are directly compatible with s3c2440 */
        s3c_i2c0_setname("s3c2440-i2c");
        s3c_i2c1_setname("s3c2440-i2c");

Thank you,
Kyungmin Park

> ? ? ? ? ? ? ? ?.parent ? ? ? ? = &clk_p,
> ? ? ? ? ? ? ? ?.enable ? ? ? ? = s3c64xx_pclk_ctrl,
> ? ? ? ? ? ? ? ?.ctrlbit ? ? ? ?= S3C6410_CLKCON_PCLK_I2C1,
> --
> 1.7.5.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
