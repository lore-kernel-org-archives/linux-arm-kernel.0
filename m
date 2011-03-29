From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 29 Mar 2011 21:51:08 +0200
Subject: [PATCH 1/2] ARM: mxs/mach-mx28evk: Set the initial value on
	gpio_request_one
In-Reply-To: <1301427910-31726-1-git-send-email-fabio.estevam@freescale.com>
References: <1301427910-31726-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110329195108.GO30938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2011 at 04:45:09PM -0300, Fabio Estevam wrote:
> Current code does not set the GPIO value to zero as mentioned in the comment.
> 
> Fix it by setting the initial GPIO value to zero.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Shawn,
> 
> I do not have the hardware to test it, but I fixed it based on the comment.
> 
>  arch/arm/mach-mxs/mach-mx28evk.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
> index bb329b9..eacdc6b 100644
> --- a/arch/arm/mach-mxs/mach-mx28evk.c
> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> @@ -375,13 +375,13 @@ static void __init mx28evk_init(void)
>  	mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
>  
>  	/* power on mmc slot by writing 0 to the gpio */
> -	ret = gpio_request_one(MX28EVK_MMC0_SLOT_POWER, GPIOF_DIR_OUT,
> +	ret = gpio_request_one(MX28EVK_MMC0_SLOT_POWER, GPIOF_OUT_INIT_LOW,
include/asm-generic/gpio.h has the following defines:

#define GPIOF_OUT_INIT_LOW      (GPIOF_DIR_OUT | GPIOF_INIT_LOW)
#define GPIOF_DIR_OUT   (0 << 0)
#define GPIOF_INIT_LOW  (0 << 1)

so your patch is a noop for the compiler, but the new version makes the
behaviour more explicit.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
