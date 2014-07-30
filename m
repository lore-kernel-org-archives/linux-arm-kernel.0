From: Paul.Zimmerman@synopsys.com (Paul Zimmerman)
Date: Wed, 30 Jul 2014 19:05:51 +0000
Subject: [PATCH 4/4] usb: dwc2: add dr_mode support for dwc2
In-Reply-To: <1406684129-18352-1-git-send-email-kever.yang@rock-chips.com>
References: <1406683873-18194-1-git-send-email-kever.yang@rock-chips.com>
 <1406684129-18352-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <A2CA0424C0A6F04399FB9E1CD98E0304844C2FA3@US01WEMBX2.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Kever Yang [mailto:kever.yang at rock-chips.com]
> Sent: Tuesday, July 29, 2014 6:35 PM
> 
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
>  	u32 greset;
>  	int count = 0;
> +	u32 gusbcfg;
> 
>  	dev_vdbg(hsotg->dev, "%s()\n", __func__);
> 
> @@ -148,6 +149,18 @@ static int dwc2_core_reset(struct dwc2_hsotg *hsotg)
>  		}
>  	} while (greset & GRSTCTL_CSFTRST);
> 
> +	if (hsotg->dr_mode == USB_DR_MODE_HOST) {
> +		gusbcfg = readl(hsotg->regs+GUSBCFG);
> +		gusbcfg &= ~GUSBCFG_FORCEDEVMODE;
> +		gusbcfg |= GUSBCFG_FORCEHOSTMODE;
> +		writel(gusbcfg, hsotg->regs+GUSBCFG);
> +	} else if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL) {
> +		gusbcfg = readl(hsotg->regs+GUSBCFG);
> +		gusbcfg &= ~GUSBCFG_FORCEHOSTMODE;
> +		gusbcfg |= GUSBCFG_FORCEDEVMODE;
> +		writel(gusbcfg, hsotg->regs+GUSBCFG);
> +	}

Please put spaces around the '+' operator. Did you run these patches
through checkpatch?

> +
>  	/*
>  	 * NOTE: This long sleep is _very_ important, otherwise the core will
>  	 * not stay in host mode after a connector ID change!
> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> index 1efd10c..9fe960b 100644
> --- a/drivers/usb/dwc2/core.h
> +++ b/drivers/usb/dwc2/core.h
> @@ -501,6 +501,7 @@ struct dwc2_hw_params {
>   *                      a_peripheral and b_device=>b_host) this may not match
>   *                      the core, but allows the software to determine
>   *                      transitions
> + * @dr_mode:            requested mode of operation

Please expand this comment, e.g.
"Requested mode of operation (host/peripheral/dual-role)"

-- 
Paul
