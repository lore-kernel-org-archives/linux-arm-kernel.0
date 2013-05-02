From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 2 May 2013 20:27:59 +0200
Subject: [PATCH 2/2] pinctrl/imx: add zero register offset valid for
 Vybrid platform
In-Reply-To: <1367480932-22318-2-git-send-email-b35083@freescale.com>
References: <1367480932-22318-1-git-send-email-b35083@freescale.com>
 <1367480932-22318-2-git-send-email-b35083@freescale.com>
Message-ID: <20130502182759.GQ32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 03:48:52PM +0800, Jingchang Lu wrote:
> On some platform such as Vybrid, offset of mux and pad ctrl register
> may be zero. This patch add a platform condition to imx core pinctrl
> framework, making zero register offset valid on setting mux_mode and
> pad config value.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
>  drivers/pinctrl/pinctrl-imx.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
> index 4fcfff92..b4d7c91 100644
> --- a/drivers/pinctrl/pinctrl-imx.c
> +++ b/drivers/pinctrl/pinctrl-imx.c
> @@ -221,10 +221,14 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
>  		pin_id = pins[i];
>  		pin_reg = &info->pin_regs[pin_id];
>  
> -		if (!pin_reg->mux_reg) {
> -			dev_err(ipctl->dev, "Pin(%s) does not support mux function\n",
> -				info->pins[pin_id].name);
> -			return -EINVAL;
> +		/* mux_reg offset maybe zero on some platform such as Vybrid */
> +		if (!of_machine_is_compatible("fsl,mvf600")) {
> +			if (!pin_reg->mux_reg) {

Please add a zero_offset_valid flag to the drivers private structure
instead of using a rather expensive function in a frequently used path.
Also the && operator can be used to test for two conditions being true.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
