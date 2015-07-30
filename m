From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 31 Jul 2015 01:30:27 +0200
Subject: [PATCH 2/2] DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation
In-Reply-To: <CAAEAJfA22JA0AWB1FCiDVYEy5BqasDror_Ejpd=b3s14BWpORw@mail.gmail.com>
References: <1437972345-16444-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1437972345-16444-3-git-send-email-ariel@vanguardiasur.com.ar>
 <CAGhQ9Vyy+oUAWm0q2+NV0D9RVf5qyED8Tn54-cGzbDc-EZR4yw@mail.gmail.com>
 <CAAEAJfApE8=cAue-bc5xPD_XAtV8qzur12C4okF-uLJ-__reBA@mail.gmail.com>
 <CAGhQ9VwudkK=bo5Qk79O7fmdEEm1KEWxUhLO14ucCJ+FbhqQqw@mail.gmail.com>
 <CAAEAJfA22JA0AWB1FCiDVYEy5BqasDror_Ejpd=b3s14BWpORw@mail.gmail.com>
Message-ID: <CAGhQ9VyCNrH_J6rP+L+6OkV-PCgemOzhznuFRg07YxPpLX_nig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2015 at 15:47, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> +devicetree guys
>
> On 28 July 2015 at 20:22, Joachim  Eastwood <manabian@gmail.com> wrote:
>> On 29 July 2015 at 00:45, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
>>> On 28 July 2015 at 19:37, Joachim  Eastwood <manabian@gmail.com> wrote:
>>>> On 27 July 2015 at 06:45, Ariel D'Alessandro <ariel@vanguardiasur.com.ar> wrote:
>>>>> Add the devicetree binding document for NXP LPC18xx PWM/SCT.
>>>>>
>>>>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
>>>>> ---
>>>>>  .../devicetree/bindings/pwm/lpc1850-pwm.txt          | 20 ++++++++++++++++++++
>>>>>  1 file changed, 20 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>>>>> new file mode 100644
>>>>> index 0000000..3055429
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>>>>> @@ -0,0 +1,20 @@
>>>>> +* NXP LPC18xx Pulse Width Modulator driver
>>>>> +
>>>>> +Required properties:
>>>>> +  - compatible: Should be "nxp,lpc1850-pwm"
>>>>> +  - reg: Should contain physical base address and length of pwm registers.
>>>>> +  - clocks: Must contain an entry for each entry in clock-names.
>>>>> +    See ../clock/clock-bindings.txt for details.
>>>>> +  - clock-names: Must include the following entries.
>>>>> +    - pwm: PWM operating clock.
>>>>> +  - #pwm-cells: Should be 3. See pwm.txt in this directory for the description
>>>>> +    of the cells format.
>>>>> +
>>>>> +Example:
>>>>> +  pwm: pwm at 40000000 {
>>>>> +    compatible = "nxp,lpc1850-pwm";
>>>>
>>>> I would prefer "nxp,lpc1850-sct" for a couple of reasons. SCT is the
>>>> name of hardware block as described in the user manual and while PWM
>>>> is the most obvious usage for this block on Linux, the hardware is not
>>>> limited to just doing that. So as a bit of future proofing if someone
>>>> wants to use this block for more than PWM I would prefer SCT.
>>>>
>>>
>>> Shouldn't we use something like "nxp,lpc1850-sct-pwm"?
>>>
>>> Sounds like the word PWM should be in the compatible as it describes
>>> not only the device, but the device used in a certain way.
>>>
>>> Otherwise, how would we use "nxp,lpc1850-sct" to distinguish a PWM from
>>> e.g. a clocksource/clockevents (we can also use SCT for that)?
>>
>> I not sure how to best handle dt bindings with such flexible hardware blocks.
>>
>> But are you suggestion to have multiple drivers for the same hw block?
>> ie.: "nxp,lpc1850-sct-pwm" for PWM and for example
>> "nxp,lpc1850-sct-clocksource" for clocksource and then use/enable one
>> or the other.
>>
>
> Yup, I'm suggesting just that. If the hardware is capable, I can't see
> why we can't have different drivers for it.

Well, I think it would be nice if we could have one driver per hw
block. But then you need a way to select whether you want to use the
counter in the SCT block for PWM or, for example, clocksource. Sort of
mode selection I guess.

But then again if someone has some very custom and application
specific usage for the SCT block that maybe better served by a
standalone driver anyway.

So for now I am fine with "nxp,lpc1850-sct-pwm". I shouldn't be too
hard to change the bindings if we see other users of this block, I
believe.


regards,
Joachim Eastwood

>> So I am not sure how to best handle this, but I think we should at
>> least consider more than just PWM usage for this hw block. Note that
>> not against calling it "lpc1850-sct-pwm", I like that better than just
>> "lpc1850-pwm".
>>
>
>
> --
> Ezequiel Garc?a, VanguardiaSur
> www.vanguardiasur.com.ar
