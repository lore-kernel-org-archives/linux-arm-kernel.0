From: kever.yang@rock-chips.com (Kever Yang)
Date: Fri, 08 Aug 2014 09:12:12 +0800
Subject: [PATCH] usb: dwc2: Read GNPTXFSIZ when in forced HOST mode.
In-Reply-To: <1407440891-29295-1-git-send-email-dianders@chromium.org>
References: <1407440891-29295-1-git-send-email-dianders@chromium.org>
Message-ID: <53E423EC.6090309@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug:

On 08/08/2014 03:48 AM, Doug Anderson wrote:
> The documentation for GNPTXFSIZ says that "For host mode, this field
> is always valid."  Since we're already switching to host mode for
> HPTXFSIZ, let's also read GNPTXFSIZ in host mode.
>
> On an rk3288 SoC, without this change we see this at bootup:
>    dwc2 ff580000.usb: gnptxfsiz=00100400
>    dwc2 ff580000.usb: 128 invalid for host_nperio_tx_fifo_size. Check HW configuration.
>
> After this change we see:
>    dwc2 ff580000.usb: gnptxfsiz=04000400
Yeap, that is the problem cause the log you shown in rk3288-evb and 
further more
cause fifo setting fail.

I was plan to commit this patch just the same as you did.
It's great that you also find out the problem and send this patch.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>   drivers/usb/dwc2/core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
> index 27d2c9b..c184ed43 100644
> --- a/drivers/usb/dwc2/core.c
> +++ b/drivers/usb/dwc2/core.c
> @@ -2674,23 +2674,23 @@ int dwc2_get_hwparams(struct dwc2_hsotg *hsotg)
>   	hwcfg2 = readl(hsotg->regs + GHWCFG2);
>   	hwcfg3 = readl(hsotg->regs + GHWCFG3);
>   	hwcfg4 = readl(hsotg->regs + GHWCFG4);
> -	gnptxfsiz = readl(hsotg->regs + GNPTXFSIZ);
>   	grxfsiz = readl(hsotg->regs + GRXFSIZ);
>   
>   	dev_dbg(hsotg->dev, "hwcfg1=%08x\n", hwcfg1);
>   	dev_dbg(hsotg->dev, "hwcfg2=%08x\n", hwcfg2);
>   	dev_dbg(hsotg->dev, "hwcfg3=%08x\n", hwcfg3);
>   	dev_dbg(hsotg->dev, "hwcfg4=%08x\n", hwcfg4);
> -	dev_dbg(hsotg->dev, "gnptxfsiz=%08x\n", gnptxfsiz);
>   	dev_dbg(hsotg->dev, "grxfsiz=%08x\n", grxfsiz);
>   
> -	/* Force host mode to get HPTXFSIZ exact power on value */
> +	/* Force host mode to get HPTXFSIZ / GNPTXFSIZ exact power on value */
>   	gusbcfg = readl(hsotg->regs + GUSBCFG);
>   	gusbcfg |= GUSBCFG_FORCEHOSTMODE;
>   	writel(gusbcfg, hsotg->regs + GUSBCFG);
>   	usleep_range(100000, 150000);
>   
> +	gnptxfsiz = readl(hsotg->regs + GNPTXFSIZ);
>   	hptxfsiz = readl(hsotg->regs + HPTXFSIZ);
> +	dev_dbg(hsotg->dev, "gnptxfsiz=%08x\n", gnptxfsiz);
>   	dev_dbg(hsotg->dev, "hptxfsiz=%08x\n", hptxfsiz);
>   	gusbcfg = readl(hsotg->regs + GUSBCFG);
>   	gusbcfg &= ~GUSBCFG_FORCEHOSTMODE;
There may be a potential problem still need to fix, the grxfsiz may have 
being changed,
the bootrom and uboot will change this value if they use the dwc2 
controller.
The way we get the register value here can not make sure this is the 
power-on
value which we actually need.

Let me do more test for that, and maybe we need another patch.

Anyway, this patch works and reasonable.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
