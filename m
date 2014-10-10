From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Fri, 10 Oct 2014 09:17:28 +0900
Subject: [PATCH v3 2/3] ARM: shmobile: koelsch: enable HS-USB
In-Reply-To: <543684B6.6060708@cogentembedded.com>
References: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
 <8674731.7YYzQeH0h1@wasted.cogentembedded.com> <5435DFD6.3050609@renesas.com>
 <543684B6.6060708@cogentembedded.com>
Message-ID: <54372598.8060000@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

(2014/10/09 21:51), Sergei Shtylyov wrote:
> Hello.
> 
> On 10/09/2014 05:07 AM, Yoshihiro Shimoda wrote:
> 
>>> Enable HS-USB device for the Koelsch board, defining the GPIO that the driver
>>> should check when probing (which is the ID output from MAX3355 OTG chip).
> 
>>> Note that there will be pinctrl-related error messages if both internal PCI
>>> and HS-USB drivers are enabled but they should be just ignored.
> 
>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>> [Sergei: added pin function/group and prop, moved device node, fixed summary,
>>> added changelog]
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
>>> ---
>>> Changes in version 3:
>>> - added pinctrl-related properties;
>>> - moved the HS-USB node to precede the USB PHY node;
>>> - uppercased "arm" in the summary;
>>> - added changelog.
> 
>>>   arch/arm/boot/dts/r8a7791-koelsch.dts |    7 +++++++
>>>   1 file changed, 7 insertions(+)
> 
>>> Index: renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
>>> ===================================================================
>>> --- renesas.orig/arch/arm/boot/dts/r8a7791-koelsch.dts
>>> +++ renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
>>> @@ -464,6 +464,13 @@
>>>       pinctrl-names = "default";
>>>   };
>>>
>>> +&hsusb {
>>> +    status = "okay";
>>> +    pinctrl-0 = <&usb0_pins>;
>>> +    pinctrl-names = "default";
> 
>> Perhaps I don't understand the pinctrl world yet, but I have a question.
> 
>> In r8a7791, the USB0_PWEN is GP7_23 and the USB0_OVC is GP7_24. And,
>> the "usb0_pins" is related to these USB0 pins. But, as you know,
>> the koelsch has a OTG ID pin and it connects to GP5_31 via MAX3355 chip.
> 
>    The GPIO pins are not requested via pinctrl.
> 
>> So, would you tell me why koelsch needs the pinctrl?
> 
>    Because at least USB0_OVC/VBUS is used by HS-USB. I decided not to modify the R8A7791 PFC driver in order to create a group consisting of that signal alone (like on R8A7790), because we don't need to read GP7_23 on these boards, unlike Lager.

Thank you very much for the reply.
Finally I understood why it needs the princtrl.
(I didn't know the HS-USB will use the USB0_OVC/VBUS for detecting VBUS...)

Best regards,
Yoshihiro Shimoda

>> Best regards,
>> Yoshihiro Shimoda
> 
> WBR, Sergei
> 
