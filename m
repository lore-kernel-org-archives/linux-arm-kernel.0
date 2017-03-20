From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 20 Mar 2017 10:31:50 +0100
Subject: [PATCH v2 0/4] arm: renesas: Add reset control properties
In-Reply-To: <20170320082852.GC21538@verge.net.au>
References: <1489673246-11015-1-git-send-email-geert+renesas@glider.be>
 <20170320082852.GC21538@verge.net.au>
Message-ID: <CAMuHMdUdFUBh=2azMLWJ1Bm34pP3OnesqdvR1ZQ14JgMtuqecw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, Shimoda-san,

On Mon, Mar 20, 2017 at 9:28 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Mar 16, 2017 at 03:07:22PM +0100, Geert Uytterhoeven wrote:
>> This patch series describes the reset control topology for on-SoC devices
>> connected to the Renesas Clock Pulse Generator / Module Standby and
>> Software Reset module on the R-Car H3 and M3-W, RZ/G1M, and RZ/G1E SoCs.
>>
>> Resets usually match the corresponding module clocks.  Exceptions are:
>>   - The Display Unit has only 2 resets, one per channel pair, cfr.
>>     "[PATCH v2] dt-bindings: drm: rcar-du: Document optional reset
>>     properties" (http://www.spinics.net/lists/dri-devel/msg134637.html),
>>   - The audio module has resets for the Serial Sound Interfaces only.
>>     Adding resets and reset-names properties depends on a DT binding
>>     update for renesas,rsnd (note: the DT binding documentation in
>>     Documentation/devicetree/bindings/sound/renesas,rsnd.txt doesn't
>>     even document clocks and clock-names?).
>> Upon request from Laurent for the DU, and upon a DT bindings update
>> for rcar_sound, the addition of resets (and reset-names) properties for
>> these complex modules is postponed.
>>
>> Note that this patch series contains hardware description only.
>> Actual reset policy is to be defined and implemented separately.
>> Also, this is an optional feature, to be enabled explicitly using
>> CONFIG_RESET_CONTROLLER=y.  When enabled, an on-SoC device can be reset
>> easily using device_reset(), or by using the reset_control_*() API when
>> more fine-grained control is desired.
>>
>> Possible use cases are (not exhaustive):
>>   - Reset a device before use, to make sure it's in a predefined state, and
>>     doesn't depend on earlier configuration by e.g. the boot loader,
>>   - Reset a device after detecting an anomaly,
>>   - Reset a device to verify suspend/resume is handled correctly by the
>>     driver in case the device would be part of a power domain on a
>>     different/future SoC.
>>
>> Dependencies and impact:
>>   - The corresponding driver changes to the CGP/MSSR driver are already
>>     present in v4.11-rc1.
>>   - These patches have no impact as long as CONFIG_RESET_CONTROLLER=n.
>>     However, if CONFIG_RESET_CONTROLLER=y and resets properties are
>>     prsesent in DTS, the EHCI and OHCI drivers already deassert reset as
>>     part of their initialization sequences, and put the devices back
>>     into reset state in case initialization failed, or on unbind.
>>     I'm not aware of other relevant drivers already using reset control.
>
> It appears that for arm64 defconfig CONFIG_RESET_CONTROLLER=y is true so
> by default there will be a behavioural change on arm64. I'd like to
> understand if it is a desirable (or at least not undesirable) change.

V1 of this patch series has been part of renesas-drivers since
renesas-drivers-2017-01-24-v4.10-rc5, so I'd hope any negative impact would
have been discovered by now.

Shimoda-san: Have you noticed any oddities w.r.t. USB?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
