From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 21 Sep 2016 10:30:24 +0300
Subject: [PATCH 1/2] dt: bindings: add allwinner,otg-routed property for
 phy-sun4i-usb
In-Reply-To: <6718551474442396@web16h.yandex.ru>
References: <20160921070406.27445-1-icenowy@aosc.xyz>
 <4a1ab62a-4091-fd75-d753-fb30585dffa5@redhat.com>
 <6718551474442396@web16h.yandex.ru>
Message-ID: <43caf5c6-0198-9178-de93-90dc25e8b72b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/21/2016 10:19 AM, Icenowy Zheng wrote:
>
>
> 21.09.2016, 15:10, "Hans de Goede" <hdegoede@redhat.com>:
>> Hi,
>>
>> On 09/21/2016 10:04 AM, Icenowy Zheng wrote:
>>>  On some newer Allwinner SoCs (H3 or A64), the PHY0 can be either routed to
>>>  the MUSB controller (which is an OTG controller) or the OHCI/EHCI pair
>>>  (which is a Host-only controller, but more stable and easy to implement).
>>>
>>>  This property marks whether on a certain board which controller should be
>>>  attached to the PHY.
>>>
>>>  Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>>
>> Erm, I think that the idea here is to dynamically switch the routing
>> based on the id-pin of the otg connector. IOW use the musb controller
>> for device mode, and the ehci/ohci proper for proper host support
>> when in host mode.
>
> At least on some boards this implementation works...
>
> (I mean Pine64, which has two USB-A connectors)

Right and I think it is great that you're working on this.

But even with an A connector on the board, we can still use the device
mode (e.g. the SoC's native FEL mode will be used this way).

Notice that you can fake id-pin changes by echoing a mode to:

/sys/devices/platform/soc at 01c00000/1c13000.usb/musb-hdrc.1.auto/mode

Valid values to echo are: host, peripheral and otg.

If you combine this with using either an USB A<->A cable, or using
the port normally as a host you should be able to develop and test
full otg support.

Eventually we will need a full otg support rather then your current solution
and I'm afraid that your solution may get in the way of full otg support.

Regards,

Hans
