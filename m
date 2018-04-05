From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 5 Apr 2018 22:04:01 +0200
Subject: [usb-next PATCH v11 3/8] usb: core: add a wrapper for the USB
 PHYs on the HCD
In-Reply-To: <CAK7LNARM=F3Ey0aO9PiNftxkcLVo4z10jdrkSrQE1f74nK1=Ng@mail.gmail.com>
References: <20180303214309.25643-1-martin.blumenstingl@googlemail.com>
 <20180303214309.25643-4-martin.blumenstingl@googlemail.com>
 <CAK7LNARM=F3Ey0aO9PiNftxkcLVo4z10jdrkSrQE1f74nK1=Ng@mail.gmail.com>
Message-ID: <CAFBinCCRhJLxOCz6_a23XnVcSo35MpE8huA8keNFBrWmr_mR=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

(great to hear that this might be useful on Socionext SoCs as well :))

On Wed, Apr 4, 2018 at 2:10 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-03-04 6:43 GMT+09:00 Martin Blumenstingl
> <martin.blumenstingl@googlemail.com>:
>> Many SoC platforms have separate devices for the USB PHY which are
>> registered through the generic PHY framework. These PHYs have to be
>> enabled to make the USB controller actually work. They also have to be
>> disabled again on shutdown/suspend.
>>
>> Currently (at least) the following HCI platform drivers are using custom
>> code to obtain all PHYs via devicetree for the roothub/controller and
>> disable/enable them when required:
>> - ehci-platform.c has ehci_platform_power_{on,off}
>> - xhci-mtk.c has xhci_mtk_phy_{init,exit,power_on,power_off}
>> - ohci-platform.c has ohci_platform_power_{on,off}
>>
>> With this new wrapper the USB PHYs can be specified directly in the
>> USB controller's devicetree node (just like on the drivers listed
>> above). This allows SoCs like the Amlogic Meson GXL family to operate
>> correctly once this is wired up correctly. These SoCs use a dwc3
>> controller and require all USB PHYs to be initialized (if one of the USB
>> PHYs it not initialized then none of USB port works at all).
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Tested-by: Yixun Lan <yixun.lan@amlogic.com>
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
>> ---
>>  drivers/usb/core/Makefile |   2 +-
>>  drivers/usb/core/phy.c    | 158 ++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/usb/core/phy.h    |   7 ++
>>  3 files changed, 166 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/usb/core/phy.c
>>  create mode 100644 drivers/usb/core/phy.h
>>
>> diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
>> index 92c9cefb4317..18e874b0441e 100644
>> --- a/drivers/usb/core/Makefile
>> +++ b/drivers/usb/core/Makefile
>> @@ -6,7 +6,7 @@
>>  usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
>>  usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
>>  usbcore-y += devio.o notify.o generic.o quirks.o devices.o
>> -usbcore-y += port.o
>> +usbcore-y += phy.o port.o
>>
>>  usbcore-$(CONFIG_OF)           += of.o
>>  usbcore-$(CONFIG_USB_PCI)              += hcd-pci.o
>> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
>> new file mode 100644
>> index 000000000000..09b7c43c0ea4
>> --- /dev/null
>> +++ b/drivers/usb/core/phy.c
>> @@ -0,0 +1,158 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * A wrapper for multiple PHYs which passes all phy_* function calls to
>> + * multiple (actual) PHY devices. This is comes handy when initializing
>> + * all PHYs on a HCD and to keep them all in the same state.
>> + *
>> + * Copyright (C) 2018 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/list.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/of.h>
>> +
>> +#include "phy.h"
>> +
>> +struct usb_phy_roothub {
>> +       struct phy              *phy;
>> +       struct list_head        list;
>> +};
>> +
>> +static struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev)
>> +{
>> +       struct usb_phy_roothub *roothub_entry;
>> +
>> +       roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
>> +       if (!roothub_entry)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       INIT_LIST_HEAD(&roothub_entry->list);
>> +
>> +       return roothub_entry;
>> +}
>> +
>> +static int usb_phy_roothub_add_phy(struct device *dev, int index,
>> +                                  struct list_head *list)
>> +{
>> +       struct usb_phy_roothub *roothub_entry;
>> +       struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
>> +
>> +       if (IS_ERR_OR_NULL(phy)) {
>> +               if (!phy || PTR_ERR(phy) == -ENODEV)
>> +                       return 0;
>> +               else
>> +                       return PTR_ERR(phy);
>> +       }
>> +
>> +       roothub_entry = usb_phy_roothub_alloc(dev);
>> +       if (IS_ERR(roothub_entry))
>> +               return PTR_ERR(roothub_entry);
>> +
>> +       roothub_entry->phy = phy;
>> +
>> +       list_add_tail(&roothub_entry->list, list);
>> +
>> +       return 0;
>> +}
>> +
>> +struct usb_phy_roothub *usb_phy_roothub_init(struct device *dev)
>> +{
>> +       struct usb_phy_roothub *phy_roothub;
>> +       struct usb_phy_roothub *roothub_entry;
>> +       struct list_head *head;
>> +       int i, num_phys, err;
>> +
>> +       num_phys = of_count_phandle_with_args(dev->of_node, "phys",
>> +                                             "#phy-cells");
>> +       if (num_phys <= 0)
>> +               return NULL;
>> +
>> +       phy_roothub = usb_phy_roothub_alloc(dev);
>> +       if (IS_ERR(phy_roothub))
>> +               return phy_roothub;
>> +
>> +       for (i = 0; i < num_phys; i++) {
>> +               err = usb_phy_roothub_add_phy(dev, i, &phy_roothub->list);
>> +               if (err)
>> +                       goto err_out;
>> +       }
>> +
>> +       head = &phy_roothub->list;
>
>
> I think phy_roothub->phy is always empty,
> and only phy_roothub->list is used.
>
>
> I just wondered if we can directly put 'struct list_head' into
> 'struct usb_hcd'.
maybe you can try it and send a patch (note: please wait until
v4.17-rc2-ish because there are some fixes that will be applied by
Greg after v4.17-rc1 is out, as well as the issues you noted below)?
I believe it's not critical so there's plenty of time to get it into v4.18

>> diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
>> new file mode 100644
>> index 000000000000..6fde59bfbff8
>> --- /dev/null
>> +++ b/drivers/usb/core/phy.h
>> @@ -0,0 +1,7 @@
>> +struct usb_phy_roothub;
>
> struct device;
>
> is also needed for usb_phy_roothub_init().
do you think that I should still fix this in 4.17?

>> +struct usb_phy_roothub *usb_phy_roothub_init(struct device *dev);
>> +int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
>> +
>> +int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
>> +void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
>
>
> Better to add an include guard?
> SPDX-License-Identifier for this header too?
good catch - I'll send a patch for this too (along with the missing
forward declaration for struct device)


Regards
Martin
