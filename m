From: balbi@ti.com (Felipe Balbi)
Date: Mon, 15 Oct 2012 16:30:15 +0300
Subject: [PATCH v7] Enable USB peripheral mode on dm365 EVM
In-Reply-To: <1349973274-24936-1-git-send-email-const@MakeLinux.com>
References: <1349973274-24936-1-git-send-email-const@MakeLinux.com>
Message-ID: <20121015133014.GU24333@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 11, 2012 at 06:34:34PM +0200, Constantine Shulyupin wrote:
> From: Constantine Shulyupin <const@MakeLinux.com>
> 
> Sets USB PHY clock source to 24 MHz clock.
> 
> Tested with OTG configuration, usb gadget g_zero on DM365 EVM connected to PC.
> 
> To active the patch need to call davinci_setup_usb from dm365_evm_init
> 
> References:
> 
> Definition of USB_PHY_CTRL and PHYCLKFREQ:
> - http://www.makelinux.com/lib/ti/DM36x_ARM/doc-141
> 
> Original patch by miguel.aguilar at ridgerun.com three years ago:
> - http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg14741.html
> 
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
> 
> Note:
> 
> Changelog
> 
> Changes since v6
> - moved call to davinci_setup_usb from dm365_evm_init to another patch accordinly request of Sergei
>  
> Changes since v5 http://www.spinics.net/lists/kernel/msg1413120.html
> accordingy feedback of nsekhar at ti.com http://www.spinics.net/lists/kernel/msg1414914.html
> - phy configuration moved to drivers/usb/musb/davinci.c
> - USB_OTG configuration is submitted in separated patch: http://www.spinics.net/lists/kernel/msg1414964.html
> - Setting current limit to 1000 mA. Any way the current is limited to 510 mA in davinci_setup_usb.
> 
> Changes since v4 http://www.spinics.net/lists/kernel/msg1412995.html
> - removed fix of dev_info in musb_init_controller
> 
> Changes since v3 http://www.spinics.net/lists/kernel/msg1412544.html:
> - removed optional altering of pr_info
> 
> Changes since v1  http://marc.info/?l=linux-kernel&m=130894150803661&w=2:
> - removed optional code and reordered
> - removed alternation of GPIO33, which is multiplexed with DRVVBUS, because is not need for peripheral USB
> 
> This patch is based on code from projects Arago, Angstom and RidgeRun.
> 
> ---
>  drivers/usb/musb/davinci.c              |    3 +++
>  drivers/usb/musb/davinci.h              |    1 +
> 
> diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
> index 472c8b4..af09ebf 100644
> --- a/drivers/usb/musb/davinci.c
> +++ b/drivers/usb/musb/davinci.c
> @@ -428,6 +428,9 @@ static int davinci_musb_init(struct musb *musb)
>  		__raw_writel(deepsleep, DM355_DEEPSLEEP);
>  	}
>  
> +	if (machine_is_davinci_dm365_evm())
> +		writel(readl(USB_PHY_CTRL) | USBPHY_CLKFREQ_24MHZ, USB_PHY_CTRL);

NAK!!! No machine_is_* in drivers/ directory. You shouldn't control your
PHY directly, you need a PHY driver.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121015/adf04329/attachment.sig>
