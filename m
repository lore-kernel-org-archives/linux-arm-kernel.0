From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 21 Aug 2017 14:35:25 +0900
Subject: [RFC] interrupts DT property for irqdomain hierarchy
In-Reply-To: <CAL_JsqLC2kUvhHHJdKd_UinvgRHpSv+vsPgRh0xGowfDX5BXYQ@mail.gmail.com>
References: <CAK7LNATme8P1uHx5hZr6Eez4KGweUi=jQ6zJ=bdBf1XmxZVoLg@mail.gmail.com>
 <CAL_JsqLC2kUvhHHJdKd_UinvgRHpSv+vsPgRh0xGowfDX5BXYQ@mail.gmail.com>
Message-ID: <CAK7LNASENLBy9vCi8tPLJ00v8yzkGiV+0w8LoiuCxiVJnxQCzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


2017-08-11 2:23 GMT+09:00 Rob Herring <robh+dt@kernel.org>:
> On Thu, Jul 6, 2017 at 4:58 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Hi IRQ experts, DT exports,
>>
>>
>> I have a question about CONFIG_IRQ_DOMAIN_HIERARCHY.
>>
>> When IRQ domains are hierarchy,
>> how can we specify IRQ number re-mapping between the
>> parent irqchip and the child irqchip?
>>
>> The following figure shows a simplified example.
>>
>> |----------|        |----------|       |----------|
>> | parent   |        | child    |       |  IRQ     |
>> | IRQ chip | <----- | IRQ chip |<----- | consumer |
>> |          |        |          |       | Device   |
>> |----------|        |----------|       |----------|
>>
>> Perhaps, we may describe DT like follows
>>
>>     gic: interrupt-controller {
>>             ...
>>             interrupt-controller;
>>             #interrupt-cells = <3>;
>>     };
>>
>>     child_intc: child-interrupt-controller {
>>             ...
>>             interrupt-parent = <&gic>;
>>             interrupts = <0 50 0>, <0 51 0>, <0 52 0>, <0 53 0>;
>>             interrupt-controller;
>>             #interrupt-cells = <2>;
>>     };
>>
>>     i2c: i2c {
>>             ...
>>             interrupt-parent = <&child_intc>;
>>             interrupts = <0 4>;
>>     };
>>
>>
>> In this example, the I2C controller takes HWIRQ=0 of the child_intc device.
>> This goes through the child IRQ chip,
>> then connected to HWIRQ=50 of the parent intc.
>>
>> The DT above describes the hardware connection well,
>> but it actually does not work.
>>
>> The root irqchip is usually declared with IRQCHIP_DECLARE().
>> So, IRQ resources are allocated when platform devices are populated from DT.
>> This means IRQ allocation happens before drivers are probed.
>>
>> of_pupulate_default_populate() does not know the fact about irqdomain hierarchy.
>
> This has not been true for some time now. The irqs are resolved at
> probe time rather than statically created resources and deferred probe
> is supported if one of the interrupt controllers is not yet
> initialized.


Yes, it is true if the irqchip is a platform driver instead of
IRQCHIP_DECLARE(),
but irqdomain hierarchy always wants to disable the static resource allocation.






>>    interrupt-ranges = <0 0 0 50 0 4>;
>>
>> This means   <0 0>, <0 1>, <0 2>, <0 3> in the child
>> should be mapped to  <0 50 0>, <0 51 0>, <0 52 0>, <0 53 0> in the parent,
>> respectively.
>
> interrupt-map property does this. See here[1].
>
> Rob
>
> [1] http://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping


Thanks for the pointer.

I read it and of_irq_parse_raw() implementation as well.

The interrupt-map would not work for the irqdomain hierarchy
because the interrupt-map transforms irq-spec based on "reg" property.

In this case, no relation between the irqchip and its irq-consumers
(between "child_intc" and "i2c") in therms of the physical address view.

Some irq-consumers have address cell size 1,
and other irq-consumers have address cells size 2.



-- 
Best Regards
Masahiro Yamada
