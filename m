From: robh@kernel.org (Rob Herring)
Date: Tue, 7 Nov 2017 18:38:56 -0600
Subject: [PATCH 2/4] pinctrl: Add skew-delay pin config and bindings
In-Reply-To: <CACRpkdZcB9ghYYFSQdTqpuN29DZZeY_AKimQ62-5W7+Mymm1HQ@mail.gmail.com>
References: <20171028133719.27528-1-linus.walleij@linaro.org>
 <20171028133719.27528-2-linus.walleij@linaro.org>
 <20171101212659.be4phj2wha66x63d@rob-hp-laptop>
 <CACRpkdZcB9ghYYFSQdTqpuN29DZZeY_AKimQ62-5W7+Mymm1HQ@mail.gmail.com>
Message-ID: <CAL_Jsq+DStFnj_oDtuVza1Owv1xpMJtxgf=FzTSJS67CqhP2AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 2, 2017 at 9:32 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Nov 1, 2017 at 10:26 PM, Rob Herring <robh@kernel.org> wrote:
>> On Sat, Oct 28, 2017 at 03:37:17PM +0200, Linus Walleij wrote:
>>> Some pin controllers (such as the Gemini) can control the
>>> expected clock skew and output delay on certain pins with a
>>> sub-nanosecond granularity. This is typically done by shunting
>>> in a number of double inverters in front of or behind the pin.
>>> Make it possible to configure this with a generic binding.
>>>
>>> Cc: devicetree at vger.kernel.org
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>>  Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt | 4 ++++
>>>  drivers/pinctrl/pinconf-generic.c                              | 2 ++
>>>  include/linux/pinctrl/pinconf-generic.h                        | 5 +++++
>>>  3 files changed, 11 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
>>> index 4483cc31e531..ad9bbbba36e9 100644
>>> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
>>> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
>>> @@ -271,6 +271,10 @@ output-high              - set the pin to output mode with high level
>>>  sleep-hardware-state - indicate this is sleep related state which will be programmed
>>>                         into the registers for the sleep state.
>>>  slew-rate            - set the slew rate
>>> +skew-delay           - this affects the expected clock skew on input pins
>>> +                       and the delay before latching a value to an output
>>> +                       pin. Typically indicates how many double-inverters are
>>> +                       used to delay the signal.
>>
>> Units?
>
> Number of double-inverters I guess, just as it says.
>
> skew-delay = <1>; // number of inverter pairs
>
> Like with other bindings of this type they are custom.
>
> The Gemini datasheet says "every unit represents about 0.2 ns".
>
> So if you set it to 1, that means (as far as I can guess) this
> is shunted in:
>
>    |\    |\
> --+ >o--+ >o---
>    |/    |/
>
> The signal will take ~0.2 ns to propagate through this.
> For 2, there will be four inverters etc.
>
> It is dependent of production technology, and I do not know
> if everyone is using something like double-inverters.
>
> We could try to define a value in picoseconds instead so I
> would need to set this to 200 in that case if you think that is better:
>
> skew-delay = <200>; // picoseconds
>
> I think it would be kludgy since with increasing clock speeds
> maybe picoseconds would be too big even. Nanoseconds is
> apparently already a to coarse unit.

Okay, it is fine.

Acked-by: Rob Herring <robh@kernel.org>
