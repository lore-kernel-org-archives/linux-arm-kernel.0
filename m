From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 09 Jun 2016 17:35:12 +0900
Subject: [RFC v4 0/7] extcon: usb-gpio: fixes and improvements
In-Reply-To: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
References: <CGME20160608134820epcas1p4ee75a89888f2ae2adb733124a330bd2c@epcas1p4.samsung.com>
 <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <57592A40.9080608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It is good to support USB_ID and USB_VBUS by extcon.

But,
there is some issue about adding the new cable type for
both EXTCON_USB_ID and EXTCON_USB_VBUS

I think that the ID and VBUS state are not cable type
Instead, ID and VBUS state are the property of USB cable.

So, I'd like to add the following function to support
the property of each cable as following:
The client driver can get the state of property by using
the extcon_get_cable_property_state().

- int extcon_get_cable_property_state(struct extcon_dev *edev,
				unsigned int id,
				enum extcon_property property);
- int extcon_set_cable_property_state(struct extcon_dev *edev,
				unsigned int id,
				enum extcon_property property,
				unsigned int state);

For example,
In extcon-usb-gpio.c, set state of property as follwoing:
	extcon_set_cable_property_state(edev, EXTCON_USB, EXTCON_USB_PROP_ID, 1);
	extcon_set_cable_property_state(edev, EXTCON_USB, EXTCON_USB_PROP_VBUS, 1);


In the extcon client driver, get state of property as following:
	id_state = extcon_get_cable_property_state(edev, EXTCON_USB, EXTCON_USB_PROP_ID);
	vbus_state = extcon_get_cable_property_state(edev, EXTCON_USB, EXTCON_USB_PROP_VUBS);

Regards,
Chanwoo Choi


On 2016? 06? 08? 22:47, Krzysztof Kozlowski wrote:
> Hi,
> 
> 
> Some time ago, Robert tried to add VBUS detection to extcon-usb-gpio
> driver [1].  There was a discussion about patch #2 ("extcon: usb-gpio:
> add support for VBUS detection").
> 
> The final conclusion was that Chanwoo will add VBUS/ID notifiers [2].
> That unfortunately never happened so this patchset is a follow up.
> 
> 1. Add VBUS/ID cable state notifiers to extcon, so USB controllers
>    could use it.
> 2. Add VBUS detection to extcon-usb-gpio driver.
> 
> Some parts are based on old Robert's work, some are new, some are
> reworked.
> 
> 
> Best regards,
> Krzysztof
> 
> 
> [1] http://thread.gmane.org/gmane.linux.kernel/1923192/focus=1923193
> [2] http://thread.gmane.org/gmane.linux.kernel/1923192/focus=1941152
> 
> 
> Krzysztof Kozlowski (5):
>   Revert "extcon: usb-gpio: switch to use pm wakeirq apis"
>   extcon: Add raw VBUS and ID cable states
>   extcon: usb-gpio: Add support for VBUS detection
>   ARM: exynos_defconfig: Enable EXTCON_USB_GPIO for Odroid XU3 USB OTG
>   ARM: dts: exynos: Add extcon-usb-gpio node for Odroid XU3
> 
> Robert Baldyga (2):
>   Documentation: extcon: usb-gpio: update usb-gpio binding description
>   extcon: usb-gpio: make debounce value configurable in devicetree
> 
>  .../devicetree/bindings/extcon/extcon-usb-gpio.txt |  28 ++++-
>  arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |  21 ++++
>  arch/arm/boot/dts/exynos5422-odroidxu3.dts         |  21 ++++
>  arch/arm/configs/exynos_defconfig                  |   1 +
>  drivers/extcon/extcon-usb-gpio.c                   | 138 +++++++++++++++++----
>  drivers/extcon/extcon.c                            |   3 +
>  include/linux/extcon.h                             |   8 +-
>  7 files changed, 190 insertions(+), 30 deletions(-)
> 
