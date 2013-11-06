From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Wed, 6 Nov 2013 15:38:24 +0530
Subject: [PATCH v4 4/6] gpio: davinci: add OF support
In-Reply-To: <527923EF.4070602@ti.com>
References: <1383406775-14902-1-git-send-email-prabhakar.csenng@gmail.com>
 <1383406775-14902-5-git-send-email-prabhakar.csenng@gmail.com>
 <5277E752.8090005@ti.com>
 <CA+V-a8uV0g36LoQtxFjR56SaMxj7KOE2ztC+pfT_Pn1wGcqEmw@mail.gmail.com>
 <527923EF.4070602@ti.com>
Message-ID: <CA+V-a8tJ7yDJOPamoCiaX6Twnnqxp_o_L0rzo2dEeSDS2VoYLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grygorii,

On Tue, Nov 5, 2013 at 10:29 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 11/05/2013 10:53 AM, Prabhakar Lad wrote:> Hi Grygorii,
>
>>
>> Thanks for the review.
>>
>> On Mon, Nov 4, 2013 at 11:58 PM, Grygorii Strashko
>> <grygorii.strashko@ti.com> wrote:
>>> Hi Prabhakar Lad,
>>>
>>>
>>> On 11/02/2013 05:39 PM, Lad, Prabhakar wrote:
>>>>
>>>> From: KV Sujith <sujithkv@ti.com>
>>>>
>>>> This patch adds OF parser support for davinci gpio
>>>> driver and also appropriate documentation in gpio-davinci.txt
>>>> located at Documentation/devicetree/bindings/gpio/.
>>>
>>>
>>> I worry, do we need to have gpio_chip.of_xlate() callback implemented?
>>
>> I looked for the other OF GPIO implementations with same "ngpio"
>> property (marvel, msm) but I don?t see of_xlate() callback implemented.
>
> The question: will below definitions in DT work or not after this series?
>  Will of_get_gpio()/of_get_named_gpio() work?
>
> Example1 - leds:
>         leds {
>                 compatible = "gpio-leds";
>                 debug0 {
>                         label = "green:debug0";
>                         gpios = <&gpio 29 GPIO_ACTIVE_HIGH>;
>                 };
>         };
>
> Example2 - any dev:
> devA {
>         compatible = "devA";
>         gpios = <&gpio 120 GPIO_ACTIVE_LOW>;
>
> }
>
>
Agreed of_get_gpio()/of_get_named_gpio() wont work without
xlate callback implemented, but I think this can be added as a
incremental patch later.

>>
>>> - From one side, Davinci GPIO controller in DT described by one entry
>>> which defines number of supported GPIOs as "ti,ngpio = <144>;"
>>>
>>> - From other side, on Linux level more than one gpio_chip objects are
>>> instantiated (one per each 32 GPIO).
>>>
>>> How the standard GPIO biding will work in this case? .. And will they?
>>>
>>> Linus, I'd very appreciate if you will be able to clarify this point.
>>>
>>>
>>>>
>>>> Signed-off-by: KV Sujith <sujithkv@ti.com>
>>>> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
>>>> [prabhakar.csengg at gmail.com: simplified the OF code, removed
>>>>                  unnecessary DT property and also simplified
>>>>                  the commit message]
>>>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>>> ---
>>>>    .../devicetree/bindings/gpio/gpio-davinci.txt      |   32
>>>> ++++++++++++
>>>>    drivers/gpio/gpio-davinci.c                        |   54
>>>> ++++++++++++++++++--
>>>>    2 files changed, 83 insertions(+), 3 deletions(-)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>>>> b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>>>> new file mode 100644
>>>> index 0000000..55aae1c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>>>> @@ -0,0 +1,32 @@
>>>> +Davinci GPIO controller bindings29
>
>>>> +
>>>> +Required Properties:
>>>> +- compatible: should be "ti,dm6441-gpio"
>>>> +
>>>> +- reg: Physical base address of the controller and the size of memory
>>>> mapped
>>>> +       registers.
>>>> +
>>>> +- gpio-controller : Marks the device node as a gpio controller.
>>>> +
>>>> +- interrupts: Array of GPIO interrupt number.
>>>
>>>
>>> May be meaning of <interrupts> property need to be extended, because,
>>> as of now, only banked or unbanked IRQs are supported - and not both.
>>>
>>>
>> OK
>>
>>>> +
>>>> +- ti,ngpio: The number of GPIO pins supported.
>>>> +
>>>> +- ti,davinci-gpio-unbanked: The number of GPIOs that have an individual
>>>> interrupt
>>>> +                            line to processor.
>>>
>>>
>>> Should interrupt-controller; specifier be added here?
>>>
>> No
>
> So, it would be impossible to map GPIO IRQ to device through DT. Right?
> Like:
>         devX at 0 {
>                 compatible = "devX";
>                 interrupt-parent = <&gpio>;
>                 interrupts = <50 IRQ_TYPE_EDGE_FALLING>; /* gpio line 50 */
>
>
>         };
>
>
may be I took you wrong here, the interrupt-controller is inherited
property taken from its parent, so didn?t mention that in the documentation

Regards,
--Prabhakar Lad
