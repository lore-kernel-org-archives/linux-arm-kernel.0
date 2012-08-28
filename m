From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 28 Aug 2012 20:34:11 +0530
Subject: [PATCH 2/2] ARM: dt: tegra: harmony: add regulators
In-Reply-To: <1346137800-7448-2-git-send-email-swarren@wwwdotorg.org>
References: <1346137800-7448-1-git-send-email-swarren@wwwdotorg.org>
 <1346137800-7448-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <503CDDEB.1050201@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 August 2012 12:40 PM, Stephen Warren wrote:
>   #include "board.h"
> -#include "board-harmony.h"
>
>   #ifdef CONFIG_TEGRA_PCI
>
>   int __init harmony_pcie_init(void)
>   {
> -       struct regulator *regulator = NULL;
> +       struct regulator *regulator_1v5, *regulator_pex;
>          int err;
>
> -       err = gpio_request(TEGRA_GPIO_EN_VDD_1V05_GPIO, "EN_VDD_1V05");
> -       if (err)
> -               return err;
> +       regulator_1v5 = regulator_get(NULL, "vdd_1v5");
> +       if (IS_ERR_OR_NULL(regulator_1v5)) {
> +               err = PTR_ERR(regulator_1v5);
> +               goto err_reg;
> +       }

You need to return in case of err otherwise it will cause the crash in 
regulator_disable() with NULL argument.
