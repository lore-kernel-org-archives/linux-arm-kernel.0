From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 28 Oct 2016 20:13:06 +0200
Subject: [linux-sunxi] [PATCH RESEND 1/2] dt: bindings: add
 allwinner,otg-routed property for phy-sun4i-usb
In-Reply-To: <86c3fad4-e0c1-9aaf-76c5-b9428110464f@redhat.com>
References: <20161025041139.46454-1-icenowy@aosc.xyz>
 <55fe59fc-6e93-d519-2d7c-264c48820fc4@redhat.com>
 <4534561477471963@web8g.yandex.ru>
 <86c3fad4-e0c1-9aaf-76c5-b9428110464f@redhat.com>
Message-ID: <32a206ab-b082-3438-1395-99a2e3cc58c4@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On 26-10-16 12:14, Hans de Goede wrote:
> Hi,
>
> On 26-10-16 10:52, Icenowy Zheng wrote:
>>
>>
>> 26.10.2016, 16:28, "Hans de Goede" <hdegoede@redhat.com>:
>>> Hi,
>>>
>>> On 25-10-16 06:11, Icenowy Zheng wrote:
>>>>  On some newer Allwinner SoCs (H3 or A64), the PHY0 can be either routed to
>>>>  the MUSB controller (which is an OTG controller) or the OHCI/EHCI pair
>>>>  (which is a Host-only controller, but more stable and easy to implement).
>>>>
>>>>  This property marks whether on a certain board which controller should be
>>>>  attached to the PHY.
>>>>
>>>>  Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>>>
>>> Icenowy, I appreciate your work on this, but we really need full otg
>>> support with dynamic switching rather then hardwiring the routing, so
>>> this cannot go in as is.
>>
>> Now I have both PHY0 controllers' drivers.
>>
>> In the tree of https://github.com/Icenowy/linux/tree/ice-a64-v6.1 , I have already
>> enabled MUSB controller.
>>
>> And this patchset is for those prefer a stable USB host implement to dual-role
>> implementation. MUSB is a good UDC, but not a good host controller. My USB
>> sound card cannot work on MUSB on A33. Even connecting a R8's MUSB (Serial
>> Gadget) to an A33's MUSB cannot work.
>
> The idea is for dual-role setups to used the MUSB in gadget mode and the EHCI/OHCI
> pair when in host mode. So for otg setups you would runtime change the mux
> from one controller to the other based on the id pin value.
>
> Take a look at drivers/phy/phy-sun4i-usb.c, around line 512:
>
>     if (id_det != data->id_det) {
>         ...
>     }
>
> This deals with id_det changes (including the initial id_det "change"
> for hardwired host-only ports). This currently assumes that the musb
> will be used for host mode too, we will want to change this to
> something like this:
>
>     if (id_det != data->id_det) {
>         if (data->cfg->separate_phy0_host_controller) {
>             if (id_det) {
>                 /* Change to gadget mode (id_det == 1), switch phy mux to musb */
>                 actual code to switch phy mux to musb...
>             } else {
>                 /* Change to host mode (id_det == 0), switch phy mux to ehci/ohci */
>                 actual code to switch phy mux to ehci/ohci...
>             }
>         }
>         /* old code */
>     }
>
> Note this will then still rely on the musb code to actually turn
> the regulator on, so you do need to have the musb driver build and
> loaded. This can be fixed but lets start with the above.
>
> If you combine this with dr_mode = "host"; in the dts, then
> sun4i_usb_phy0_get_id_det() will return 0 so on its first run
> sun4i_usb_phy0_id_vbus_det_scan() will throw the mux to the ehci/ohci
> and everything should work as you want without needing the custom
> "allwinner,otg-routed" property, and we should be more or less
> ready to support full otg on other boards.

I've just found further proof that the musb on the H3 at least
only is intended for gadget mode and that we must dynamically
switch for host-mode. If you look at:

drivers/usb/sunxi_usb/include/sunxi_udc.h

In the h3 sdk then you will see that for the H3 a different fifo
endpoint table is used, as the total fifo space is only 4k where
as previous SoCs had 8k. This means that we need to have 2
different ep tables in drivers/usb/musb/sunxi.c and select by
compatible.

Regards,

Hans
