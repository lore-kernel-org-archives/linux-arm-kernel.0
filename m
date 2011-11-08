From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 8 Nov 2011 21:57:56 +0530
Subject: [PATCH] ARM: S3C6410: Use device names for both I2C clocks
In-Reply-To: <1320768593-21010-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320768593-21010-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwTM4M-dt6mMgOH2TLEbBx7CgmiNVaB2VqYN-YMLYHqaZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 November 2011 21:39, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> When the S3C64xx CPUs were converted to clkdev mappings were added for the
> I2C controllers on them. On S3C6410 a device name is specified for I2C
> controller 1 but not for controller 0 which makes the code less robust as
> we'll falsely return the clock for controller 0 if there's an error in the
> request for controller 1.
>
> Improve things by registering a device name for controller 0 as well. Due
> to the fact that we change the numbering for controller 0 depending on if
> we've registered controller 1 this requires an ifdef to choose the name.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> ?arch/arm/mach-s3c64xx/clock.c | ? ?5 +++++
> ?1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
> index 39c238d..52b264e 100644
> --- a/arch/arm/mach-s3c64xx/clock.c
> +++ b/arch/arm/mach-s3c64xx/clock.c
> @@ -138,6 +138,11 @@ static struct clk init_clocks_off[] = {
> ? ? ? ? ? ? ? ?.ctrlbit ? ? ? ?= S3C_CLKCON_PCLK_TSADC,
> ? ? ? ?}, {
> ? ? ? ? ? ? ? ?.name ? ? ? ? ? = "i2c",
> +#ifdef CONFIG_S3C_DEV_I2C1
> + ? ? ? ? ? ? ? .devname ? ? ? ?= "s3c2440-i2c.0",
> +#else
> + ? ? ? ? ? ? ? .devname ? ? ? ?= "s3c2440-i2c",
> +#endif
> ? ? ? ? ? ? ? ?.parent ? ? ? ? = &clk_p,
> ? ? ? ? ? ? ? ?.enable ? ? ? ? = s3c64xx_pclk_ctrl,
> ? ? ? ? ? ? ? ?.ctrlbit ? ? ? ?= S3C_CLKCON_PCLK_IIC,


The #ifdef around the id of the s3c_device_i2c0 structure in
arch/arm/plat-samsung/devs.c file can be removed and id can be fixed
as 0. And devname "s3c2440-i2c.0" can be assigned above without the
#ifdef. Will there be any issues in using .id as 0 even if there is
only one instance of i2c?

Thanks,
Thomas.
