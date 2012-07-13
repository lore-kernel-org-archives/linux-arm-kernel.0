From: robherring2@gmail.com (Rob Herring)
Date: Thu, 12 Jul 2012 22:19:56 -0500
Subject: [RESEND PATCH 1/1] clk: add DT support for clock gating control
In-Reply-To: <4FFECC4E.4070001@googlemail.com>
References: <4FFE7979.4060000@googlemail.com> <4FFEBF8A.1020700@gmail.com>
 <4FFECC4E.4070001@googlemail.com>
Message-ID: <4FFF93DC.30103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2012 08:08 AM, Sebastian Hesselbarh wrote:
> On 07/12/2012 02:14 PM, Rob Herring wrote:
>>> +Required child properties:
>>> +- reg : should contain the individual bit and polarity to control
>>> +        the clock gate. A polarity of 0 means that by setting the
>>> +        bit to 1 the clock passes through the clock gate while
>>> +    setting the bit to 0 disables the clock. Any other value
>>> +         for polarity inverts the meaning of the control bit.
>>
>> This is a bit of overloading reg to specify the polarity.
> 
> Well, yes it is overloading but still matches reg somehow, as the
> extra information is required to access the resource. But I agree,
> expecially wrt more-than-one-bit clk-gate (see below).
> 

You can define your own property names.

>>> +        /* SATA clock gate with different parent clock */
>>> +        cg_sata: clockgate at 3 {
>>> +            reg =<3 0>; /* register bit 3, normal polarity */
>>> +            clocks =<&sata_clk>;
>>> +        };
>>
>> I'm not sure I like the node per bit. What about a bit mask for valid
>> bits and polarities. Then add a clock cell to specify the bit or index.
>>
>> i.MX has 2-bit enable fields for its leaf clocks, so how and if you
>> would support that is something to think about.
> 
> Yeah, I thought of "what if the clk_gate needs to be enabled with more
> than 1 bit" already. But this is a short-comming of the current clk-gate
> implementation.

What's implemented in Linux should not define the binding. The binding
should describe the hardware.

> Just to get it right, i.MX requires to set more than one bit to change
> the state of the gate for one leaf clock?

It's basically ON, OFF, and "ON in run/OFF in wfi".

Perhaps the iMX case is unique enough we don't try to make it use a
common binding.

> If this is true, that would require a change of the generic clk-gate
> anyway.

True, but not your problem to implement. A binding doesn't necessarily
mean there is a full Linux implementation. We just don't want to create
something only to find others need something completely different.

Rob

> I had a look at pinctrl-bindings.txt maybe this is the way to go for
> clock gating control, too. That would require clk-gate to handle an
> 'active' and 'gated' state and leave it to a clock gate control to
> actually set the required bits in any registers. This would allow
> other special implementations of clock gating controllers to reuse
> clk-gate DT description. Additionally, there could be a
> simple-clock-gating-control that can set states by reg address and
> for each controlled gate a mask, enable value, and disable value.
> 
> Sebastian
