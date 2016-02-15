From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 15 Feb 2016 16:08:12 +0000
Subject: [PATCH v6 2/3] Documentation: gpio: Update description for X-Gene
 standby GPIO controller DTS binding
In-Reply-To: <CAFopSPRwd8cHnH8efegYVv52hPVTyk=VW9OrZZtSCj6Szj-K4Q@mail.gmail.com>
References: <1455512263-18183-1-git-send-email-qnguyen@apm.com>
 <1455512263-18183-3-git-send-email-qnguyen@apm.com>
 <56C1CA6E.1060606@arm.com>
 <CAFopSPRwd8cHnH8efegYVv52hPVTyk=VW9OrZZtSCj6Szj-K4Q@mail.gmail.com>
Message-ID: <56C1F7EC.3020701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/16 15:31, Quan Nguyen wrote:
> On Mon, Feb 15, 2016 at 7:54 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 15/02/16 04:57, Quan Nguyen wrote:
>>> Update description for X-Gene standby GPIO controller DTS binding to
>>> support GPIO line configuration as input, output or external IRQ pin.
>>>
>>> Signed-off-by: Y Vo <yvo@apm.com>
>>> Signed-off-by: Quan Nguyen <qnguyen@apm.com>
>>> ---
>>>  .../devicetree/bindings/gpio/gpio-xgene-sb.txt     | 47 ++++++++++++++++++----
>>>  1 file changed, 40 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt b/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
>>> index dae1300..7b8b4cb 100644
>>> --- a/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
>>> +++ b/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
>>> @@ -1,10 +1,20 @@
>>>  APM X-Gene Standby GPIO controller bindings
>>>
>>> -This is a gpio controller in the standby domain.
>>> -
>>> -There are 20 GPIO pins from 0..21. There is no GPIO_DS14 or GPIO_DS15,
>>> -only GPIO_DS8..GPIO_DS13 support interrupts. The IRQ mapping
>>> -is currently 1-to-1 on interrupts 0x28 thru 0x2d.
>>> +This is a gpio controller in the standby domain. It also supports interrupt in
>>> +some particular pins which are sourced to its parent interrupt controller
>>> +as diagram below:
>>> +                           +-----------------+
>>> +                           | X-Gene standby  |
>>> +                           | GPIO controller +--------- GPIO_0
>>> ++------------+             |                 | ...
>>> +| Parent IRQ |             |                 +--------- GPIO_8/EXT_INT_0
>>> +| controller |  EXT_INT_0  |                 | ...
>>> +| (GICv2)    +-------------+                 +--------- GPIO_[N+8]/EXT_INT_N
>>> +|            |  ...        |                 |
>>> +|            |  EXT_INT_N  |                 +--------- GPIO_[N+9]
>>> +|            +-------------+                 | ...
>>> +|            |             |                 +--------- GPIO_MAX
>>> ++------------+             +-----------------+
>>>
>>>  Required properties:
>>>  - compatible: "apm,xgene-gpio-sb" for the X-Gene Standby GPIO controller
>>> @@ -15,10 +25,18 @@ Required properties:
>>>               0 = active high
>>>               1 = active low
>>>  - gpio-controller: Marks the device node as a GPIO controller.
>>> -- interrupts: Shall contain exactly 6 interrupts.
>>> +- interrupts: The EXT_INT_0 parent interrupt resource must be listed first.
>>> +- interrupt-parent: Phandle of the parent interrupt controller.
>>> +- interrupt-cells: Should be two.
>>> +       - first cell is 0-N coresponding for EXT_INT_0 to EXT_INT_N.
>>> +       - second cell is used to specify flags.
>>> +- interrupt-controller: Marks the device node as an interrupt controller.
>>> +- apm,nr-gpios: Optional, specify number of gpios pin.
>>> +- apm,nr-irqs: Optional, specify number of interrupt pins.
>>> +- apm,irq-start: Optional, specify lowest gpio pin support interrupt.
>>
>> This is quite ambiguous. Is that relative to the GIC? Assuming this is
>> the case, you should then document it, specify the type of interrupt
>> (SPI?), and whether this is 0- or 32-based (the code seems to indicate
>> that is is 0-based).
>>
> 
> Hi Marc, Let me explain by diagram below.
> As you can also see in diagram above, the lowest gpio pin that
> supports interrupt is GPIO_8 (EXT_INT_0),
> and hence, apm,irq-start=<8> as default.
> 
>                                            +-----------------+
>                                            | X-Gene standby  |
>                                            | GPIO controller +--------- GPIO_0
> +------------+                             |                 | ...
> | Parent IRQ |                             |
> +--------- GPIO_[apm,irq-start]/EXT_INT_0
> | controller |  EXT_INT_0                  |                 | ...
> | (GICv2)    +-----------------------------+
> +--------- GPIO_[apm,nr-irqs + apm,irq-start - 1]/EXT_INT_[apm,nr-irqs
> - 1]
> |            |  ...                        |                 |
> |            |  EXT_INT_[apm,nr-irqs - 1]  |
> +--------- GPIO_[apm,nr-irqs + apm,irq-start]
> |            +-----------------------------+                 | ...
> |            |                             |                 +--------- GPIO_MAX
> +------------+                             +-----------------+
> 
> To fix this ambiguity, I'm thinking to change it to:
> "apm,irq-start: Optional, specify index of first gpio pin
> corresponding to EXT_INT_0, default is 8."

I think you are missing the point I'm trying to make. There are two ways
to refer to an SPI: either by its absolute number (INT32 for example) or
by its relative number (SPI0). SPI0 and INT32 are the same interrupt.
Just with a different base.

My question is: which base are you using? By looking at the code, I
think you're using the absolute version (INTx). And as your controller
seems to be very GIC specific, you should add a pointer to the GIC
documentation.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
