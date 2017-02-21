From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 21 Feb 2017 17:36:16 +0100
Subject: [PATCH/RFC 4/6] drivers: firmware: psci: Fix non-PMIC wake-up if
 SYSTEM_SUSPEND cuts power
In-Reply-To: <bed72738-93c7-c0da-d6c7-383d6881dbdd@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-5-git-send-email-geert+renesas@glider.be>
 <bed72738-93c7-c0da-d6c7-383d6881dbdd@arm.com>
Message-ID: <CAMuHMdWXEw+rkzd2_7fetmwsaSZqXBD_YHsMV2XnLBxAn0Eh8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Tue, Feb 21, 2017 at 11:50 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 20/02/17 20:33, Geert Uytterhoeven wrote:
>> Nothing in the PSCI specification requires the SoC to remain powered and
>> to support wake-up sources when suspended using SYSTEM_SUSPEND.
>> If the firmware implements the PSCI SYSTEM_SUSPEND operation by cutting
>> power to the SoC, the only possibly wake-up sources are thus the ones
>> connected to the PMIC.
>>
>> Document and add support for an "arm,psci-system-suspend-is-power-down"
>> DT property, so Linux uses a different suspend method when other wake-up
>> sources (e.g. wake on LAN, UART or GPIO) are enabled.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  Documentation/devicetree/bindings/arm/psci.txt | 11 +++++++++++
>>  drivers/firmware/psci.c                        | 13 ++++++++++---
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
>> index a2c4f1d524929bb7..16e390ecb7531028 100644
>> --- a/Documentation/devicetree/bindings/arm/psci.txt
>> +++ b/Documentation/devicetree/bindings/arm/psci.txt
>> @@ -68,6 +68,17 @@ state nodes, as per bindings in [1]) must specify the following properties:
>>               Definition: power_state parameter to pass to the PSCI
>>                           suspend call.
>>
>> + - arm,psci-system-suspend-is-power-down
>> +             Nothing in the PSCI specification requires the SoC to remain
>> +             powered and to support wake-up sources when suspended using
>> +             SYSTEM_SUSPEND.
>
> Again, yes SoC can be powered down but you give no reasons why this is
> useful other than help you to hack around to implement suspend_ops. As

This is useful to support other wake-up sources. Linux has a standardized
way to handle wake-up sources, which may be circumvented by calling PSCI
SYSTEM_SUSPEND.

> suggested please try using freeze_ops.

Freezing the system works, but requires manual configurarion.
This should be done automatically.

> After commit a94e502c22b6 ("cpuidle: dt: assign ->enter_freeze to same
> as ->enter callback function"), you can enter suspend-to-idle(a.k.a
> freeze state) on all platforms using ARM DT cpuidle driver.

This should be used automatically if the system can't wake-up from
suspend-to-RAM using the configured wake-up sources.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
