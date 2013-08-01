From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 1 Aug 2013 14:51:48 +0800
Subject: [PATCH 1/2] pinctrl: imx: work around select input quirk
In-Reply-To: <1375330924-27384-1-git-send-email-shawn.guo@linaro.org>
References: <1375330924-27384-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130801065147.GM8540@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 12:22:03PM +0800, Shawn Guo wrote:
> The select input for some pin may not be implemented using the regular
> select input register but the general purpose register.  A real example
> is that imx6q designers found the select input for USB OTG ID pin is
> missing at the very late stage, and can not add a new select input
> register but have to use a general purpose register bit to implement it.
> 
> The patch adds a workaround for such select input quirk by interpreting
> the input_val cell of pin function ID in a different way, so that all
> the info that needed for setting up select input bits in general purpose
> register could be decoded from there.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/pinctrl/pinctrl-imx.c |   25 ++++++++++++++++++++++++-
>  1 files changed, 24 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
> index 57a4eb0..6ebe2e9 100644
> --- a/drivers/pinctrl/pinctrl-imx.c
> +++ b/drivers/pinctrl/pinctrl-imx.c
> @@ -241,7 +241,30 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
>  
>  		/* some pins also need select input setting, set it if found */
>  		if (input_reg[i]) {
> -			writel(input_val[i], ipctl->base + input_reg[i]);
> +			u32 val = input_val[i];
> +			/*
> +			 * If the select input value begins with 0xff, the value
> +			 * will be interpreted as below.
> +			 *     31     23      15      7        0
> +			 *     | 0xff | shift | width | select |
> +			 * It's used to work around the problem that the select
> +			 * input for some pin is not implemented in the select
> +			 * input register but in some general purpose register.
> +			 * We encode the select input value, width and shift of
> +			 * the bit field into input_val cell of pin function ID
> +			 * in device tree, and then decode them here for setting
> +			 * up the select input bits in general purpose register.
> +			 */
> +			if (val >> 24 == 0xff) {
> +				u8 select = val & 0xff;
> +				u8 width = (val >> 8) & 0xff;
> +				u8 shift = (val >> 16) & 0xff;
> +				u32 mask = ((1 << width) - 1) << shift;
> +				val = readl(ipctl->base + input_reg[i]);
> +				val &= ~mask;
> +				val |= select << shift;
> +			}
> +			writel(val, ipctl->base + input_reg[i]);
>  			dev_dbg(ipctl->dev,
>  				"==>select_input: offset 0x%x val 0x%x\n",
>  				input_reg[i], input_val[i]);
> -- 
> 1.7.1
> 

Shawn, input_reg[i] may be 0 if the fixed one at first register of IOMUXC

-- 

Best Regards,
Peter Chen
