From: aalonso@freescale.com (Alonso Adrian)
Date: Tue, 8 Sep 2015 16:05:32 +0000
Subject: [PATCH v2 5/8] pinctrl: freescale: imx: add ZERO_OFFSET_VALID flag
In-Reply-To: <20150907012831.GE30746@tiger>
References: <1441147753-13239-1-git-send-email-aalonso@freescale.com>
 <1441147753-13239-5-git-send-email-aalonso@freescale.com>,
 <20150907012831.GE30746@tiger>
Message-ID: <BN3PR03MB1509E4893244D963FDA21707A8530@BN3PR03MB1509.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

See comments below

Regards
________________________________________
From: Shawn Guo <shawnguo@kernel.org>
Sent: Sunday, September 6, 2015 8:28 PM
To: Alonso Lazcano Adrian-B38018
Cc: linux-arm-kernel at lists.infradead.org; shawn.guo at linaro.org; linus.walleij at linaro.org; lznuaa at gmail.com; devicetree at vger.kernel.org; Li Frank-B20596; Garg Nitin-B37173; Huang Yongcai-B20788; linux-gpio at vger.kernel.org; robh+dt at kernel.org; Gong Yibin-B38343
Subject: Re: [PATCH v2 5/8] pinctrl: freescale: imx: add ZERO_OFFSET_VALID flag

On Tue, Sep 01, 2015 at 05:49:10PM -0500, Adrian Alonso wrote:
> - Add ZERO_OFFSET_VALID flag, on imx7d mux_conf reg
>   offset is zero for iomuxc-lspr controller
> - Do default initialization on parse group function.
>
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>

I do not follow why this patch is needed at all.  All the register
validity check are done against -1, and zero offset is already supported
by the driver in the current form.  Or am I missing anything?

Shawn

> ---
> Changes for V2: Resend
>
>  drivers/pinctrl/freescale/pinctrl-imx.c | 23 +++++++++++++----------
>  drivers/pinctrl/freescale/pinctrl-imx.h |  1 +
>  2 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 95db9e8..9f019be 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -437,7 +437,7 @@ static void imx_pinconf_dbg_show(struct pinctrl_dev *pctldev,
>       const struct imx_pin_reg *pin_reg = &info->pin_regs[pin_id];
>       unsigned long config;
>
> -     if (!pin_reg || pin_reg->conf_reg == -1) {
> +     if (pin_reg->conf_reg == -1) {
>               seq_printf(s, "N/A");
>               return;
>       }
> @@ -536,21 +536,29 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
>               return -ENOMEM;
>
>       for (i = 0; i < grp->npins; i++) {
> -             u32 mux_reg = be32_to_cpu(*list++);
> +             u32 mux_reg;
>               u32 conf_reg;
>               unsigned int pin_id;
>               struct imx_pin_reg *pin_reg;
>               struct imx_pin *pin = &grp->pins[i];
>
> +             mux_reg = be32_to_cpu(*list++);
> +             if (!(info->flags & ZERO_OFFSET_VALID) && !mux_reg)
> +                     mux_reg = -1;
> +
>               if (info->flags & SHARE_MUX_CONF_REG) {
>                       conf_reg = mux_reg;
>               } else {
>                       conf_reg = be32_to_cpu(*list++);
> -                     if (!conf_reg)
> +                     if (!(info->flags & ZERO_OFFSET_VALID) && !conf_reg)
>                               conf_reg = -1;
>               }
>
[Adrian] The below assignment is the important thing that this patch does,
it allows the pad_id to be zero and match the pad id's according to the mux_reg offset.
> -             pin_id = mux_reg ? mux_reg / 4 : conf_reg / 4;
> +             if (info->flags & ZERO_OFFSET_VALID)
> +                     pin_id = mux_reg / 4;
> +             else
> +                     pin_id = mux_reg ? mux_reg / 4 : conf_reg / 4;
> +
>               pin_reg = &info->pin_regs[pin_id];
>               pin->pin = pin_id;
>               grp->pin_ids[i] = pin_id;
> @@ -684,7 +692,7 @@ int imx_pinctrl_probe(struct platform_device *pdev,
>  {
>       struct imx_pinctrl *ipctl;
>       struct resource *res;
> -     int ret, i;
> +     int ret;
>
>       if (!info || !info->pins || !info->npins) {
>               dev_err(&pdev->dev, "wrong pinctrl info\n");
> @@ -702,11 +710,6 @@ int imx_pinctrl_probe(struct platform_device *pdev,
>       if (!info->pin_regs)
>               return -ENOMEM;
>
> -     for (i = 0; i < info->npins; i++) {
> -             info->pin_regs[i].mux_reg = -1;
> -             info->pin_regs[i].conf_reg = -1;
> -     }
> -
>       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>       ipctl->base = devm_ioremap_resource(&pdev->dev, res);
>       if (IS_ERR(ipctl->base))
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/freescale/pinctrl-imx.h
> index 26f8f1c..67c07c2 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.h
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.h
> @@ -85,6 +85,7 @@ struct imx_pinctrl_soc_info {
>  };
>
>  #define SHARE_MUX_CONF_REG   0x1
> +#define ZERO_OFFSET_VALID    0x2
>
>  #define NO_MUX               0x0
>  #define NO_PAD               0x0
> --
> 2.1.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
