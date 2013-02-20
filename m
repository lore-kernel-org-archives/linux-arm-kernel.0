From: dong.aisheng@linaro.org (Dong Aisheng)
Date: Wed, 20 Feb 2013 17:44:09 +0800
Subject: [PATCH 3/3] pinctrl: imx: move hard-coding data into device tree
In-Reply-To: <1361344089-16804-4-git-send-email-shawn.guo@linaro.org>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAP1dx+zuGZ5uvOho03ieEB=17=YtkYn5UyBOsRXSJcpsKQRTAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 February 2013 15:08, Shawn Guo <shawn.guo@linaro.org> wrote:
> Currently, all imx pinctrl drivers maintain a big array of struct
> imx_pin_reg which hard-codes data like register offset and mux mode
> setting for each pin function.  Every time a new imx SoC support is
> added, we need to add such a big mount of data.  With moving to single
> kernel build, it's only matter of time to be blamed on memory consuming.
>
> With DTC pre-processor support in place, the patch moves all these data
> into device tree by redefining the PIN_FUNC_ID in imxXX-pinfunc.h and
> changing the PIN_FUNC_ID parsing code a little bit.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../bindings/pinctrl/fsl,imx-pinctrl.txt           |    6 +-
>  arch/arm/boot/dts/imx35-pinfunc.h                  | 1908 ++++++------
>  arch/arm/boot/dts/imx51-pinfunc.h                  | 1514 +++++-----
>  arch/arm/boot/dts/imx53-pinfunc.h                  | 2346 +++++++-------
>  arch/arm/boot/dts/imx6q-pinfunc.h                  | 3190 ++++++++++----------
>  drivers/pinctrl/pinctrl-imx.c                      |  118 +-
>  drivers/pinctrl/pinctrl-imx.h                      |   13 +-
>  drivers/pinctrl/pinctrl-imx35.c                    |  958 ------
>  drivers/pinctrl/pinctrl-imx51.c                    |  762 -----
>  drivers/pinctrl/pinctrl-imx53.c                    | 1177 --------
>  drivers/pinctrl/pinctrl-imx6q.c                    | 1599 ----------
>  11 files changed, 4534 insertions(+), 9057 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
> index ab19e6b..614cab1 100644
> --- a/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
> @@ -24,9 +24,9 @@ Required properties for iomux controller:
>  Required properties for pin configuration node:
>  - fsl,pins: two integers array, represents a group of pins mux and config
>    setting. The format is fsl,pins = <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID is
> -  pin working on a specific function, CONFIG is the pad setting value like
> -  pull-up on this pin. Please refer to fsl,<soc>-pinctrl.txt for the valid
> -  pins and functions of each SoC.
> +  pin working on a specific function, which consists of a tuple of <pinid
> +  mux_reg conf_reg input_reg mux_val input_val>.  CONFIG is the pad setting
> +  value like pull-up on this pin.

Since we actually do not have a PIN_FUNC_ID anymore, i would suggest
totoally remove this concept in both doc and code.

> +/*
> + * The pin function ID is a tuple of
> + * <pinid mux_reg conf_reg input_reg mux_val input_val>
> + */
> +#define MX6Q_PAD_SD2_DAT1__USDHC2_DAT1                 0x000 0x04c 0x360 0x000 0x0 0x0

The original table generated does not have pinid, so you manually added it here?
Since the pin id is really created by us, maybe we could try to remove it
and dynamically generate the pin id.
Then user does not need to care about id anymore.

> +/*
> + * Each pin represented in fsl,pins consists of 6 u32 PIN_FUNC_ID and

We could remove PIN_FUNC_ID.

> + * 1 u32 CONFIG, so 28 types in total for each pin.
> + */
> +#define FSL_PIN_SIZE 28
>
>  static int imx_pinctrl_parse_groups(struct device_node *np,
>                                     struct imx_pin_group *grp,
>                                     struct imx_pinctrl_soc_info *info,
>                                     u32 index)
>  {
> -       unsigned int pin_func_id;
> -       int ret, size;
> +       int size;
>         const __be32 *list;
> -       int i, j;
> +       int i;
>         u32 config;
>
>         dev_dbg(info->dev, "group(%d): %s\n", index, np->name);
> @@ -447,32 +401,36 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
>          */
>         list = of_get_property(np, "fsl,pins", &size);
>         /* we do not check return since it's safe node passed down */
> -       size /= sizeof(*list);

Is this wrongly deleted?

> -       if (!size || size % 2) {
> -               dev_err(info->dev, "wrong pins number or pins and configs should be pairs\n");
> +       if (!size || size % FSL_PIN_SIZE) {
> +               dev_err(info->dev, "Invalid fsl,pins property\n");
>                 return -EINVAL;
>         }
>
> -       grp->npins = size / 2;
> +       grp->npins = size / FSL_PIN_SIZE;
>         grp->pins = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned int),
>                                 GFP_KERNEL);
>         grp->mux_mode = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned int),
>                                 GFP_KERNEL);
> +       grp->input_val = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned int),
> +                               GFP_KERNEL);
>         grp->configs = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned long),
>                                 GFP_KERNEL);
> -       for (i = 0, j = 0; i < size; i += 2, j++) {
> -               pin_func_id = be32_to_cpu(*list++);
> -               ret = imx_pinctrl_get_pin_id_and_mux(info, pin_func_id,
> -                                       &grp->pins[j], &grp->mux_mode[j]);
> -               if (ret) {
> -                       dev_err(info->dev, "get invalid pin function id\n");
> -                       return -EINVAL;
> -               }
> +       for (i = 0; i < grp->npins; i++) {
> +               unsigned int pin_id = be32_to_cpu(*list++);
> +               struct imx_pin_reg *pin_reg = &info->pin_regs[pin_id];
> +
> +               grp->pins[i] = pin_id;
> +               pin_reg->mux_reg = be32_to_cpu(*list++);
> +               pin_reg->conf_reg = be32_to_cpu(*list++);
> +               pin_reg->input_reg = be32_to_cpu(*list++);
> +               grp->mux_mode[i] = be32_to_cpu(*list++);
> +               grp->input_val[i] = be32_to_cpu(*list++);
> +
>                 /* SION bit is in mux register */
>                 config = be32_to_cpu(*list++);
>                 if (config & IMX_PAD_SION)
> -                       grp->mux_mode[j] |= IOMUXC_CONFIG_SION;
> -               grp->configs[j] = config & ~IMX_PAD_SION;
> +                       grp->mux_mode[i] |= IOMUXC_CONFIG_SION;
> +               grp->configs[i] = config & ~IMX_PAD_SION;
>         }
>
>  #ifdef DEBUG
> @@ -568,8 +526,7 @@ int imx_pinctrl_probe(struct platform_device *pdev,
>         struct resource *res;
>         int ret;
>
> -       if (!info || !info->pins || !info->npins
> -                 || !info->pin_regs || !info->npin_regs) {
> +       if (!info || !info->pins || !info->npins) {
>                 dev_err(&pdev->dev, "wrong pinctrl info\n");
>                 return -EINVAL;
>         }
> @@ -580,6 +537,11 @@ int imx_pinctrl_probe(struct platform_device *pdev,
>         if (!ipctl)
>                 return -ENOMEM;
>
> +       info->pin_regs = devm_kzalloc(&pdev->dev, sizeof(*info->pin_regs) *
> +                                     info->npins, GFP_KERNEL);

Since we only record the used pins from device tree, it seems not make too much
sense to create pin_regs for everypin no matter wheter it's used or not.
I would suggest to put the pin_regs info into group,
then we do not need info->pin_regs anymore.
What do you think?

Regards
Dong Aisheng
> +       if (!info->pin_regs)
> +               return -ENOMEM;
> +
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!res)
>                 return -ENOENT;
> diff --git a/drivers/pinctrl/pinctrl-imx.h b/drivers/pinctrl/pinctrl-imx.h
> index 9b65e78..4749b0a 100644
> --- a/drivers/pinctrl/pinctrl-imx.h
> +++ b/drivers/pinctrl/pinctrl-imx.h
> @@ -26,6 +26,8 @@ struct platform_device;
>   *     elements in .pins so we can iterate over that array
>   * @mux_mode: the mux mode for each pin in this group. The size of this
>   *     array is the same as pins.
> + * @input_val: the select input value for each pin in this group. The size of
> + *     this array is the same as pins.
>   * @configs: the config for each pin in this group. The size of this
>   *     array is the same as pins.
>   */
> @@ -34,6 +36,7 @@ struct imx_pin_group {
>         unsigned int *pins;
>         unsigned npins;
>         unsigned int *mux_mode;
> +       unsigned int *input_val;
>         unsigned long *configs;
>  };
>
> @@ -51,30 +54,22 @@ struct imx_pmx_func {
>
>  /**
>   * struct imx_pin_reg - describe a pin reg map
> - * The last 3 members are used for select input setting
> - * @pid: pin id
>   * @mux_reg: mux register offset
>   * @conf_reg: config register offset
> - * @mux_mode: mux mode
>   * @input_reg: select input register offset for this mux if any
>   *  0 if no select input setting needed.
> - * @input_val: the value set to select input register
>   */
>  struct imx_pin_reg {
> -       u16 pid;
>         u16 mux_reg;
>         u16 conf_reg;
> -       u8 mux_mode;
>         u16 input_reg;
> -       u8 input_val;
>  };
>
>  struct imx_pinctrl_soc_info {
>         struct device *dev;
>         const struct pinctrl_pin_desc *pins;
>         unsigned int npins;
> -       const struct imx_pin_reg *pin_regs;
> -       unsigned int npin_regs;
> +       struct imx_pin_reg *pin_regs;
>         struct imx_pin_group *groups;
>         unsigned int ngroups;
>         struct imx_pmx_func *functions;
