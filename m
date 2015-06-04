From: lznuaa@gmail.com (Zhi Li)
Date: Thu, 4 Jun 2015 10:00:44 -0500
Subject: [RFC] pinctrl: pinctrl-imx: implement suspend/resume
In-Reply-To: <1433171567-24571-1-git-send-email-stefan@agner.ch>
References: <1433171567-24571-1-git-send-email-stefan@agner.ch>
Message-ID: <CAHrpEqS8qYUrcSoNSDMB9tA+D_KcfoSWz75VDSk-S=ZNpwU7mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 1, 2015 at 10:12 AM, Stefan Agner <stefan@agner.ch> wrote:
> In some SoC's using the IMX pin controller, the IP looses its state
> when entering lowest power modes. Enhance the driver with suspend/
> resume functions restoring the pin states.
> ---
> Hi all,
>
> Currently I'm working on implementing suspend-to-memory for Freescale
> Vybrid (vf610) using the SoC's LPSTOP2 low power mode. One of the
> issues I came across is that the IOMUXC module is also in the higher
> power domain PD1 and hence looses its state during suspend.
>
> I'm not sure if other SoC's behave similar and hence would benefit
> from a generic implementation. At least i.MX6 seems not to power
> gate the IOMUXC, at least this quote from the RM, chapter 10.4.2.3.3
> "IO power reduction" lead me to believe that:
>> Digital IOs - Make sure all unnecessary PU/PD are disabled and IO
>> are switched to either minimal drive strength or to input mode
>> (when applicable)
>
> If no other SoC is making use of it, its probably better to implement
> it in the SoC specific code (e.g. pinctrl-vf610.c?) Although, currently
> the mapped access to the registers is only locally available in
> pinctrl-imx.c.

i.MX7 support LPSR mode, which IOMUX will lost state also.

>
> I'm also not sure if the suspend/resume functions are currently
> early enough, at least the noirq family of suspend/resume functions
> would be earlier. Hence if a device needs to have access to pins then,
> we would restore them too late. Maybe syscore_ops would be more
> appropriate?

Driver can call pinctrl_pm_select_sleep_state in suspend and
pinctrl_pm_select_default_state
to recover IOMUX state.

but I think this way is more simple than driver call
pinctrl_pm_select_default_state.

>
> Comments/ideas/advice appriciated...
>
> --
> Stefan
>
>  drivers/pinctrl/freescale/pinctrl-imx.c   | 64 +++++++++++++++++++++++++++++++
>  drivers/pinctrl/freescale/pinctrl-imx.h   |  3 ++
>  drivers/pinctrl/freescale/pinctrl-vf610.c |  6 +++
>  3 files changed, 73 insertions(+)
>
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 448f109..0829098 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -23,6 +23,7 @@
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
>  #include <linux/slab.h>
> +#include <linux/syscore_ops.h>
>
>  #include "../core.h"
>  #include "pinctrl-imx.h"
> @@ -40,6 +41,10 @@ struct imx_pinctrl {
>         struct pinctrl_dev *pctl;
>         void __iomem *base;
>         const struct imx_pinctrl_soc_info *info;
> +#ifdef CONFIG_PM_SLEEP
> +       u32 *mux_regs;
> +       u32 *input_regs;
> +#endif
>  };
>
>  static const inline struct imx_pin_group *imx_pinctrl_find_group_by_name(
> @@ -640,6 +645,53 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
>         return 0;
>  }
>
> +static int __maybe_unused imx_pinctrl_suspend(struct device *dev)
> +{
> +       struct imx_pinctrl *ipctl = dev_get_drvdata(dev);
> +       const struct imx_pinctrl_soc_info *info = ipctl->info;
> +       int i;
> +
> +       for (i = 0; i < info->npins; i++) {
> +               const struct imx_pin_reg *pin_reg = &info->pin_regs[i];
> +               if (pin_reg->mux_reg == -1)
> +                       continue;
> +
> +               ipctl->mux_regs[i] = readl(ipctl->base + pin_reg->mux_reg);
> +       }
> +
> +       for (i = 0; i < info->ninput_regs; i++)
> +               ipctl->input_regs[i] = readl(ipctl->base +
> +                               info->input_regs_offset + i * sizeof(u32 *));
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused imx_pinctrl_resume(struct device *dev)
> +{
> +       struct imx_pinctrl *ipctl = dev_get_drvdata(dev);
> +       const struct imx_pinctrl_soc_info *info = ipctl->info;
> +       const struct imx_pin_reg *pin_reg;
> +       int i;
> +
> +       for (i = 0; i < info->npins; i++) {
> +               pin_reg = &info->pin_regs[i];
> +               if (pin_reg->mux_reg == -1)
> +                       continue;
> +
> +               writel(ipctl->mux_regs[i], ipctl->base + pin_reg->mux_reg);
> +       }
> +
> +       for (i = 0; i < info->ninput_regs; i++)
> +               writel(ipctl->input_regs[i], ipctl->base +
> +                               info->input_regs_offset + i * sizeof(u32 *));
> +
> +       return 0;
> +}
> +
> +const struct dev_pm_ops imx_pinctrl_dev_pm_ops = {
> +       SET_LATE_SYSTEM_SLEEP_PM_OPS(imx_pinctrl_suspend, imx_pinctrl_resume)
> +};
> +
>  int imx_pinctrl_probe(struct platform_device *pdev,
>                       struct imx_pinctrl_soc_info *info)
>  {
> @@ -664,6 +716,18 @@ int imx_pinctrl_probe(struct platform_device *pdev,
>                 return -ENOMEM;
>         memset(info->pin_regs, 0xff, sizeof(*info->pin_regs) * info->npins);
>
> +#ifdef CONFIG_PM_SLEEP
> +       ipctl->mux_regs = devm_kzalloc(&pdev->dev, sizeof(u32 *) *
> +                                      info->npins, GFP_KERNEL);
> +       if (!ipctl->mux_regs)
> +               return -ENOMEM;
> +
> +       ipctl->input_regs = devm_kzalloc(&pdev->dev, sizeof(u32 *) *
> +                                        info->ninput_regs, GFP_KERNEL);
> +       if (!ipctl->input_regs)
> +               return -ENOMEM;
> +#endif
> +
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         ipctl->base = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(ipctl->base))
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/freescale/pinctrl-imx.h
> index 49e55d3..6da6806 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.h
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.h
> @@ -80,6 +80,8 @@ struct imx_pinctrl_soc_info {
>         unsigned int ngroups;
>         struct imx_pmx_func *functions;
>         unsigned int nfunctions;
> +       unsigned int input_regs_offset;
> +       unsigned int ninput_regs;
>         unsigned int flags;
>  };
>
> @@ -97,4 +99,5 @@ struct imx_pinctrl_soc_info {
>  int imx_pinctrl_probe(struct platform_device *pdev,
>                         struct imx_pinctrl_soc_info *info);
>  int imx_pinctrl_remove(struct platform_device *pdev);
> +extern const struct dev_pm_ops imx_pinctrl_dev_pm_ops;
>  #endif /* __DRIVERS_PINCTRL_IMX_H */
> diff --git a/drivers/pinctrl/freescale/pinctrl-vf610.c b/drivers/pinctrl/freescale/pinctrl-vf610.c
> index fc86276..dbea076 100644
> --- a/drivers/pinctrl/freescale/pinctrl-vf610.c
> +++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
> @@ -19,6 +19,9 @@
>
>  #include "pinctrl-imx.h"
>
> +#define VF610_INPUT_REG_CNT            49
> +#define VF610_INPUT_REG_BASE           0x2ec
> +
>  enum vf610_pads {
>         VF610_PAD_PTA6 = 0,
>         VF610_PAD_PTA8 = 1,
> @@ -299,6 +302,8 @@ static const struct pinctrl_pin_desc vf610_pinctrl_pads[] = {
>  static struct imx_pinctrl_soc_info vf610_pinctrl_info = {
>         .pins = vf610_pinctrl_pads,
>         .npins = ARRAY_SIZE(vf610_pinctrl_pads),
> +       .input_regs_offset = VF610_INPUT_REG_BASE,
> +       .ninput_regs = VF610_INPUT_REG_CNT,
>         .flags = SHARE_MUX_CONF_REG,
>  };
>
> @@ -316,6 +321,7 @@ static struct platform_driver vf610_pinctrl_driver = {
>         .driver = {
>                 .name = "vf610-pinctrl",
>                 .of_match_table = vf610_pinctrl_of_match,
> +               .pm = &imx_pinctrl_dev_pm_ops,
>         },
>         .probe = vf610_pinctrl_probe,
>         .remove = imx_pinctrl_remove,
> --
> 2.4.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
