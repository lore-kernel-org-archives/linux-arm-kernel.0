From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 27 Nov 2013 15:24:57 -0500
Subject: [PATCH 2/3] ARM: dts: keystone: Add usb devicetree bindings
In-Reply-To: <5295C27E.3010805@ti.com>
References: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
 <1385410581-12148-3-git-send-email-w-kwok2@ti.com> <5295C27E.3010805@ti.com>
Message-ID: <52965519.3080209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 November 2013 04:59 AM, George Cherian wrote:
> On 11/26/2013 1:46 AM, WingMan Kwok wrote:
>> Added device tree support for TI's Keystone USB driver and updated the
>> Documentation with device tree binding information.
>>
>> On Keystone II platforms, we use no-op phy driver.
>>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
>> ---
>>   .../devicetree/bindings/usb/keystone-usb.txt       |   43 ++++++++++++++++++++
>>   arch/arm/boot/dts/keystone.dtsi                    |   27 ++++++++++++
>>   2 files changed, 70 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/usb/keystone-usb.txt
>>
[...]

>> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
>> index f6d6d9e..1e1049c 100644
>> --- a/arch/arm/boot/dts/keystone.dtsi
>> +++ b/arch/arm/boot/dts/keystone.dtsi
>> @@ -181,5 +181,32 @@
>>               interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
>>               clocks = <&clkspi>;
>>           };
>> +
>> +        usb2_phy: usb2_phy {
>> +            compatible = "usb-nop-xceiv";
>> +        };
>> +
>> +        usb3_phy: usb3_phy {
>> +            compatible = "usb-nop-xceiv";
>> +        };
>> +
>> +        usb: usb at 2680000 {
>> +            compatible = "ti,keystone-dwc3";
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            reg = <0x2680000 0x10000
>> +                   0x2620738 32>;
>> +            clocks = <&clkusb>;
>> +            clock-names = "usb";
>> +            interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
> 
> You don't have seperate interrrupt for wrapper and core?
> Is it the same interrupt shared between XHCI,DWC3 and wrapper?
>
You don't need actually two seperate interrupts.
DWC3 core actually registers IRQ for XHCI. And in OMAP case, there
is one more IRQ in wrapper. After checking with Felipe, it seems
the OMAP wrapper interrupt was more for debug purpose than any real
use.

On Keystone only one IRQ is used and the handling is managed
through IRQF_SHARED and that is also mainly because the IRQ
ack needs special write to EOI register unlike OMAP.

Regards,
Santosh
 
