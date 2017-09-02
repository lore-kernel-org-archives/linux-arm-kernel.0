From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 1 Sep 2017 19:16:26 -0700
Subject: [PATCH V5 0/4] Add Broadcom STB USB phy driver
In-Reply-To: <1503683495-11766-1-git-send-email-alcooperx@gmail.com>
References: <1503683495-11766-1-git-send-email-alcooperx@gmail.com>
Message-ID: <f4625f5e-db00-ebcc-4618-6f00247edfab@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/25/2017 10:51 AM, Al Cooper wrote:
> Add a new USB Phy driver for Broadcom STB SoCs. This driver
> supports Broadcom STB ARM SoCs. This driver in
> combination with the Broadcom STB ohci, ehci and xhci
> drivers will enable USB1.1, USB2.0 and USB3.0 support.
> This Phy driver also supports the Broadcom BDC gadget
> driver.

Thanks Al! Kishon, feel free to merge everything through your tree there
should not be any conflicts with drivers/soc/bcm/brcmstb/common.c and
include/linux/soc/brcmstb/brcmstb.h.

> 
> Changes since v4:
> - MIPS support was dropped, so remove MIPS specific code
>   in the brcmusb_readl/brcmusb_writel routines.
> - Use readl/writel instead of readl_relaxed/writel_relaxed.
> - Remove double blank lines between some functions.
> - Remove support for obselete phy phandle argument.
> 
> Changes since v3:
> - Removed MIPS support because there is such a small
>   amount of code that is common to both ARM and MIPS.
>   I'll create a separate MIPS driver in the future.
> - Have the Kconfig selection for this driver also select
>   "CONFIG_SOC_BRCMSTB" which contains needed functions.
> - Change device tree properties to use "brcm,has_xhci" and
>   "brcm,has_eohci" to determine if the phy contains
>   a xhci phy, and e/ohci phy or both.
> - Change the phy xlate routine to return an error instead
>   of NULL for a requested phy that doesn't exist.
> - Moved some probe functionality into it's own funtion to
>   simplify the many "if (has_xhci)" statements.
> 
> Changes since v2:
> - Fix kbuild errors by changing Kconfig so the driver
>   only builds for ARCH_BRCMSTB || BMIPS_GENERIC systems
> 
> Changes since v1:
> - Rebased to next
> - Add Kconfig entry to build the driver
> - Commented all delays
> - Split out sysfs functionality in separate patch
> - Removed parsing of old obselete device tree properties
> - Changed device property "device" to "dr_mode" using
>   standard values "host" and "peripheral" along with new
>   values "drd" and "typec-pd"
> - Add ability to handle the standard PHY_TYPE_USB2 and
>   PHY_TYPE_USB3 arguments passed in by phy consumers.
> - Moved phy_provider_register() to end of probe routine
> 
> Al Cooper (4):
>   soc: brcmstb: Add Product ID and Family ID helper functions
>   dt-bindings: Add Broadcom STB USB PHY binding document
>   phy: usb: phy-brcm-usb: Add Broadcom STB USB phy driver
>   phy: usb: phy-brcm-usb: Add ability to force DRD mode to host or
>     device
> 
>  .../bindings/phy/brcm,brcmstb-usb-phy.txt          |   43 +
>  MAINTAINERS                                        |    7 +
>  drivers/phy/broadcom/Kconfig                       |   13 +
>  drivers/phy/broadcom/Makefile                      |    3 +
>  drivers/phy/broadcom/phy-brcm-usb-init.c           | 1007 ++++++++++++++++++++
>  drivers/phy/broadcom/phy-brcm-usb-init.h           |   50 +
>  drivers/phy/broadcom/phy-brcm-usb.c                |  458 +++++++++
>  drivers/soc/bcm/brcmstb/common.c                   |   12 +
>  include/linux/soc/brcmstb/brcmstb.h                |   10 +
>  9 files changed, 1603 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
>  create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init.c
>  create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init.h
>  create mode 100644 drivers/phy/broadcom/phy-brcm-usb.c
> 

-- 
Florian
