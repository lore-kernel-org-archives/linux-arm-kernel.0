From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 25 Apr 2013 10:59:50 -0700
Subject: [PATCH 18/21] USB: ehci-msm: USB_MSM_OTG needs USB_PHY
In-Reply-To: <1366910944-3033663-19-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-19-git-send-email-arnd@arndb.de>
Message-ID: <20130425175950.GA14654@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 07:29:01PM +0200, Arnd Bergmann wrote:
> The Kconfig entry for USB_EHCI_MSM unconditionally selects USB_MSM_OTG,
> which is now only visible when USB_PHY is also enabled.
> 
> This adds an appropriate dependency and enables USB_PHY in the msm
> defconfig, avoiding the Kbuild warning:
> 
> warning: (USB_EHCI_MSM) selects USB_MSM_OTG which has unmet direct dependencies (USB_SUPPORT && USB_PHY && (USB || USB_GADGET) && ARCH_MSM)
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-usb at vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Pavankumar Kondeti <pkondeti@codeaurora.org>
> ---
>  arch/arm/configs/msm_defconfig | 1 +
>  drivers/usb/host/Kconfig       | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/msm_defconfig b/arch/arm/configs/msm_defconfig
> index 44f9291..690b5f9 100644
> --- a/arch/arm/configs/msm_defconfig
> +++ b/arch/arm/configs/msm_defconfig
> @@ -101,6 +101,7 @@ CONFIG_SND_DYNAMIC_MINORS=y
>  CONFIG_SND_SOC=y
>  CONFIG_HID_BATTERY_STRENGTH=y
>  CONFIG_USB=y
> +CONFIG_USB_PHY=y
>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  CONFIG_USB_MON=y
>  CONFIG_USB_EHCI_HCD=y

This part of the patch doesn't apply to my tree, so I can't take it.

> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index c558472..de94f26 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -188,6 +188,7 @@ config USB_EHCI_HCD_AT91
>  config USB_EHCI_MSM
>  	tristate "Support for Qualcomm QSD/MSM on-chip EHCI USB controller"
>  	depends on ARCH_MSM
> +	depends on USB_PHY
>  	select USB_EHCI_ROOT_HUB_TT
>  	select USB_MSM_OTG
>  	---help---

But this does, and I'm guessing that it's the more important part, so
I'll just edit it and only take this hunk, ok?

thanks,

greg k-h
