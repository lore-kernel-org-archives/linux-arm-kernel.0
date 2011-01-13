From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 13 Jan 2011 14:26:23 +0100
Subject: [patch 2/2] mx51: add support for pwm
In-Reply-To: <20110113113007.690473432@rtp-net.org>
References: <20110113112638.328269873@rtp-net.org>
	<20110113113007.690473432@rtp-net.org>
Message-ID: <20110113132623.GQ24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 12:26:40PM +0100, Arnaud Patard wrote:
> This patch is adding support for pwm1 and pwm2 devices found
> on mx51.
> [ this patch has been tested with pwm-backlight driver ]
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: linux-2.6-submit/arch/arm/mach-mx5/clock-mx51-mx53.c
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/clock-mx51-mx53.c	2011-01-12 16:51:29.000000000 +0100
> +++ linux-2.6-submit/arch/arm/mach-mx5/clock-mx51-mx53.c	2011-01-12 16:54:40.000000000 +0100
> @@ -1228,6 +1228,11 @@
>  DEFINE_CLOCK(gpt_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG9_OFFSET,
>  	NULL,  NULL, &ipg_clk, &gpt_ipg_clk);
>  
> +DEFINE_CLOCK(pwm1_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG6_OFFSET,
> +	NULL, NULL, &ipg_clk, NULL);
> +DEFINE_CLOCK(pwm2_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG8_OFFSET,
> +	NULL, NULL, &ipg_clk, NULL);
> +
>  /* I2C */
>  DEFINE_CLOCK(i2c1_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG9_OFFSET,
>  	NULL, NULL, &ipg_clk, NULL);
> @@ -1320,6 +1325,8 @@
>  	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
>  	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
>  	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
> +	_REGISTER_CLOCK("mxc_pwm.0", "pwm", pwm1_clk)
> +	_REGISTER_CLOCK("mxc_pwm.1", "pwm", pwm2_clk)
You really need "pwm"? I'd prefer NULL if that works, too.  (And if not,
please fix the driver :-)

Uwe
>  	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
>  	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
>  	_REGISTER_CLOCK("imx-i2c.2", NULL, hsi2c_clk)
> Index: linux-2.6-submit/arch/arm/plat-mxc/pwm.c
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/plat-mxc/pwm.c	2011-01-12 16:48:33.000000000 +0100
> +++ linux-2.6-submit/arch/arm/plat-mxc/pwm.c	2011-01-12 16:54:40.000000000 +0100
> @@ -57,7 +57,7 @@
>  	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
>  		return -EINVAL;
>  
> -	if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25()) {
> +	if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()) {
>  		unsigned long long c;
>  		unsigned long period_cycles, duty_cycles, prescale;
>  		u32 cr;
Hmm, time to convert to platform-id?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
