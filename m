From: mturquette@ti.com (Mike Turquette)
Date: Mon, 26 Nov 2012 09:06:41 -0800
Subject: [PATCH 1/2] clk: ux500: Initial support for abx500 clock driver
In-Reply-To: <1353580540-3774-2-git-send-email-ulf.hansson@stericsson.com>
References: <1353580540-3774-1-git-send-email-ulf.hansson@stericsson.com>
 <1353580540-3774-2-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121126170641.21126.73503@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ulf Hansson (2012-11-22 02:35:39)
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> The abx500 clock driver is a platform driver which will be initialized
> during arch init. The platform device shall be added from the ab-core
> driver as a mfd child device to maintain correct boot sequence.
> 
> Depending on what ab version we use, different clock definitions will
> be added.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Taken into clk-next.

Thanks,
Mike

> ---
>  drivers/clk/ux500/Makefile     |    3 ++
>  drivers/clk/ux500/abx500-clk.c |   73 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>  create mode 100644 drivers/clk/ux500/abx500-clk.c
> 
> diff --git a/drivers/clk/ux500/Makefile b/drivers/clk/ux500/Makefile
> index 858fbfe..bcc0c11 100644
> --- a/drivers/clk/ux500/Makefile
> +++ b/drivers/clk/ux500/Makefile
> @@ -10,3 +10,6 @@ obj-y += clk-prcmu.o
>  obj-y += u8500_clk.o
>  obj-y += u9540_clk.o
>  obj-y += u8540_clk.o
> +
> +# ABX500 clock driver
> +obj-y += abx500-clk.o
> diff --git a/drivers/clk/ux500/abx500-clk.c b/drivers/clk/ux500/abx500-clk.c
> new file mode 100644
> index 0000000..e27c523
> --- /dev/null
> +++ b/drivers/clk/ux500/abx500-clk.c
> @@ -0,0 +1,73 @@
> +/*
> + * abx500 clock implementation for ux500 platform.
> + *
> + * Copyright (C) 2012 ST-Ericsson SA
> + * Author: Ulf Hansson <ulf.hansson@linaro.org>
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/abx500/ab8500.h>
> +
> +/* TODO: Add clock implementations here */
> +
> +
> +/* Clock definitions for ab8500 */
> +static int ab8500_reg_clks(struct device *dev)
> +{
> +       return 0;
> +}
> +
> +/* Clock definitions for ab8540 */
> +static int ab8540_reg_clks(struct device *dev)
> +{
> +       return 0;
> +}
> +
> +/* Clock definitions for ab9540 */
> +static int ab9540_reg_clks(struct device *dev)
> +{
> +       return 0;
> +}
> +
> +static int __devinit abx500_clk_probe(struct platform_device *pdev)
> +{
> +       struct ab8500 *parent = dev_get_drvdata(pdev->dev.parent);
> +       int ret;
> +
> +       if (is_ab8500(parent) || is_ab8505(parent)) {
> +               ret = ab8500_reg_clks(&pdev->dev);
> +       } else if (is_ab8540(parent)) {
> +               ret = ab8540_reg_clks(&pdev->dev);
> +       } else if (is_ab9540(parent)) {
> +               ret = ab9540_reg_clks(&pdev->dev);
> +       } else {
> +               dev_err(&pdev->dev, "non supported plf id\n");
> +               return -ENODEV;
> +       }
> +
> +       return ret;
> +}
> +
> +static struct platform_driver abx500_clk_driver = {
> +       .driver = {
> +               .name = "abx500-clk",
> +               .owner = THIS_MODULE,
> +       },
> +       .probe  = abx500_clk_probe,
> +};
> +
> +static int __init abx500_clk_init(void)
> +{
> +       return platform_driver_register(&abx500_clk_driver);
> +}
> +
> +arch_initcall(abx500_clk_init);
> +
> +MODULE_AUTHOR("Ulf Hansson <ulf.hansson@linaro.org");
> +MODULE_DESCRIPTION("ABX500 clk driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.10
