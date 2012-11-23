From: padma.kvr@gmail.com (Padma Venkat)
Date: Fri, 23 Nov 2012 16:48:13 +0530
Subject: [PATCH V3 5/5] ARM: Exynos: Avoid passing the clks through
 platform data
In-Reply-To: <1352177317-16395-6-git-send-email-padma.v@samsung.com>
References: <1352177317-16395-1-git-send-email-padma.v@samsung.com>
 <1352177317-16395-6-git-send-email-padma.v@samsung.com>
Message-ID: <CAAgF-BcMBr-uNmL3L1g2qPmk17G1gN2Lwa9KRdjagm0z61GXkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cc'ing Mark Brown.

On Tue, Nov 6, 2012 at 10:18 AM, Padmavathi Venna <padma.v@samsung.com> wrote:
> I2S controller has an internal mux for RCLK source clks. The list
> of source clk names were passed through platform data in non-dt case.
> The variable holding the list of RCLK source clk names is not
> required, as the list of clks need to be registered with clkdev
> using generic connection id. This is required as part of adding DT
> support for I2S controller driver.
>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  arch/arm/mach-exynos/dev-audio.c |   12 ------------
>  1 files changed, 0 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/dev-audio.c b/arch/arm/mach-exynos/dev-audio.c
> index ae321c7..e7d46fd 100644
> --- a/arch/arm/mach-exynos/dev-audio.c
> +++ b/arch/arm/mach-exynos/dev-audio.c
> @@ -23,11 +23,6 @@
>  #include <mach/irqs.h>
>  #include <mach/regs-audss.h>
>
> -static const char *rclksrc[] = {
> -       [0] = "busclk",
> -       [1] = "i2sclk",
> -};
> -
>  static int exynos4_cfg_i2s(struct platform_device *pdev)
>  {
>         /* configure GPIO for i2s port */
> @@ -55,7 +50,6 @@ static struct s3c_audio_pdata i2sv5_pdata = {
>                 .i2s = {
>                         .quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI
>                                          | QUIRK_NEED_RSTCLR,
> -                       .src_clk = rclksrc,
>                         .idma_addr = EXYNOS4_AUDSS_INT_MEM,
>                 },
>         },
> @@ -78,17 +72,11 @@ struct platform_device exynos4_device_i2s0 = {
>         },
>  };
>
> -static const char *rclksrc_v3[] = {
> -       [0] = "sclk_i2s",
> -       [1] = "no_such_clock",
> -};
> -
>  static struct s3c_audio_pdata i2sv3_pdata = {
>         .cfg_gpio = exynos4_cfg_i2s,
>         .type = {
>                 .i2s = {
>                         .quirks = QUIRK_NO_MUXPSR,
> -                       .src_clk = rclksrc_v3,
>                 },
>         },
>  };
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
