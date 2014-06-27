From: dianders@chromium.org (Doug Anderson)
Date: Fri, 27 Jun 2014 08:10:28 -0700
Subject: [PATCH] ARM: dts: Add mask-tpm-reset to the device tree
In-Reply-To: <53AD60D7.4040404@gmail.com>
References: <1403774127-21892-1-git-send-email-vikas.sajjan@samsung.com>
 <53ABED5B.8010506@samsung.com>
 <CAD=FV=Vwgdis6FzJ8MHDwfuohB1kN8Mf--2N=rxGNeAfKjJMig@mail.gmail.com>
 <53AD60D7.4040404@gmail.com>
Message-ID: <CAD=FV=Wz5nB=fe-snzdNC-Tb50wXz9h3S5z4jAHzKxH3N66UVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz and Vikas,

On Fri, Jun 27, 2014 at 5:17 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Doug,
>
> On 26.06.2014 17:25, Doug Anderson wrote:
>> Tomasz,
>>
>> On Thu, Jun 26, 2014 at 2:52 AM, Tomasz Figa <t.figa@samsung.com> wrote:
>>> Hi Vikas, Doug,
>>>
>>> On 26.06.2014 11:15, Vikas Sajjan wrote:
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
>>>> ---
>>>>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   20 ++++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>>>> index 7649982..8fd990a 100644
>>>> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
>>>> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>>>> @@ -87,6 +87,18 @@
>>>>               pinctrl-0 = <&usb301_vbus_en>;
>>>>               enable-active-high;
>>>>       };
>>>> +
>>>> +     /* We need GPX0_6 to be low at sleep time; just keep it low always */
>>>> +     mask_tpm_reset_regulator: mask-tpm-reset-regulator {
>>>> +     compatible = "regulator-fixed";
>>>> +     regulator-name = "mask-tpm-reset ";
>>>> +             gpio = <&gpx0 6 0>;
>>>> +             enable-active-low;
>>>> +             regulator-boot-on;
>>>> +             regulator-always-on;
>>>> +             pinctrl-names = "default";
>>>> +             pinctrl-0 = <&mask_tpm_reset>;
>>>> +     };
>>>
>>> I don't think this pin is supposed to be a real regulator. If I'm right,
>>> you should just add a hog for it, if you don't have a proper driver to
>>> handle it.
>>
>> Yes, I agree that it shouldn't really be a regulator, but there's not
>> a whole lot of choice.  The pin needs to actually be driven low, not
>> just pulled low.  Without your proposed patch (pinctrl: samsung: Allow
>> pin value to be initialized using pinfunc) I don't think it's possible
>> to actually drive a pin low with a hog.  I could be wrong, though.
>>
>
> Uhm, I was convinced that this patch was already in. So I think your use
> case is definitely a good reason to get back to this patch and use the
> facility it provides to solve your problem.

Thanks, that seems very reasonable to me, too.

Are you going to pick up revitalizing this patch series or are you
hoping Vikas will?  IIRC I was in favor of your patch but it generated
a whole bunch of discussion and never actually landed.

-Doug
