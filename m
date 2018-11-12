From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 12 Nov 2018 15:33:21 +0000
Subject: [PATCH] pinctrl: imx: Fix imx_dt_node_to_map handling of
 IMX_NO_PAD_CTL
In-Reply-To: <1547d44dba63cbfd1b813018866f8916013b3381.1541973902.git.leonard.crestez@nxp.com>
References: <1547d44dba63cbfd1b813018866f8916013b3381.1541973902.git.leonard.crestez@nxp.com>
Message-ID: <AM0PR04MB421189893528B45B404CC15E80C10@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonard,

> -----Original Message-----
> From: Leonard Crestez
> Sent: Monday, November 12, 2018 6:15 AM
[...]
> 
> After changes for SCU support the IMX_NO_PAD_CTL flag is not longer handled
> correctly in imx_dt_node_to_map. Pins with this flag are no longer skipped
> and the new_map array can overflow and corrupt memory.
> 
> This fixes imx6-sabreauto boards failing to boot.
> 
> Fixes: b96eea718bf6 ("pinctrl: fsl: add scu based pinctrl support")
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Please see another more simpler fix just sent out with both you and Martin Kaiser's tags.
Thanks for the effort.

Regards
Dong Aisheng

> 
> ---
>  drivers/pinctrl/freescale/pinctrl-imx.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> A different was posted earlier:
> https://lore.kernel.org/patchwork/patch/1009504/
> 
> I don't think that's correct because it assumes num_configs is zero-initialized
> but new_map comes from kmalloc_array.
> 
> Code is clearer if SCU and MMIO paths are separate.
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
> b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 78d33dfb4d2d..51312e81eff7 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -106,29 +106,31 @@ static int imx_dt_node_to_map(struct pinctrl_dev
> *pctldev,
> 
>  	/* create config map */
>  	new_map++;
>  	for (i = j = 0; i < grp->num_pins; i++) {
>  		pin = &((struct imx_pin *)(grp->data))[i];
> -		new_map[j].type = PIN_MAP_TYPE_CONFIGS_PIN;
> -		new_map[j].data.configs.group_or_pin =
> -					pin_get_name(pctldev, pin->pin);
> -
>  		if (info->flags & IMX_USE_SCU) {
>  			/*
>  			 * For SCU case, we set mux and conf together
>  			 * in one IPC call
>  			 */
> +			new_map[j].type = PIN_MAP_TYPE_CONFIGS_PIN;
> +			new_map[j].data.configs.group_or_pin =
> +					pin_get_name(pctldev, pin->pin);
>  			new_map[j].data.configs.configs =
>  					(unsigned long *)&pin->conf.scu;
>  			new_map[j].data.configs.num_configs = 2;
> +			++j;
>  		} else if (!(pin->conf.mmio.config & IMX_NO_PAD_CTL)) {
> +			new_map[j].type = PIN_MAP_TYPE_CONFIGS_PIN;
> +			new_map[j].data.configs.group_or_pin =
> +					pin_get_name(pctldev, pin->pin);
>  			new_map[j].data.configs.configs =
>  					&pin->conf.mmio.config;
>  			new_map[j].data.configs.num_configs = 1;
> +			++j;
>  		}
> -
> -		j++;
>  	}
> 
>  	dev_dbg(pctldev->dev, "maps: function %s group %s num %d\n",
>  		(*map)->data.mux.function, (*map)->data.mux.group, map_num);
> 
> --
> 2.17.1
