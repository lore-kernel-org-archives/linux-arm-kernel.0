From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 14 Nov 2013 19:42:28 +0800
Subject: [PATCH 2/2] usb: chipidea: usbmisc: Add support for i.MX51 CPU
In-Reply-To: <1384067901-9377-2-git-send-email-shc_work@mail.ru>
References: <1384067901-9377-1-git-send-email-shc_work@mail.ru>
 <1384067901-9377-2-git-send-email-shc_work@mail.ru>
Message-ID: <CAL411-ptccWHJTG0HzP1bNVJg8Nq=bJ_K9jDz_B4vAQmqA8jFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 10, 2013 at 3:18 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> This adds i.MX51 as the next user of the usbmisc driver.
> Since the functional is similar i.MX53, we just rename the
> definitions and add an alias for the new CPU.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/usb/chipidea/usbmisc_imx.c | 40 +++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index 4381c5a6..f348ebb 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -25,12 +25,12 @@
>  #define MX27_H2_PM_BIT                 BIT(16)
>  #define MX27_OTG_PM_BIT                        BIT(24)
>
> -#define MX53_USB_OTG_PHY_CTRL_0_OFFSET 0x08
> -#define MX53_USB_UH2_CTRL_OFFSET       0x14
> -#define MX53_USB_UH3_CTRL_OFFSET       0x18
> -#define MX53_BM_OVER_CUR_DIS_H1                BIT(5)
> -#define MX53_BM_OVER_CUR_DIS_OTG       BIT(8)
> -#define MX53_BM_OVER_CUR_DIS_UHx       BIT(30)
> +#define MX5_USB_OTG_PHY_CTRL_0_OFFSET  0x08
> +#define MX5_USB_UH2_CTRL_OFFSET                0x14
> +#define MX5_USB_UH3_CTRL_OFFSET                0x18
> +#define MX5_BM_OVER_CUR_DIS_H1         BIT(5)
> +#define MX5_BM_OVER_CUR_DIS_OTG                BIT(8)
> +#define MX5_BM_OVER_CUR_DIS_UHx                BIT(30)
>
>  #define MX6_BM_OVER_CUR_DIS            BIT(7)
>
> @@ -102,7 +102,7 @@ static int usbmisc_imx27_init(struct imx_usbmisc_data *data)
>         return 0;
>  }
>
> -static int usbmisc_imx53_init(struct imx_usbmisc_data *data)
> +static int usbmisc_imx5_init(struct imx_usbmisc_data *data)
>  {
>         void __iomem *reg = NULL;
>         unsigned long flags;
> @@ -115,20 +115,20 @@ static int usbmisc_imx53_init(struct imx_usbmisc_data *data)
>                 spin_lock_irqsave(&usbmisc->lock, flags);
>                 switch (data->index) {
>                 case 0:
> -                       reg = usbmisc->base + MX53_USB_OTG_PHY_CTRL_0_OFFSET;
> -                       val = readl(reg) | MX53_BM_OVER_CUR_DIS_OTG;
> +                       reg = usbmisc->base + MX5_USB_OTG_PHY_CTRL_0_OFFSET;
> +                       val = readl(reg) | MX5_BM_OVER_CUR_DIS_OTG;
>                         break;
>                 case 1:
> -                       reg = usbmisc->base + MX53_USB_OTG_PHY_CTRL_0_OFFSET;
> -                       val = readl(reg) | MX53_BM_OVER_CUR_DIS_H1;
> +                       reg = usbmisc->base + MX5_USB_OTG_PHY_CTRL_0_OFFSET;
> +                       val = readl(reg) | MX5_BM_OVER_CUR_DIS_H1;
>                         break;
>                 case 2:
> -                       reg = usbmisc->base + MX53_USB_UH2_CTRL_OFFSET;
> -                       val = readl(reg) | MX53_BM_OVER_CUR_DIS_UHx;
> +                       reg = usbmisc->base + MX5_USB_UH2_CTRL_OFFSET;
> +                       val = readl(reg) | MX5_BM_OVER_CUR_DIS_UHx;
>                         break;
>                 case 3:
> -                       reg = usbmisc->base + MX53_USB_UH3_CTRL_OFFSET;
> -                       val = readl(reg) | MX53_BM_OVER_CUR_DIS_UHx;
> +                       reg = usbmisc->base + MX5_USB_UH3_CTRL_OFFSET;
> +                       val = readl(reg) | MX5_BM_OVER_CUR_DIS_UHx;
>                         break;
>                 }
>                 if (reg && val)
> @@ -166,8 +166,8 @@ static const struct usbmisc_ops imx27_usbmisc_ops = {
>         .init = usbmisc_imx27_init,
>  };
>
> -static const struct usbmisc_ops imx53_usbmisc_ops = {
> -       .init = usbmisc_imx53_init,
> +static const struct usbmisc_ops imx5_usbmisc_ops = {
> +       .init = usbmisc_imx5_init,
>  };
>
>  static const struct usbmisc_ops imx6q_usbmisc_ops = {
> @@ -204,8 +204,12 @@ static const struct of_device_id usbmisc_imx_dt_ids[] = {
>                 .data = &imx27_usbmisc_ops,
>         },
>         {
> +               .compatible = "fsl,imx51-usbmisc",
> +               .data = &imx5_usbmisc_ops,
> +       },
> +       {
>                 .compatible = "fsl,imx53-usbmisc",
> -               .data = &imx53_usbmisc_ops,
> +               .data = &imx5_usbmisc_ops,
>         },
>         {
>                 .compatible = "fsl,imx6q-usbmisc",
> --

Acked-by: Peter Chen <peter.chen@freescale.com>

-- 
BR,
Peter Chen
