From: dianders@chromium.org (Doug Anderson)
Date: Wed, 9 Jul 2014 08:22:05 -0700
Subject: [PATCH] ARM: dts: Add mask-tpm-reset to the device tree
In-Reply-To: <53BC1A63.80900@samsung.com>
References: <1403774127-21892-1-git-send-email-vikas.sajjan@samsung.com>
 <CACRpkdZrDJ3xoUYGynf0sO4-U7ZVkJ=Mr_pNVSdar8oM85aVgA@mail.gmail.com>
 <CAD=FV=WQWBkq5JKttikLkyKEDX-YydQJLr9=bFWifpy2Lf0mSg@mail.gmail.com>
 <53BC1A63.80900@samsung.com>
Message-ID: <CAD=FV=XjWu6RQ+9789fzg08Whq-d=XWoeT+dZ7YQLLJvCBUfwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas,

On Tue, Jul 8, 2014 at 9:20 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> On 08.07.2014 17:27, Doug Anderson wrote:
>> Hi,
>>
>> On Tue, Jul 8, 2014 at 12:46 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Thu, Jun 26, 2014 at 11:15 AM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>>>
>>>> From: Doug Anderson <dianders@chromium.org>
>>>>
>>>> The mask-tpm-reset GPIO is used by the kernel to prevent the TPM from
>>>> being reset across sleep/wake.  If we don't set it to anything then
>>>> the TPM will be reset.  U-Boot will detect this as invalid
>>>> and will reset the system on resume time. This GPIO can always be low
>>>> and not hurt anything.  It will get pulled back high again during a
>>>> normal warm reset when it will default back to an input.
>>>>
>>>> To properly preserve the TPM state across suspend/resume and to make
>>>> the chrome U-Boot happy, properly set the GPIO to mask the
>>>> reset to the TPM.
>>>>
>>>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>>>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>>> (...)
>>>> +       /* We need GPX0_6 to be low at sleep time; just keep it low always */
>>>> +       mask_tpm_reset_regulator: mask-tpm-reset-regulator {
>>>> +       compatible = "regulator-fixed";
>>>
>>> No matter how the discussion ends up, regulator-fixed is wrong.
>>
>> OK, fair enough.
>>
>>
>>> Either folding it into the TPM driver or using a separate reset driver
>>> is fine with me.
>>
>> OK, Vikas: do you want to code up the driver?
>>
>>
>>> So what about the generic delayed reset GPIO thing?
>>> http://marc.info/?l=linux-kernel&m=140309916607115&w=2
>>
>> That's a neat concept and could be useful in other cases, but I think
>> it's just as much of a hack as using a regulator.  This is not a reset
>> signal for the TPM.  This is a signal that will mask the CPU's reset
>> signal (using a special bit of board-specific logic).
>>
>>
>> Personally I think Tomasz's idea of using hogs (after his patches
>> allowing a default output level) is the cleanest, but I think Stephen
>> didn't like that.
>
> I don't see any benefits of using complex interfaces over simply
> initializing the pin to the right value once at boot-up or at
> suspend/resume. As far as I understand Doug's explanation of the
> problem, nothing else is expected from the OS with respect to this pin.
> Moreover it doesn't affect operation of any drivers.
>
> So I'm still for the simplest and effective solution, i.e. hogs.

It looks as if Tomasz's patch has landed, so perhaps you could try to
code it up his way.  It should be very simple.  Please make sure to CC
Stephen Warren on the patch so that he is included in the discussion
(and of course include Tomasz, Linus W, etc).

-Doug
