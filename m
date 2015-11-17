From: leoli@freescale.com (Li Yang)
Date: Tue, 17 Nov 2015 17:00:00 -0600
Subject: [PATCH] i2c: imx: fix build issue for platforms without pinctrl
In-Reply-To: <1447794675-19411-1-git-send-email-leoli@freescale.com>
References: <1447794675-19411-1-git-send-email-leoli@freescale.com>
Message-ID: <CADRPPNRXgR9D7=tE66zBU6rFPatrZsmpUnU-yoOp1unOa6bB=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 3:11 PM, Li Yang <leoli@freescale.com> wrote:
> With commit 1c4b6c3b (i2c: imx: implement bus recovery) the driver
> starts to use pinctrl to do i2c bus recovery.  But this breaks build
> for platforms that don't implement pinctrl, such as ls1021a and
> ls1043a.
>
> This patch fix the problem by only compiling the bus recovery code
> when CONFIG_PINCTRL is enabled.

Please ignore this patch.  I missed the patch from Zhiqiang
(https://patchwork.ozlabs.org/patch/545494/) to fix the same build
issue.  Although the driver can build correctly when CONFIG_PINCTRL is
enabled by having <linux/pinctrl/consumer.h> included though
<linux/device.h>.  Including the <linux/pinctrl/consumer.h> explicitly
seems to be a better fix for the build issue itself.

On the other hand, the driver shouldn't fail to probe or try to
register recovery routine when there is actually no pinctrl support as
the recovery is just an optional function.  I can submit another patch
for this.

>
> Reported-by: Ren Xiaofeng <xiaofeng.ren@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Cc: Gao Pan <b54642@freescale.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 1e4d99d..614253a 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -208,11 +208,13 @@ struct imx_i2c_struct {
>         unsigned int            cur_clk;
>         unsigned int            bitrate;
>         const struct imx_i2c_hwdata     *hwdata;
> +#ifdef CONFIG_PINCTRL
>         struct i2c_bus_recovery_info rinfo;
>
>         struct pinctrl *pinctrl;
>         struct pinctrl_state *pinctrl_pins_default;
>         struct pinctrl_state *pinctrl_pins_gpio;
> +#endif
>
>         struct imx_i2c_dma      *dma;
>  };
> @@ -902,12 +904,14 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
>
>         /* Start I2C transfer */
>         result = i2c_imx_start(i2c_imx);
> +#ifdef CONFIG_PINCTRL
>         if (result) {
>                 if (i2c_imx->adapter.bus_recovery_info) {
>                         i2c_recover_bus(&i2c_imx->adapter);
>                         result = i2c_imx_start(i2c_imx);
>                 }
>         }
> +#endif
>
>         if (result)
>                 goto fail0;
> @@ -969,6 +973,7 @@ fail0:
>         return (result < 0) ? result : num;
>  }
>
> +#ifdef CONFIG_PINCTRL
>  static void i2c_imx_prepare_recovery(struct i2c_adapter *adap)
>  {
>         struct imx_i2c_struct *i2c_imx;
> @@ -1017,6 +1022,7 @@ static void i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
>         rinfo->recover_bus = i2c_generic_gpio_recovery;
>         i2c_imx->adapter.bus_recovery_info = rinfo;
>  }
> +#endif
>
>  static u32 i2c_imx_func(struct i2c_adapter *adapter)
>  {
> @@ -1086,11 +1092,13 @@ static int i2c_imx_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +#ifdef CONFIG_PINCTRL
>         i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
>         if (IS_ERR(i2c_imx->pinctrl)) {
>                 ret = PTR_ERR(i2c_imx->pinctrl);
>                 goto clk_disable;
>         }
> +#endif
>
>         /* Request IRQ */
>         ret = devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
> @@ -1125,7 +1133,9 @@ static int i2c_imx_probe(struct platform_device *pdev)
>                 goto clk_disable;
>         }
>
> +#ifdef CONFIG_PINCTRL
>         i2c_imx_init_recovery_info(i2c_imx, pdev);
> +#endif
>
>         /* Set up platform driver data */
>         platform_set_drvdata(pdev, i2c_imx);
> --
> 2.3.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
- Leo
