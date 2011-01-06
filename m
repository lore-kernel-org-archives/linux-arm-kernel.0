From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 6 Jan 2011 08:16:47 +0200
Subject: [PATCH] ARM i.MX53: enable fec driver on EVK board
In-Reply-To: <1294292731-2896-1-git-send-email-yong.shen@freescale.com>
References: <1294292731-2896-1-git-send-email-yong.shen@freescale.com>
Message-ID: <20110106061647.GB30232@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Thu, Jan 06, 2011 at 01:45:31PM +0800, yong.shen at freescale.com wrote:
> From: Yong Shen <yong.shen@freescale.com>
> 
> 1. Adjust FEC base address name to fit macro definition
> 2. Add platform data and reset function for FEC
> 
> Signed-off-by: Yong Shen <yong.shen@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx53_evk.c       |   27 +++++++++++++++++++++++++++
>  arch/arm/mach-mx5/devices-imx53.h        |    4 ++++
>  arch/arm/plat-mxc/devices/Kconfig        |    2 +-
>  arch/arm/plat-mxc/devices/platform-fec.c |    5 +++++
>  arch/arm/plat-mxc/include/mach/mx53.h    |    2 +-
>  5 files changed, 38 insertions(+), 2 deletions(-)

[snip]

> @@ -60,11 +65,33 @@ static inline void mx53_evk_init_uart(void)
>  	imx53_add_imx_uart(2, &mx53_evk_uart_pdata);
>  }
>  
> +static inline void fec_reset(void)

For the sake of clearer stack traces I prefer a less generic name for this 
routine, something like mx53_evk_fec_reset().

> +{
> +	int ret;
> +
> +	/* reset FEC PHY */
> +	ret = gpio_request(SMD_FEC_PHY_RST, "fec-phy-reset");
> +	if (ret) {
> +		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
> +		return;
> +	}
> +	gpio_direction_output(SMD_FEC_PHY_RST, 0);
> +	gpio_set_value(SMD_FEC_PHY_RST, 0);

This seems to be redundant. gpio_direction_output() has already set the value 
to 0.

> +	msleep(1);
> +	gpio_set_value(SMD_FEC_PHY_RST, 1);
> +}
> +
> +static struct fec_platform_data fec_pdata = {
> +	.phy = PHY_INTERFACE_MODE_RMII,
> +};
> +

[snip]

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
