From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 4 Apr 2016 16:32:33 +0200
Subject: [PATCH v2 1/9] Documentation: dt-bindings: Document STM32 EXTI
 controller bindings
In-Reply-To: <20160404051529.GA17806@rob-hp-laptop>
References: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1459436979-17275-2-git-send-email-mcoquelin.stm32@gmail.com>
 <20160404051529.GA17806@rob-hp-laptop>
Message-ID: <CALszF6CEs_5BATN5Vz-=z=ukL5cSKnCLVz+3mU0G9ohfq1RwpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

2016-04-04 7:15 GMT+02:00 Rob Herring <robh@kernel.org>:
> On Thu, Mar 31, 2016 at 05:09:31PM +0200, Maxime Coquelin wrote:
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  .../bindings/interrupt-controller/st,stm32-exti.txt  | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
>> new file mode 100644
>> index 000000000000..6e7703d4ff5b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
>> @@ -0,0 +1,20 @@
>> +STM32 External Interrupt Controller
>> +
>> +Required properties:
>> +
>> +- compatible: Should be "st,stm32-exti"
>> +- reg: Specifies base physical address and size of the registers
>> +- interrupt-controller: Indentifies the node as an interrupt controller
>> +- #interrupt-cells: Specifies the number of cells to encode an interrupt
>> +  specifier, shall be 2
>> +- interrupts: interrupts references to primary interrupt controller
>
> Need to define how many and what is the order?
The exti driver uses of_irq_count() to count the number of interrupts.
The order doesn't matter in my implementation, I will come back on
this point below.

>
> Are these 1:1 mapping? You could use interrupt-map here to define the
> mapping.

No, this is not 1:1 mapping.
This is the mapping for STM32F429 (With 'n' managed by a mux in Syscfg
(from GPIOA to GPIOI)):
EXTI0 (GPIOn0) : NVIC 6
EXTI1 (GPIOn1) : NVIC 7
EXTI2 (GPIOn2) : NVIC 8
EXTI3 (GPIOn3) : NVIC 9
EXTI4 (GPIOn4) : NVIC 10
EXTI5 (GPIOn5) : NVIC 23
EXTI6 (GPIOn6) : NVIC 23
EXTI7 (GPIOn7) : NVIC 23
EXTI8 (GPIOn8) : NVIC 23
EXTI9 (GPIOn9) : NVIC 23
EXTI10 (GPIOn10) : NVIC 40
EXTI11 (GPIOn11) : NVIC 40
EXTI12 (GPIOn12) : NVIC 40
EXTI13 (GPIOn13) : NVIC 40
EXTI14 (GPIOn14) : NVIC 40
EXTI15 (GPIOn15) : NVIC 40
EXTI16 (PVD) : NVIC 1
EXTI17 (RTC Alarm) : NVIC 41
EXTI18 (USB OTG FS Wakeup) : NVIC 42
EXTI19 (Ethernet Wakeup) : NVIC 62
EXTI20 (USB OTG HS Wakeup) : NVIC 76
EXTI21 (RTC Tamper) : NVIC 2
EXTI22 (RTC Wakeup) : NVIC 3

Ideally, we should define a kind of mapping in the DT node.
However, from what I understand 'interrupt-map' is not intended to be used
in an interrupt controller (it would not even be parsed in of_irq_parse_raw()).

Any ideas?

Thanks for the review,
Maxime
