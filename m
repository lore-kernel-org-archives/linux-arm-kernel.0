From: dianders@chromium.org (Doug Anderson)
Date: Thu, 26 Jun 2014 08:25:10 -0700
Subject: [PATCH] ARM: dts: Add mask-tpm-reset to the device tree
In-Reply-To: <53ABED5B.8010506@samsung.com>
References: <1403774127-21892-1-git-send-email-vikas.sajjan@samsung.com>
 <53ABED5B.8010506@samsung.com>
Message-ID: <CAD=FV=Vwgdis6FzJ8MHDwfuohB1kN8Mf--2N=rxGNeAfKjJMig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Thu, Jun 26, 2014 at 2:52 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Vikas, Doug,
>
> On 26.06.2014 11:15, Vikas Sajjan wrote:
>> From: Doug Anderson <dianders@chromium.org>
>>
>> The mask-tpm-reset GPIO is used by the kernel to prevent the TPM from
>> being reset across sleep/wake.  If we don't set it to anything then
>> the TPM will be reset.  U-Boot will detect this as invalid
>> and will reset the system on resume time. This GPIO can always be low
>> and not hurt anything.  It will get pulled back high again during a
>> normal warm reset when it will default back to an input.
>>
>> To properly preserve the TPM state across suspend/resume and to make
>> the chrome U-Boot happy, properly set the GPIO to mask the
>> reset to the TPM.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> index 7649982..8fd990a 100644
>> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> @@ -87,6 +87,18 @@
>>               pinctrl-0 = <&usb301_vbus_en>;
>>               enable-active-high;
>>       };
>> +
>> +     /* We need GPX0_6 to be low at sleep time; just keep it low always */
>> +     mask_tpm_reset_regulator: mask-tpm-reset-regulator {
>> +     compatible = "regulator-fixed";
>> +     regulator-name = "mask-tpm-reset ";
>> +             gpio = <&gpx0 6 0>;
>> +             enable-active-low;
>> +             regulator-boot-on;
>> +             regulator-always-on;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&mask_tpm_reset>;
>> +     };
>
> I don't think this pin is supposed to be a real regulator. If I'm right,
> you should just add a hog for it, if you don't have a proper driver to
> handle it.

Yes, I agree that it shouldn't really be a regulator, but there's not
a whole lot of choice.  The pin needs to actually be driven low, not
just pulled low.  Without your proposed patch (pinctrl: samsung: Allow
pin value to be initialized using pinfunc) I don't think it's possible
to actually drive a pin low with a hog.  I could be wrong, though.


So I think our options are:

* Begrudgingly use the regulator this way.

* Re-propose your pinctrl patch and use hogs.

* Implement a tiny driver that will just hold a GPIO in a certain
state and instantiate that driver here.

* Decide that really the firmware should have set this pin and that if
someone wants suspend/resume to work then they'll just have to update
their firmware.  Queue the debate about what firmware vs. kernel's job
is and commence yelling about the fact that it's hard to get an
official RW firmware update approved.  Note: I'm not quite sure why I
didn't have the firmware init this GPIO to begin with (so that if the
kernel didn't do anything it would just work).  Probably just me being
stupid.


Ah, one other thing that could justify this being its own special
driver (though you might be able to use the regulator framework for it
too?).  Technically you'll save a tiny amount of power in the system
if you leave this GPIO high while the system is running and only drive
it low when the system goes to suspend.  That's because there's a
pretty strong external pullup on this pin.  The amount of power is
probably not noticeable and the savings is only possible when the
system is on (and in high power state) anyway, but...

-Doug
