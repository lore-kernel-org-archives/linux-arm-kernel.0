From: mturquette@baylibre.com (Michael Turquette)
Date: Mon, 15 Feb 2016 14:13:13 -0800
Subject: [PATCH 01/14] mfd: intel_quark_i2c_gpio: Use clkdev_create()
In-Reply-To: <1454982341-22715-2-git-send-email-sboyd@codeaurora.org>
References: <1454982341-22715-1-git-send-email-sboyd@codeaurora.org>
 <1454982341-22715-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160215221313.2278.40061@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2016-02-08 17:45:28)
> Convert this driver to use clkdev_create() instead of
> clk_register_clkdevs(). The latter API is only used by this driver,
> although this driver only allocates one clk to add anyway.
> Furthermore, this driver allocates the clk_lookup structure with
> devm, but clkdev_drop() will free that structure when passed,
> leading to a double free when this driver is removed. Clean it
> all up and pave the way for the removal of clk_register_clkdevs().
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Looks good to me.

Regards,
Mike

> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
> index 042137465300..bdc5e27222c0 100644
> --- a/drivers/mfd/intel_quark_i2c_gpio.c
> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> @@ -52,8 +52,6 @@
>  /* The Quark I2C controller source clock */
>  #define INTEL_QUARK_I2C_CLK_HZ 33000000
>  
> -#define INTEL_QUARK_I2C_NCLK   1
> -
>  struct intel_quark_mfd {
>         struct pci_dev          *pdev;
>         struct clk              *i2c_clk;
> @@ -128,30 +126,24 @@ MODULE_DEVICE_TABLE(pci, intel_quark_mfd_ids);
>  static int intel_quark_register_i2c_clk(struct intel_quark_mfd *quark_mfd)
>  {
>         struct pci_dev *pdev = quark_mfd->pdev;
> -       struct clk_lookup *i2c_clk_lookup;
>         struct clk *i2c_clk;
> -       int ret;
> -
> -       i2c_clk_lookup = devm_kcalloc(&pdev->dev, INTEL_QUARK_I2C_NCLK,
> -                                     sizeof(*i2c_clk_lookup), GFP_KERNEL);
> -       if (!i2c_clk_lookup)
> -               return -ENOMEM;
> -
> -       i2c_clk_lookup[0].dev_id = INTEL_QUARK_I2C_CONTROLLER_CLK;
>  
>         i2c_clk = clk_register_fixed_rate(&pdev->dev,
>                                           INTEL_QUARK_I2C_CONTROLLER_CLK, NULL,
>                                           CLK_IS_ROOT, INTEL_QUARK_I2C_CLK_HZ);
> +       if (IS_ERR(i2c_clk))
> +               return PTR_ERR(i2c_clk);
>  
> -       quark_mfd->i2c_clk_lookup = i2c_clk_lookup;
>         quark_mfd->i2c_clk = i2c_clk;
> +       quark_mfd->i2c_clk_lookup = clkdev_create(i2c_clk, NULL,
> +                                               INTEL_QUARK_I2C_CONTROLLER_CLK);
>  
> -       ret = clk_register_clkdevs(i2c_clk, i2c_clk_lookup,
> -                                  INTEL_QUARK_I2C_NCLK);
> -       if (ret)
> -               dev_err(&pdev->dev, "Fixed clk register failed: %d\n", ret);
> +       if (!quark_mfd->i2c_clk_lookup) {
> +               dev_err(&pdev->dev, "Fixed clk register failed\n");
> +               return -ENOMEM;
> +       }
>  
> -       return ret;
> +       return 0;
>  }
>  
>  static void intel_quark_unregister_i2c_clk(struct pci_dev *pdev)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
