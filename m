From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 29 Oct 2013 16:22:49 -0700
Subject: [PATCH 2/2] misc: atmel_pwm: set initcall level to subsys
In-Reply-To: <1382459560-26596-3-git-send-email-jhovold@gmail.com>
References: <1382459560-26596-1-git-send-email-jhovold@gmail.com>
 <1382459560-26596-3-git-send-email-jhovold@gmail.com>
Message-ID: <20131029232249.GA20476@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 06:32:40PM +0200, Johan Hovold wrote:
> Even with the atmel_pwm driver and the atmel-pwm-bl backlight driver
> supporting deferred probing, we still want to make sure that any
> pwm-device is available when the backlight devices are probed to avoid
> any unnecessary delays before enabling the backlight.
> 
> Signed-off-by: Johan Hovold <jhovold@gmail.com>
> ---
>  drivers/misc/atmel_pwm.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/atmel_pwm.c b/drivers/misc/atmel_pwm.c
> index a6dc56e..0d0f599 100644
> --- a/drivers/misc/atmel_pwm.c
> +++ b/drivers/misc/atmel_pwm.c
> @@ -395,7 +395,17 @@ static struct platform_driver atmel_pwm_driver = {
>  	 */
>  };
>  
> -module_platform_driver_probe(atmel_pwm_driver, pwm_probe);
> +static int __init pwm_init(void)
> +{
> +	return platform_driver_probe(&atmel_pwm_driver, pwm_probe);
> +}
> +subsys_initcall(pwm_init);

I really hate this type of patch, as it's papering over the real
problem.  What happens when someone else moves their driver to this
level?  Then you are back to the original problem.

This is what deferred probing was supposed to fix.  If it doesn't, then
something else needs to be done, or fix the deferred probing mess...

Sorry, I can't take this.

greg k-h
