From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 23 Jul 2012 09:42:21 +0200
Subject: [PATCH 2/2] PWM: EHRPWM: PWM driver support for EHRPWM.
In-Reply-To: <1342172102-30363-3-git-send-email-avinashphilip@ti.com>
References: <1342172102-30363-1-git-send-email-avinashphilip@ti.com>
 <1342172102-30363-3-git-send-email-avinashphilip@ti.com>
Message-ID: <20120723074221.GB23797@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 03:05:02PM +0530, Philip, Avinash wrote:
> Enhanced high resolution PWM module (EHRPWM) hardware can be used to
> generate PWM output over 2 channels. This commit adds PWM driver support
> for EHRPWM device present on AM33XX SOC. Current implementation supports
> simple PWM functionality.
> 
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> Reviewed-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

So this driver is very similar to the ECAP one and pretty much all the
comments apply to this as well. Some additional comments below.

> ---
> :100644 100644 f20b8f2... ad62d7a... M	drivers/pwm/Kconfig
> :100644 100644 7dd90ec... 636a1d6... M	drivers/pwm/Makefile
> :000000 100644 0000000... 985d334... A	drivers/pwm/pwm-ehrpwm.c
>  drivers/pwm/Kconfig      |   10 +
>  drivers/pwm/Makefile     |    1 +
>  drivers/pwm/pwm-ehrpwm.c |  476 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 487 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index f20b8f2..ad62d7a 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -95,4 +95,14 @@ config  PWM_ECAP
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm_ecap.
>  
> +config  PWM_EHRPWM
> +	tristate "EHRPWM PWM support"
> +	depends on SOC_AM33XX
> +	help
> +	  PWM driver support for the EHRPWM controller found on AM33XX
> +	  TI SOC
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-ehrpwm.
> +

Maybe it would be useful to prefix the names with AM33XX here. ECAP and
EHRPWM are sort of generic and may have name clashes in the future.

> +#define PWM_CHANNEL		2	/* EHRPWM channels */

I'd say you can just replace the one occurrence of this with the literal
2. If you still want to have the symbolic name, then I'd suggest to call
it something like NUM_PWM_CHANNELS to make its meaning more obvious.

> +static int __devexit ehrpwm_pwm_remove(struct platform_device *pdev)
> +{
> +	struct ehrpwm_pwm_chip *pc = platform_get_drvdata(pdev);
> +
> +	if (WARN_ON(!pc))
> +		return -ENODEV;
> +
> +	pm_runtime_disable(&pdev->dev);
> +	pwmchip_remove(&pc->chip);
> +	return 0;
> +}

I forgot to mention this for ECAP, but you need to check the return
value of pwmchip_remove() because there are situations where it can
actually fail.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/9ecdce34/attachment.sig>
