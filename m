From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Tue, 25 Sep 2012 18:47:24 +0530
Subject: [PATCH v6 1/5] usb: phy: samsung: Introducing usb phy driver for
 hsotg
In-Reply-To: <5061A131.9010905@gmail.com>
References: <1347886484-16064-1-git-send-email-p.paneri@samsung.com>
 <1347886484-16064-2-git-send-email-p.paneri@samsung.com>
 <50605A69.2070201@gmail.com>
 <CAD6zSYOABTwTGXgFwGwLX-NhjDjDvtqUDVYTMGDng3nuTgLeZg@mail.gmail.com>
 <5061A131.9010905@gmail.com>
Message-ID: <CAAe_U6J7j1_kLz3kUaOQqXmpR1JbS3wQypaPe=MTae8JUs5LDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 25, 2012 at 5:48 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 09/25/2012 06:23 AM, Praveen Paneri wrote:
>> Hi Rob,
>>
>> On Mon, Sep 24, 2012 at 6:34 PM, Rob Herring <robherring2@gmail.com> wrote:
>>> On 09/17/2012 07:54 AM, Praveen Paneri wrote:
>>>> This driver uses usb_phy interface to interact with s3c-hsotg. Supports
>>>> phy_init and phy_shutdown functions to enable/disable phy. Tested with
>>>> smdk6410 and smdkv310. More SoCs can be brought under later.
>>>>
>>>> Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
>>>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>>>> ---
>>>>  .../devicetree/bindings/usb/samsung-usbphy.txt     |    9 +
>>>>  drivers/usb/phy/Kconfig                            |    8 +
>>>>  drivers/usb/phy/Makefile                           |    1 +
>>>>  drivers/usb/phy/samsung-usbphy.c                   |  360 ++++++++++++++++++++
>>>>  include/linux/platform_data/samsung-usbphy.h       |   27 ++
>>>>  5 files changed, 405 insertions(+), 0 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/usb/samsung-usbphy.txt
>>>>  create mode 100644 drivers/usb/phy/samsung-usbphy.c
>>>>  create mode 100644 include/linux/platform_data/samsung-usbphy.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/samsung-usbphy.txt b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
>>>> new file mode 100644
>>>> index 0000000..fefd9c8
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
>>>> @@ -0,0 +1,9 @@
>>>> +* Samsung's usb phy transceiver
>>>> +
>>>> +The Samsung's phy transceiver is used for controlling usb otg phy for
>>>> +s3c-hsotg usb device controller.
>>>> +
>>>> +Required properties:
>>>> +- compatible : should be "samsung,exynos4210-usbphy"
>>>> +- reg : base physical address of the phy registers and length of memory mapped
>>>> +     region.
>>>
>>> What's missing here is describing the connection of phys to host
>>> controllers. We've got several people adding usb phy bindings and need
>>> to define them in a common way.
>> yes! it just covers the generic binding. I will update it accordingly
>> as the generic phy framework takes its final shape.
>
> That sounds like the wrong way to define a binding... Figuring out how
> to describe the h/w should not be dependent on changes in the kernel.
> Bindings are an ABI and should not be evolving.

There can be multiple ways to define the binding. For e.g. We
discussed few ways of binding the phys to the controller

controller {
              phy0 = <&phandle1_name>;
              phy1 = <&phandle2_name>;
}

phy0 and phy1 are any name given to obtain a reference to the phy and
the controller should send the phandle name like
get_phy_by_phandle("phy0");. Then we thought of standardizing that
name.

and then finally we settled on something like this
controller {
              phy = <&phandle0_name>, <&phandle1_name>;
}
so that controller can obtain a reference to the PHY using
*of_phy_get(struct device *dev, const char *phandle, u8 index)*

Thanks
Kishon
