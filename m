From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 25 Aug 2016 12:31:08 +0900
Subject: [PATCH/RTF 7/7] arm64: dts: r8a7796: salvator-x: enable SDHI0 & 3
In-Reply-To: <CAMuHMdVjmVobeTNSf9kWtWaGk6zcWRjGKkjKqfFmqx0ZJYJurg@mail.gmail.com>
References: <1471433516-4478-1-git-send-email-horms+renesas@verge.net.au>
 <1471433516-4478-8-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVjmVobeTNSf9kWtWaGk6zcWRjGKkjKqfFmqx0ZJYJurg@mail.gmail.com>
Message-ID: <CANqRtoQ4jsxyKsh8qHxXmwPOH==uE-AzY4_9886XQmPE7nk3KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Thu, Aug 18, 2016 at 12:52 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Aug 17, 2016 at 1:31 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
>> Enable the exposed SD card slots in the DT of the r8a7796/salvator-x.
>>
>> Based on work for the r8a7795/salvator-x by Ai Kyuse.
>>
>> Cc: Ai Kyuse <ai.kyuse.uw@renesas.com>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
>> +&sdhi0 {
>> +       pinctrl-0 = <&sdhi0_pins>;
>> +       pinctrl-names = "default";
>> +
>> +       vmmc-supply = <&vcc_sdhi0>;
>> +       vqmmc-supply = <&vccq_sdhi0>;
>> +       cd-gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
>> +       wp-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
>
> BTW, is there a specific reason CD and WP use GPIOs, and not the
> dedicated sdhi0_cd and sdhi0_wp pin config?
> It's done the same on r8a7795/salvator-x.

On R-Car SoCs I believe all the SDHI instances have CD and WP support
in the SDHI hardware block. For some boards some SDHI instances may
not make use of all signals for instance in case of uSD WP signal.

Historically with SDHI the CD and WP pin availability depends on SDHI
instance for the particular SoC. On older mobile SoCs some SDHI
instances were intended to be used with an on-board SDIO module so the
hotplug / write protect signals were then omitted so no such PFC pins
existed. I've seen designs that used other GPIO signals for CD and WP
in such case.

I like the idea that the SoC specific DT device provides some shared
generic information about the SDHI channel and each board may opt-in
on certain board-specific properties such as CD and WP signals. Opt-in
for the WP signal is especially useful if we want to be able to
support both uSD and SD with the same DT device node. Before switching
to GPIO we had issues with uSD cards turning out to be read-only. If
CD/WP handling can be done consistently with the PFC signals then
that's of course fine, but I'm not sure the merit over that compared
to GPIO. Both CD and WP are not exactly in the hot path. =)

For R-Car I'm yet to see SDHI instances in power domains and PM is not
such a hot topic. On mobile SoCs we wanted to do our very best to turn
off the power domain the SDHI instance belongs to. It helps using GPIO
for CD in such case since the SDHI device can be runtime suspended and
the power domain powered down while the GPIO block still provides card
insert events. If we use the SDHI device CD signal for hot plug
notification then powering off the power domain may not be possible if
we still want notifications.

Thanks,

/ magnus
