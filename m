From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sat, 08 Nov 2014 14:58:27 +0100
Subject: [PATCH v2] ARM: BCM5301X: set customized AUXCTL
In-Reply-To: <2789449.fsn4D0imX4@wuerfel>
References: <1414851912-30630-1-git-send-email-hauke@hauke-m.de>
 <54580CD9.3050309@hauke-m.de> <54581230.9090205@gmail.com>
 <2789449.fsn4D0imX4@wuerfel>
Message-ID: <545E2183.7010308@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2014 11:22 AM, Arnd Bergmann wrote:
> On Monday 03 November 2014 15:39:28 Florian Fainelli wrote:
>> On 11/03/2014 03:16 PM, Hauke Mehrtens wrote:
>>> On 11/03/2014 11:00 AM, Arnd Bergmann wrote:
>>>> On Saturday 01 November 2014 15:41:38 Hauke Mehrtens wrote:
>>>>>  };
>>>>>  
>>>>>  DT_MACHINE_START(BCM5301X, "BCM5301X")
>>>>> -       .l2c_aux_val    = 0,
>>>>> +       .l2c_aux_val    = L310_AUX_CTRL_CACHE_REPLACE_RR |
>>>>> +                         L310_AUX_CTRL_DATA_PREFETCH |
>>>>> +                         L310_AUX_CTRL_INSTR_PREFETCH |
>>>>> +                         L310_AUX_CTRL_EARLY_BRESP,
>>>>
>>>> Please put these into the dts file instead if the boot loader fails
>>>> to set them correctly. We should not override them from source code
>>>> for new platforms any more.
>>> I checked again and I only need L310_AUX_CTRL_DATA_PREFETCH and
>>> L310_AUX_CTRL_INSTR_PREFETCH, the others get activate by the existing
>>> code. Should I make it possible to give l2c_aux_val through dt, or
>>> should I create some boolean options for  L310_AUX_CTRL_DATA_PREFETCH
>>> and  L310_AUX_CTRL_INSTR_PREFETCH?
> 
> Certainly not the entire l2c_aux_val, what I meant is to use
> boolean options for the bits you need. I was under the impression
> that by now we had defined bindings for all the bits that are required
> on any platform.

Currently there are no bindings for L310_AUX_CTRL_DATA_PREFETCH and
L310_AUX_CTRL_INSTR_PREFETCH, but I can add them.

>> Last we talked about these prefetch bits with Russell, I think we kind
>> of agreed that they could probably be enabled by default

If they were changed to be enabled by default I do not have to add any
device tree stuff at all that would be the best solution for me. ;-)

>> There is already a large number of properties defined in
>> Documentation/devicetree/bindings/arm/l2cc.txt, I suppose that having
>> prefetch properties could work too.
> 
> I can't really help with this if we don't have a binding. Proving that
> it's always correct to enable these seems better than defining a
> binding.

When should they get activated automatically, every time we find a l2x0
compatible cache?

Hauke
