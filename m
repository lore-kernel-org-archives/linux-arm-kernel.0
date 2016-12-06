From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 6 Dec 2016 09:36:48 -0800
Subject: [PATCH 2/5] ARM: BCM5301X: Specify USB controllers in DT
In-Reply-To: <CACna6rw4iY_xhEUyWkGrchs0SOn3nLBKYMuA7qa0UHAbxpGN0A@mail.gmail.com>
References: <20161206171714.22738-1-zajec5@gmail.com>
 <20161206171714.22738-2-zajec5@gmail.com>
 <c721c71c-117f-185d-0544-954981dbcf04@broadcom.com>
 <CACna6rw4iY_xhEUyWkGrchs0SOn3nLBKYMuA7qa0UHAbxpGN0A@mail.gmail.com>
Message-ID: <cbb8f2e0-864f-8c95-d9fe-2de46ed0fce0@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/6/2016 9:31 AM, Rafa? Mi?ecki wrote:
> On 6 December 2016 at 18:28, Ray Jui <ray.jui@broadcom.com> wrote:
>> On 12/6/2016 9:17 AM, Rafa? Mi?ecki wrote:
>>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>>
>>> There are 3 separated controllers, one per USB /standard/. With PHY
>>> drivers in place they can be simply supported with generic drivers.
>>>
>>> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
>>> ---
>>>  arch/arm/boot/dts/bcm5301x.dtsi | 33 ++++++++++++++++++++++++++++++++-
>>>  1 file changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
>>> index f09a2bb..bfc98d19 100644
>>> --- a/arch/arm/boot/dts/bcm5301x.dtsi
>>> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
>>> @@ -248,8 +248,26 @@
>>>
>>>                       #address-cells = <1>;
>>>                       #size-cells = <1>;
>>> +                     ranges;
>>>
>>> -                     phys = <&usb2_phy>;
>>> +                     interrupt-parent = <&gic>;
>>> +
>>> +                     ohci: ohci at 21000 {
>>> +                             #usb-cells = <0>;
>>> +
>>> +                             compatible = "generic-ohci";
>>> +                             reg = <0x00022000 0x1000>;
>>
>> Your label ohci at 21000 does not match the 'reg' at 0x22000.
>>
>>> +                             interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
>>> +                     };
>>> +
>>> +                     ehci: ehci at 22000 {
>>> +                             #usb-cells = <0>;
>>> +
>>> +                             compatible = "generic-ehci";
>>> +                             reg = <0x00021000 0x1000>;
>>
>> Looks like you got the label of ohci and ehci reversed?
> 
> Nice catch, thanks! I'll fix it in V2 (just let me wait a day to see
> if there will be other comments).
> 

In V2, please remember to put the nodes in ascending order based on the
base address of the registers, i.e., ehci at 21000, and then followed by
ohci at 22000.

Thanks,

Ray
