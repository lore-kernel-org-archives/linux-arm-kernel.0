From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Jul 2014 21:29:01 -0700
Subject: [PATCH 4/4] usb: dwc2: add dr_mode support for dwc2
In-Reply-To: <1406684129-18352-1-git-send-email-kever.yang@rock-chips.com>
References: <1406683873-18194-1-git-send-email-kever.yang@rock-chips.com>
 <1406684129-18352-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=VibSP16ierOU-6E=GddQoeQ=mrqD4ik7VG0o=ZULF7uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Tue, Jul 29, 2014 at 6:35 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
> Some devices with A female host port and without use of usb_id pin
> will need this for the otg controller works as device role
> during firmware period and works as host role in rich os.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  drivers/usb/dwc2/core.c     |   13 +++++++++++++
>  drivers/usb/dwc2/core.h     |    2 ++
>  drivers/usb/dwc2/platform.c |    4 ++++
>  3 files changed, 19 insertions(+)
>
> diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
> index 27d2c9b..6688951 100644
> --- a/drivers/usb/dwc2/core.c
> +++ b/drivers/usb/dwc2/core.c
> @@ -118,6 +118,7 @@ static int dwc2_core_reset(struct dwc2_hsotg *hsotg)
>  {
>         u32 greset;
>         int count = 0;
> +       u32 gusbcfg;
>
>         dev_vdbg(hsotg->dev, "%s()\n", __func__);
>
> @@ -148,6 +149,18 @@ static int dwc2_core_reset(struct dwc2_hsotg *hsotg)
>                 }
>         } while (greset & GRSTCTL_CSFTRST);
>
> +       if (hsotg->dr_mode == USB_DR_MODE_HOST) {
> +               gusbcfg = readl(hsotg->regs+GUSBCFG);
> +               gusbcfg &= ~GUSBCFG_FORCEDEVMODE;
> +               gusbcfg |= GUSBCFG_FORCEHOSTMODE;
> +               writel(gusbcfg, hsotg->regs+GUSBCFG);
> +       } else if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL) {
> +               gusbcfg = readl(hsotg->regs+GUSBCFG);
> +               gusbcfg &= ~GUSBCFG_FORCEHOSTMODE;
> +               gusbcfg |= GUSBCFG_FORCEDEVMODE;
> +               writel(gusbcfg, hsotg->regs+GUSBCFG);
> +       }

Don't you want to handle "dr_mode == USB_DR_MODE_OTG" here too?
