From: balbi@ti.com (Felipe Balbi)
Date: Tue, 13 May 2014 10:27:35 -0500
Subject: [PATCH 5/8] usb: phy: msm: reset controller is mandatory now
In-Reply-To: <1399557141-1346645-6-git-send-email-arnd@arndb.de>
References: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
 <1399557141-1346645-6-git-send-email-arnd@arndb.de>
Message-ID: <20140513152735.GJ1151@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 03:52:18PM +0200, Arnd Bergmann wrote:
> Commit a27345434134 "usb: phy: msm: Use reset framework for LINK
> and PHY resets" introduced a mandatory call to reset_control_get
> into the msm usb phy driver, which means we have to add a Kconfig
> dependency on the API to avoid this build error:
> 
> phy/phy-msm-usb.c: In function 'msm_otg_read_dt':
> phy/phy-msm-usb.c:1461:2: error: implicit declaration of function 'devm_reset_control_get' [-Werror=implicit-function-declaration]
>   motg->link_rst = devm_reset_control_get(&pdev->dev, "link");
>   ^
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> ---
>  drivers/usb/host/Kconfig | 2 +-
>  drivers/usb/phy/Kconfig  | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 3d9e540..890fc8c 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -168,7 +168,7 @@ config USB_EHCI_HCD_AT91
>  
>  config USB_EHCI_MSM
>  	tristate "Support for Qualcomm QSD/MSM on-chip EHCI USB controller"
> -	depends on ARCH_MSM
> +	depends on ARCH_MSM && RESET_CONTROLLER
>  	select USB_EHCI_ROOT_HUB_TT
>  	select USB_MSM_OTG
>  	---help---
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index 359a6c1..65bec8f 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -165,6 +165,7 @@ config USB_ISP1301
>  config USB_MSM_OTG
>  	tristate "Qualcomm on-chip USB OTG controller support"
>  	depends on (USB || USB_GADGET) && (ARCH_MSM || ARCH_QCOM)
> +	depends on RESET_CONTROLLER
>  	select USB_PHY
>  	help
>  	  Enable this to support the USB OTG transceiver on Qualcomm chips. It

yeah, only this second hunk is necessary. I'll swap my patch with yours
once I see a second version.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140513/db821aaa/attachment-0001.sig>
