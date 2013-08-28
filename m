From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 28 Aug 2013 11:57:07 +0200
Subject: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND] i2c:
 designware: use module_platform_driver)
In-Reply-To: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20130828095706.GH4086@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 04:32:28PM +0800, Zhangfei Gao wrote:
> Instead of use platform_driver_probe, use module_platform_driver
> To support deferred probing
> Also subsys_initcall may too early to auto set pinctl
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Acked-by: Baruch Siach <baruch@tkos.co.il>

This patch is tougher than it looks. You need it, because
subsys_initcall may be too early for pinctrl. Other people might be
depending on subsys_initcall to get I2C active before they want to
activate, say, PMICs. So, I fear regressions, since deferred probing
might not be available in the needed places to avoid these regressions.
I am all ears for a nice transition away from subsys_initcall, anyone?

> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c |   14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 4c5fada..36ceebc 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -236,6 +236,7 @@ static SIMPLE_DEV_PM_OPS(dw_i2c_dev_pm_ops, dw_i2c_suspend, dw_i2c_resume);
>  MODULE_ALIAS("platform:i2c_designware");
>  
>  static struct platform_driver dw_i2c_driver = {
> +	.probe		= dw_i2c_probe,
>  	.remove		= dw_i2c_remove,
>  	.driver		= {
>  		.name	= "i2c_designware",
> @@ -245,18 +246,7 @@ static struct platform_driver dw_i2c_driver = {
>  		.pm	= &dw_i2c_dev_pm_ops,
>  	},
>  };
> -
> -static int __init dw_i2c_init_driver(void)
> -{
> -	return platform_driver_probe(&dw_i2c_driver, dw_i2c_probe);
> -}
> -subsys_initcall(dw_i2c_init_driver);
> -
> -static void __exit dw_i2c_exit_driver(void)
> -{
> -	platform_driver_unregister(&dw_i2c_driver);
> -}
> -module_exit(dw_i2c_exit_driver);
> +module_platform_driver(dw_i2c_driver);
>  
>  MODULE_AUTHOR("Baruch Siach <baruch@tkos.co.il>");
>  MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter");
> -- 
> 1.7.9.5
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130828/0656d05e/attachment.sig>
