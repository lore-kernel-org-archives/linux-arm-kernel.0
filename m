From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 14 Jan 2013 11:44:24 +0100
Subject: [PATCH 1/6] ARM: common: vic: Parse interrupt and resume masks
 from device tree
In-Reply-To: <50F35AA1.1010902@gmail.com>
References: <1358039458-31960-1-git-send-email-tomasz.figa@gmail.com>
 <1358039458-31960-2-git-send-email-tomasz.figa@gmail.com>
 <50F35AA1.1010902@gmail.com>
Message-ID: <CA+Ln22F_wQe+r-5fQHyW4bB_DzNu3FLSntkN7mF+uwBkvFGBjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

2013/1/14 Rob Herring <robherring2@gmail.com>:
> On 01/12/2013 07:10 PM, Tomasz Figa wrote:
>> This patch extends vic_of_init to parse valid interrupt sources
>> and resume sources masks from device tree.
>>
>> If mask values are not specified in device tree, all sources
>> are assumed to be valid, as before this patch.
>>
>> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/arm/vic.txt | 6 ++++++
>>  arch/arm/common/vic.c                         | 7 ++++++-
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/vic.txt b/Documentation/devicetree/bindings/arm/vic.txt
>> index 266716b..bb7137c 100644
>> --- a/Documentation/devicetree/bindings/arm/vic.txt
>> +++ b/Documentation/devicetree/bindings/arm/vic.txt
>> @@ -18,6 +18,9 @@ Required properties:
>>  Optional properties:
>>
>>  - interrupts : Interrupt source for parent controllers if the VIC is nested.
>> +- interrupt-mask : Bit mask of valid interrupt sources (defaults to all valid)
>
> Can you explain why this is needed and is not just the OR of all
> interrupts described in the DT?

Well, it depends what you mean with interrupts described in the DT.

Basically this mask is used for sanity checks of request_irq calls,
by denying interrupts non-existent on given platform.

>> +- wakeup-mask : Bit mask of interrupt sources that can wake up the system
>> +  (defaults to all allowed)
>
> Seems like this would be all VIC interrupts unless the wake-up handling
> is done in some shadow controller. If the former is true, then wake-up
> capability is really a property of individual devices. If the later,
> then this property would belong in that shadow controller.

Yes, there is a shadow controller used for configuring which of the available
wake-up signals shall be used.

Still, I don't see how I should model it in the device tree, since its VIC whose
set_irq_wake callback is called.

Before Device Tree, both interrupt and wake-up masks were being passed
as arguments to vic_init function. This is what made me add them as
DT attributes of VIC.

Best regards,
Tomasz Figa

P.S. Rob, sorry for the original message. I have clicked "reply"
instead of "reply to all" in the mobile GMail client.

> Rob
>
>>
>>  Example:
>>
>> @@ -26,4 +29,7 @@ Example:
>>               interrupt-controller;
>>               #interrupt-cells = <1>;
>>               reg = <0x60000 0x1000>;
>> +
>> +             interrupt-mask = <0xffffff7f>;
>> +             wakeup-mask = <0x0000ff7f>;
>>       };
>> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
>> index e4df17c..c2889da 100644
>> --- a/arch/arm/common/vic.c
>> +++ b/arch/arm/common/vic.c
>> @@ -407,6 +407,8 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
>>  int __init vic_of_init(struct device_node *node, struct device_node *parent)
>>  {
>>       void __iomem *regs;
>> +     u32 interrupt_mask = ~0;
>> +     u32 wakeup_mask = ~0;
>>
>>       if (WARN(parent, "non-root VICs are not supported"))
>>               return -EINVAL;
>> @@ -415,10 +417,13 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
>>       if (WARN_ON(!regs))
>>               return -EIO;
>>
>> +     of_property_read_u32(node, "interrupt-mask", &interrupt_mask);
>> +     of_property_read_u32(node, "wakeup-mask", &wakeup_mask);
>> +
>>       /*
>>        * Passing -1 as first IRQ makes the simple domain allocate descriptors
>>        */
>> -     __vic_init(regs, -1, ~0, ~0, node);
>> +     __vic_init(regs, -1, interrupt_mask, wakeup_mask, node);
>>
>>       return 0;
>>  }
>>
>
