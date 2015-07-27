From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 27 Jul 2015 07:59:13 +0200
Subject: [PATCH] ARM: appropriate __init annotation for const data
In-Reply-To: <alpine.LFD.2.20.1507241440550.1806@knanqh.ubzr>
References: <alpine.LFD.2.20.1507241440550.1806@knanqh.ubzr>
Message-ID: <20150727055913.GR745@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nico,

On Fri, Jul 24, 2015 at 02:54:04PM -0400, Nicolas Pitre wrote:
> 
> Init data marked const should be annotated with __initconst for
> correctness and not __initdata.  This also fixes LTO builds that
> otherwise fails with section mismatch errors.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
> index 4e9837ded9..87eb359048 100644
> --- a/arch/arm/mach-cns3xxx/core.c
> +++ b/arch/arm/mach-cns3xxx/core.c
> @@ -392,7 +392,7 @@ static void __init cns3xxx_init(void)
>                          cns3xxx_auxdata, NULL);
>  }
>  
> -static const char *cns3xxx_dt_compat[] __initdata = {
> +static const char *cns3xxx_dt_compat[] __initconst = {
this one (and a few others) are wrong. This is a (mutable) array of
pointers to constant strings and so you have to use one of:

	static const char *cns3xxx_dt_compat[] __initdata = {
	static const char *const cns3xxx_dt_compat[] __initconst = {

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
