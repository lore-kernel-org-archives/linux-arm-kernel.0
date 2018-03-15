From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 15 Mar 2018 10:54:05 -0700
Subject: [RESEND PATCH] clk: enable hi655x common clk automatically
In-Reply-To: <20180312104945.3001-1-riku.voipio@linaro.org>
References: <20180312104945.3001-1-riku.voipio@linaro.org>
Message-ID: <152113644553.107923.8652081506535849458@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting riku.voipio at linaro.org (2018-03-12 03:49:45)
> From: Riku Voipio <riku.voipio@linaro.org>
> 
> Without COMMON_CLK_HI655X Wifi and bluetooth are non-functional on Hikey.
> As suggested by Arnd, enable the driver automatically when the parent
> driver is selected. With sensible defaults in place, we can leave other
> choices for EXPERT.
> 
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@linaro.org>
> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
> ---
> Previous discussion at https://patchwork.kernel.org/patch/9767143/
> ---
>  drivers/clk/Kconfig | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 98ce9fc6e6c0..448ce83b334d 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -55,8 +55,10 @@ config COMMON_CLK_RK808
>           by control register.
>  
>  config COMMON_CLK_HI655X
> -       tristate "Clock driver for Hi655x"
> -       depends on MFD_HI655X_PMIC || COMPILE_TEST
> +       tristate "Clock driver for Hi655x" if EXPERT

Hmm. This would be the first EXPERT usage in the clk code. I guess
that's ok.

> +       depends on (MFD_HI655X_PMIC || COMPILE_TEST)
> +       depends on REGMAP
> +       default MFD_HI655X_PMIC
