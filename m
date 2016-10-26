From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 26 Oct 2016 16:52:43 +0800
Subject: [linux-sunxi] [PATCH RESEND 1/2] dt: bindings: add allwinner,
 otg-routed property for phy-sun4i-usb
In-Reply-To: <55fe59fc-6e93-d519-2d7c-264c48820fc4@redhat.com>
References: <20161025041139.46454-1-icenowy@aosc.xyz>
 <55fe59fc-6e93-d519-2d7c-264c48820fc4@redhat.com>
Message-ID: <4534561477471963@web8g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



26.10.2016, 16:28, "Hans de Goede" <hdegoede@redhat.com>:
> Hi,
>
> On 25-10-16 06:11, Icenowy Zheng wrote:
>> ?On some newer Allwinner SoCs (H3 or A64), the PHY0 can be either routed to
>> ?the MUSB controller (which is an OTG controller) or the OHCI/EHCI pair
>> ?(which is a Host-only controller, but more stable and easy to implement).
>>
>> ?This property marks whether on a certain board which controller should be
>> ?attached to the PHY.
>>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>
> Icenowy, I appreciate your work on this, but we really need full otg
> support with dynamic switching rather then hardwiring the routing, so
> this cannot go in as is.

Now I have both PHY0 controllers' drivers.

In the tree of https://github.com/Icenowy/linux/tree/ice-a64-v6.1 , I have already
enabled MUSB controller.

And this patchset is for those prefer a stable USB host implement to dual-role
implementation. MUSB is a good UDC, but not a good host controller. My USB
sound card cannot work on MUSB on A33. Even connecting a R8's MUSB (Serial
Gadget) to an A33's MUSB cannot work.

See the IRC log between Andre and me,
https://irclog.whitequark.org/linux-sunxi/2016-10-24#18012695; .

>
> NACK.
>
> Regards,
>
> Hans
>
>> ?---
>> ??Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 6 ++++++
>> ??1 file changed, 6 insertions(+)
>>
>> ?diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
>> ?index 287150d..a63c766 100644
>> ?--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
>> ?+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
>> ?@@ -36,6 +36,12 @@ Optional properties:
>> ??- usb1_vbus-supply : regulator phandle for controller usb1 vbus
>> ??- usb2_vbus-supply : regulator phandle for controller usb2 vbus
>>
>> ?+Optional properties for H3 or A64 SoCs:
>> ?+- allwinner,otg-routed : USB0 (OTG) PHY is routed to OHCI/EHCI pair rather than
>> ?+ MUSB. (boolean, if this property is set, the OHCI/EHCI
>> ?+ controllers at PHY0 should be enabled and the MUSB
>> ?+ controller must *NOT* be enabled)
>> ?+
>> ??Example:
>> ??????????usbphy: phy at 0x01c13400 {
>> ??????????????????#phy-cells = <1>;
