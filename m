From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 19 Nov 2014 14:49:42 +0100
Subject: Bug in clk_mux_set_parent for CLK_MUX_INDEX_BIT muxes ?
In-Reply-To: <546B3BEA.90002@ti.com>
References: <546899E6.6040306@redhat.com> <20141117185709.25314.61477@quantum>
 <546B3BEA.90002@ti.com>
Message-ID: <546C9FF6.3070506@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/18/2014 01:30 PM, Tero Kristo wrote:
> On 11/17/2014 08:57 PM, Mike Turquette wrote:
>> Quoting Hans de Goede (2014-11-16 04:34:46)
>>> Hi,
>>>
>>> While looking at what I believe is a bug in the sunxi gmac clk code
>>> (more on that later), I believe I've also found a bug in
>>>
>>> clk_mux_set_parent for the CLK_MUX_INDEX_BIT case.
>>>
>>> AFAIK if CLK_MUX_INDEX_BIT is set, then each bit turns
>>> on / off a single parent, so theoretically multiple
>>> parents could be enabled at the same time, but in practice
>>> only one bit should ever be 1. So to select parent 0, set
>>> the register (*) to 0x01, to select parent 1 set it 0x02,
>>> parent 2, 0x04, parent 3, 0x08, etc.
>>>
>>> Correct ?
>>>
>>> Assuming I got that right, then this bit of code in
>>> clk_mux_set_parent is wrong:
>>>
>>>                  if (mux->flags & CLK_MUX_INDEX_BIT)
>>>                          index = (1 << ffs(index));
>>>
>>> For an input index of 0, ffs returns 0, so we set the register
>>> to 0x01, ok.
>>>
>>> For an input index of 1, ffs returns 1, so we set the register
>>> to 0x02, ok.
>>>
>>> For an input index of 2, ffs returns 2, so we set the register
>>> to 0x04, ok.
>>>
>>> For an input index of 3, ffs returns 1, so we set the register
>>> to 0x02, not good!
>>>
>>> I believe this code should simply be:
>>>
>>>                  if (mux->flags & CLK_MUX_INDEX_BIT)
>>>                          index = 1 << index;
>>>
>>> I guess we've been getting away by this because the input index
>>> so far has never gotten above 2.
>>
>> Good catch. I've Cc'd Tero Kristo from TI as the TI SoCs are the only
>> other user of CLK_MUX_INDEX_BIT.
>>
>>>
>>> If I'm right about this, I can whip up a patch to fix this. Note
>>> I don't really have hardware to properly exercise this code-path
>>> AFAIK.
>>
>> Please do. I think your change is reasonable and Tero can scream if
>> something breaks for him.
> 
> TI SoC:s use a copy pasted version of the mux clock (with some additional tweaks), but we never set the CLK_MUX_INDEX_BIT flag, so we have been safe from this bug. Feel free to send a patch against the TI clock driver also if you want, I can ack that one. If not, I can craft a quick patch for this myself.

I've just send a fix for the generic version of this code, I'm sorry
but I do not have the time to also fix the TI code.

Regards,

Hans
