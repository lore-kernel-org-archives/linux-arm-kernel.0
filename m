From: ludovic.barre@st.com (Ludovic BARRE)
Date: Mon, 14 May 2018 14:40:57 +0200
Subject: [PATCH 07/11] irqchip: stm32: add stm32mp1 support with hierarchy
 domain
In-Reply-To: <CAL_JsqLh4+vs-hQceg3bZ-ALWKE182vKbL90xxLwdgb09OtZ7Q@mail.gmail.com>
References: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
 <1524759514-12392-8-git-send-email-ludovic.Barre@st.com>
 <20180501145611.GA6842@rob-hp-laptop>
 <6fdb652b-e7f9-7035-3eda-39f763ed7ea3@st.com>
 <CAL_JsqLvbGdPC9ifPZ5+tVxznHbsDuWGRg4R47st8Y9BtnNYUQ@mail.gmail.com>
 <26de0a75-e4e1-7c43-e31d-599d3c7de0ff@st.com>
 <CAL_JsqLh4+vs-hQceg3bZ-ALWKE182vKbL90xxLwdgb09OtZ7Q@mail.gmail.com>
Message-ID: <56bc18fc-b941-0121-0805-399cb6979792@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/04/2018 10:38 PM, Rob Herring wrote:
> On Thu, May 3, 2018 at 4:55 AM, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>>
>> On 05/02/2018 07:45 PM, Rob Herring wrote:
>>>
>>> On Wed, May 2, 2018 at 11:03 AM, Ludovic BARRE <ludovic.barre@st.com>
>>> wrote:
>>>>
>>>> Hi Rob
>>>>
>>>>
>>>>
>>>> On 05/01/2018 04:56 PM, Rob Herring wrote:
>>>>>
>>>>>
>>>>> On Thu, Apr 26, 2018 at 06:18:30PM +0200, Ludovic Barre wrote:
>>>>>>
>>>>>>
>>>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>>>
>>>>>> Exti controller has been differently integrated on stm32mp1 SoC.
>>>>>> A parent irq has only one external interrupt. A hierachy domain could
>>>>>> be used. Handlers are call by parent, each parent interrupt could be
>>>>>> masked and unmasked according to the needs.
>>>>>>
>>>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>>>>> ---
>>>>>>     .../interrupt-controller/st,stm32-exti.txt         |   3 +
>>>>>>     drivers/irqchip/irq-stm32-exti.c                   | 322
>>>>>> +++++++++++++++++++++
>>>>>>     2 files changed, 325 insertions(+)
>>>>>>
>>>>>> diff --git
>>>>>>
>>>>>> a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
>>>>>>
>>>>>> b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
>>>>>> index edf03f0..136bd61 100644
>>>>>> ---
>>>>>>
>>>>>> a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
>>>>>> +++
>>>>>>
>>>>>> b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
>>>>>> @@ -5,11 +5,14 @@ Required properties:
>>>>>>     - compatible: Should be:
>>>>>>         "st,stm32-exti"
>>>>>>         "st,stm32h7-exti"
>>>>>> +    "st,stm32mp1-exti"
>>>>>>     - reg: Specifies base physical address and size of the registers
>>>>>>     - interrupt-controller: Indentifies the node as an interrupt
>>>>>> controller
>>>>>>     - #interrupt-cells: Specifies the number of cells to encode an
>>>>>> interrupt
>>>>>>       specifier, shall be 2
>>>>>>     - interrupts: interrupts references to primary interrupt controller
>>>>>> +  (only needed for exti controller with multiple exti under
>>>>>> +  same parent interrupt: st,stm32-exti and st,stm32h7-exti")
>>>>>>       Example:
>>>>>>     diff --git a/drivers/irqchip/irq-stm32-exti.c
>>>>>> b/drivers/irqchip/irq-stm32-exti.c
>>>>>> index b38c655..ebf7146 100644
>>>>>> --- a/drivers/irqchip/irq-stm32-exti.c
>>>>>> +++ b/drivers/irqchip/irq-stm32-exti.c
>>>>>
>>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>> +static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
>>>>>> +       { .exti = 1, .irq_parent = 7 },
>>>>>> +       { .exti = 2, .irq_parent = 8 },
>>>>>> +       { .exti = 3, .irq_parent = 9 },
>>>>>> +       { .exti = 4, .irq_parent = 10 },
>>>>>> +       { .exti = 5, .irq_parent = 23 },
>>>>>> +       { .exti = 6, .irq_parent = 64 },
>>>>>> +       { .exti = 7, .irq_parent = 65 },
>>>>>> +       { .exti = 8, .irq_parent = 66 },
>>>>>> +       { .exti = 9, .irq_parent = 67 },
>>>>>> +       { .exti = 10, .irq_parent = 40 },
>>>>>> +       { .exti = 11, .irq_parent = 42 },
>>>>>> +       { .exti = 12, .irq_parent = 76 },
>>>>>> +       { .exti = 13, .irq_parent = 77 },
>>>>>> +       { .exti = 14, .irq_parent = 121 },
>>>>>> +       { .exti = 15, .irq_parent = 127 },
>>>>>> +       { .exti = 16, .irq_parent = 1 },
>>>>>> +       { .exti = 65, .irq_parent = 144 },
>>>>>> +       { .exti = 68, .irq_parent = 143 },
>>>>>> +       { .exti = 73, .irq_parent = 129 },
>>>>>> +};
>>>>>
>>>>>
>>>>>
>>>>> You can use an interrupt-map property rather than put this into the
>>>>> driver.
>>>>
>>>>
>>>>
>>>> interrupt-map seemed interesting and promising like used in pci host.
>>>> At first sight this property can't be used into node with
>>>> "interrupt-controller" property (see in drivers/of/irq.c function:
>>>> of_irq_parse_raw) because "of_irq_parse_raw" checks if node got
>>>> it first, and after lookup the interrupt-map.
>>>>
>>>> Rob, Thomas, Jason, Marc what do you prefers or the right ways...?
>>>
>>>
>>> I believe the correct thing to do is simply drop "interrupt-controller".
>>
> 
> Actually, that's not right.
> 
>> if I drop "interrupt-controller" of my node, my driver will not be
>> initialized by "of_irq_init"
>> (start_kernel->init_IRQ->irqchip_init->of_irq_init).
>> Probably, we could replace "IRQCHIP_DECLARE" by a
>> "module_platform_driver" or "postcore_initcall" but I'm not a big fan of
>> this solution. what do you think ?
> 
> You'd have to parse 'interrupt-map' yourself to extract the data for
> this to work because interrupt-map currently only works when the
> translation is transparent (i.e. doesn't need s/w handling). So I
> guess leave this in the driver. Sorry for the noise.
> 

Sorry, I don't know if I've correctly understand the answer.
I hesitate between:
- keep the code like this, with stm32mp1_desc_irq tab.
- parse interrupt-map property into stm32 exti driver.

Just to be sure, and avoid misunderstand.

BR
Ludo

> Rob
> 
