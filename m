From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 7 Sep 2012 15:04:05 +0200
Subject: [PATCH 1/9] pwm i.MX: factor out SoC specific functions
In-Reply-To: <1346935695-25179-2-git-send-email-s.hauer@pengutronix.de>
References: <1346935695-25179-1-git-send-email-s.hauer@pengutronix.de>
 <1346935695-25179-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120907130405.GC29340@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 02:48:07PM +0200, Sascha Hauer wrote:
> To make the code more flexible.

The code isn't made much more flexible, but it is cleaned up quite a
bit. Maybe this should be mentioned instead. Or something along the
lines that these changes make it easier to support multiple variants
in the driver.

Also, can we please try to stick to the "pwm:" prefix for the subject. I
like to keep for consistency and because it makes filtering easier.
Furthermore I've been getting on people's nerves by telling them to use
the all uppercase "PWM" when referring to PWM devices (note the prefix
subject is still lowercase), so it would be unfair not to get on your
nerves as well. =)

One other comment inline.

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
> ---
>  drivers/pwm/pwm-imx.c |  145 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 82 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 2a0b353..38270f4 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -46,81 +46,95 @@ struct imx_chip {
>  	void __iomem	*mmio_base;
>  
>  	struct pwm_chip	chip;
> +
> +	int (*config)(struct pwm_chip *chip,
> +		struct pwm_device *pwm, int duty_ns, int period_ns);
>  };
>  
>  #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
>  
> -static int imx_pwm_config(struct pwm_chip *chip,
> +static int imx_pwm_config_v1(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
>  	struct imx_chip *imx = to_imx_chip(chip);
>  
> -	if (!(cpu_is_mx1() || cpu_is_mx21())) {
> -		unsigned long long c;
> -		unsigned long period_cycles, duty_cycles, prescale;
> -		u32 cr;
> -
> -		c = clk_get_rate(imx->clk);
> -		c = c * period_ns;
> -		do_div(c, 1000000000);
> -		period_cycles = c;
> -
> -		prescale = period_cycles / 0x10000 + 1;
> -
> -		period_cycles /= prescale;
> -		c = (unsigned long long)period_cycles * duty_ns;
> -		do_div(c, period_ns);
> -		duty_cycles = c;
> -
> -		/*
> -		 * according to imx pwm RM, the real period value should be
> -		 * PERIOD value in PWMPR plus 2.
> -		 */
> -		if (period_cycles > 2)
> -			period_cycles -= 2;
> -		else
> -			period_cycles = 0;
> -
> -		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> -		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> -
> -		cr = MX3_PWMCR_PRESCALER(prescale) |
> -			MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
> -			MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
> -
> -		if (cpu_is_mx25())
> -			cr |= MX3_PWMCR_CLKSRC_IPG;
> -		else
> -			cr |= MX3_PWMCR_CLKSRC_IPG_HIGH;
> -
> -		writel(cr, imx->mmio_base + MX3_PWMCR);
> -	} else if (cpu_is_mx1() || cpu_is_mx21()) {
> -		/* The PWM subsystem allows for exact frequencies. However,
> -		 * I cannot connect a scope on my device to the PWM line and
> -		 * thus cannot provide the program the PWM controller
> -		 * exactly. Instead, I'm relying on the fact that the
> -		 * Bootloader (u-boot or WinCE+haret) has programmed the PWM
> -		 * function group already. So I'll just modify the PWM sample
> -		 * register to follow the ratio of duty_ns vs. period_ns
> -		 * accordingly.
> -		 *
> -		 * This is good enough for programming the brightness of
> -		 * the LCD backlight.
> -		 *
> -		 * The real implementation would divide PERCLK[0] first by
> -		 * both the prescaler (/1 .. /128) and then by CLKSEL
> -		 * (/2 .. /16).
> -		 */
> -		u32 max = readl(imx->mmio_base + MX1_PWMP);
> -		u32 p = max * duty_ns / period_ns;
> -		writel(max - p, imx->mmio_base + MX1_PWMS);
> -	} else {
> -		BUG();
> -	}
> +	/* The PWM subsystem allows for exact frequencies. However,

According to CodingStyle, this should be:

	/*
	 * The PWM subsystem...
	 * ...
	 */

I know the original had it wrong as well, but since you're changing the
lines anyway, would you mind fixing it anyway?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120907/d9d97926/attachment.sig>
