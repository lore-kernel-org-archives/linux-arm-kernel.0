From: carlo.caione@gmail.com (Carlo Caione)
Date: Thu, 9 Jan 2014 15:00:29 +0100
Subject: [PATCH v2 3/3] ARM: sun7i: irqchip: Update the documentation
In-Reply-To: <52CD4C89.1040604@redhat.com>
References: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
 <1389030097-10822-4-git-send-email-carlo.caione@gmail.com>
 <201401081229.45029.arnd@arndb.de>
 <CAOQ7t2bg7qmwnQ-7iqbKCqK8fNS5GC=G0BN2188FQhPLN3v9VQ@mail.gmail.com>
 <52CD4C89.1040604@redhat.com>
Message-ID: <CAOQ7t2bXXTXfQoXTx5GOYksqWRwvQYmTRvRLSFYL3kKKCNSceA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 2:03 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 01/08/2014 12:49 PM, Carlo Caione wrote:
>>
>> On Wed, Jan 8, 2014 at 12:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> On Monday 06 January 2014, Carlo Caione wrote:
>>>>
>>>> +Allwinner Sunxi NMI Controller
>>>> +==============================
>>>> +
>>>> +Required properties:
>>>> +
>>>> +- compatible : should be "allwinner,sun7i-sc-nmi"
>>>> +- reg : Specifies base physical address and size of the registers.
>>>> +- interrupt-controller : Identifies the node as an interrupt controller
>>>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>>>> +  interrupt source. The value shall be 2.
>>>
>>>
>>> I think you should list what the two cells are so users know what to
>>> put in the irq specifier.
>>
>>
>> Agree, I'll fix in v3
>>
>>>> +sc-nmi-intc at 01c00030 {
>>>> +       compatible = "allwinner,sun7i-sc-nmi";
>>>> +       interrupt-controller;
>>>> +       #interrupt-cells = <2>;
>>>> +       reg = <0x01c00030 0x0c>;
>>>> +       interrupt-parent = <&gic>;
>>>> +       interrupts = <0 0 1>;
>>>> +};
>>>
>>>
>>> Is <0 0 1> the correct representation of the NMI? This question has
>>> recently
>>> come up on IRC and I didn't know the answer at the time.
>>
>>
>> Why shouldn't it be a correct representation? I think I missed the
>> discussion on IRC.
>
>
> I did not see the discussion on irc either, but this almost certainly
> should be <0 0 4>, as all interrupts on sun7i are level sensitive, not
> edge sensitive, making it <0 0 1> and thus edge sensitive can cause
> lost interrupts if an interrupt fires between the handler has reading
> the interrupt status register, and it writing it to clear the bits it
> has seen. In this case the interrupt line stays high, but the interrupt
> handler won't get re-run when configured for level interrupts.

Ouch, right! fix coming in v3.

Thanks,

--
Carlo Caione
