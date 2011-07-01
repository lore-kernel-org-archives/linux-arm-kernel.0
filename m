From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 1 Jul 2011 10:03:11 +0200
Subject: [PATCH 2/2] ARM: plat-mxc: Fix pwm frequency
In-Reply-To: <1309485035-5964-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1309485035-5964-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20110701080311.GS6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 06:50:35PM -0700, Troy Kisky wrote:
> The PWMPR register is number of clocks + 2, so include
> a -2 when setting the register. There is currently no rounding
> up, so this may give a higher frequency than requested.

Have you checked this applies to mx2/3 aswell?

Sascha

> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  arch/arm/plat-mxc/pwm.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
> index 73f17b2..844415e 100644
> --- a/arch/arm/plat-mxc/pwm.c
> +++ b/arch/arm/plat-mxc/pwm.c
> @@ -76,7 +76,13 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
>  		duty_cycles = c;
>  
>  		writel(duty_cycles, pwm->mmio_base + MX3_PWMSAR);
> -		writel(period_cycles, pwm->mmio_base + MX3_PWMPR);
> +		if (period_cycles < 2)
> +			period_cycles = 2;
> +		/*
> +		 * manual says - "A value of zero in the PWMPR will result in
> +		 * a period of two clock cycles for the output signal.
> +		 */
> +		writel(period_cycles - 2, pwm->mmio_base + MX3_PWMPR);
>  
>  		cr = MX3_PWMCR_PRESCALER(prescale) | MX3_PWMCR_EN;
>  
> -- 
> 1.7.0.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
