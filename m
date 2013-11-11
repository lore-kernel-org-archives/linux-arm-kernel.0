From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Mon, 11 Nov 2013 23:18:02 +0900
Subject: [PATCH 2/4] clk: clk-s2mps11: Add support for clocks in S5M8767
 MFD
In-Reply-To: <1383202124-1775-3-git-send-email-tushar.behera@linaro.org>
References: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
 <1383202124-1775-3-git-send-email-tushar.behera@linaro.org>
Message-ID: <CAKew6eXHUZupSkvNDrX1R9+YREekYzVB5ktA7JRsARgA6OspMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 3:48 PM, Tushar Behera <tushar.behera@linaro.org> wrote:
> Since clock operation within S2MPS11 and S5M8767 are similar, we can
> support both the devices within a single driver.
>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> CC: Yadwinder Singh Brar <yadi.brar@samsung.com>
> CC: Mike Turquette <mturquette@linaro.org>
> ---

Reviewed-by: Yadwinder Singh Brar <yadi.brar@samsung.com>

Regards,
Yadwinder

>  drivers/clk/Kconfig       |    6 ++++--
>  drivers/clk/clk-s2mps11.c |    5 +++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 5c51115..7f2aef2 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -65,10 +65,12 @@ config COMMON_CLK_SI5351
>           generators.
>
>  config COMMON_CLK_S2MPS11
> -       tristate "Clock driver for S2MPS11 MFD"
> +       tristate "Clock driver for S2MPS11/S5M8767 MFD"
>         depends on MFD_SEC_CORE
>         ---help---
> -         This driver supports S2MPS11 crystal oscillator clock.
> +         This driver supports S2MPS11/S5M8767 crystal oscillator clock. These
> +         multi-function devices have 3 fixed-rate oscillators, clocked at
> +         32KHz each.
>
>  config CLK_TWL6040
>         tristate "External McPDM functional clock from twl6040"
> diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
> index 2262cb4..19c075c 100644
> --- a/drivers/clk/clk-s2mps11.c
> +++ b/drivers/clk/clk-s2mps11.c
> @@ -27,6 +27,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/samsung/s2mps11.h>
> +#include <linux/mfd/samsung/s5m8767.h>
>  #include <linux/mfd/samsung/core.h>
>
>  #define s2mps11_name(a) (a->hw.init->name)
> @@ -175,6 +176,9 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
>         case S2MPS11X:
>                 s2mps11_reg = S2MPS11_REG_RTC_CTRL;
>                 break;
> +       case S5M8767X:
> +               s2mps11_reg = S5M8767_REG_CTRL1;
> +               break;
>         default:
>                 dev_err(&pdev->dev, "Invalid device type\n");
>                 return -EINVAL;
> @@ -254,6 +258,7 @@ static int s2mps11_clk_remove(struct platform_device *pdev)
>
>  static const struct platform_device_id s2mps11_clk_id[] = {
>         { "s2mps11-clk", S2MPS11X},
> +       { "s5m8767-clk", S5M8767X},
>         { },
>  };
>  MODULE_DEVICE_TABLE(platform, s2mps11_clk_id);
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
