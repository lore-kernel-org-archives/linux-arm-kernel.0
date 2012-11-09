From: dron0gus@gmail.com (Andrey Gusakov)
Date: Fri, 9 Nov 2012 12:31:15 +0300
Subject: [PATCH] ARM: S3C64XX: Statically define parent clock of the
 "camera" clock
In-Reply-To: <1352449929-20168-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <CAA11ShAo_N5iwPmVqE27NMzhpSD6NZORqf7yvjUyZ-+kGkgYog@mail.gmail.com>
 <1352449929-20168-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <CAA11ShABPJhLP5dvx65=HOzSNoiY+jjiiNPAvd_x_5z7K3meVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

On Fri, Nov 9, 2012 at 12:32 PM, Sylwester Nawrocki
<sylvester.nawrocki@gmail.com> wrote:
> The "camera" clock defined in arch/arm/mach-s3c64xx/clock.c has null
> clock source mux control register as it can have only one parent
> clock. In such cases there is a need to configure the parent clock
> statically, otherwise s3c_set_clksrc() bails out with an error message
> "no parent clock specified" leaving the parent clock not configured.
> Define statically the parent clock so it is possible to get or set
> rate of the "camera" clock.
> While at it remove the unneded null reg_src definition.
>
> Reported-by: In-Bae Jeong <kukyakya@gmail.com>
> Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/clock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
> index 28041e8..2e6d7f9 100644
> --- a/arch/arm/mach-s3c64xx/clock.c
> +++ b/arch/arm/mach-s3c64xx/clock.c
> @@ -744,9 +744,9 @@ static struct clksrc_clk clksrcs[] = {
>                         .name           = "camera",
>                         .ctrlbit        = S3C_CLKCON_SCLK_CAM,
>                         .enable         = s3c64xx_sclk_ctrl,
> +                       .parent         = &clk_h2,
>                 },
>                 .reg_div        = { .reg = S3C_CLK_DIV0, .shift = 20, .size = 4  },
> -               .reg_src        = { .reg = NULL, .shift = 0, .size = 0  },
>                 .sources        = &clkset_camif,
Just figure out that .sources can be removed to. And seems
"clkset_camif" and "clkset_camif_list" can be removed as unused.

I'll try to test it tiday.
